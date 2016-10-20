<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Proposal\Model;
use Think\Model;
use Think\Page;

/**
 * 提案模型
 * Class ProposalModel
 * @package Proposal\Model
 * autor:MR.Z
 */
class ProposalModel extends Model{
    protected $_validate = array(
        array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
        array('explain', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('status', '1', self::MODEL_INSERT),
        array('uid', 'is_login',3, 'function'),
    );
	
	public $viewFields = array(
			'Proposal'       => array('id','ycode','title','content'=>'content','create_time','type_id','jiebie','renshu','status','_type'=>'LEFT'),
			'ProposalResult' => array('content','status'=>'rstatus','_on'=>'Proposal.id=ProposalResult.proposal_id'),
	);
	
	public function _initialize() {
		parent::_initialize(); // TODO: Change the autogenerated stub
		$this->msuggest = D('ProposalProcess');
	}
	
	
	/**
	 * 更新提案状态
	 * param id 提案ID 的数组集合
	 * status 提案状态
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function setStatus($id,$status){
		
		
			$id = is_array($id) ? implode(',',$id):$id;
			$map['id'] = array('in',$id);
		
			return $this->where($map)->setField('status',$status);
	}
	
	
	/*
	 * 批量交办
	 * param
	 * status
	 * author: MR.Z <327778155@qq.com>
	 */
	public function batchHandover($ids){
			$id = is_array($ids) ? implode(',',$ids):$ids;
			$map['id'] = array('in',$id);
			$this->where($map)->setField('status',19);    //提案批量交办设置
			
		
	}
	
	/**
	 * 回复提案建议
	 * param id 提案ID status 针对提案状态 content 回复内容
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
/*	public function setSuggest($id,$status,$content){
			$this->setStatus($id,$status);
			return $this->msuggest->setSuggest($id,$status,$content);
	}
*/}