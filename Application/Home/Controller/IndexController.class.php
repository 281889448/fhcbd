<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;

use Common\Controller\BaseController;
use OT\DataDictionary;


/**
 * 前台首页控制器
 * 主要获取首页聚合数据
 */
class IndexController extends BaseController
{

    //系统首页
   public function index()
    {

        $default_url=C('DEFUALT_HOME_URL');//获得配置，如果为空则显示聚合，否则跳转

			$this->assignProposalCount();
	    $this->assignPollsCount();
	    $this->assignWorkingCount();
	    $this->assignMessage();
			$this->assignWork();
	    $this->assignPolls();
        $this->assignSurveyCount();

               $this->display();
            }

    private function assignPostCount()
    {
        $post_count = S('home_post_count');
        if (empty($post_count)) {
            $post_count = D('ForumPost')->where(array('status' => 1))->count();
            S('home_post_count', $post_count, 1);
        }
        $this->assign('post_count', $post_count);
    }

    private function assignProposalCount(){
//joint 联名 merge 并案 review 审核 status8 已立案 stauts3 退回 status17 已办理反馈 status14 退回重办 status18 待交办 status181 移交办理 status13 已办理 status19 待办理
    	$proposal_joint_count    = S('proposal_joint_count');
	    $proposal_review_count   = S('proposal_review_count');
	    $proposal_status8_count  = S('proposal_status8_count');
	    $proposal_status3_count  = S('proposal_status3_count');
	    $proposal_status17_count = S('proposal_status17_count');
	    $proposal_status14_count = S('proposal_status14_count');
	    $proposal_status18_count = S('proposal_status18_count');
	    $proposal_status11_count = S('proposal_status11_count');
	    $proposal_status13_count = S('proposal_status13_count');
	    $proposal_status19_count = S('proposal_status19_count');
	    
	    $mp = D('Proposal');
	    $mr = D('ProposalResult');
	    //参与联名提案
	    if(empty($proposal_joint_count)){
	      
	    	$proposal_joint_count = $mp->alias('p')->join('LEFT JOIN __PROPOSAL_JOINT__ pj ON p.id=pj.proposal_id')->where(array('status'=>1,'user_id'=>get_uid()))->count();
		    S('proposal_joint_count',$proposal_joint_count, 1);
	  
	    }
	    $this->assign('proposal_joint_count',$proposal_joint_count);

	    //待审核
	    if(empty($proposal_review_count)){
	    	$map['status']  = array('in',array(2));
		    $map['is_merge'] = array('in',array(0,2));
		    $proposal_review_count = $mp->where($map)->count();
	
		    S('proposal_review_count',$proposal_review_count, 1);
		
	    }
	    $this->assign('proposal_review_count',$proposal_review_count);
	

			//已立案
	    if(empty($proposal_status8_count)){
		    $proposal_status8_count = $mp->where(array('status'=>8,'uid'=>get_uid()))->count();
		   
		    S('proposal_status8_count',$proposal_status8_count, 1);
		
	    }
	    $this->assign('proposal_status8_count',$proposal_status8_count);
	
	
	    //已立案   非委员集体
	    if(empty($proposal_status8_count_2)){
		    $proposal_status8_count_2 = $mp->where(array('status'=>8))->count();
		
		    S('proposal_status8_count_2',$proposal_status8_count_2, 1);
		
	    }
	    $this->assign('proposal_status8_count_2',$proposal_status8_count_2);
	    
	    //退回
	    if(empty($proposal_status3_count)){
		    $proposal_status3_count = $mp->where(array('status=3','uid'=>get_uid()))->count();

		    S('proposal_status3_count',$proposal_status3_count, 1);
		
	   }
	    $this->assign('proposal_status3_count',$proposal_status3_count);
	    
	    //已办理反馈
	    if(empty($proposal_status17_count)){
		    $map['is_merge'] = array('in',array(0,2));
		    $map['status'] = 17;
		    $proposal_status17_count = $mp->where($map)->count();
		    
		    S('proposal_status17_count',$proposal_status17_count, 1);
		
	    }
	    $this->assign('proposal_status17_count',$proposal_status17_count);
	    
	    //退回重办
	  //  if(empty($proposal_status14_count)){
	    	$map_r['status'] = 5;
		    $map_r['user_id'] = get_uid();
		    $proposal_status14_count = $mr->where($map_r)->count();
	    unset($map_r);
		    S('proposal_status14_count',$proposal_status14_count, 1);
		
	    //}
	    $this->assign('proposal_status14_count',$proposal_status14_count);
	    
	    //待交办
	    if(empty($proposal_status18_count)){
	    	
		    $proposal_status18_count = $mp->where('status=18')->count();
		    S('proposal_status18_count',$proposal_status18_count, 1);
		
	    }
	    $this->assign('proposal_status18_count',$proposal_status18_count);
	    
	    //移交办理
	    if(empty($proposal_status193_count)){
		    $proposal_status193_count = $mp->alias('p')->join('__PROPOSAL_RESULT__ pr on p.id=pr.proposal_id')->where('p.status=19 and pr.status=3 and  p.is_merge IN (0,2)')->count();
	
		  
		      S('proposal_status193_count',$proposal_status193_count, 1);
		
	    }
	    $this->assign('proposal_status193_count',$proposal_status193_count);
	    
	    //已办理---督查室
	    if(empty($proposal_status13_count_2)){
	
		 //   $map_r['pr.status'] = 2;
		    $map_r['p.status'] = 13;
		    $proposal_status13_count_2 = $mp->alias('p')->where($map_r)->count();

		    unset($map_r);
		    S('proposal_status13_count_2',$proposal_status13_count_2, 1);
		
	    }
	    $this->assign('proposal_status13_count_2',$proposal_status13_count_2);
	    
	    
	    //已办理
	    if(empty($proposal_status13_count)){
		    $map_r['pr.user_id'] = get_uid();
		    $map_r['pr.status'] = 2;
	    $map_r['p.status'] = 13;
		    $proposal_status13_count = $mr->alias('pr')->join('__PROPOSAL__ p on pr.proposal_id=p.id')->where($map_r)->count();
	 
		    unset($map_r);
		    S('proposal_status13_count',$proposal_status13_count, 1);
		
	    }
	    $this->assign('proposal_status13_count',$proposal_status13_count);
	    
	    //待办理
	    if(empty($proposal_status19_count)){
		    $map_r['pr.user_id'] = get_uid();
		    $map_r['pr.status'] = array('in',[1,6]);
	      $map_r['p.status'] = 19;
		    $proposal_status19_count = $mr->alias('pr')->join('__PROPOSAL__ p on pr.proposal_id=p.id')->where($map_r)->count();

		    S('proposal_status19_count',$proposal_status19_count, 1);
		
	   }
	    $this->assign('proposal_status19_count',$proposal_status19_count);
	
			
    }
    
    
    /*
     * 社情民意个数
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/18
     */
    private function assignPollsCount(){
    	$model = D('Polls');
    	$polls_review_count_2 = S('polls_review_count_2');
	    $polls_review_count_3 = S('polls_review_count_3');
	    $group = get_group(get_uid());

        if(get_permission(get_uid(),['集体'])){

		    	$map['uid'] = get_uid();
			    $map['status'] = 2;
			    $polls_review_count_user = $model->where($map)->count();
			    $this->assign('polls_review_count_user',$polls_review_count_user);
			    unset($map);

        }


	    
	    
	    
	    if(empty($polls_review_count_2)){
	    	$map['status'] = 2;
	    	$polls_review_count_2 = $model->where($map)->count();
		    S('polls_review_count_2',$polls_review_count_2, 1);
	    }
	    if(empty($polls_review_count_3)){
		    $map['status'] = 3;
		    $polls_review_count_3 = $model->where($map)->count();
		    S('polls_review_count_3',$polls_review_count_3, 1);
	    }
	    
	    $this->assign('polls_review_count_2',$polls_review_count_2);
	    $this->assign('polls_review_count_3',$polls_review_count_3);
	    
    }


    private function assignSurveyCount(){

      //  $uid = get_uid();
    //    $map['_string'] = "{$uid} in (author_id) or author_id =''";
        $surveys = D('Survey')->order('time desc,id desc')->limit('0,5')->select();

        $m = D('User/User');
        $m->setModel(WEIYUAN);

        foreach($surveys as &$v){
            $user = $m->getUser($v['uid']);
            $v['author'] = $user['名称'];
        }
        $this->assign('surveys',$surveys);

    }
    
    /*
     * 工作动态个数
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/18
     *
     */
    private function assignWorkingCount(){
	    $model = D('Working');
	    $working_review_count_2 = S('working_review_count_2');
	    $working_review_count_3 = S('working_review_count_3');
	    $group = get_group(get_uid());
        if(get_permission(get_uid(),['集体'])){
            $map['uid'] = get_uid();
            $map['status'] = 2;
            $working_review_count_uid = $model->where($map)->count();
            $this->assign('working_review_count_user',$working_review_count_uid);
            unset($map);

        }

	
	
	
	    if(empty($working_review_count_2)){
		    $map['status'] = 2;
		    $map['bstatus'] = 1;
		    $working_review_count_2 = $model->where($map)->count();
		    S('working_review_count_2',$working_review_count_2, 1);
	    }
	    if(empty($working_review_count_3)){
		    $map['status'] = 3;
		    $map['bstatus'] = 1;
		    $working_review_count_3 = $model->where($map)->count();
		    S('working_review_count_3',$working_review_count_3, 1);
	    }
	
	    $this->assign('working_review_count_2',$working_review_count_2);
	    $this->assign('working_review_count_3',$working_review_count_3);
    }
    
    /*
     * 通知公告
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/11
     *
     */
    private function  assignMessage(){
        $uid = get_uid();
        $map['_string'] = "{$uid} in (people) or people =''";
    	$msgs = D('Message')->where($map)->order('stime desc,id desc')->limit('0,5')->select();

	    $m = D('User/User');
	    $m->setModel(WEIYUAN);
	    
	    foreach($msgs as &$v){
	    	$user = $m->getUser($v['uid']);
	    	$v['author'] = $user['名称'];
	    }
	    $this->assign('msgs',$msgs);
	    
    }
    
    /*
     * 工作动态
     * author: MR.Z <327778155@qq.com>
     *  create: 2016/9/11
     */
    private function assignWork(){

        $map['status'] = 6;
    	$works = D('Working')->where( $map)->order('time desc')->limit('0,5')->select();

        $m = D('User/User');
        $m->setModel(WEIYUAN);
	   foreach($works as &$v){
	       $v['user'] = $m->getUser($v['uid']);
       }


	    $this->assign('works',$works);
    }
	
    private function assignPolls(){
        $uid = get_uid();
        $map['status'] = 6;


    	$polls  = D('Polls')->where($map)->order('time desc')->limit('0,5')->select();

	    $m = D('User/User');
	    $m->setModel(WEIYUAN);
			foreach($polls as &$v){
				$v[type] = $this->getPollsType($v[type_id]);
				$user = $m->getUser($v['uid']);
				$v['author'] = $user['名称'];
			}

	    $this->assign('polls',$polls);
    }
	
	private function getPollsType($type_id)
	{
		$type = D('PollsType')->where('id=' . $type_id)->find();
		return $type;
	}



	/*
	 * 公告列表页
	 *  author: MR.Z <327778155@qq.com>
	 * create: 2016/10/18
	 */
	public function message($page = 1){

	    if(IS_POST){
	        $map = I('post.');
            $map['title'] = ['like',"%{$map['title']}%"];
        }
        $uid = get_uid();
        $map['_string'] = "{$uid} in (people) or people =''";
        $msgs = D('Message')->where($map)->order('stime desc,id desc')->page($page,15)->select();

        $totalCount = D('Message')->where($map)->count();
        $m = D('User/User');
        $m->setModel(WEIYUAN);

        foreach($msgs as &$v){
            $user = $m->getUser($v['uid']);
            $v['author'] = $user['名称'];
        }
        $this->assign('msgs',$msgs);
        $this->assign('totalPageCount', $totalCount);
        //{:getPagination($totalPageCount,10)}
        $this->display();
    }


    public function survey($page=1){
        if(IS_POST){
            $map = I('post.');
            $map['title'] = ['like',"%{$map['title']}%"];
        }
        $uid = get_uid();
        $map['_string'] = "{$uid} in (author_id) or author_id =''";
        $surveys = D('Survey')->where($map)->order('time desc,id desc')->page($page,15)->select();

        $totalCount = D('Survey')->where($map)->count();
        $m = D('User/User');
        $m->setModel(WEIYUAN);

        foreach($surveys as &$v){
            $user = $m->getUser($v['uid']);
            $v['author'] = $user['名称'];
        }
        $this->assign('surveys',$surveys);
        $this->assign('totalPageCount', $totalCount);
        //{:getPagination($totalPageCount,10)}
        $this->display();
    }
    /*
     * 工作动态列表页
     *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/18
     */
    public function working($page = 1){
        if(IS_POST){
            $map = I('post.');
            $map['title'] = ['like',"%{$map['title']}%"];
            $stime=strtotime($map['stime']);
            $etime=strtotime($map['etime'])+3600*24;

            if(!empty($map['stime']) && !empty($map['etime'])){
                $map['time'] =array('between',"{$stime},{$etime}");
            }elseif(!empty($map['stime']) && empty($map['etime'])){
                $map['time'] =array('gt',$stime);
            }elseif(empty($map['stime']) && !empty($map['etime'])){
                $map['time'] =array('lt',$etime);
            }
        }

        $map['status'] = 6;
        $works = D('Working')->where( $map)->order('time desc')->page($page,15)->select();

        $totalCount = D('Working')->where($map)->count();
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        foreach($works as &$v){
            $v['user'] = $m->getUser($v['uid']);
        }

        $this->assign('totalPageCount', $totalCount);
        $this->assign('works',$works);
        $this->display();
    }

    /*
     * 社情民意列表页
     *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/18
     */
    public function polls($page = 1){
        $uid = get_uid();

        $tree = D('PollsType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);

        if(IS_POST){
            $map = I('post.');
            $map['title'] = ['like',"%{$map['title']}%"];
            $stime=strtotime($map['stime']);
            $etime=strtotime($map['etime'])+3600*24;

            if(!empty($map['stime']) && !empty($map['etime'])){
                $map['time'] =array('between',"{$stime},{$etime}");
            }elseif(!empty($map['stime']) && empty($map['etime'])){
                $map['time'] =array('gt',$stime);
            }elseif(empty($map['stime']) && !empty($map['etime'])){
                $map['time'] =array('lt',$etime);
            }
        }

        $map['status'] = 6;




        $polls  = D('Polls')->where($map)->order('time desc')->page($page,15)->select();

        $totalCount = D('Polls')->where($map)->count();
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        foreach($polls as &$v){
            $v[type] = $this->getPollsType($v[type_id]);
            $user = $m->getUser($v['uid']);
            $v['author'] = $user['名称'];
        }
        $this->assign('totalPageCount', $totalCount);
        $this->assign('polls',$polls);
        $this->display();
    }

    public function help(){
        $this->display();
    }


}