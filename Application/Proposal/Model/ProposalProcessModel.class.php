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


/**
 * 提案建议模型
 * 该模型是数据是单向的
 * Class ProposalModel
 * @package Proposal\Model
 * autor:MR.Z
 */
class ProposalProcessModel extends Model{
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
	
	
	/**
	 * 回复提案建议
	 * param id 提案ID status 针对提案状态 content 回复内容
	 * @package Proposal\Model
	 * autor:MR.Z <327778155@qq.com>
	 */
	public function setSuggest($proposal_id,$status,$content){
			$m = M('ProposalProcess');
			$m->proposal_id = $proposal_id;
			$m->to_status = $status;
			$m->content = $content;
			$m->create_time = time();
			$m->status = 1;
			$m->uid = get_uid();
			$flag = $m->add();

			return $flag;
	}
}
