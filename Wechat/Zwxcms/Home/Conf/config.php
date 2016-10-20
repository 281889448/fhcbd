<?php
if (!defined('THINK_PATH'))	exit('非法调用');
return array(
	//配置微信
	'WX_APPID'=>'wx86ab743c45a91125',
	'WX_SECRET'=>'5cd21f48240a14689df230f24106c7b1',
	'WX_TOKEN'=>'haozhili',
	'WX_OAUTHINFO'=>'snsapi_base',//网页授权方式
	'WX_SUB_REPLY'=>'您好，欢迎关注江汉政协微信公众账号！',//关注回复文字设置
	'WX_KEY_REPLY'=>array(1,2,3,4,5),//关键字回复
	//数据库配置
	'DB_TYPE'=>'mysql',
	'DB_HOST'=>'localhost',
	'DB_NAME'=>'thinkox',
	'DB_USER'=>'haozhili',
	'DB_PWD'=>'haozhili520',
	'DB_PORT'=>'3306',
	'DB_PREFIX'=>'onethink_',
	//

);