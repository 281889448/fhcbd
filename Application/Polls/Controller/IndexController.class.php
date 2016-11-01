<?php


namespace Polls\Controller;

use Polls\Model\Polls_yprepareModel;
use Common\Controller\BaseController;
use Weibo\Api\WeiboApi;
use Polls\Model\Polls_shenheModel;

class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {   parent::_initialize();
        $tree = D('PollsType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);


        $this->assign('current', 'polls');
    }

    /**
     * 民意
     */

//遍历主页信息
    public function index(){
        $status =I('get.status');
        $poll = D('Polls'); // 实例化User对象
	      
	      $this->check_view($status);
	    
        if(IS_POST){
            $type_id 	= I('post.type_id');
            $title	=I("post.title");
            $stime 	= I('post.stime');
            $etime= I('POST.etime');

            $stime=strtotime($stime);
            $etime=strtotime($etime) + 3600*24;
	        
	        if(!empty($stime) && !empty($etime)){
		        $map['time'] =array('between',"{$stime},{$etime}");
	        }elseif(!empty($stime) && empty($etime)){
		        $map['time'] =array('gt',$stime);
	        }elseif(empty($stime) && !empty($etime)){
		        $map['time'] =array('lt',$etime);
	        }
	        
            if(!empty($title)){
                $map['title']=array('like', '%'.$title .'%');
            }
            if(!empty($type_id)){
                $map['type_id']=$type_id;
            };
            
           
		
           
        }

	    if(get_permission(get_uid(),['委员','集体']) ){$map['uid'] = get_uid();}
        $map['status'] = array('in',explode(',',$status));
	    $map = array_filter($map);
	
        $count= $poll->where($map)->count();
        $Page= new \Think\Page($count,10);
        $resaut = $poll->where($map)->order('time desc')->limit($Page->firstRow.','.$Page->listRows)->select();

	      foreach($resaut as &$v){
	      	$v[type] = $this->getType($v[type_id]);
	      }
	      
        /*    echo $poll->getLastSql();
                exit;*/


        $this->assign('status',$status);
        $this->assign('resaut',$resaut);
        $this->assign('page',$Page->show());
        $this->display();
    }
//添加民意页面之间提交



    
    //修改未提交民意
    public function alter($id){
        $data=I('post.');
        $data['time']=strtotime(I('post.time'));
        $result = D('Polls')->where("id={$id}")->save($data);

        if($result > 0)
        {
            $this->success("修改民意成功！");
        }
        else
        {
            $this->success("修改民意失败！");
        }
    }

//民意添加
    public function addition($id){
        if(IS_POST){
            $model =D('Polls');
            //如果接收到了post请求，就添加数据
            $data=I('post.');
            $data['time']=strtotime(I('post.time'));
            if($model->where(array('id' => $id))->save($data)){
                return $this->ajaxReturn('1');
            }else{
                //添加失败
                return $this->ajaxReturn($model->getError());
            }
        }

    }


    //通过民意
    public function out($id){

        $model =D('Polls');
        $data=I('post.');
        $data['time']=strtotime(I('post.time'));
        $data['adopt'] = implode(',',I('post.adopt'));
        $data['make'] = implode(',',I('post.make'));
			
	    $jump_status = $model->where('id='.$id)->getField('status');
	    
	    
        $resaut=$model->where(array('id' => $id))->save($data);
        $this->process_log($id,get_uid(),$data['status']);

        $polls = $model->find($id);
	    $peoples = array_unique(array_filter(explode(',',$polls['people'].','.$polls['uid'])));
	    $adopt = max(I('post.adopt'));
	    $make = max(I('post.make'));
	    
	    if($data['status']==6){
	        $uids = $peoples ;
            foreach($uids as $uid ){
                switch($adopt){
                    case 1:
                        update_action_log('weiyuan_polls_adopt_q','polls',$id,$uid);
                        break;
                    case 2:
                        update_action_log('weiyuan_polls_adopt_s','polls',$id,$uid);
                        break;
                    case 3:
                        update_action_log('weiyuan_polls_adopt_shen','polls',$id,$uid);
                        break;
                    case 4:
                        update_action_log('weiyuan_polls_adopt_g','polls',$id,$uid);
                        break;
                }

                switch($make){
                    case 1:

                        update_action_log('weiyuan_polls_awaiting_q','polls',$id,$uid);
                        break;
                    case 2:

                        update_action_log('weiyuan_polls_awaiting_s','polls',$id,$uid);
                        break;
                    case 3:

                        update_action_log('weiyuan_polls_awaiting_shen','polls',$id,$uid);
                        break;
                    case 4:
                        update_action_log('weiyuan_polls_awaiting_z','polls',$id,$uid);
                        break;
                }
            }
	    }
	    
	    
        if($resaut){
            $this->success("审核成功",U('index/index', array('status' =>$jump_status)));
        }else{
            $this->error("审核失败");
        }
    }

    //已通过审核
    public function yprepare($id){


        $content=D('Polls')->where("id={$id}")->find();
        $this->assign('content',$content);
        $this->display();
    }

//添加页面增加作者
    public function searchuser(){
        $nickname = I('post.nickname');
        if(!empty($nickname)){
            $where['nickname ']=array('like', '%'.$nickname .'%');
        };
        $model=D('Member');
        $data=$model->where($where)->select();
        if($data)
        {
            $this->ajaxReturn($data);

        }
    }

 
    //民意退回
    public function tj($polls_id)
    {
    	$data=I('post.');
      $model =D('Polls');
        
	    $polls = $model->find($polls_id);
	    
			//更新主表状态  初审退回

     $model->where(array('id' => $polls_id))->save($data);
	    
	    //退回信息录入    status 状态跟随主表状态
	    
	    $suggest = I('post.suggest');

	    $pid = $this->process_log($polls_id,get_uid(),$data['status'],$suggest);
	    
        if($pid){
            $this->success("退回成功",U('index/index', array('status' =>$polls['status'])));
        }else{
            $this->error("退回失败");
        }
    }



    /**
     * 获取推荐活动数据
     * autor:xjw129xjt
     */
    public function getRecommend()
    {
        $rec_event = D('Event')->where(array('is_recommend' => 1))->limit(2)->order('rand()')->select();
        foreach ($rec_event as &$v) {
            $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
            $v['type'] = $this->getType($v['type_id']);
            $v['check_isSign'] = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $v['id']))->select();
        }
        unset($v);

        $this->assign('rec_event', $rec_event);


    }



    /**
     * 发布活动
     * @param int    $id
     * @param int    $cover_id
     * @param string $title
     * @param string $explain
     * @param string $sTime
     * @param string $eTime
     * @param string $address
     * @param int    $limitCount
     * @param string $deadline
     * autor:xjw129xjt
     */
    public function doPost($id = 0)
    { $data = I('post.');
        $model =D('Polls');
        $data['time']=strtotime(I('post.time'));
        $data['adopt'] = implode(',',I('post.adopt'));
        $data['make'] = implode(',',I('post.make'));
        if($id){
            $flag=$model->save($data);
        }else{
            $flag = $model->add($data);
        }

        if($flag){
            if($data['status']=3){
                $this->success("提交成功",U('index/index', array('status' =>5)));
            }else{
                $this->success("提交成功",U('index/index', array('status' =>4)));
            }

        }else{
            $this->error("提交失败");
        }
    }

    /**
     * 活动详情
     * @param int $id
     * autor:xjw129xjt
     */

    public function detail($id = 0)
    {

        $poll_content = D('Polls')->find($id);

        if (!$poll_content) {
            $this->error('404 not found');
        }


        $this->assign('poll', $poll_content);

        $this->display();
    }

    /**
     * 活动成员
     * @param int    $id
     * @param string $tip
     * autor:xjw129xjt
     */
    public function member($id = 0, $tip = 'all')
    {
        if ($tip == 'sign') {
            $map['status'] = 0;
        }
        if ($tip == 'attend') {
            $map['status'] = 1;
        }
        $check_isSign = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $id))->select();
        $this->assign('check_isSign', $check_isSign);

        $event_content = D('Event')->where(array('status' => 1, 'id' => $id))->find();
        if (!$event_content) {
            $this->error('404 not found');
        }
        $map['event_id'] = $id;
        $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);
        $menber = D('event_attend')->where($map)->select();
        foreach ($menber as $k => $v) {
            $event_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'avatar128', 'rank_html', 'signature'), $v['uid']);
            $event_content['member'][$k]['name'] = $v['name'];
            $event_content['member'][$k]['phone'] = $v['phone'];
            $event_content['member'][$k]['status'] = $v['status'];
        }

        $this->assign('all_count', D('event_attend')->where(array('event_id' => $id))->count());
        $this->assign('sign_count', D('event_attend')->where(array('event_id' => $id, 'status' => 0))->count());
        $this->assign('attend_count', D('event_attend')->where(array('event_id' => $id, 'status' => 1))->count());

        $this->assign('content', $event_content);
        $this->assign('tip', $tip);
        $this->setTitle('{$content.title|op_t}' . '——活动');
        $this->setKeywords('{$content.title|op_t}' . ',活动');
        $this->display();
    }

    /**
     * 编辑社情民意
     * @param $id
     * autor: MR.Z  <327778155@qq.com>
     * create: 2016/9/13
     */
    public function edit($id)
    {
	      $polls_content = D('Polls')->where(array( 'id' => $id))->find();

        if (!$polls_content) {
            $this->error('404 not found');
        }

	
	    $group_ids = C('CONTACT_GROUP');
	    $group = array();
	    foreach($group_ids as $k=>$v){
		    if($v['is_final']==true && $v['parent_id']==0){
			    $group[$k]['name']	= $v['name'];
		    }elseif($v['is_final']==true && $v['parent_id'] != 0){
			    $group[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
			    $group[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
		    }
	    }
	
	    ksort($group);
        //提交状态默认为2
        $to_status = 2;
        if($polls_content['status']==4){
            $to_status = 2;
        }elseif($polls_content['status']==5){
            $to_status = 3;
        }

        $this->assign('to_status',$to_status);
	    $this->assign('contact_group',$group);

        $this->assign('content', $polls_content);

        $this->display();
    }

    public function add()
    {
      /*  if (IS_POST) {
            //如果接收到了post请求，就添加数据
            $model =D('Polls');
            $data=I('post.');
            $data['time']=strtotime(I('post.time'));
            if ($model->add($data)) {
                return $this->ajaxReturn('1');
            } else {
                return $this->ajaxReturn($model->getError());
            }
        }*/

        $group_ids = C('CONTACT_GROUP');
        $group = array();
        foreach($group_ids as $k=>$v){
            if($v['is_final']==true && $v['parent_id']==0){
                $group[$k]['name']	= $v['name'];
            }elseif($v['is_final']==true && $v['parent_id'] != 0){
                $group[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
                $group[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
            }
        }

        ksort($group);
        $this->assign('contact_group',$group);
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $member = $m->getUser(get_uid());
        $name = $member['名称'];

        $this->assign('name',$name);
       
        $time= time();
        $this->assign('time',$time);
        $this->display();
    }
//添加页面保存民意
    public function upload($type_id='',$title='',$content='')
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
        if (trim(op_t($type_id)) == '') {
            $this->error('请输入发表类型。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入发表标题。');
        }
        if (trim(op_t($content)) == '') {
            $this->error('请输入发表内容。');
        }
        if(empty(I('post.people'))){
            $this->error('请添加作者');
        }
        $data=I('post.');
        $data['time']= strtotime($data['time']);
	      $data['status']  = $data['status'];
	      $data['uid'] = get_uid();
        $rs = D('Polls')->add($data);
	
	
	    if($rs){
		    $map_f['user_id'] = get_uid();
		    $map_f['model'] = MODULE_NAME;
		    $map_f['record_id'] = 0;
		    D('Fileu')->where($map_f)->setField('record_id',$rs);
	    }

        $uids = $data['people'].','.get_uid();
        $uidarr = array_unique(array_filter(explode(',',$uids)));
        //	 基础积分处理
        if($rs){
            foreach($uidarr as $u){
              action_log('weiyuan_basic_polls_add', 'polls', $rs, $u);
            }
        }
	    
        if (empty($rs)) {
            $this->error("添加失败");
        }else{
            $this->success("添加成功",U('index/index', array('status'=>1)));
        }

    }
    
    
    
    public function doEdit($id,$type_id,$title,$content){
	    if (!is_login()) {
		    $this->error('请登陆后再投稿。');
	    }
	    if (trim(op_t($type_id)) == '') {
		    $this->error('请输入发表类型。');
	    }
	    if (trim(op_t($title)) == '') {
		    $this->error('请输入发表标题。');
	    }
	    if (trim(op_t($content)) == '') {
		    $this->error('请输入发表内容。');
	    }
	    //获取当前社情民意的信息
	    $polls = D('Polls')->find($id);
	    $data=I('post.');
	    $data['id'] = $id;
	    $data['time']= strtotime($data['time']);
	    $rs = D('Polls')->save($data);

	    
	
	    if($rs){
		    $map_f['user_id'] = $polls['uid'];
		    $map_f['model'] = MODULE_NAME;
		    $map_f['record_id'] = 0;
		    D('Fileu')->where($map_f)->setField('record_id',$rs);
	    }
	
	
	
	    if (empty($rs)) {
		    $this->error("更新失败");
	    }else{
		    $this->success("更新成功",U('index/index', array('status'=>$polls['status'])));
	    }
    }
//搜索页面
    public function search()
    {
        //接收
        $type_id 	= I('post.type_id');
        $uid	=I("post.uid");
        $stime 	= I('post.stime');
        $status = I('post.status');
        $etime= I('POST.etime');
        //判断是否有值


        if(!empty($uid)){
            $where['uid']=$uid;
        };
        if(!empty($type_id)){
            $where['type']=$type_id;
        };

        if(!empty($stime)&&!empty($etime)){
            $where['time'] =array(array('gt',$stime),array('lt',$etime));
        }elseif(!empty($stime)){
            $where['time'] =array('gt',$stime);
        }elseif(!empty($etime)){
            $where['time'] =array('lt',$etime);
        }
        if($status||$status=='0'){
            $where['status']=$status;
        };


        date(strtotime($stime),'Y-m-d');
        //实例化模型
        $model=D('Polls');

        //查询
        $re=$model->where($where)->select();
        $this->assign('uid',$uid);
        $this->assign('type',$type_id);
        $this->assign('status',$status);
        $this->assign('stime',$stime);
        $this->assign('etime',$etime);
        $this->assign('re', $re);
        $this->display();

    }
    //终审退回
    public function th($polls_id)
    {
    	$data = I('post.');
	    
	    $model =D('Polls');
	    
	    $polls = $model->find($polls_id);
	
	    $model->where(array('id' => $polls_id))->save($data);
	
	    //退回信息录入    status 跟随主表状态
	    $suggest=I('post.suggest');
	   $pid = $this->process_log($polls_id,get_uid(),$data['status'],$suggest);
	
	
	    if($pid){
		    $this->success("退回成功",U('index/index', array('status' =>$polls['status'])));
	    }else{
		    $this->error("退回失败");
	    }
	    
    }
//删除民意
    public function remove($id){
        $id=I('post.id');
        $model=D('Polls');
        //积分处理操作  积分规则中  如果发布一条社情民意会有加分， 在这里，如果这条是当前用户最后一条，则会进行积分取消操作
        $count = $model->where('uid='.get_uid())->count();
        if($count == 1){
            del_action_log('weiyuan_basic_polls_add','polls',$id,get_uid());
        }

        $read=$model->where(array('id'=>$id))->delete();

        if($read){
            $exit=array('code'=>1,'msg'=>"删除成功");
        }else{
            $exit=array('code'=>0,'msg'=>"删除失败");
        }
        echo json_encode($exit);

    }

    //审核
    public function review(){
        $this->display();
    }
    public function review1(){
        $this->display();
    }


    /**
     * 报名参加活动
     * @param $event_id
     * @param $name
     * @param $phone
     * autor:xjw129xjt
     */
    public function doSign($event_id, $name, $phone)
    {
        if (!is_login()) {
            $this->error('请登陆后再报名。');
        }
        if (!$event_id) {
            $this->error('参数错误');
        }
        if (trim(op_t($name)) == '') {
            $this->error('请输入姓名。');
        }
        if (trim($phone) == '') {
            $this->error('请输入手机号码。');
        }
        $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->select();
        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }
        /*      if ($event_content['attentionCount'] + 1 > $event_content['limitCount']) {
                  $this->error('超过限制人数，报名失败');
              }*/
        if (time() > $event_content['deadline']) {
            $this->error('报名已经截止');
        }
        if (!$check) {
            $data['uid'] = is_login();
            $data['event_id'] = $event_id;
            $data['name'] = $name;
            $data['phone'] = $phone;
            $data['creat_time'] = time();
            $res = D('event_attend')->add($data);
            if ($res) {

                D('Message')->sendMessageWithoutCheckSelf($event_content['uid'], query_user('nickname', is_login()) . '报名参加了活动]' . $event_content['title'] . ']，请速去审核！', '报名通知', U('Event/Index/member', array('id' => $event_id)), is_login());

                D('Event')->where(array('id' => $event_id))->setInc('signCount');
                $this->success('报名成功。', 'refresh');
            } else {
                $this->error('报名失败。', '');
            }
        } else {
            $this->error('您已经报过名了。', '');
        }
    }

    /**
     * 审核
     * @param $uid
     * @param $event_id
     * @param $tip
     * autor:xjw129xjt
     */
    public function shenhe($uid, $event_id, $tip)
    {
        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }
        if ($event_content['uid'] == is_login()) {
            $res = D('event_attend')->where(array('uid' => $uid, 'event_id' => $event_id))->setField('status', $tip);
            if ($tip) {
                D('Event')->where(array('id' => $event_id))->setInc('attentionCount');
                D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '已经通过了您对活动' . $event_content['title'] . '的报名请求', '审核通知', U('Event/Index/detail', array('id' => $event_id)), is_login());
            } else {
                D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
                D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '取消了您对活动[' . $event_content['title'] . ']的报名请求', '取消审核通知', U('Event/Index/member', array('id' => $event_id)), is_login());
            }
            if ($res) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('操作失败，非活动发起者操作！');
        }
    }

    /**
     * 取消报名
     * @param $event_id
     * autor:xjw129xjt
     */
    public function unSign($event_id)
    {

        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }

        $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->find();

        $res = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->delete();
        if ($res) {
            if ($check['status']) {
                D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
            }
            D('Event')->where(array('id' => $event_id))->setDec('signCount');

            D('Message')->sendMessageWithoutCheckSelf($event_content['uid'], query_user('nickname', is_login()) . '取消了对活动[' . $event_content['title'] . ']的报名', '取消报名通知', U('Event/Index/detail', array('id' => $event_id)), is_login());

            $this->success('取消报名成功');
        } else {
            $this->error('操作失败');
        }
    }

    /**
     * 报名弹出框页面
     * @param $event_id
     * autor:xjw129xjt
     */
    public function ajax_sign($event_id)
    {

        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }

        D('Event')->where(array('id' => $event_id))->setInc('view_count');
        $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);
        $event_content['type'] = $this->getType($event_content['type_id']);

        $menber = D('event_attend')->where(array('event_id' => $event_id, 'status' => 1))->select();
        foreach ($menber as $k => $v) {
            $event_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

        }

        $this->assign('content', $event_content);
        $this->display();
    }

    /**
     * ajax删除活动
     * @param $event_id
     * autor:xjw129xjt
     */
    public function doDelEvent($event_id)
    {

        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }
        if ($event_content['uid'] == is_login() || is_administrator(is_login())) {
            $res = D('Event')->where(array('status' => 1, 'id' => $event_id))->setField('status', 0);
            if ($res) {
                $this->success('删除成功！', U('Event/Index/index'));
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('非活动发起者操作！');
        }

    }

    /**
     * ajax提前结束活动
     * @param $event_id
     * autor:xjw129xjt
     */
    public function doEndEvent($event_id)
    {

        $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
        if (!$event_content) {
            $this->error('活动不存在！');
        }
        if ($event_content['uid'] == is_login() || is_administrator(is_login())) {
            $res = D('Event')->where(array('status' => 1, 'id' => $event_id))->setField('eTime', time());
            if ($res) {
                $this->success('操作成功！');
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('非活动发起者操作！');
        }

    }
    /*  //名意类型
      public function type(){
          $type=M('polls_type')->select();
          $this->assign('type',$type);

      }*/

    //已提交待审核页面的修改保存
    public function save($id){
        if(IS_POST){
            $model =D('Polls');
            //如果接收到了post请求，就修改数据
            $data=I('post.');
            $data['adopt']=implode($_POST['adopt']);
            $data['make']=implode($_POST['make']);
            if($model->where(array('id'=>$id))->save($data)){
                return $this->ajaxReturn('1');
            }else{
                //添加失败
                return $this->ajaxReturn($model->getError());
            }
        }
    }

//秘书长审核通过
    public function detail_manger($id){
        $content=D('polls')->where(array('id'=>$id))->find();
        $this->assign('content',$content);
        $this->display();
    }

    public function detail_mangers($id){
        $model =D('Polls');
        $data=I('post.');
        $data['time']=strtotime(I('post.time'));
        $data['adopt'] = implode(',',I('post.adopt'));
        $data['make'] = implode(',',I('post.make'));
        $data['status']=6;
        $resaut=$model->where(array('id' => $id))->save($data);
        if($resaut){
            $this->success("审核成功",U('index/index', array('status' =>3)));
        }else{
            $this->error("审核失败");
        }
    }


    //审核页面
    public function prepare($id){
        $table=D('Polls');
        //生成模型
        $polls= $table->find($id);
	
	
	    $group_ids = C('CONTACT_GROUP');
	    $group = array();
	    foreach($group_ids as $k=>$v){
		    if($v['is_final']==true && $v['parent_id']==0){
			    $group[$k]['name']	= $v['name'];
		    }elseif($v['is_final']==true && $v['parent_id'] != 0){
			    $group[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
			    $group[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
		    }
	    }
	
	    ksort($group);
        $this->assign('back_url',I('server.HTTP_REFERER'));
	    $this->assign('contact_group',$group);
	    
        //分配变量
        $this->assign('polls', $polls);
        //分配变量
        $this->display();

    }
    
    
    private function getType($type_id)
    {
        $type = D('PollsType')->where('id=' . $type_id)->find();
        return $type;
    }
    
    
    private function process_log($id,$uid,$status,$suggest){
    	$data['polls_id'] = $id;
	    $data['uid'] = $uid;
	    $data['status'] = $status;
	    $data['suggest'] = $suggest;
	    $data['create_time'] = time();
	    $pid = D('PollsProcess')->add($data);

	    return $pid;
    }


    public function view($page=1){
        if(IS_POST){
            $data = I('post.');
            $map['title'] = ['like', "%{$data['title']}%"];
            $map['type_id'] = ['eq',$data['type_id']];
            $map['stime'] = ['gt',$data['stime']];
            $map['etime'] = ['lt',$data['etime']];
             $map =  array_unique(array_filter($map));
        }
        $uid = get_uid();
        $map['status'] = 6;
        $map['_string'] = "{$uid} in (people) or people is null";


        $polls  = D('Polls')->where($map)->order('id desc')->page($page, 16)->select();
        $totalPage = D('Polls')->where($map)->count();

        $this->assign('polls',$polls);
        $this->assign('totalPageCount',$totalPage);
        $this->display();
    }
    
    
    /******************************华丽分隔线********下面是 ajax *******************************/
    /*
     * 查看退回意见
     * author: MR.Z <327778155@qq.com>
     *  create: 2016/9/13
     */
    public function return_ajax(){
    	$status = 0;
    	if(IS_AJAX){
    		$data = I('post.');
		    $map['status'] = $data['status'];
		    $map['polls_id'] = $data['id'];
		    $result = D('PollsProcess')->where($map)->order('create_time desc')->find();

		    if($result){
		    	$status = 1;
			    $data['data'] = $result;
		    }
		    $data['status'] = $status;
		    $this->ajaxReturn($data);
		    
	    }
    }
    
    private function check_view($status){
	    $group = get_group(get_uid());

    	$view_status = C('POLLS_VIEW_STATUS');

        $status_tmp = [];
        foreach($group as $v){
            if($view_status[$v]){
                $status_tmp = array_merge($status_tmp,$view_status[$v]);
            }
        }

      $status_arr =  array_unique($status_tmp) ;

	    if(!in_array( $status,$status_arr)){
		    $this->error("您没有访问该社情民意的权限");
	    }
    	
    }

}