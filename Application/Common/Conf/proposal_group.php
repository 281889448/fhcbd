<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/9/6
 * Time: 15:36
 */

define('WEIYUAN',13);
define('UNIT',14);
define('TEAM',15);

return array(
'CONTACT_GROUP' => array(
	'1'=>array(
		'parent_id' => 0,
		'name' => '专委会',
		'is_final' => false,
	
	),
	'2' => array(
		'parent_id' =>0,
		'name' => '常委会成员',
		'is_final' => true,
	),
	'3' => array(
		'parent_id' =>0,
		'name' => '街道联络委主任',
		'is_final' => true,
	),
	'4' => array(
		'parent_id' =>0,
		'name' => '街道联络委联络员、信息员',
		'is_final' => false,
	),
	'5' => array(
		'parent_id' =>0,
		'name' => '界别和专委会信息员',
		'is_final' => false,
	),
	'6' => array(
		'parent_id' =>0,
		'name' => '七党一联主委',
		'is_final' => true,
	),
	'7' => array(
		'parent_id' =>0,
		'name' => '主席会议成员',
		'is_final' => true,
	),
	'8' => array(
		'parent_id' =>0,
		'name' => '街道联络委成员',
		'is_final' => false,
	),
	
	'11'=>array(
		'parent_id' => 1,
		'name' => '提案委',
		'is_final' => true,
	),
	'12'=>array(
		'parent_id' => 1,
		'name' => '经济科技委',
		'is_final' => true,
	),
	'13'=>array(
		'parent_id' => 1,
		'name' => '文史学习委',
		'is_final' => true,
	),
	'14'=>array(
		'parent_id' => 1,
		'name' => '社会法制与人口资源环境委',
		'is_final' => true,
	),
	'15'=>array(
		'parent_id' => 1,
		'name' => '民族宗教与港澳台侨外事委',
		'is_final' => true,
	),
	'16'=>array(
		'parent_id' => 1,
		'name' => '委员工作委',
		'is_final' => true,
	),
	
	'41'=>array(
		'parent_id' => 4,
		'name' => '民族街联络委员会',
		'is_final' => true,
	),
	'42'=>array(
		'parent_id' => 4,
		'name' => '民权街联络委员会',
		'is_final' => true,
	),
	'43'=>array(
		'parent_id' => 4,
		'name' => '满春街联络委员会',
		'is_final' => true,
	),
	'44'=>array(
		'parent_id' => 4,
		'name' => '花楼水塔街联络委员会',
		'is_final' => true,
	),
	'45'=>array(
		'parent_id' => 4,
		'name' => '前进街联络委员会',
		'is_final' => true,
	),
	'46'=>array(
		'parent_id' => 4,
		'name' => '民意街联络委员会',
		'is_final' => true,
	),
	'47'=>array(
		'parent_id' => 4,
		'name' => '新华街联络委员会',
		'is_final' => true,
	),
	'48'=>array(
		'parent_id' => 4,
		'name' => '万松街联络委员会',
		'is_final' => true,
	),
	'49'=>array(
		'parent_id' => 4,
		'name' => '北湖街联络委员会',
		'is_final' => true,
	),
	'410'=>array(
		'parent_id' => 4,
		'name' => '常青街联络委员会',
		'is_final' => true,
	),
	'411'=>array(
		'parent_id' => 4,
		'name' => '汉兴街联络委员会',
		'is_final' => true,
	),
	'412'=>array(
		'parent_id' => 4,
		'name' => '江汉经济开发区联络委员会',
		'is_final' => true,
	),
	
	'81'=>array(
		'parent_id' => 8,
		'name' => '民族街联络委员会',
		'is_final' => true,
	),
	'82'=>array(
		'parent_id' => 8,
		'name' => '民权街联络委员会',
		'is_final' => true,
	),
	'83'=>array(
		'parent_id' => 8,
		'name' => '满春街联络委员会',
		'is_final' => true,
	),
	'84'=>array(
		'parent_id' => 8,
		'name' => '花楼水塔街联络委员会',
		'is_final' => true,
	),
	'85'=>array(
		'parent_id' => 8,
		'name' => '前进街联络委员会',
		'is_final' => true,
	),
	'86'=>array(
		'parent_id' => 8,
		'name' => '民意街联络委员会',
		'is_final' => true,
	),
	'87'=>array(
		'parent_id' => 8,
		'name' => '新华街联络委员会',
		'is_final' => true,
	),
	'88'=>array(
		'parent_id' => 8,
		'name' => '万松街联络委员会',
		'is_final' => true,
	),
	'89'=>array(
		'parent_id' => 8,
		'name' => '北湖街联络委员会',
		'is_final' => true,
	),
	'811'=>array(
		'parent_id' => 8,
		'name' => '常青街联络委员会',
		'is_final' => true,
	),
	'812'=>array(
		'parent_id' => 8,
		'name' => '汉兴街联络委员会',
		'is_final' => true,
	),
	'813'=>array(
		'parent_id' => 8,
		'name' => '江汉经济开发区联络委员会',
		'is_final' => true,
	),
	
	'51'=>array(
		'parent_id' => 5,
		'name' => '提案委',
		'is_final' => true,
	),
	'52'=>array(
		'parent_id' => 5,
		'name' => '经济科技委',
		'is_final' => true,
	),
	'53'=>array(
		'parent_id' => 5,
		'name' => '文史学习委',
		'is_final' => true,
	),
	'54'=>array(
		'parent_id' => 5,
		'name' => '社会法制与人口资源环境委',
		'is_final' => true,
	),
	'55'=>array(
		'parent_id' => 5,
		'name' => '民族宗教与港澳台侨外事委',
		'is_final' => true,
	),
	'56'=>array(
		'parent_id' => 5,
		'name' => '委员工作委',
		'is_final' => true,
	),


),);