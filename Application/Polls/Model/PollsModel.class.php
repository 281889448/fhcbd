<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Polls\Model;
use Think\Model;

/**
 * 会议模型
 * Class EventModel
 * @package Event\Model
 * autor:xjw129xjt
 */
class PollsModel extends Model{
    protected $insertFields = array('time','author','title','type','adopt','back','status','upload','content');//新增是允许接收的字段
    protected $updateFields = array('id','time','author','title','type','adopt','back','status','upload','content');//更新是允许接收的字段

    //字段验证
    protected $_validate = array(
        array('time','require','时间不能为空！',1),
        array('author','require','作者不能为空！',1),
        array('title', 'require', '标题不能为空！', 1 ),
        array('type', 'require', '类别不能为空！', 1 ),
        array('content', 'require', '内容不能为空！', 1 ),

    );

}
