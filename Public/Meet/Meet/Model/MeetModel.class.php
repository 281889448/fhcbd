<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Meet\Model;
use Think\Model;
use Think\Page;

/**
 * 会议模型
 * Class EventModel
 * @package Event\Model
 * autor:xjw129xjt
 */
class MeetModel extends Model{
    protected $_validate = array(
        array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
        array('explain', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

   /* protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('status', '1', self::MODEL_INSERT),
        array('uid', 'is_login',3, 'function'),
    );*/

    protected $insertFields = array('time','uid','title','type','content','people','sTime','eTime','qdsTime','qdeTime','qdcount');//新增是允许接收的字段
    protected $updateFields = array('id','time','uid','title','type','content','people','sTime','eTime','qdsTime','qdeTime','qdcount');//更新是允许接收的字段



}
