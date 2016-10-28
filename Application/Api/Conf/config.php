<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.thinkphp.cn>
// +----------------------------------------------------------------------

/**
 * 前台配置文件
 * 所有除开系统级别的前台配置
 */
return array(

    // 预先加载的标签库
    'TAGLIB_PRE_LOAD'     =>    'OT\\TagLib\\Article,OT\\TagLib\\Think',
        
    /* 主题设置 */
    'DEFAULT_THEME' =>  'default',  // 默认模板主题名称

    /* SESSION 和 COOKIE 配置 */
    'SESSION_PREFIX' => 'onethink_home', //session前缀
    'COOKIE_PREFIX'  => 'onethink_home_', // Cookie前缀 避免冲突

    /* 模板相关配置 */
    'TMPL_PARSE_STRING' => array(
        '__STATIC__' => __ROOT__ . '/Public/static',
        '__ADDONS__' => __ROOT__ . '/Public/' . MODULE_NAME . '/Addons',
        '__IMG__'    => __ROOT__ . '/Public/' . MODULE_NAME . '/images',
        '__CSS__'    => __ROOT__ . '/Public/' . MODULE_NAME . '/css',
        '__JS__'     => __ROOT__ . '/Public/' . MODULE_NAME . '/js',
    ),
    'SMS' => array(
        'VERIFY_TIMEOUT' => 300, //认证超时时间(单位：秒)
        'MIN_TIME_SPAN'   => 60, //最小重复发送间隔，单位秒,不限制则设置为0
        'SINGLE_IP_LIMIT' => 30, //单个IP 在SINGLE_IP_LIMIT_TIME规定的时间内允许发送的最多条数,不限制则设置为0
        'SINGLE_IP_LIMIT_TIME' => 3600, //单个IP灌水检测时间限制，单位秒
        //主短信服务商设置（名称为ClassName), 通道为验证码通道
        'SP' => 'Montnets',
        //备用短信服务商设置（名称为ClassName), 通道为验证码通道
        'SP_BAK' => '',
        //短信服务商设置（名称为ClassName), 通知类通道
        'SP_NOTICE' => '',
        //备用短信服务商设置（名称为ClassName), 通知类通道
        'SP_NOTICE_BAK' => '',
        'Montnets' => array(
            'API_URL'  => 'http://61.145.229.29:9006/MWGate/wmgw.asmx/',
            'USERNAME' => '用户名',
            'PASSWORD' => '密码',
        ),
        'Smszx' => array(
            'API_URL'  => 'http://www.hb-mas.cn/web/service/ExternalService',
            'UserLoginID' => 'whjh1993',
            'FirstPassword' => 'whjh19931234',
            'UserSecondID' => 'admin',
            'SecondPassword' => '1234qwer',
            'spNumber' => '503184',
            'srcID' =>  '10657309266201',
        )
    ),

);