<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: MR.Z <327778155@qq.com> 
// +----------------------------------------------------------------------


function parse_field_attr($string) {
	if(0 === strpos($string,':')){
		// 采用函数定义
		return   eval(substr($string,1).';');
	}
	$array = preg_split('/[,;\r\n]+/', trim($string, ",;\r\n"));
	if(strpos($string,':')){
		$value  =   array();
		foreach ($array as $val) {
			list($k, $v) = explode(':', $val);
			$value[$k]   = $v;
		}
	}else{
		$value  =   $array;
	}
	return $value;
}


//通过字段名获取扩展字段
function getExtend($group_id,$name,$uid){
	$uid = $uid ? $uid : is_login();
	if(!$uid || !$name || !$group_id){
		return;
	}
	$mfs = D('field_setting');
	$mf = D('field');
	
	$map['profile_group_id'] = array('eq',$group_id);
	$map['field_name'] = array('eq',$name);
	$extend = $mfs->where($map)->getField('id,id,field_name,profile_group_id,visiable,required,sort,form_type,form_default_value,validation,status,createTime,child_form_type,input_tips');
	$current = reset($extend);

	$map2['field_id'] = array('eq',$current['id']);

	$map2['uid'] = array('eq',$uid);
	$current['field_content'] = $mf->where($map2)->find();

    //获取当前UID的扩展信息缓存  若存在缓存就用缓存代替
    if(empty(S('user_expandinfo_'.$uid))){
        $map_ex['uid'] = $uid;
        $map_ex['is_now'] = 1;
        $map_ex['is_review'] = 1;
        $user_history = M('UserHistory')->where($map_ex)->find();

        if(!empty($user_history)){S('user_expandinfo_'.$uid,unserialize($user_history['data']),1);}

    }

     $user_expandinfo =     S('user_expandinfo_'.$uid);
    if(!empty(S('user_expandinfo_'.$uid))){$current['field_content']['field_data'] = $user_expandinfo[$current['id']];}

	return $current;
}

function array2string($array){

    $string = [];

    if($array && is_array($array)){

        foreach ($array as $key=> $value){
            $string[] = $key."='".$value."'";
        }
    }

    return implode(',',$string);
}



?>