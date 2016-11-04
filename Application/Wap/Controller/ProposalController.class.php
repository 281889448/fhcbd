<?php
/**
 * Created by PhpStorm.
 * User: MR.Z
 * Date: 16-10-8
 * Time: AM9:45
 */

namespace Wap\Controller;

use Common\Controller\BaseController;


class ProposalController extends BaseController
{
        public function _initialize()
        {
            parent::_initialize(); // TODO: Change the autogenerated stub
            $tree = D('ProposalType')->where(array('status' => 1))->select();
            $this->assign('tree', $tree);
        }

    /*
     * 提案列表
     *  create: 2016/10/8
     * author : MR.Z <327778155@qq.com>
     */
    public function index($status=1,$page = 1, $type_id = 0){

        $status_view = $status_p = $status;
        //这是复合状态如  193 181 之类的status
        if(strlen($status_p)>2 && !stripos($status_p,',')){
            $status = substr($status_p,0,2);
            $substatus = substr($status_p,2,1);
        }

        //固定的状态下才会有匹配user_id
        $uid_array = C('UID_FILTER');
        $group = get_group(get_uid());
        if(get_permission(get_uid(),['委员','集体'])){
            if(in_array($status,$uid_array['委员'])){
                $map['p.uid'] = array('eq',get_uid());
            }
        }


        $map['p.status'] = array('in',"{$status}");
        //只有第一提案人和未并案的提案会显示  即0 2
        $map['p.is_merge'] = array('in',array(0,2));

        $this->check_view($status);
        $type_id = intval($type_id);
        if ($type_id != 0) {
            $map['type_id'] = $type_id;
        }



        // $map['status'] = 1;
        $order = 'p.create_time desc';

        if(IS_POST){
            $map_search = I('post.');
            $this->assign('map',$map_search);

            $map_search['author'] = !empty($map_search['author']) ? array('like',"%{$map_search['author']}%") : '';
            $map_search['title'] = !empty($map_search['title']) ? array('like',"%{$map_search['title']}%") : '';
            $map_search =   array_filter($map_search);

            $map = array_merge($map,$map_search);


        }

        if(empty($substatus)){
            $content = D('Proposal')->alias('p')->where($map)->order($order)->page($page, 100)->select();

            $totalCount = D('Proposal')->alias('p')->where($map)->count();
        }else{
            $map['pr.status'] = array('eq',"{$substatus}");
            $content = D('Proposal')->alias('p')->field('title,type_id,ycode,code,jiebie,author,p.contact,p.id,is_merge,is_joint,p.status')->join('left join __PROPOSAL_RESULT__ as pr on p.id=pr.proposal_id')->where($map)->group('p.id')->order($order)->page($page, 100)->select();

            $totalCount = D('Proposal')->alias('p')->where($map)->count();
        }


        foreach ($content as &$v) {
            $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
            $v['type'] = $this->getType($v['type_id']);
            $v['check_isSign'] = D('proposal_attend')->where(array('uid' => is_login(), 'proposal_id' => $v['id']))->select();
            $map_pr['proposal_id'] = $v['id'];
            $map_pr['status'] = 2;
            $v['units'] = D('ProposalResult')->where($map_pr)->getField('unit',true);

            if($status == 18){
                $map_dw['proposal_id'] = $v['id'];

                $flag_dw = D('ProposalResult')->where($map_dw)->find();
                $v['status'] = $flag_dw ? '181':$v['status'];
            }
        }

        unset($v);
        if($status=='4,5,6,7'){$status_view=4;}
        if($status=='8,11,13,14,17,18,19'){$status_view=8;}
        //所有状态集合
        $status_config = C('PROPOSAL_STATUS');

        $this->assign('group',$group);
        $this->assign('status',$status);
        $this->assign('substatus',$substatus);
        $this->assign('status_view',$status_view);
        $this->assign('status_config', $status_config);
        $this->assign('type_id', $type_id);
        $this->assign('contents', $content);

        $this->assign('totalPageCount', $totalCount);
        $this->setTitle('提案交办首页');
        $this->setKeywords('提案交办');
        $this->display();
	}

	/*
	 * 撰写提案
	 * create: 2016/10/8
	 * author: MR.Z <327778155@qq.com>
	 */
	public function edit(){
	    $proposal_id = I('get.proposal_id');

	    if($proposal_id){
	        $content = D('Proposal')->find($proposal_id);
        }

        $mu = D('User/User');
        $user_id = get_uid();

        if(get_permission(get_uid(),['委员'])){$group_id = WEIYUAN;}
        if(get_permission(get_uid(),['集体'])){$group_id = TEAM;}

        $mu->setModel($group_id);
        $user = $mu->getUser($user_id);

        switch($group_id){
            case WEIYUAN:
                $user['lxr'] = $user['名称'];
                $user['sjh'] = $user['手机号'];
                break;
            case TEAM:
                $user['lxr'] = $user['联络员'];
                $user['sjh'] = $user['联系方式'];
                break;
        }


        //提出期间处理
        $meetbetween_conrfig = C('MEET_BETWEEN');
        $meets =  explode('~',$meetbetween_conrfig);
        if(count($meets)!= 2){$this->error('请检查会议期间的设置！');}
        if(strtotime($meets[0]) < time() && strtotime($meets[1]) > time()){
            $user['meet_type'] = '会议期间';
        }else{
            $user['meet_type'] = '闭会期间';
        }

        //   $userarr = $mu->getUsers();

        //	  $user = D('User/Weiyuan')->getWeiyuan(get_uid());

        $this->setTitle('添加提案' . '——提案');
        $this->setKeywords('添加' . ',提案');

        $this->assign('back_url',I('server.HTTP_REFERER'));
        $this->assign('content',$content);
        $this->assign('data',$user);
        $this->display();
    }


    /**
     * 发布提案
     * @param int    $id
     * @param int    $cover_id
     * @param string $title
     * @param string $explain
     * @param string $sTime
     * @param string $eTime
     * @param string $address
     * @param int    $limitCount
     * @param string $deadline
     * autor: MR.Z <327778155@qq.com>
     */
    public function doPost($proposal_id = 0,  $title = '',$content='',  $limitCount = 0, $type_id = 0)
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
        //检查是否有提交提案的权限
        if(!$proposal_id){
            if (!check_auth('addProposalContent')) {

                $this->error('抱歉，您不具备提交提案权限。');
            }
        }else{
            if (!check_auth('editProposalContent')) {
                $this->error('抱歉，您不具备编辑提案权限。');
            }
        }


        if (trim(op_t($title)) == '') {
            $this->error('请输入案由。');
        }
        if ($type_id == 0) {
            $this->error('请选择提案类型。');
        }
        if (trim(op_h($content)) == '') {
            $this->error('请输入内容。');
        }




        $content = M('Proposal')->create();


        //如果当前提案在联名里表没有一个人同意联名，联名属性为未联名
        $map_pj['proposal_id'] = $proposal_id;
        $map_pj['is_agree'] = 1;
        $map_pj['user_id'] = array('neq',get_uid());
        $flag = D('ProposalJoint')->where($map_pj)->find();

        if(!$flag){
            $content['is_joint'] = 0;
        }

        $content['content'] = op_h($content['content']);
        $content['title'] = op_t($content['title']);


        $content['type_id'] = intval($type_id);
        //传递过来ID说明是已经生成的提案
        if(!$proposal_id){
            if($content[meet_type] == '会议期间'){
                $map['meet_type'] = array('eq','会议期间');
                $map['meet'] = array('eq',$content[meet]);
                $lastycode = D('Proposal')->where($map)->order('id desc')->getField('ycode');
                if(empty($lastycode)){
                    $content[ycode] = $content[meet].'原案001号';
                }else{
                    $content[ycode] =  preg_replace_callback('/([0-9]+)/',function ($matches) {
                        return str_pad( $matches[0] + 1 , 3 , '0' , STR_PAD_LEFT );
                    },$lastycode);

                }
            }elseif($content[meet_type] == '闭会期间'){
                $map['meet_type'] = array('eq','闭会期间');
                $map['ycode'] = array('like','闭'.date('Y',time()).'%');
                $lastycode = D('Proposal')->where($map)->order('id desc')->getField('ycode');
                if(empty($lastycode)){
                    $content[ycode] = '闭原案'.date('Y',time()).'001号';
                }else{
                    $content[ycode] =  preg_replace_callback('/([0-9]+)/',function ($matches) {
                        return str_pad( $matches[0] + 1 , 3 , '0' , STR_PAD_LEFT );
                    },$lastycode);

                }
            }
        }
        //$content['ycode'] = D('Proposal')

        if ($proposal_id) {
            $content['create_time'] = time();
            $content_temp = M('Proposal')->find($proposal_id);

            if (!is_administrator(is_login())) { //不是管理员则进行检测
                //记录user_id 与当前UID匹配
                if((get_permission(get_uid(),['提案委']) && $content_temp['status']==2)) {

                }else{
                    if ($content_temp['uid'] != is_login()) {

                        $flag_temp = true;
                    }
                }
            }

            if($flag_temp){
                $this->error('越权操作。');
            }



            $content['uid'] = $content_temp['uid']; //权限矫正，防止被改为管理员
            $content['id'] = $proposal_id;
            $content['recommend'] = implode(',',I('post.recommend'));


            $rs = M('Proposal')->save($content);

            /*       $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Proposal/Index/detail', array('id' => $ids));
                   $weiboApi = new WeiboApi();
                   $weiboApi->resetLastSendTime();
                   $weiboApi->sendWeibo("我修改了活动【" . $title . "】：" . $postUrl);
           */

            if($content['status'] == 2 && (get_permission(get_uid(),['委员','集体']))){
                $back_url = U('Wap/Proposal/index',array('status'=>2));
                //流程记录
                process_log( 'dopost','proposal', $proposal_id, get_uid(),$proposal_id);

                //积分记录
                action_log('weiyuan_basic_proposal_add','proposal',$proposal_id,$content['uid']);
            }


            $str = $content['status']==1 ? '保存': '提交';
            if ($rs) {
                $this->success($str.'成功。',$back_url);
            } else {
                $this->success($str.'失败。', '');
            }
        } else {
            $content['create_time'] = time();
            $content['uid'] = is_login();
            if (modC('NEED_VERIFY',0) && !is_administrator()) //需要审核且不是管理员
            {

                $content['status'] = 0;
                $tip = '但需管理员审核通过后才会显示在列表中，请耐心等待。';
                $user = query_user(array('username', 'nickname'), is_login());
                D('Common/Message')->sendMessage(C('USER_ADMINISTRATOR'), "{$user['nickname']}发布了一个活动，请到后台审核。", $title = '活动发布提醒', U('Admin/Proposal/verify'), is_login(), 2);
            }

            $rs = M('Proposal')->add($content);

            //更新附件
            $map_f['user_id'] = get_uid();
            $map_f['model'] = 'proposal';
            $map_f['record_id'] = 0;
            D('Fileu')->where($map_f)->setField('record_id',$rs);

            if($content['status'] == 2){
                $back_url = U('Wap/Proposal/index',array('status'=>2));
                //流程记录
                process_log( 'dopost','proposal', $rs, get_uid(),$rs);

                //积分记录
                action_log('weiyuan_basic_proposal_add','proposal',$rs,$content['uid']);
            }else{
                $back_url = U('Wap/Proposal/edit',array('proposal_id'=> $rs ));
            }

//同步到微博
            /*           $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Proposal/Index/detail', array('id' => $rs));
                       $weiboApi = new WeiboApi();
                       $weiboApi->resetLastSendTime();
                       $weiboApi->sendWeibo("我发布了一个新的活动【" . $title . "】：" . $postUrl);
               */         $str = $content['status']==1 ? '保存': '提交';

            if ($rs) {
                $this->success($str.'成功。' . $tip,   $back_url );
            } else {
                $this->success($str.'失败。', '');
            }
        }
    }



    /*
     * 提案详情
     * create: 2016/10/8
     * author: MR.Z <327778155@qq.com>
     */
    public function detail($proposal_id){
        $proposal = D('Proposal/Proposal')->find($proposal_id);

        if($proposal['is_joint']){
            $proposal_joint = D('ProposalJoint')->where(['proposal_id'=>$proposal_id])->select();

            $m = D('User/User');
            $m->setModel(WEIYUAN);
            foreach($proposal_joint as &$v){
                $v['user'] = $m->getUser($v['user_id']);
            }

            $this->assign('proposal_joint',$proposal_joint);

        }

        $this->assign('content',$proposal);
        $this->display();
    }

    /*
     * 选择联名
     * create: 2016/10/8
     * author: MR.Z <327778155@qq.com>
     */
    public function jointly_chosen($proposal_id){
        $proposal =  D('Proposal')->find($proposal_id);
        if(IS_POST){
            $map = I('post.');
            $this->assign('map',$map);
            $map['nickname'] = array('like','%'.I('post.nickname').'%');
            $map['名称'] = array('like','%'.I('post.名称').'%');
            $map['user_id'] = array('neq',get_uid());
            $mu = D('User/User');
            $mu->setModel(WEIYUAN);

            $users = $mu->getUsers($map,array('名称','界别','专委会','街道联络委'));

            //获取已经选择的联名UID
            $chosens = D('ProposalJoint')->where(['proposal_id'=>$proposal_id])->getField('user_id',true);

            //如果被选中，则赋值其属性
            foreach($users as &$v){
                if(in_array($v['uid'],$chosens)){
                    $v['chosen'] = 1;
                }
            }

            $this->assign('users',$users);

        }
        $this->assign('proposal',$proposal);
        $this->display();
    }

    /*
     * 联名列表
     * create: 2016/10/8
     * author: MR.Z <327778155@qq.com>
     */
    public function jointly($proposal_id){

        $proposal =  D('Proposal')->find($proposal_id);

        //  $users = $mweiyuan->getWeiyuans($map);





        $map_j['proposal_id'] = $proposal_id;
        $joint = D('ProposalJoint')->where($map_j)->select();
        foreach($joint as &$v){
            //	  $v['user'] = D('User/Weiyuan')->getWeiyuan($v['user_id']);
            $mu = D('User/User');
            $mu->setModel(WEIYUAN);
            $v['user'] = $mu->getUser($v['user_id']);


        }
        if(get_permission(get_uid(),['提案委'])){
            $this->assign('back_url',I('server.HTTP_REFERER'));
        }else{
            $this->assign('back_url',U('Proposal/Index/index',array('status'=>1)));
        }
        $this->assign('joints',$joint);
        $this->assign('proposal',$proposal);

        $this->display();
    }

    /*
	 * 联名信息保存提交
	 * 些操作仅更新联系建议，不对联名状态作操作
	 *
	 */
    public function doJoint($proposal_id,$content,$status){
        //0  1 为保存 2为已提交
        $data['joint_content'] = $content;
        $data['id'] = $proposal_id;
        //状态只录入发起联名状态和未联名状态，方便联名总结后的筛选录入
        $data['is_joint'] = $status ? 2 : 0;
        $flag = M('Proposal')->save($data);

        if($flag){
            $this->success("联名信息更新成功",U('Proposal/Index/index',array('status'=>1)));
        }else{
            $this->error("联名信息更新失败");
        }

    }

    /*
     * 已提交的提案展示页面
     * create: 2016/10/8
     * author: MR.Z <327778155@qq.com>
     */
    public function detail_view(){

    }

    /*
     * 请求联名操作
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/13
     */
    public function detail_joint($id){
        $proposal_joint = D('ProposalJoint')->where('id='.$id)->find();
        $proposal = D('Proposal')->find($proposal_joint['proposal_id']);

        if($proposal_joint['is_agree']){
            $htmlstatus = 1;
        }else{
            $htmlstatus = 0;
        }
        $backurl = I('server.HTTP_REFERER');
        $this->assign('backurl',$backurl);
        $this->assign('htmlstatus',$htmlstatus);
        $this->assign('proposal',$proposal);
        $this->assign('id',$id);


        $this->display();
    }

    /*
     * 联名处理操作
     *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/14
     */
    public function joint_agree($id){
        $m = D('ProposalJoint');

        $m->create();
        $m->suggest = I('post.suggest');
        $map['id'] = array('eq',$id);

        $flag = $m->where($map)->save();

        if($flag){
            $this->success('更新成功',U('pleaseJoint'));
        }else{
            $this->error('更新失败',U('pleaseJoint'));

        }
    }

    /*
	 * 用户被请求联名信息列表
	 *  create: 2016/10/13
	 * author: MR.Z <327778155@qq.com>
	 */
    public function pleaseJoint(){

        $map['user_id'] = get_uid();
        $proposal_ids = D('ProposalJoint')->where($map)->getField('proposal_id',true);
        $proposal_ids = array_unique($proposal_ids);
        $map_p['p.status'] = array('eq',1);
        $map_p['user_id'] = get_uid();
        $map_p['p.id'] = array('in',$proposal_ids);
        $contents = D('Proposal')->alias('p')->field('p.id,type_id,title,ycode,jiebie,author,contact,is_joint,is_merge,is_agree,pj.id as pjid')->join('LEFT JOIN __PROPOSAL_JOINT__ pj ON p.id=pj.proposal_id')->where($map_p)->select();

        foreach($contents as &$v){
            $v['type'] = $this->getType($v['type_id']);
        }

        $this->assign('statusname','被邀联名');
        $this->assign('contents',$contents);
        $this->display('index');
    }


    /*
     * 被并案的提案列表
     *  create: 2016/10/13
     * author: MR.Z <327778155@qq.com>
     *
     */
    public function pleaseMerge(){

        $map['uid'] = array('eq',get_uid());
        $map['is_merge'] = array('eq',1);
        $map['merge_id'] = array('neq','');
        $contents = D('Proposal')->where($map)->select();
        foreach($contents as &$v){
            $v['type'] = $this->getType($v['type_id']);
        }
        $this->assign('statusname','被并案');
        $this->assign('contents',$contents);
        $this->display('index');
    }

    /**
     * 流程信息列表
     * @param $proposal_id 提案ID
     * autor: MR.Z <327778155@qq.com>
     * create: 2016/8/30
     */
    public function process($proposal_id){
        $proposal = D('Proposal')->find($proposal_id);
        $map['proposal_id'] = array('eq',$proposal_id);
        $result_p = M('ProposalProcess')->where($map)->order('create_time desc')->select();
        $proposal_status = C('PROPOSAL_STATUS');

        $this->assign('back_url',U('Proposal/Index/index',array('status'=>$proposal['status'])));
        $this->assign('proposalstatus',$proposal_status);
        $this->assign('resultprocess',$result_p);
        $this->display();

    }



    /**
     * 提案浏览权限
     * @param int $id
     * autor: MR.Z <327778155@qq.com>
     */
    private function check_view($status){
        $group =  get_group(get_uid() );;

        $view_status = C('VIEW_STATUS');
        $status_tmp = [];
        foreach($group as $v){
            if($view_status[$v]){
                $status_tmp = array_merge($status_tmp,$view_status[$v]);
            }
        }

        $status_arr =  array_unique($status_tmp) ;
        if(!in_array( $status,$status_arr)){
            $this->error("您没有访问该提案的权限");
        }
    }

    /**
     * 提案操作权限
     * @param int $id   //TODO  接收的status必须为单状态  接收的ids 可以为数组，数组默认取第一个元素
     * autor: MR.Z <327778155@qq.com>
     */
    private function check_change($ids,$status){

        $change_status = C('CHANGE_STATUS');
        $id = is_array($ids) ? $ids[0]:$ids;

        $proposal = D('Proposal')->find($id);
        if(!in_array($status,$change_status[$proposal['status']])){
            $this->error('您不能这样操作您的提案');
        }
    }

    /**
     * 获取提案类型
     * @param $type_id
     * @return mixed
     * autor:xjw129xjt
     */
    private function getType($type_id)
    {
        $type = D('ProposalType')->where('id=' . $type_id)->find();

        return $type;
    }

    /***********************************办理单位***********************************************/
    /*
     *  查办列表
     *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/13
     */
    public function handcheck($proposal_id){
        $map['proposal_id'] = array('eq',$proposal_id);

        //查办共用 一个模板，当前用户组是委员

        $results = D('ProposalResult')->where($map)->select();

        foreach($results as &$v){
            //		$v['user'] = D('User/Unit')->getUnit($v['user_id']);
            $mu = D('User/User');
            $mu->setModel(UNIT);
            $v['user'] = $mu->getUser($v['user_id']);

            //	print_r($v['user']);exit;
        }
        //$back_url = U('Proposal/Index/index',array('status'=>13));
        $this->assign('back_url',$back_url);
        $this->assign('result',$results);
        $this->display();
    }

    /*
     * 查看办理
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/13
     */
    public function handreply($result_id){
        $m = D('Proposal/ProposalResult');
        $data = I('post.');
        $data['id'] = $result_id;
        $result = $m->getResultbyId($result_id);
        $mp = D('Proposal');

        if(empty($result)){return false;}
        $proposal = D('Proposal')->find($result['proposal_id']);
        $result['code'] = $proposal['code'];
        $result['proposal_title'] = $proposal['title'];

        $back_url = U('Proposal/result/handcheck',array('proposal_id'=>$proposal['id']));

        $this->assign('back_url',$back_url);
        $this->assign('result',$result);
        $this->display();
    }



    /*****************************以下为ajax**************************************/

    /*
     * 委员提案ajax请求
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/19
     */
    public function get_proposals_ajax($page=1,$map=[]){
        $status = 0;
        $m = D('Proposal');

        $order = 'create_time desc';

        $map_search = I('post.');
        $map_search['author'] = !empty($map_search['author']) ? array('like',"%{$map_search['author']}%") : '';
        $map_search['title'] = !empty($map_search['title']) ? array('like',"%{$map_search['title']}%") : '';

        $map_search = array_filter($map_search);
      //  $map_search =   array_filter($map_search);


        $proposals = D('Proposal')->where($map_search)->page($page+1,10)->order($order)->select();

        $status_config = C('PROPOSAL_STATUS');
        foreach($proposals as $k=>&$v){
            $type = $this->getType($v['type_id']);

            $v['is_joint'] = $v['is_joint'] ? '是':'否';
            $v['is_merge'] = $v['is_merge'] ? '是':'否';
            $v['type'] = $type['title'] ? $type['title'] : '';
            $v['url'] = U('Wap/Proposal/detail',['proposal_id'=>$v['id']]);
            $v['url_process'] = U('Wap/Proposal/process',['proposal_id'=>$v['id']]);
            $v['status'] = $status_config[$v['status']]; $v['is_joint'] = $v['is_joint'] ? '是':'否';
            $v['is_merge'] = $v['is_merge'] ? '是':'否';
            $v['type'] = $type['title'] ? $type['title'] : '';
            $v['url'] = U('Wap/Proposal/detail',['proposal_id'=>$v['id']]);
            $v['url_process'] = U('Wap/Proposal/process',['proposal_id'=>$v['id']]);
            $v['status'] = $status_config[$v['status']];
        }

        if($proposals){
            $rdata['status'] = 1;
            $rdata['page'] = $page + 1;
            $rdata['content'] = $proposals;
        }else{
            $rdata['status'] = 0;
            $rdata['content'] = '没有更多了';
        }
        $this->ajaxReturn($rdata);

    }

    /*
     * 联名提案
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/19
     */
    public function get_pleasejoint_ajax($page=1,$map=[]){
        $status = 0;
        $map['user_id'] = get_uid();
        $proposal_ids = D('ProposalJoint')->where($map)->getField('proposal_id',true);
        $proposal_ids = array_unique($proposal_ids);
        $map_p['p.status'] = array('eq',1);
        $map_p['user_id'] = get_uid();
        $map_p['p.id'] = array('in',$proposal_ids);
        $proposals = D('Proposal')->alias('p')->field('p.id,type_id,title,ycode,jiebie,author,contact,is_joint,is_merge,is_agree')->join('LEFT JOIN __PROPOSAL_JOINT__ pj ON p.id=pj.proposal_id')->where($map_p)->page($page+1,10)->select();

        $status_config = C('PROPOSAL_STATUS');
        foreach($proposals as &$v){
            $type = $this->getType($v['type_id']);

            $v['is_joint'] = $v['is_joint'] ? '是':'否';
            $v['is_merge'] = $v['is_merge'] ? '是':'否';
            $v['type'] = $type['title'] ? $type['title'] : '';
            $v['url'] = U('Wap/Proposal/detail',['proposal_id'=>$v['id']]);
            $v['url_process'] = U('Wap/Proposal/process',['proposal_id'=>$v['id']]);
            $v['status'] = $status_config[$v['status']];
        }

        if($proposals){
            $rdata['status'] = 1;
            $rdata['page'] = $page + 1;
            $rdata['content'] = $proposals;
        }else{
            $rdata['status'] = 0;
            $rdata['content'] = '没有更多了';
        }

        $this->ajaxReturn($rdata);
    }


    /*
     * 被并案提案
     * author: MR.Z <327778155@qq.com>
     * create : 2016/10/19
     */
    public function get_pleasemerge_ajax($page=1,$map=[]){
        $status = 0;

        $map['uid'] = array('eq',get_uid());
        $map['is_merge'] = array('eq',1);
        $map['merge_id'] = array('neq','');
        $proposals = D('Proposal')->where($map)->page($page+1,10)->select();

        $status_config = C('PROPOSAL_STATUS');
        foreach($proposals as &$v){
            $type = $this->getType($v['type_id']);

            $v['is_joint'] = $v['is_joint'] ? '是':'否';
            $v['is_merge'] = $v['is_merge'] ? '是':'否';
            $v['type'] = $type['title'] ? $type['title'] : '';
            $v['url'] = U('Wap/Proposal/detail',['proposal_id'=>$v['id']]);
            $v['url_process'] = U('Wap/Proposal/process',['proposal_id'=>$v['id']]);
            $v['status'] = $status_config[$v['status']];
        }

        if($proposals){
            $rdata['status'] = 1;
            $rdata['page'] = $page + 1;
            $rdata['content'] = $proposals;
        }else{
            $rdata['status'] = 0;
            $rdata['content'] = '没有更多了';
        }

        $this->ajaxReturn($rdata);
    }

    public function check_title_ajax($title){
        $status = 0;
        if($title){
            $map['title'] = array('like',"%{$title}%");
            $contents = D('Proposal')->where($map)->select();

        }
        foreach($contents as &$v){
            $v['title'] = str_replace($title,"<font color=red>{$title}</font>",$v['title']);
            $v['create_time'] = date('Y-m-d',$v['create_time']);
        }
        if($contents){
            $status = 1;
            $data['content'] = $contents;
        }
        $data['status'] = $status;
        $this->ajaxReturn($data);
    }

    /*
     * 选择联名
     * create: 2016/10/17
     * author: MR.Z <327778155@qq.com>
     * msg 1 选取联名 2 取消联名
     */
    public function jointly_chosen_ajax($uid,$proposal_id){
        $status = 0;
        if(IS_AJAX){
            $m = D('ProposalJoint');
            $pj = $m->where(['user_id'=>$uid,'proposal_id'=>$proposal_id])->find();
            if($pj){
                $flag = $m->delete($pj['id']);
                if($flag){
                    $status = 1;

                    $rdata['msg'] = 2;
                }
            }else{
                $data['user_id'] = $uid;
                $data['proposal_id'] = $proposal_id;
                $data['create_time'] = time();
                $flag = $m->add($data);
                if($flag){
                    $status = 1;

                    $rdata['msg'] = 1;
                }
            }
            $rdata['status'] = $status;
            $this->ajaxReturn($rdata);
        }
    }

    /*
     * 删除联名
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/17
     */
    public function  del_chosen_ajax($id){
        $status = 0;
       $flag =  D('ProposalJoint')->delete($id);
        if($flag){
            $status = 1;
        }
        $rdate['status'] = $status;
        $this->ajaxReturn($rdate);
    }

}