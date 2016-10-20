<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Message\Model;
use Think\Model;
use Think\Page;

/**
 * 活动模型
 * Class EventModel
 * @package Event\Model
 * autor:xjw129xjt
 */
class MessageModel extends Model{

    protected $insertFields = array('stime','uid','title','type','upload','content','etime',);//新增是允许接收的字段
    protected $updateFields = array('id','stime','uid','title','type','upload','content','etime',);//更新是允许接收的字段

    //字段验证
    protected $_validate = array(
        array('time','require','时间不能为空！',1),
        array('uid','require','作者不能为空！',1),
        array('title', 'require', '标题不能为空！', 1 ),
        array('type', 'require', '类别不能为空！', 1 ),
        array('content', 'require', '内容不能为空！', 1 ),

    );

}
