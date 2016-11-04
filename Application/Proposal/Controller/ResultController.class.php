<?php


namespace Proposal\Controller;

use Common\Controller\BaseController;
use Weibo\Api\WeiboApi;
use User\Model\Weiyuan;


//提案交办控制器，用于提案提交与展示，不涉及后面的流程操作
class ResultController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {   parent::_initialize();
        $tree = D('ProposalType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);


        $this->assign('current', 'proposal');
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
    public function doPost($id = 0,  $title = '',$suggest='',  $limitCount = 0)
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
				//检查是否有提交提案的权限
				if(!$id){
					$this->error('非法操作');
				}else{
					if (!check_auth('doResult')) {
						$this->error('抱歉，您不具备提交提案权限。');
					}
				}

        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }

        if (trim(op_h($suggest)) == '') {
            $this->error('请输入内容。');
        }


        $content = D('ProposalResult')->create();
        $content['content'] = op_h($content['content']);
        $content['title'] = op_t($content['title']);
	

        //$content['type_id'] = intval($type_id);
	    
        
            $content_temp = D('ProposalResult')->find($id);
            if (!is_administrator(is_login())) { //不是管理员则进行检测
								
                if ($content_temp['user_id'] != is_login()) {
                    $this->error('越权操作。');
                }
            }
            $content['uid'] = $content_temp['uid']; //权限矫正，防止被改为管理员
            $rs = D('ProposalResult')->save($content);
	    
            if ($rs) {
                $this->success('编辑成功。', U('Index/result', array('status' => 19)));
            } else {
                $this->success('编辑失败。', '');
            }
        
    }
	
	/**
	 * 提案状态设置
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
    private function changeStatus($ids,$status){
	    //节点权限判断  待补充   //TODO
	     $this->check_change($ids,$status);
    	  
	     $content = I('post.content');
		//    if (!check_auth('proposalSetStatus')) {
			
		//	    $this->error('抱歉，您不具备更改提案状态的权限。');
		//    }

		    //只有在id为单个时，对会提交反馈
		    $m = D('Proposal');
	      $m->startTrans();
	      $flag = 1;
		    if(!is_array($ids) && !empty($content)){
					$flag = D('ProposalProcess')->setSuggest($ids,$status,$content);
			   
		    }
		   
	      $flagp = $m->setStatus($ids,$status);

		    if($flag && $flagp){
			    $m->commit();
			    $this->success("更新成功",U('index',array('status'=>$status)));
			    
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
		public function handOver($proposal_id){
			//	$result = D('ProposalResult')->getResult($proposal_id);
			
				$flag = D('ProposalResult')->setReturn($proposal_id);
				if($flag){
						$this->success("申请移交办理成功，等待办理单位处理");
				}else{
						$this->error("申请失败，可能您之前已经申请过了");
				}
		}
	
	/**
	 * 退回重办
	 * @param int $id
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function handAgain($result_id){
		$result = D('ProposalResult')->getResultById($result_id);
		$flag = D('ProposalResult')->setAjain($result_id);
		if($flag){
			process_log( 'handagain','proposalresult', $result['proposal_id'], $result['user_id'],$result_id);
			$this->success("退回重办处理成功，等待办理单位处理");
		}else{
			$this->error("退回重办处理失败，是否已经进行过退回重办处理");
		}
	}
	
	
	/*
	 * 填办提案
	 *
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function handReply($result_id){
			$m = D('ProposalResult');
			$data = I('post.');
			$data['id'] = $result_id;
			$result = $m->getResultbyId($result_id);
			$mp = D('Proposal');

			if(empty($result)){return false;}
			$proposal = D('Proposal')->find($result['proposal_id']);
			$result['code'] = $proposal['code'];
			$result['proposal_title'] = $proposal['title'];

			if(IS_POST){
				
			//检测针对提案ID有多少条未办理的，如果当前为最后一条，便针提案状态进行更新

					M('ProposalResult')->create();
			//		$data['status'] = $data['status'];    //已填办状态
					$data['rate'] = htmlspecialchars($data['rate']);
					$data['end_time'] = $data['end_time'] ? strtotime($data['end_time']) : time();
					$data['link_time'] = strtotime($data['link_time']);
                    $data = array_filter($data);

					$flag = M('ProposalResult')->save($data);
					$map['proposal_id'] = array('eq',$result['proposal_id']);
					$map['status'] = array('in',array(1,5,6));
					$count = M('ProposalResult')->where($map)->count();
		
					if($count == 0){
							$map_p['id'] = $result['proposal_id'];
						
						//TODO 此处有问题
							D('proposal')->where($map_p)->setField('status',13);
					}
				
					if($flag){
							$this->success('提案填办成功',U('Proposal/Index/result',array('status'=>19)));
					}else{
							$this->error('提案填办失败,可能您未对提案填办信息作更改');
					}
			}else{
				$back_url = U('Proposal/result/handcheck',array('proposal_id'=>$proposal['id']));

				$this->assign('back_url',$back_url);
				$this->assign('result',$result);
				$this->display();
			}
	}
	
	
	/*
	 * 查办提案列表
	 *  create: 2016/8/18
	 * author: MR.Z <327778155@qq.com>
	 */
	public function handCheck($proposal_id){
			$map['proposal_id'] = array('eq',$proposal_id);
		
		//查办共用 一个模板，当当前用户组是办理单位时，才以UID作为条件
		if(get_permission(get_uid(),['办理单位'])){
			$map['user_id'] = get_uid();
            $back_url = U('Proposal/Index/index',['status'=>13]);
		}else{
		    if(get_permission(get_uid(),['提案委'])){
            $back_url = I('server.HTTP_REFERER');
            }else{
            //上面代码 dcs 在退回重办操作后，返回会出错
            $back_url = U('Proposal/Index/index',['status'=>13]);
            }
        }
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

    /**
     *  办理单位接收交办操作
     *  author: MR.Z <327778155@qq.com>
     *  create: 2016/09/24
     */
    public function acceptHand($id){
        if(IS_POST){
            $backinfo = I('post.');
            if(count($backinfo) != count(array_filter($backinfo))){
                $this->error('请将表单填写完整');
                exit;
            }

            $m = M('ProposalResult');



            $m->create();
            $m->status = 6;
            $flag = $m->save();

            if($flag){
                $this->success('接收成功');
                exit;
            }else{
                $this->error('接收失败');
                exit;
            }

        }
        $this->error('非法操作');

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
			if(!in_array( $status, $status_arr)){
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
	 * 添加办理单位
	 * @param $leader,$contact,$user_id
	 * autor: MR.Z <327778155@qq.com>
	 */
	public function add_result_ajax($proposal_id,$leader,$contact,$user_id)
	{
			$m = D('ProposalResult');
			$m->create();
			$m->user_id = get_uid();
			$m->group_id = M('AuthGroupAccess')->where('uid='.get_uid())->getField('group_id');
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

}