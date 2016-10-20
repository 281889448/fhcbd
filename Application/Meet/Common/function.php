<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/10/11 0011
 * Time: 下午 17:59
 */

//返回$exit函数
 function return_exit_arr($id,$str_suc,$str_err)
{
    if($id){
        $exit=json_encode(array('code'=>1,'msg'=>$str_suc));
    }else{
        $exit=json_encode(array('code'=>0,'msg'=>$str_err));
    }
    return $exit;
}
