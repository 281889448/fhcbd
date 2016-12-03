<?php


namespace Survey\Controller;

use Common\Controller\BaseController;
use Weibo\Api\WeiboApi;

class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {   parent::_initialize();
        $tree = D('SurveyType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);


        $this->assign('current', 'survey');
    }
//主页面
  public function index(){

      $model = D('Survey'); // 实例化User对象
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
      $where['uid'] = get_uid();
      $count= $model->where($where)->count();
      $Page= new \Think\Page($count,10);
      $list = $model->where($where)->order('time desc')->limit($Page->firstRow.','.$Page->listRows)->select();
	
	  foreach($list as &$v){
	  	$v[type] = $this->getType($v['type_id']);
	  }
	  
	  
      $this->assign('list',$list);
      $this->assign('page',$Page->show());
      $this->display();
  }
    public function add()
    {
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
    //未提交查看页面
    public function detail($id){
        $content = D('Survey')->where(array('id' =>$id))->find();
        $this->assign('content',$content);
        $this->display();
    }

    public function prepare($id){
        $content = D('Survey')->where(array('id' =>$id))->find();
        $back_url = I('server.HTTP_REFERER');
        $this->assign('back_url',$back_url);
        $this->assign('content',$content);

        $this->display();
    }

    //添加调研报告
    public function upload($author="",$type_id="",$title="",$content=""){
    	if(IS_POST){
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }

      /*  if (!check_auth('addsurvey')) {

            $this->error('抱歉，您不具备提交调研报告的权限。');
        }*/

        if (trim(op_t($author)) == '') {
            $this->error('请输入撰写人。');
        }
        if (trim(op_t($type_id)) == '') {
            $this->error('请输入类型。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }
        if (trim(op_t($content)) == '') {
            $this->error('请输入备注内容。');
        }
            if(empty(I('post.people'))){
                $this->error('请添加参与人员');
            }

        $data=I('post.');
        $data['time']=strtotime(I('post.time'));
        $data['uid'] = get_uid();
	      $data['speak'] = implode(',',$data['speak']);
        $model=D('Survey');

        $id = $model->add($data);

	    $map_f['user_id'] = get_uid();
	    $map_f['model'] = MODULE_NAME;
	    $map_f['record_id'] = 0;
	    D('Fileu')->where($map_f)->setField('record_id',$id);



         //调研报告加分  参与加分处理

         $people_arr = array_unique(explode(',',$data['people']));

          foreach($people_arr as $v){

             update_action_log('weiyuan_survey_unit','survey',$id,$v);

          }

            //调研报告发言加分

         $speak =  min(I('post.speak'));


            $author_arr = array_unique(explode(',',$data['author_id']));

            foreach($author_arr as $va){
                //    在调研报告按篇加分之前，对之前数据进行清除

                del_action_log('weiyuan_survey_allfy','survey',$id, $va);
                del_action_log('weiyuan_survey_allsm','survey',$id, $va);
                del_action_log('weiyuan_survey_cwfy','survey',$id, $va);
                del_action_log('weiyuan_survey_cwsm','survey',$id, $va);

                switch($speak){
                    case 1:
                        action_log('weiyuan_survey_allfy','survey',$id,$va);
                        break;
                    case 2:
                        action_log('weiyuan_survey_allsm','survey',$id,$va);
                        break;
                    case 3:
                        action_log('weiyuan_survey_cwfy','survey',$id,$va);
                        break;
                    case 4:
                        action_log('weiyuan_survey_cwsm','survey',$id,$va);
                        break;
                }
            }


	    

	    
	    
        if (empty($id)) {
            $this->error("添加失败");
        }else{
            $this->success("添加成功",U('index/index'));
        }
	    }
    }
//修改调研报告
public function save($id){
    if (!is_login()) {
        $this->error('请登陆后再修改。');
    }

 /*   if (!check_auth('editsurvey')) {

          $this->error('抱歉，您不具备修改调研报告的权限。');
      }*/
        $model =D('Survey');
        //如果接收到了post请求，就修改数据
        $data=I('post.');
        $data['time']=strtotime(I('post.time'));
        $data['speak']=implode(',',I('post.speak'));


    //调研报告加分  参与加分处理

    $people_arr = array_unique(explode(',',$data['people']));

    foreach($people_arr as $v){

        update_action_log('weiyuan_survey_unit','survey',$id,$v);

    }
    //调研报告发言加分

    $speak =  min(I('post.speak'));

//    在调研报告按篇加分之前，对之前数据进行清除
    $author = explode(',',I('post.author_id'));

    foreach($author as $v){
        del_action_log('weiyuan_survey_allfy','survey',$id,$v);
        del_action_log('weiyuan_survey_allsm','survey',$id,$v);
        del_action_log('weiyuan_survey_cwfy','survey',$id,$v);
        del_action_log('weiyuan_survey_cwsm','survey',$id,$v);


        switch($speak){
            case 1:
                action_log('weiyuan_survey_allfy','survey',$id,$v);
                break;
            case 2:
                action_log('weiyuan_survey_allsm','survey',$id,$v);
                break;
            case 3:
                action_log('weiyuan_survey_cwfy','survey',$id,$v);
                break;
            case 4:
                action_log('weiyuan_survey_cwsm','survey',$id,$v);
                break;
        }
    }


        if($model->where(array('id'=>$id))->save($data)){
            $this->success('保存成功');
        }else{

          $this->error('保存失败');
        }
    }



    //删除调研报告
    public function remove($id){
        if (!is_login()) {
            $this->error('请登陆后再操作。');
        }

        /*if (!check_auth('removesurvey')) {

            $this->error('抱歉，您不具备删除调研报告的权限。');
        }*/
        $id=I('post.id');
        $model=D('Survey');
        $read=$model->where(array('id'=>$id))->delete();
        if($read){
            $exit=array('code'=>1,'msg'=>"删除成功");
        }else{
            $exit=array('code'=>0,'msg'=>"删除失败");
        }
        echo json_encode($exit);

    }
//修改调研报告
public function edit($id){
 if(IS_POST){
        $model =D('Survey');
        //如果接收到了post请求，就修改数据
        $id=$_POST['id'];
        $data=I('post.');
        if($model->where(array('id'=>$id))->save($data)){
            return $this->ajaxReturn('1');
        }else{
            //添加失败
            return $this->ajaxReturn($model->getError());
        }
    }
    $content = D('Survey')->where(array('id' =>$id))->find();
    $this->assign('content',$content);
    $this->display();
}
	
	
	/**
	 * 获取提案类型
	 * @param $type_id
	 * @return mixed
	 * autor:xjw129xjt
	 */
	private function getType($type_id)
	{
		$type = D('SurveyType')->where('id=' . $type_id)->find();
		return $type;
	}

    /****************************下面是ajax方法******************************************/
    /*
     * 通过输入的作者名称检索出符合条件的作者
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/30
     */
    public function search_user_ajax(){
        $status = 0;
        if(IS_POST){
            $status = 1;
            $m = D('User/User');
            $author = I('post.author');
            $map['名称'] = ['like',"%{$author}%"];
            $m->setModel(WEIYUAN);
            $users = $m->getUsers($map);
            $rdata['status'] = $status;
            $rdata['content'] = $users;

        }
        $this->ajaxReturn($rdata);
    }

}