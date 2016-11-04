<?php


namespace Proposal\Controller;

use Common\Controller\BaseController;
use Sms\Sms;
use Weibo\Api\WeiboApi;
use User\Model\User;
use Common\Api\WeixinApi;


/*
 * 并案状态 0 未并案 1被并案 2 第一提案人
 *
 *
 */

//提案交办控制器，用于提案提交与展示，不涉及后面的流程操作
class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        parent::_initialize();
        $tree = D('ProposalType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);
	

        $this->assign('current', 'proposal');
    }
	
	
	public function __call($name,$param){

		   if (!check_auth(ACTION_NAME)) {
		
			    $this->error('抱歉，您不具备更改提案状态的权限。');
		   }
		
		
		
		//在此作权限判断
		 preg_match('/([a-zA-Z]+)([\d]+)/',$name,$data);
			$method = $data[1];

			$this->$method(I('post.ids'),$data[2]);
	
	}

    /**
     * 提案首页
     * @param int    $page
     * @param int    $type_id
     * @param string $norh
     * author: MR.Z <327778155@qq.com>
     */
    public function index($page = 1, $type_id = 0, $norh = 'new')
    {

        C('TOKEN_ON',false);
			$status_p = I('get.status','');
	    if(strlen($status_p)>2 && !stripos($status_p,',')){
	    	$status = substr($status_p,0,2);
		    $substatus = substr($status_p,2,1);
	    }else{
	    	$status = $status_p;
	    }
	   
	    //固定的状态下才会有匹配user_id
			$uid_array = C('UID_FILTER');
	    $group = get_group(get_uid());
        if(array_intersect($group,['委员','集体'])){
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
				if($status=='4,5,6,7'){$status=4;}
	    if($status=='8,11,13,14,17,18,19'){$status=8;}
				//所有状态集合
				$status_config = C('PROPOSAL_STATUS');
	    
	      $this->assign('group',$group);
	      $this->assign('status',$status);
	      $this->assign('substatus',$substatus);
				$this->assign('status_config', $status_config);
        $this->assign('type_id', $type_id);
        $this->assign('contents', $content);
        $this->assign('norh', $norh);
        $this->assign('totalPageCount', $totalCount);
        $this->setTitle('提案交办首页');
        $this->setKeywords('提案交办');
        $this->display();
    }


    /** 集体下委员提案的提案，该流程仅限集体主任查看
     *  author: MR.Z <327778155@qq.com>
     * create : 2016/10/19
     *
     */
   /* public function index_team(){
        $map = I('post.');

        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $user = $m->getUser(get_uid());
        $roler = $user['主任'];


        $mp = D('Proposal');
        $map['_string'] = " (jdllw='{$roler}' OR zwh='{$roler}') ";
        $map['status'] = ['neq',1];

        $contents = $mp->where($map)->select();

        $this->assign('current','search');
        $this->assign('contents',$contents);
        $this->display();
    }*/



		/**
		 * 办理单位首页
		 * @param int    $page
		 * @param int    $type_id
		 * @param string $norh
		 * autor: MR.Z <327778155@qq.com>
		 */
		public function result($page = 1, $type_id = 0, $norh = 'new'){
			//  $result_status = array('13','14','19');    //此为办理单位的三个状态
			$status = I('get.status','');
			switch($status){
				case 13:
					$map['pr.status'] = array('in',"2");
					$map['p.status'] = array('in',$status);
					break;
				case 14:
					$map['pr.status'] = array('in',"5");
					$map['p.status'] = array('in',array(13));
					break;
				case 19:
					$map['pr.status'] = array('in',array(1,6));
					$map['p.status'] = array('in',$status);
					break;
			}
	
			//$map[C('DB_PREFIX').'proposal.'.'status'] = array('in',"{$status}");
			$map['pr.user_id'] = array('eq',get_uid());
			$this->check_view($status);
			$type_id = intval($type_id);
			if ($type_id != 0) {
				$map['type_id'] = $type_id;
			}
			// $map['status'] = 1;
			$order = 'pr.status=1 desc,pr.create_time desc';
			$norh == 'hot' && $order = 'signCount desc';
			$content = M('ProposalResult')->alias('pr')->field('pr.id as result_id,proposal_id,p.telephone,pr.status as rstatus,title as proposal_title,jiebie,type_id,author,is_merge,is_joint,p.code')->join('__PROPOSAL__ p ON pr.proposal_id=p.id')->where($map)->order($order)->page($page, 10)->select();


			$totalCount = M('PorposalResult')->alias('pr')->join('LEFT JOIN __PROPOSAL__ ON __PROPOSAL_RESULT__.proposal_id=__PROPOSAL__.id')->where($map)->count();
			
			foreach($content as &$v){
				$v['type'] = $this->getType($v['type_id']);


                $map_pp['to_status'] = ['eq',193];

                $map_pp['result_id'] = ['eq',$v['result_id']];
                $backflag = M('ProposalProcess')->where($map_pp)->order('id desc')->find();

                if($backflag){$v['backflag'] = 1;}
			}

			//退回移交办理的申请



			$status_config = C('PROPOSAL_STATUS');

			$this->assign('status', $status);
			$this->assign('status_config', $status_config);
			$this->assign('type_id', $type_id);
			$this->assign('contents', $content);
			$this->assign('norh', $norh);
			$this->assign('totalPageCount', $totalCount);
			$this->getRecommend();
			$this->setTitle('提案交办办理单位首页');
			$this->setKeywords('提案交办-办理单位');
			$this->display();
		}
	
	/**
	 * 退回重办详情页
	 *  create: 2016/8/18
	 * author: <327778155@qq.com>
	 *
	 */
		public function detail_result($result_id){
			
			
			$result  = D('ProposalResult')->find($result_id);
			$check_isSign = D('proposal_attend')->where(array('uid' => is_login(), 'proposal_id' => $result['proposal_id']))->select();
			
			

			$this->assign('check_isSign', $check_isSign);
			
			$proposal_content = D('Proposal')->where(array( 'id' => $result['proposal_id']))->find();
			
			//代码优化过了    浏览权限判断
			$this->check_view($proposal_content['status']);
			
			
			if (!$proposal_content) {
				$this->error('404 not found');
			}
			D('Proposal')->where(array('id' => $result['proposal_id']))->setInc('view_count');
			
			$proposal_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $proposal_content['uid']);
			$proposal_content['type'] = $this->getType($proposal_content['type_id']);
			
			$menber = D('proposal_attend')->where(array('proposal_id' =>$proposal_content['id'], 'status' => 1))->select();
			foreach ($menber as $k => $v) {
				$proposal_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);
				
			}
		//	$member = D('User/Weiyuan')->getWeiyuan($proposal_content['uid']);
			$mu = D('User/User');
			$mu->setModel(WEIYUAN);
			$member = $mu->getUser($proposal_content['uid']);
			//办理单位列表
			$map_result['proposal_id'] = array('eq',$proposal_content['id']);
			$result_list = D('ProposalResult')->where($map_result)->select();
			
			
		
	
			//所有反馈意见信息列表
			$map_p['proposal_id'] = $result['proposal_id'];
			$map_p['uid'] = get_uid();
			//不立案理由
			$map_p['to_status'] = array('in',array(3,4,5,6,7));
			$suggest = D('ProposalProcess')->where($map_p)->find();
			
			//办理单位集合
		//	$units = D('User/Unit')->getUnits();
			$mu = D('User/User');
			$mu->setModel(UNIT);
			$units = $mu->getUsers(array(),array('单位'));
			
			$this->assign('back_url', U('Proposal/Index/result',array('status'=>$proposal_content['status'])));
			
			//办理单位集合
		//	$units = D('User/Unit')->getUnits();
			$mu = D('User/User');
			$mu->setModel(UNIT);
			$units = $mu->getUsers();
			
			
			$this->assign('units', $units);

			$this->assign('result_id', $result_id);
			$this->assign('suggest', $suggest);
			$this->assign('member', $member);
			$this->assign('result_list', $result_list);
			$this->assign('content', $proposal_content);
			$this->setTitle('{$content.title|op_t}' . '——提案详情');
			
			$this->getRecommend();
			$this->display();
			
			
				
		}


    /**
     * 获取推荐活动数据
     * autor:xjw129xjt
     */
    public function getRecommend()
    {
        $rec_proposal = D('Proposal')->where(array('is_recommend' => 1))->limit(2)->order('rand()')->select();
        foreach ($rec_proposal as &$v) {
            $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
            $v['type'] = $this->getType($v['type_id']);
            $v['check_isSign'] = D('proposal_attend')->where(array('uid' => is_login(), 'proposal_id' => $v['id']))->select();
        }
        unset($v);

        $this->assign('rec_proposal', $rec_proposal);


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
    public function doPost($ids = 0,  $title = '',$content='',  $limitCount = 0, $type_id = 0)
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
		//检查是否有提交提案的权限
		if(!$ids){
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
        
		    if (I('post.meet') == '') {
			    $this->error('请选择会议次数。');
		    }
		    if (I('post.meet_type') == '') {
			    $this->error('请选择会议提出期间。');
		    }
		    
		   
        $content = M('Proposal')->create();

	
	    //如果当前提案在联名里表没有一个人同意联名，联名属性为未联名
	    $map_pj['proposal_id'] = $ids;
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
	      if(!$ids){
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
	    
        if ($ids) {
	           $content['create_time'] = time();
            $content_temp = M('Proposal')->find($ids);

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
	          $content['id'] = $ids;
						$content['recommend'] = implode(',',I('post.recommend'));


            $rs = M('Proposal')->save($content);

     /*       $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Proposal/Index/detail', array('id' => $ids));
            $weiboApi = new WeiboApi();
            $weiboApi->resetLastSendTime();
            $weiboApi->sendWeibo("我修改了活动【" . $title . "】：" . $postUrl);
	*/

		        if($content['status'] == 2 && (get_permission(get_uid(),['委员','集体']))){
			        $back_url = U('Proposal/Index/index',array('status'=>2));
			        //流程记录
			        process_log( 'dopost','proposal', $ids, get_uid(),$ids);
			
			        //积分记录
			        action_log('weiyuan_basic_proposal_add','proposal',$ids,$content['uid']);
		        }
	        
	        
						$str = $content['status']==1 ? '保存': '提交';
            if ($rs) {
                $this->success($str.'成功。',$back_url);
            } else {
                $this->error($str.'失败。', '');
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
	           $map_f['model'] = MODULE_NAME;
							$map_f['record_id'] = 0;
	          D('Fileu')->where($map_f)->setField('record_id',$rs);

	          if($content['status'] == 2){
		          $back_url = U('Proposal/Index/index',array('status'=>2));
						//流程记录
		           process_log( 'dopost','proposal', $rs, get_uid(),$rs);
		        
		        //积分记录
		          action_log('weiyuan_basic_proposal_add','proposal',$rs,$content['uid']);
	          }else{
	          	$back_url = U('Proposal/Index/detail',array('id'=> $rs ));
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
                $this->error($str.'失败。', '');
            }
        }
    }
	
	/**
	 * 提案状态设置
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
    private function changeStatus($ids,$status){
	    if(empty($ids)){
		    $this->error('请选择要操作的提案');
	    }
    	
    
	     $this->check_change($ids,$status);
    	  
	     $content = I('post.content');
		//    if (!check_auth('proposalSetStatus')) {
			
		//	    $this->error('抱歉，您不具备更改提案状态的权限。');
		//    }
	    
	    //跳转回原状态的列表页面
	      $id = is_array($ids) ? $ids[0]:$ids;
	      $ids_bak = $ids;
	      $map_old['id'] = $id;
	      $old_status = D('Proposal')->where($map_old)->getField('status');

		    //只有在id为单个时，对会提交反馈
		    $m = D('Proposal');
	      $m->startTrans();
		   
	      //批量提交反馈条件审核
	      switch($status){
	      	//政府督查室移交到提案委
		      case 17:
		      	$map['proposal_id'] = array('in',$ids);
						$map['status'] = array('neq',2);
						//查询所有选中的提案中是否有未处理的办理单位

		      	$nids = D('ProposalResult')->where($map)->getField('proposal_id',true);
                $nids = $nids ? $nids : [];
                //获取传递过来的ids中   有未办理完成的单位
			    $nids = array_unique(array_filter($nids));
                $ids = array_diff($ids,$nids);

		      	break;
		      //结案操作
		      case 9:
		      	$data['adopt'] = implode(',',I('post.adopt'));
			      $data['write'] = implode(',',I('post.write'));
			      $data['recommend'] = implode(',',I('post.recommend'));
						$map_9['id'] = $ids;
			      $flag = D('Proposal')->where($map_9)->save($data);
			      
			      break;

	      }

	      $flagp = $m->setStatus($ids,$status);

		    if($flagp){
			    $m->commit();
			    //流程入库
			    process_log( 'changestatus','proposal', $ids , get_uid(),$ids);
		
			    $proposal = D('Proposal')->find($ids);
			    if($status == 8){

                    $member = D('UcenterMember')->where(['id'=>$proposal['uid']])->find();

                    $wxapi = new WeixinApi();
                    $msg = "您的\"{$proposal['title']}\"提案经审核已立案";

                    $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                    self::$sms->send($member['username'],$msg);
				    action_log('weiyuan_proposal_do','proposal',$ids,$proposal['uid']);
			    }

                $member = D('UcenterMember')->where(['id'=>$proposal['uid']])->find();
			    //退回的通知
			    switch($status){
                    case 3:

                        $wxapi = new WeixinApi();
                        $msg = "您的\"{$proposal['title']}\"提案经审核被退回，请登陆系统查看！";

                        $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                        self::$sms->send($member['username'],$msg);
                        break;
                    case 4:
                        $wxapi = new WeixinApi();
                        $msg = "您的\"{$proposal['title']}\"提案经审核不予立案";

                        $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                        self::$sms->send($member['username'],$msg);
                        break;
                    case 5:
                        $wxapi = new WeixinApi();
                        $msg = "您的\"{$proposal['title']}\"提案经审核被撤案";

                        $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                        self::$sms->send($member['username'],$msg);
                        break;
                    case 6:
                        $wxapi = new WeixinApi();
                        $msg = "您的\"{$proposal['title']}\"提案经审核不予立案，因不在管辖区";

                        $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                        self::$sms->send($member['username'],$msg);
                        break;
                    case 7:
                        $wxapi = new WeixinApi();
                        $msg = "您的\"{$proposal['title']}\"提案经审核不予立案，转委员来信";

                        $wxapi->sendTempMsg_proposal($member['openid'],$proposal['title'],$msg);
                        self::$sms->send($member['username'],$msg);
                        break;
                }

			    if($status == 9){
			    	$adopt = end(explode(',',$proposal['adopt']));
				    $write = end(explode(',',$proposal['write']));
				    //确定为重点提案，优秀提案，建议案
				  //  $recommend = explode(',',$proposal['recommend']);
				   if($proposal['recommend']  == '1'){
					   action_log('weiyuan_proposal_important','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '2'){
					   action_log('weiyuan_proposal_good','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '3'){
					   action_log('weiyuan_proposal_advise','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '1,2'){
					   action_log('weiyuan_proposal_goodandimport','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '1,3'){
					   action_log('weiyuan_proposal_advise','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '2,3'){
					   action_log('weiyuan_proposal_advise','proposal',$ids,$proposal['uid']);
				   }elseif($proposal['recommend']  == '1,2,3'){
					   action_log('weiyuan_proposal_advise','proposal',$ids,$proposal['uid']);
				   }
				    
				   switch($adopt){
					   case 1:
						   action_log('weiyuan_polls_adopt_q','proposal',$ids,$proposal['uid']);
					   	break;
					   case 2:
						   action_log('weiyuan_polls_adopt_s','proposal',$ids,$proposal['uid']);
						   
					   	break;
					   case 3:
						   action_log('weiyuan_polls_adopt_shen','proposal',$ids,$proposal['uid']);
						   
					   	break;
					   case 4:
						   action_log('weiyuan_polls_adopt_g','proposal',$ids,$proposal['uid']);
						   
					   	break;
				   }
				   
				   switch($write){
					   case 1:
						   action_log('weiyuan_polls_awaiting_q','proposal',$ids,$proposal['uid']);
						   
						   break;
					   case 2:
						   action_log('weiyuan_polls_awaiting_s','proposal',$ids,$proposal['uid']);
						   
						   break;
					   case 3:
						   action_log('weiyuan_polls_awaiting_shen','proposal',$ids,$proposal['uid']);
						   
						   break;
					   case 4:
						   action_log('weiyuan_polls_awaiting_z','proposal',$ids,$proposal['uid']);
						   
						   break;
				   }
				   
				   

			    }

			    if($ids != $ids_bak){
				    $this->success('已移交成功部分办理单位，剩余的交办意见请联系办理单位办理后再移交');
                    exit;
			    }
			    
			    
			    $this->success("更新成功",U('index',array('status'=>$old_status)));
			    
		    }else{
			    $m->rollback();
			    $this->error("更新失败");
		    }
		   
  
    }
	

	
	/**
	 * 移交办理
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
		public function handOver($result_id){
				$result = D('ProposalResult')->getResultbyId($result_id);
			
				$flag = D('ProposalResult')->setReturn($result_id);
	
				if($flag){
						process_log( 'handover','proposalresult', $result['proposal_id'] , get_uid(),$result_id);
						$this->success("申请移交办理成功，等待办理单位处理",U('Proposal/Index/result',array('status'=>19)));
				}else{
						$this->error("申请失败，可能您之前已经申请过了");
				}
		}
	
	/**
	 * 批量交办
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function batchHandover($status){
			//当前状态    待交办状态为18    设置取第一个ID来校验数据
			$ids = I('post.ids');
			if(empty($ids)){
				$this->error('请选择要交办的提案');
			}
			
			if(is_array($ids)){$id = $ids[0];}
			$this->check_change($id,$status);
			$m = D('Proposal');
			//清除出 未选择办理单位的提案
			foreach($ids as $k =>$v){
					$map['proposal_id'] = $v;
					$flag = D('ProposalResult')->where($map)->find();
					if(!$flag){
							//全都卸载了  有问题 //TODO
							unset($ids[$k]);
					}
			}

			$flag = $m->setStatus($ids,$status);

			if($flag){
					$this->success('交办成功，未进行选办的提案请选办');
			}else{
					$this->error('交办失败，有提案未进行选办');
			}
	}
	
	
	/**
	 * 退回重办
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function handAgain($proposal_id){
		$result = D('ProposalResult')->getResult($proposal_id);
		$flag = D('ProposalResult')->setReturn($proposal_id);
		if($flag){
			$this->success("退回重办处理成功，等待办理单位处理");
		}else{
			$this->error("退回重办处理失败，是否已经进行过退回重办处理");
		}
	}
	/**
	 * 提案状态批量设置
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
	
		//批量提交的可以省略掉，后面全用 changeStatus 代替
/*	public function changeAllStatus($ids,$status){
		
		if (!check_auth('proposalSetStatus')) {
			
			$this->error('抱歉，您不具备批量更改提案状态的权限。');
		}
		
		if(D('Proposal')->setStatus($ids,$status)){
			$this->success("更新成功",U('index'));
		}else{
			$this->error("更新失败");
		}
		
	}
*/
	
	/**
	 * 针对提案状态回复设置
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
		//提交留言的逻辑统一在changStatus里处理
/*    public function setSuggest($id ,$status ,$content){
    	  if(!check_auth('proposalSetSuggest')){
    	  	  $this->error('抱歉，您不具备回复提案的权限。');
	      }
	      D('Proposal')->setSuggest($id ,$status ,$content);
	      if( D('Proposal')->setSuggest($id ,$status ,$content)){
	      	  $this->success('回复成功');
	      }else{
	      	  $this->error('回复失败');
	      }
    	
    }
*/
	/**
	 * 提案浏览权限
	 * @param int $id
	 * autor: MR.Z <327778155@qq.com>
	 */
		private function check_view($status){
			$group = get_group(get_uid());
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
     * 提案详情
     * @param int $id
     * autor: MR.Z <327778155@qq.com>
     */
    public function detail($id = 0)
    {
	

        $check_isSign = D('proposal_attend')->where(array('uid' => is_login(), 'proposal_id' => $id))->select();
				//$member = D('User/Weiyuan')->getWeiyuan(get_uid());
		    $mu = D('User/User');
		    $mu->setModel(WEIYUAN);
		    $member = $mu->getUser(get_uid());

	      
        $this->assign('check_isSign', $check_isSign);

        $proposal_content = D('Proposal')->where(array( 'id' => $id))->find();
	    
			//设置元素当前角色状态下的状态
	      if(((get_permission(get_uid(),['委员','集体'])) && $proposal_content['status'] == 1) || ((get_permission(get_uid(),['委员','集体'])) && $proposal_content['status'] == 3) || (get_permission(get_uid(),'提案委') &&  $proposal_content['status'] == 2)){
	      	  $html_status = '0';
	      }else{
	      	$html_status = '1';
	      }
	    
	    
		    //代码优化过了    浏览权限判断
				$this->check_view($proposal_content['status']);


        if (!$proposal_content) {
            $this->error('404 not found');
        }
        D('Proposal')->where(array('id' => $id))->setInc('view_count');

        $proposal_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $proposal_content['uid']);
        $proposal_content['type'] = $this->getType($proposal_content['type_id']);


        $menber = D('proposal_attend')->where(array('proposal_id' => $id, 'status' => 1))->select();
        foreach ($menber as $k => $v) {
            $proposal_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

        }
        
        //办理单位列表
	      $map_result['proposal_id'] = array('eq',$id);
	      $result_list = D('ProposalResult')->where($map_result)->select();
				foreach($result_list as &$v){
				//		$v[user] = D('User/Unit')->getUnit($v[user_id]);
					$mu = D('User/User');
					$mu->setModel(UNIT);
					$v['user'] = $mu->getUser($v['user_id']);
					
				}
	 

	      //所有反馈意见信息列表
	      $map_p['proposal_id'] = $id;
	      $map_p['uid'] = get_uid();
	      //不立案理由
	      $map_p['to_status'] = array('in',array(3,4,5,6,7));
	      $suggest = D('ProposalProcess')->where($map_p)->find();
	    
	    
	    //办理单位集合
	   //   $units = D('User/Unit')->getUnits();
	    $mu = D('User/User');
	    $mu->setModel(UNIT);
	    $units = $mu->getUsers();
	
	    //移交办理的标记
	    $count_pr =  D('ProposalResult')->where('status=3')->count();
	    
	      $this->assign('count_pr', $count_pr);
	      $this->assign('back_url',U('Proposal/Index/index',array('status'=>$proposal_content['status'])));
	      $this->assign('html_status', $html_status);
				$this->assign('units',$units);
	      $this->assign('suggest', $suggest);
				$this->assign('member', $member);
	      $this->assign('result_list', $result_list);
        $this->assign('content', $proposal_content);
        $this->setTitle('{$content.title|op_t}' . '——提案详情');

        $this->getRecommend();
        $this->display();
    }

    /*
     * 不受理退回申请
     *  create:2016/9/23
     *  author: MR.Z <327778155@qq.com>
     */
    public function denyBack(){

        if(IS_POST){
            $id = I('post.ids');
            $result_id  = I('post.result_id');
            $map['id'] = $result_id;
            $data['status'] = 1;
           $flag =  M('ProposalResult')->where( $map)->save($data);
            if($flag){
                process_log( 'denyBack','proposalresult', $id , get_uid(),$result_id);

                $this->success('更新成功');}else{$this->error('更新失败');}
                exit();
        }
        $this->error('非法操作');
    }



    /*
     * 请求联名提案
     *  create:2016/8/18
     *  author: MR.Z <327778155@qq.com>
     */
    public function detail_joint($id){
    	  //提案基本信息
	      $content = D('Proposal')->find($id);
	      $map['proposal_id'] = array('eq',$id);
	      $joint = D('ProposalJoint')->where($map)->select();


	      foreach($joint as &$v){
	      	//  $v['user'] = D('User/Weiyuan')->getWeiyuan($v['user_id']);
		      $mu = D('User/User');
		      $mu->setModel(WEIYUAN);
		      $v['user'] = $mu->getUser($v['user_id']);
	      }
				
		    $map['user_id'] = array('eq',get_uid());
		    $map['proposal_id'] = array('eq',$id);
	
	    $content_joint = D('ProposalJoint')->where($map)->find();
	    
	    //联名页面展示状态

	      if($content['status'] != 1 || !empty($content_joint)){$htmlstatus=1;}else{$htmlstatus=0;}
	    
	    
	     
	    
	      $this->assign('htmlstatus',$htmlstatus);
	      $this->assign('back_url',U('Proposal/Index/pleasejoint'));
	      $this->assign('content_joint',$content_joint);
	      $this->assign('content',$content);
	      $this->assign('joint',$joint);
	      $this->display();
    	
    }
    
    /*
     * 联名请求操作
     *  create: 2016/8/18
     *  author: MR.Z <327778155@qq.com>
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
    
    
    /**
     * 联名提案成员
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
        $check_isSign = D('proposal_attend')->where(array('uid' => is_login(), 'proposal_id' => $id))->select();
        $this->assign('check_isSign', $check_isSign);

        $proposal_content = D('Proposal')->where(array('status' => 1, 'id' => $id))->find();
        if (!$proposal_content) {
            $this->error('404 not found');
        }
        $map['proposal_id'] = $id;
        $proposal_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $proposal_content['uid']);
        $menber = D('proposal_attend')->where($map)->select();
        foreach ($menber as $k => $v) {
            $proposal_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'avatar128', 'rank_html', 'signature'), $v['uid']);
            $proposal_content['member'][$k]['name'] = $v['name'];
            $proposal_content['member'][$k]['phone'] = $v['phone'];
            $proposal_content['member'][$k]['status'] = $v['status'];
        }

        $this->assign('all_count', D('proposal_attend')->where(array('proposal_id' => $id))->count());
        $this->assign('sign_count', D('proposal_attend')->where(array('proposal_id' => $id, 'status' => 0))->count());
        $this->assign('attend_count', D('proposal_attend')->where(array('proposal_id' => $id, 'status' => 1))->count());

        $this->assign('content', $proposal_content);
        $this->assign('tip', $tip);
        $this->setTitle('{$content.title|op_t}' . '——活动');
        $this->setKeywords('{$content.title|op_t}' . ',活动');
        $this->display();
    }

    /**
     * 编辑提案
     * @param $id
     * autor:xjw129xjt
     */
    public function edit($id)
    {
        $proposal_content = D('Proposal')->where(array('status' => 1, 'id' => $id))->find();
        if (!$proposal_content) {
            $this->error('404 not found');
        }
        if (!is_administrator(is_login())) { //不是管理员则进行检测
            if ($proposal_content['uid'] != is_login()) {
                $this->error('404 not found');
            }
        }
        $proposal_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $proposal_content['uid']);
        $this->assign('content', $proposal_content);
        $this->setTitle('编辑活动' . '——活动');
        $this->setKeywords('编辑' . ',活动');
        $this->display();
    }

    public function add()
    {
     //   $sms = Sms::instance('Smszx', C('SMS.Smszx'));


        $mu = D('User/User');
        $user_id = get_uid();

        if(get_permission($user_id,['委员'])){$group_id = WEIYUAN;}
        if(get_permission($user_id,['集体'])){$group_id = TEAM;}


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
        $this->assign('data',$user);
        $this->display();
    }











	/**
     * 联名
     * @param $proposal_id
     * autor: MR.Z <327778155@qq.com>
     */
    public function jointly($proposal_id)
    {


	      $proposal =  D('Proposal')->find($proposal_id);
	    if(IS_POST){
	       $map['nickname'] = array('like','%'.I('post.nickname').'%');
		     $map['名称'] = array('like','%'.I('post.名称').'%');
		      $map['user_id'] = array('neq',get_uid());
			    $mu = D('User/User');
			    $mu->setModel(WEIYUAN);
			    $users = $mu->getUsers($map,array('名称','界别','专委会','街道联络委'));

		     $this->assign('users',$users);
		
	    }
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
	      $this->assign('joint',$joint);
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
					$this->success("联名信息更新失败");
			}
		
	}
	
	/*
	 * 用户被请求联名信息列表
	 *  create: 2016/8/17
	 * author: MR.Z <327778155@qq.com>
	 */
		public function pleaseJoint(){

				$map['user_id'] = get_uid();
				$proposal_ids = D('ProposalJoint')->where($map)->getField('proposal_id',true);
				$proposal_ids = array_unique($proposal_ids);
				$map_p['p.status'] = array('eq',1);
				$map_p['user_id'] = get_uid();
				$map_p['p.id'] = array('in',$proposal_ids);
				$contents = D('Proposal')->alias('p')->field('p.id,type_id,title,ycode,jiebie,author,contact,is_joint,is_merge,is_agree')->join('LEFT JOIN __PROPOSAL_JOINT__ pj ON p.id=pj.proposal_id')->where($map_p)->select();

			foreach($contents as &$v){
				$v['type'] = $this->getType($v['type_id']);
			}

				$this->assign('contents',$contents);
				$this->display();
		}
		
		
		/*
		 * 被并案的提案列表
		 *  create: 2016/9/4
		 * author: MR.Z <327778155@qq.com>
		 *
		 */
		public function pleaseMerge(){

			$map['uid'] = array('eq',get_uid());
			$map['is_merge'] = array('eq',1);
			$map['merge_id'] = array('neq','');
			$contents = D('Proposal')->where($map)->select();
			foreach($contents as &$v){
				$v['type'] = $this->getType($v[type_id]);
			}
			
			$this->assign('contents',$contents);
			$this->display();
		}
	
	/*
	 * 并案首页
	 *  autor: MR.Z <327778155@qq.com>
	 */
	public function mergeIndex($id){
        C('TOKEN_ON',false);
		if(IS_POST){
			$map = I('post.');
			$map['title'] = array('like',"%{$map[title]}%");
			$map['author'] = array('like',"%{$map[author]}%");
			$m = D('Proposal');
			$map = array_filter($map);
			$map['status'] = 2;   //只有状态是已提交的才会有并案的的操作
			$map['is_merge'] = array('not in',array(1,2));   //排除已经并案的提案进入搜索列表
			$map['id'] = array('neq',$id);
			$content = $m->where($map)->select();

			
			foreach($content as &$v){
				$v['type'] = $this->getType($v['type_id']);
			}
			$this->assign('content', $content);
			
		}
		$map_merge['merge_id'] = $id;
		
		$merge_list = D('Proposal')->where($map_merge)->select();

		foreach($merge_list as &$v){
				$v['type'] = $this->getType($v['type_id']);
		}
		
		$proposal = D('proposal')->find($id);

	//	$this->assign('id',$id);
		$status = C('PROPOSAL_STATUS');
		if($proposal['is_merge'] == 2){
			$back_url = I('server.HTTP_REFERER');
		}else{
			$back_url = U('Proposal/Index/detail',array('id'=>$id));
		}
		
		$this->assign('back_url',$back_url);
		$this->assign('status',$status);
		$this->assign('proposal',$proposal);
		$this->assign('merge_list',$merge_list);
		$this->display();
		
	}
	
	/*
	 * 并案操作
	 *  $ids 提案ID
	 *  autor: MR.Z <327778155@qq.com>
	 */
	public function merge($ids){
			//0未并案 1 被并案 2第一提案人
			if(IS_POST){
					//第一提案人更新
					$data['id'] = $ids;
					$data['is_merge'] = 2;
					$data['merge_id'] = $ids;
					$flag = D('Proposal')->save($data);
					//附加提案人更新   //TODO
					if($flag){
							$this->success('并案成功',U('Proposal/Index/detail',array('id'=>$ids)));
					}else{
							$this->error('并案失败');
					}
			}
			
			
	}
	
	
	/*
	 * 并案的提案展示列表页面
	 *  create: 2016/8/18
	 *  author: MR.Z <327778155@qq.com>
	 *  第一提案人与其它提案人均到这个页面
	 */
	public function mergeList($proposal_id){
			$map['merge_id'] = array('eq',$proposal_id);
			$contents = D('Proposal')->where($map)->order('is_merge desc')->select();
			foreach($contents as &$v){
				$v['type'] = $this->getType($v['type_id']);
			}
			$status_config = C('PROPOSAL_STATUS');
			$this->assign('back_url',I('server.HTTP_REFERER'));
			$this->assign('status_config',$status_config);
			$this->assign('content',$contents);
			$this->display();
		
	}
	
	/*
	 * 并案的提案展示的详情页面
	 *  create: 2016/8/18
	 *  author: MR.Z <327778155@qq.com>
	 *  第一提案人与其它提案人均到这个页面
	 */
	public function detail_merge($proposal_id){
		//提案基本信息
		$content = D('Proposal')->find($proposal_id);
		$map['proposal_id'] = array('eq',$proposal_id);
		$joint = D('ProposalJoint')->where($map)->select();
		
		
		foreach($joint as &$v){
		//	$v['user'] = D('User/Weiyuan')->getWeiyuan($v['user_id']);
			$mu = D('User/User');
			$mu->setModel(WEIYUAN);
			$v['user'] = $mu->getUser($v['user_id']);
		}
		
		$this->assign('back_url',U('Proposal/Index/index',array('status'=>$content['status'])));
		$this->assign('content',$content);

		$this->display();
	}
	
	
	/**
	 * 交办意见提交
	 * @param $proposal_id 提案ID
	 * autor: MR.Z <327778155@qq.com>
	 * create: 2016/8/30
	 */
	public function doHandsuggest($proposal_id){
		if (!check_auth('doHandsuggest')) {
			
			$this->error('抱歉，您不具备提交交办意见的权限。');
		}
		$data['id'] = $proposal_id;
		$data['handsuggest'] = I('post.handsuggest');
		$flag = D('Proposal')->save($data);
		if($flag){
			$this->success('交办意见提交成功',U('Proposal/Index/index',array('status'=>18)));
		}else{
			$this->error('交办意见提交失败');
		}
	}
	
	
	
	
	/*
	 * 生成正式案号
	 *
	 *
	 */
	public function setCode(){

		
		//会议期间更新
		$map_hy['status'] = 8;
		$map_hy['meet_type'] = '会议期间';
		$order = "leibie='集体' desc,leibie='委员' desc, jdllw='花楼水塔街联络委员会' desc,jdllw='前进街联络委员会' desc ,jdllw='民意街联络委员会' desc,jdllw='新华街联络委员会' desc,jdllw='万松街联络委员会' desc,jdllw='北湖街联络委员会' desc,jdllw='唐家墩街联络委员会' desc,jdllw='常青街联络委员会' desc,jdllw='汉兴街联络委员会' desc,jdllw='江汉经济开发区联络委员会' desc";
		$proposal_hy = M('Proposal')->where($map_hy)->order($order)->select();

		$meet = C('PROPOSAL_MEET');
		$hy_number = 1;
		foreach($proposal_hy as $v){

			$v[code] = $meet.str_pad($hy_number++,3,"0",STR_PAD_LEFT).'号';
			M('Proposal')->save($v);

		}
		
		//闭会期间更新
		$map_bh['status'] = 8;
		$map_bh['meet_type'] = '闭会期间';
		$order = "leibie='集体' desc,leibie='委员' desc, jdllw='花楼水塔街联络委员会' desc,jdllw='前进街联络委员会' desc ,jdllw='民意街联络委员会' desc,jdllw='新华街联络委员会' desc,jdllw='万松街联络委员会' desc,jdllw='北湖街联络委员会' desc,jdllw='唐家墩街联络委员会' desc,jdllw='常青街联络委员会' desc,jdllw='汉兴街联络委员会' desc,jdllw='江汉经济开发区联络委员会' desc";
		$proposal_bh = M('Proposal')->where($map_bh)->order($order)->select();
		
		$bh_number = 1;
		foreach($proposal_bh as $v){
			$v[code] = '闭'.date('Y',time()).str_pad($bh_number++,3,'0',STR_PAD_LEFT).'号';
			M('Proposal')->save($v);
		}
		
		$this->success("生成正式案号成功");
/*		$content_pr = M('Proposal')->where($map_gr)->order($order)->select();
		
		
		if($content[meet_type] == '会议期间'){
			$map['meet_type'] = array('eq','会议期间');
			$map['meet'] = array('eq',$content[meet]);
			$lastycode = D('Proposal')->where($map)->order('id desc')->getField('ycode');
			if(empty($lastycode)){
				$content[ycode] = $content[meet].'001号';
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
				$content[ycode] = '闭'.date('Y',time()).'001号';
			}else{
				$content[ycode] =  preg_replace_callback('/([0-9]+)/',function ($matches) {
					return str_pad( $matches[0] + 1 , 3 , '0' , STR_PAD_LEFT );
				},$lastycode);
				
			}
		}
*/	}

	
	//导出提案
	public function exportProposal($proposal_id){
		$map['id'] = array('EQ',$proposal_id);

		$proposal = M('Proposal')->where($map)->find();
		$proposal['ycode'] = iconv('utf-8','gb2312',$proposal['ycode']);
		$proposal['title'] = iconv('utf-8','gb2312',$proposal['title']);
		$proposal['content'] = iconv('utf-8','gb2312',$proposal['content']);
		$proposal['suggest'] = iconv('utf-8','gb2312',$proposal['suggest']);
		$proposal['author'] = iconv('utf-8','gb2312',$proposal['author']);
		$proposal['contact_unit'] = iconv('utf-8','gb2312',$proposal['contact_unit']);
		$proposal['telephone'] = iconv('utf-8','gb2312',$proposal['telephone']);
		$this->assign('proposal',$proposal);
	
		$content = $this->fetch('proposal');
		$fileContent = getWordDocument($content);
		$filename = "./Public/proposal_{$proposal_id}.doc";
		$fp = fopen($filename, 'w+') or die("文件打开失败");
		fwrite($fp, $fileContent);
		fclose($fp);
		
		
		$fp = fopen($filename, 'r') or die("文件打开失败");
		$size = filesize($filename);
		
		header("Content-type: application/doc");
		header("Accept-Ranges: bytes");
		header("Accept-Length: ".$size);
		header("Content-Disposition:attachment;filename=提案内容.doc");
		echo  fread($fp, $size);
		
		
	}
	
	/*****************************华丽分隔线*******下面为ajax请求************************************************************************/
	
	/*
	 * 添加并案
	 *  autor: MR.Z <327778155@qq.com>
	 */
	public function add_merge_ajax($id,$merge_id){
			
			$status = 0;    //0 为失败 1为成功
			if($id == $merge_id){
					$rdata['status'] = $status;
					$rdata['content'] = '并案中不能添加自己';
					$this->ajaxReturn($rdata);
			}
			$proposal_status = D('Proposal')->where('id='.$id)->getField('status');
			if($proposal_status != 2){
				$rdata['status'] = 0;
				$rdata['content'] = '非法操作';
				$this->ajaxReturn($rdata);
				return;
			}
			$data['merge_id'] = $merge_id;
			$data['id'] = $id;
			$data['is_merge'] = 1;  //被合并
			$flag = D('Proposal')->save($data);
			if($flag){
				$status=1;
				$rdata['content'] = $data;
				
			}else{
				$status = 0;
				$rdata['content'] = '请不要重复添加';
			}
			$rdata['status'] = $status;
			$this->ajaxReturn($rdata);
		
	}
	
	/*
	 * 删除并案
	 *   autor: MR.Z <327778155@qq.com>
	 */
	public function del_merge_ajax($id){
			$status = 0;
			$map['id'] = $id;
			$merge_id = D('Proposal')->where($map)->getField('merge_id');
			$is_merge = D('Proposal')->where('id='.$merge_id)->getField('is_merge');

		//如果是第一提案人，则不能进行删除
			if($is_merge == 2){
				$rdata['status'] = 0;
				$rdata['content'] = '非法操作';
				$this->ajaxReturn($rdata);
				return;
			}
			$data['merge_id'] = 0;
			$data['id'] = $id;
			$data['is_merge'] = 0;
			$flag = D('Proposal')->save($data);
			if($flag){$status=1;}
			$rdata['content'] = $data;
			$rdata['status'] = $status;
			$this->ajaxReturn($rdata);
	}
	
	/*
	 * 添加联名
	 *  autor: MR.Z <327778155@qq.com>
	 * //TODO 联名信息未作校验，后期补上校验
	 *  //  0 为未联名 1 联名
	 */
	public function add_joint_ajax($user_id,$proposal_id){
			$status = 0;
			$map['id'] = $proposal_id;
		//提案状态是否正常
			$is_joint = D('Proposal')->where($map)->getField('is_joint');
			if($is_joint == 2){
					$rdata['status'] = 0;
					$rdata['content'] = '非法操作';
					$this->ajaxReturn($rdata);
					return;
			}
			//提案联名信息是否重复
			$map_j['proposal_id'] = $proposal_id;
			$map_j['user_id'] = $user_id;
			$joints = D('ProposalJoint')->where($map_j)->find();
			if($joints){
				$rdata['status'] = 0;
				$rdata['content'] = '已经添加过了，不能重复添加哦！';
				$this->ajaxReturn($rdata);
				return;
			}
			
			$data['create_time'] = time();
			$data['user_id'] = $user_id;
			$data['proposal_id'] = $proposal_id;
			$id = M('ProposalJoint')->add($data);
			if($id){
					$status = 1;
					$data['id'] = $id;
			}
			$rdata['status'] = $status;
			$rdata['content'] = $data;
			$this->ajaxReturn($rdata);
		
	}
	
	
	/*
	 * 获取单条联名信息
	 *  $joint_id  联名信息ID
	 *  autor: MR.Z <327778155@qq.com>
	 * create: 2016/8/30
	 */
	public function get_joint_ajax($joint_id){
		$status = 0;
		$joint = D('ProposalJoint')->find($joint_id);
		if($joint){
			$status = 1;
			$rdata['data'] = $joint;
		}
		$rdata['status'] = $status;
		$this->ajaxReturn($rdata);
		
	}
	
	/*
	 *  删除联名
	 *  $id  联名信息ID
	 *  autor: MR.Z <327778155@qq.com>
	 * create: 2016/8/30
	 */
	public function del_joint_ajax($id){
			$status = 0;
			$map['id'] = $id;
			$proposal_joint = D('ProposalJoint')->find($id);
			$map_p['id'] = $proposal_joint['proposal_id'];
			$is_joint = D('Proposal')->where($map_p)->getField('is_joint');
			if($is_joint == 2){
				$rdata['status'] = 0;
				$rdata['content'] = '非法操作';
				$this->ajaxReturn($rdata);
				return;
			}
			
			if($proposal_joint['is_agree'] == 1){
				$rdata['status'] = 0;
				$rdata['content'] = '该委员已经同意联名，不能删除！';
				$this->ajaxReturn($rdata);
				return;
			}
		
			if(M('ProposalJoint')->delete($id)){
					$status = 1;
			}
			$rdata['status'] = $status;
			$this->ajaxReturn($rdata);
	}
	
	/**
	 * 添加办理单位信息
	 * @param $leader,$contact,$user_id
	 * autor: MR.Z <327778155@qq.com>
	 */
	public function add_result_ajax($proposal_id,$duban_leader,$user_id)
	{   //只有在待交办状态和已办交但有移交办理的单位才支持新增单位
			$map['id'] = $proposal_id;
		//查询办理单位状态 是待交办才能添加
			$status_p = D('Proposal')->where($map)->getField('status');
		//处理移交办理逻辑
			if($status_p == 19){
				$map_pr['proposal_id'] = $proposal_id;
				$map_pr['status'] = array('in',array(3,4));
				//获取办理单位为移交办理的单位
				$flag = D('ProposalResult')->where($map_pr)->find();
				if($flag){
					$status_p = 193;
				}
			}
			if($status_p == 18 || $status_p == 193){
				
			}else{
				$data['status'] = 0;
				$data['content'] = '该提案现在的状态不能再添加办理单位';
				$this->ajaxReturn($data);
				return;
			}
	
			$m = D('ProposalResult');
		//不能重复添加
			$map_check['proposal_id'] = $proposal_id;
			$map_check['user_id'] = $user_id;
			$result_check = $m->where($map_check)->find();
			if($result_check){
				$data['status'] = 0;
				$data['content'] = '不能重复添加办理单位';
				$this->ajaxReturn($data);
				return;
			}
			$m->create();
		//	$unit =  D('User/Unit')->getUnit($user_id);
			$mu = D('User/User');
			$mu->setModel(UNIT);
			$unit = $mu->getUser($user_id);
            $m->duban_leader = $duban_leader;
	        $m->proposal_id = $proposal_id;
			$m->unit = $unit['名称'];
			$m->user_id = $user_id;
			$m->group_id = M('AuthGroupAccess')->where('uid='.$user_id)->getField('group_id');
			$id = $m->add();

			if($id){
				$data['status'] = 1;
				$data['id'] = $id;
				$this->ajaxReturn($data);
			}
	}
	
	public function del_result_ajax($id){
			$m = D('ProposalResult');
			$flag = $m->delete($id);
			$data['status'] = 0;
			if($flag){
				$data['status'] = 1;
			}
			$this->ajaxReturn($data);
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
	
	//移交办理  信息获取
	public function handtransfer_ajax($result_id){
		$status = 0;
		//proposal_process
	/*	$map['pr.id'] = $result_id;
		$map['pp.to_status'] = 192;
		
		$result_p = D('ProposalResult')->alias('pr')->field('pr.id,pp.suggest')->join(' __PROPOSAL_PROCESS__ pp on pr.user_id=pp.user_id and pr.proposal_id=pp.proposal_id')->where($map)->order('pp.create_time desc')->find();
*/
	$result_p = D('ProposalProcess')->where(['result_id'=>$result_id,'to_status'=>193])->order('create_time desc')->find();

		if($result_p ){
			$status = 1;
			$rdata['data'] = $result_p;
		}
		$rdata['status'] = $status;
		$this->ajaxReturn($rdata);
	}
	

	
	/**
	 * 获取退回意见
	 * @param $proposal_id 提案ID
	 * autor: MR.Z <327778155@qq.com>
	 * create: 2016/8/30
	 */
	public function get_back_ajax($result_id){
		$status = 0;
		$map['pp.result_id'] = $result_id;
		//流程表状态为 已办理
		$map['pp.to_status'] = 13;
		//办理反馈表状态为退回重办
		$map['pr.status'] = 5;
		$resultback = D('ProposalResult')->alias('pr')->field('pr.id,pp.suggest')->join(' __PROPOSAL_PROCESS__ pp on pr.id=pp.result_id')->where($map)->order('pp.create_time desc')->find();

		if($resultback){
			$status = 1;
			$rdata['data'] = $resultback;
		}
		$rdata['status'] = $status;
		
		$this->ajaxReturn($rdata);

	}


	/*
	 * 获取申请被拒绝的意见
	 * author: MR.Z <327778155@qq.com>
	 *  create: 2016/9/23
	 */
	public function get_denyback_ajax($result_id){
        $status = 0;
        $map['pp.result_id'] = $result_id;
        $map['pp.to_status'] = ['in',[193]];
        $map['pr.status'] = 1;

        $resultback = D('ProposalResult')->alias('pr')->field('pr.id,pp.suggest')->join(' __PROPOSAL_PROCESS__ pp on pr.id=pp.result_id')->where($map)->order('pp.create_time desc')->find();

        if($resultback){
            $status = 1;
            $rdata['data'] = $resultback;
        }
        $rdata['status'] = $status;

        $this->ajaxReturn($rdata);
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


	
	
}