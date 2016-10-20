<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: MR.Z <327778155@qq.com>
// +----------------------------------------------------------------------
//status   1:处理中   2：已处理  3：移交办理申请中   4：移交办理已处理   5：退回重办   6.接收交办
namespace Proposal\Model;
use Think\Model;
use Think\Page;

/**
 * 提案办理结果模型
 * Class ProposalModel
 * @package Proposal\Model
 * autor:MR.Z <327778155@qq.com>
 */
class ProposalResultModel extends Model{
	protected $_validate = array(
		array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
		array('explain', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
	);
	
	protected $_auto = array(
		array('create_time', NOW_TIME, self::MODEL_INSERT),
		array('update_time', NOW_TIME, self::MODEL_BOTH),
		array('status', '1', self::MODEL_INSERT),
	
	);
	

	
	public function _initialize() {
		parent::_initialize(); // TODO: Change the autogenerated stub
		
	}
	
	
	/**
	 * 获取办理单位 结果信息
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function getResultbyId($id) {
		
		$m = D('ProposalResult');

		return $m->find($id);
		
	}
	
	/**
	 * 获取提案的办理单位信息列表
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function getResults($proposal_id){
		$m = D('ProposalResult');
		$map['proposal_id'] = array('eq',$proposal_id);
		return $m->where($map)->select();
	}
	
	/**
	 * 设置办理单位 移交办理信息
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function setReturn($id){
		$data['status'] = 3;   //3的状态为移交办理申请中
		$m = D('ProposalResult');
		
		$map['id'] = array('eq',$id);
		$flag = $m->where($map)->save($data);
		return $flag;
	}
	
	/**
	 * 设置办理单位 退回重办 信息
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function setAjain($result_id){
		$data['status'] = 5;   //5的状态为退回重办
	//	$user_id = get_uid();
	//	$group = get_group($user_id);
	//	if($user_id || $group != '办理单位'){return false;}
		$m = D('ProposalResult');

		$map['id'] = array('eq',$result_id);

		$flag = $m->where($map)->save($data);
	
		return $flag;
	}
	
	/**
	 * 设置 填办信息
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function setDo($result_id){
		$data['status'] = 2;   //4的状态为已办理
		$user_id = get_uid();
		$group = get_group($user_id);
		if($user_id || $group != '办理单位'){return false;}
		$m = D('ProposalResult');
		$map['user_id'] = array('eq',$user_id);
		$map['result_id'] = array('eq',$result_id);
		$flag = $m->where($map)->save($data);
		$map_check['status'] = array('neq',2);
		$flag_check = $m->where($map_check)->find();
		$map_p['proposal_id'] = array('eq',$proposal_id);
		//如果没有办理单位不等于2，说明所有的办理单位都已经办理提交  此时更新proposal表
		if(empty($flag_check)){
				$data_proposal['status'] = 13;
				D('Proposal')->where($map_check)->save($data_proposal);
		}
		return $flag;
	}
	
	
	//办理单位的设置已经在待交办环节已经设置，此处不用再进行批量设置
	/**
	 * 设置办理单位 批量交办
	 * param id 提案ID
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */

}