<?php


namespace Historical\Controller;

use Common\Controller\BaseController;

class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {   parent::_initialize();
        $tree = D('HistoricalType')->where('status=1')->select();
        $this->assign('tree', $tree);
        

        $this->assign('current', 'historical');
    }

    //主页面显示
    public function index(){

        $work = D('Historical'); // 实例化User对象
        if(IS_POST){
	        $title = I('post.title');
	        $stime 	= I('post.stime');
	        $etime= I('post.etime');
	
	        $stime=strtotime($stime);
	        $etime=strtotime($etime);
	
	        $where['title'] = array('like',"%{$title}%");
	
	
	        if(!empty($stime) && !empty($etime)){
		        $where['time'] =array('between',"{$stime},{$etime}");
	        }elseif(!empty($stime) && empty($etime)){
		        $where['time'] =array('gt',$stime);
	        }elseif(empty($stime) && !empty($etime)){
		        $where['time'] =array('lt',$etime);
	        }

          
        }
        $count= $work->where($where)->count();
        $Page= new \Think\Page($count,10);
        $content = $work->where($where)->order('time desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	    
	    foreach($content as &$v){
	    	$v[type] =  $this->getType($v['type_id']);
	    }
        $this->assign('content',$content);
        $this->assign('page',$Page->show());
        $this->display();
    }

   //未提交状态的删除
    public function remove($id){
        if (!is_login()) {
            $this->error('请登陆后在修改。');
        }

        /*if (!check_auth('removehistorical')) {

            $this->error('抱歉，您不具备删除文史资料的权限。');
        }*/

        $id=I('post.id');
        $model=D('Historical');
        $read=$model->where(array('id'=>$id))->delete();
        if($read){
            $exit=array('code'=>1,'msg'=>"删除成功");
        }else{
            $exit=array('code'=>0,'msg'=>"删除失败");
        }
        echo json_encode($exit);


    }
    


    public function detail($id){
        $content=D('Historical')->find($id);
        $this->assign('content',$content);
        $this->display();
    }


//查看编辑未提交文史
    public function edit($id)
    {
        $content = D('Historical')->find($id);
        $this->assign('content',$content);
        $this->display();
    }


    //修改未提交的文史
    public function save($id)
{
    if (!is_login()) {
        $this->error('请登陆后在修改。');
    }

    /*if (!check_auth('edithistorical')) {

        $this->error('抱歉，您不具备添加文史资料的权限。');
    }*/

    $model =D('Historical');
    $data=I('post.');
    $data['time']=strtotime(I('post.time'));
    $resaut=$model->where(array('id' => $id))->save($data);
    $peoples = array_unique(array_filter(explode(',',$data['people'])));
    //处理积分添加
    if($data['adopt'] == 1 && !empty($id)){

        foreach($peoples as $v){

            update_action_log('weiyuan_historical_adopt','historical',$id,$v);
        }
    }elseif($data['adopt'] == 2 && !empty($id)){
        foreach($peoples as $v){

            del_action_log('weiyuan_historical_adopt','historical',$id,$v);
        }


    }

        if($resaut){
            $this->success('保存成功');
        }else{
            $this->error('保存失败');
        }
    }
    

    //审核成功
    public function save1($id,$adopt='')
    {
        if (trim(op_t($adopt)) == '') {
        $this->error('采用情况不能为空');
    }
        $model =D('Historical');
        $data=I('post.');
        $data['status']=4;
        $re=$model->where(array('id' => $id))->save($data);

            if($re)
        {
            $this->success("审核成功");
        }else{
            $this->error("审核失败");
        }
    }
//退回后从新提交
    public function save2($id,$adopt='')
    {
        $model =D('Historical');
        $data=I('post.');
        $data['status']=2;
        if($model->where(array('id' => $id))->save($data)) {
            $this->success("提交成功");
        }else{
            $this->error("提交失败");
        }
    }
    //查看已提交状态
public function show($id){
    $model=D('Historical');
    $tw = $model->where(array('id' => $id))->find();
    $this->assign('tw',$tw);
    $this->display();
}
    //查看已通过审核详情页
    public function show1($id){
        $fou = D('Historical')->where(array('id' => $id))->find();
        $this->assign('fou',$fou);
        $this->display();
    }

    public function show2($id){
        $thr = D('Historical')->where(array('id' => $id))->find();
        $this->assign('thr',$thr);
        $this->display();
    }
//提交文史资料
    public function upload($type_id='',$title ='',$content, $time = '',$remake='')
    {
        if (!is_login()) {
            $this->error('请登陆后再添加。');
        }

        /*if (!check_auth('addhistorical')) {

            $this->error('抱歉，您不具备添加文史资料的权限。');
        }*/

        if (trim(op_t($type_id)) == '') {
            $this->error('请输入发言类别。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入发言或者报告题目。');
        }
        if (trim(op_t($time)) == '') {
            $this->error('请输入时间。');
        }
        if (trim(op_t($content)) == '') {
            $this->error('请输入备注内容。');
        }

        $data=I('post.');
        $model=D('Historical');
        $data['time']=strtotime(I('post.time'));
	      $id = I('get.id');
	      $data['uid'] = get_uid();
        if($id){
            $flag=$model->save($data);
        }else{
            $rs = $model->add($data);
	  
        }
				
	
				if($rs){
			    $map_f['user_id'] = get_uid();
			    $map_f['model'] = MODULE_NAME;
			    $map_f['record_id'] = 0;
			    D('Fileu')->where($map_f)->setField('record_id',$rs);
				}

				//处理积分添加
	      if($data['adopt'] == 1 && !empty($rs)){

	      	foreach(explode(',',$data['people']) as $v){
                update_action_log('weiyuan_historical_adopt','historical',$rs,$v);
		      }
	      }
        
        if ($flag ||  $rs) {
	        $this->success("添加成功",U('index/index'));
           
        }else{
	        $this->error("添加失败");
        }

    }

    //添加页面直接提交
    public function inseter($id=0)
    {
        if (IS_POST) {
            //如果接收到了post请求，就添加数据
            $model = D('Historical');
            $data = I('post.');
            $data['status']=2;
            if ($id) {
                $flag = $model->save($data);
            } else {
                $flag = $model->add($data);
            }
            if ($flag) {
                return $this->ajaxReturn('1');
            } else {
                return $this->ajaxReturn($model->getError());
            }
        }
    }


    public function add(){
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
	    $time=date('Y-m-d H:i:s');
	    $time=strtotime($time);
	    $this->assign('time',$time);
	    $this->display();
    }



  /*  public function search(){
        //接收
        $type 	= I('post.type');
        $author	=I("post.author");
        $stime 	= I('post.stime');
        $status = I('post.status');
        $etime= I('POST.etime');

        //判断是否有值
        if(!empty($author)){
            $where['author']=$author;
        };
        if(!empty($type)){
            $where['type']=$type;
        };
        if(!empty($stime)&&!empty($etime)){
            $where['time'] =array(array('egt',$stime),array('elt',$etime));
        }elseif(!empty($stime)){
            $where['time'] =array('egt',$stime);
        }elseif(!empty($etime)){
            $where['time'] =array('elt',$etime);
        }
        if($status||$status=='0'){
            $where['status']=$status;
        };

        //实例化模型
        $model=D('History');
        //查询
        $re=$model->where($where)->select();
        $this->assign('uid',$uid);
        $this->assign('type',$type);
        $this->assign('status',$status);
        $this->assign('stime',$stime);
        $this->assign('etime',$etime);
        $this->assign('re', $re);
        $this->display();
    }*/

    public function qdadd(){
        $this->display();
    }
	
	
	private function getType($type_id)
	{
		$type = D('HistoricalType')->where('id=' . $type_id)->find();
		return $type;
	}
}