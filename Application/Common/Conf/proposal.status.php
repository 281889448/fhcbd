<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/9/7
 * Time: 16:53
 */
return array(
'PROPOSAL_STATUS' => array(
	"1" => "未提交",
	"2" => "已提交",
	"3" => "退回",
	"4" => "未立案",
	"5" => "撤案",
	"6" => "不在管辖区",
	"7" => "委员来信",
	"8" => "已立案",
	"9" => "已结案",
	"10" => "待移交",
	"11" => "已移交",
	//	"12" => "移交办理",
	"13" => "已办理",
	"14" => "退回重办",
	"15" => "被并案",
	'17' => "已办理反馈",
	'18' => "待交办",
	'181' =>'待交办,已选办',
	'19' => "待办理",
),
	
	//提案浏览权限配置  用于提案详情和左侧菜单
'VIEW_STATUS' =>  array(
	'委员' => array(1,2,3,4,5,6,7,8,9,10,11,13,15,17,18,19),
	'集体' => array(1,2,3,4,5,6,7,8,9,10,11,13,15,17,18,19),
	'提案委' =>  array(2,3,4,5,6,7,8,9,10,17),
	'政府督查室' =>  array(11,13,18,9,17,19),
	'办理单位' =>   array(13,14,19)

),

'CHANGE_STATUS' =>array(
	1=>array(2),
	2=>array(3,4,5,6,7,8,15),
	3=>array(2),
	4=>array(),
	5=>array(),
	6=>array(),
	7=>array(),
	8=>array(18),
	9=>array(),
	//	10=>array(11),
	11=>array(18),
	//待办理操作移交办理后跳到待交办
	//12=>array(18),
	//已办理操作退回重办后跳到待办理
	13=>array(19,17),
	14=>array(13),
	15=>array(),
	16=>array(),
	17=>array(9),
	18=>array(19),
	19=>array(13,12),
),
'UID_FILTER' =>array(
	'委员' =>array(1,2,3,4,5,6,7,8,9),
    '集体' =>array(1,2,3,4,5,6,7,8,9),
	//'提案委' =>
),
);