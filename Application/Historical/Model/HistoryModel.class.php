<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace History\Model;
use Think\Model;

/**
 * 会议模型
 * Class EventModel
 * @package Event\Model
 * autor:xjw129xjt
 */
class HistoryModel extends Model{
    protected $_validate = array(
        array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
        array('remake', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $insertFields = array('time','author','title','type','remake','adopt','back','status','upload');//新增是允许接收的字段
    protected $updateFields = array('id','time','author','title','type','remake','adopt','back','status','upload');//更新是允许接收的字段



}
