<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 4/4/14
 * Time: 9:29 AM
 */

namespace Api\Controller;


use Think\Controller;


use Sms\Sms;


class SmsController extends Controller
{
    public function send(){

        $mobile = '13971609049';
        $content = 'this is demo content.'  . ' [for test] ' . date('Y-m-d H:i:s');


        $sms = Sms::instance('Smszx', C('SMS.Smszx'));
        $mobile = '13971609049';
        $content = '我就是想测试一下，看是不是正常的啊!';
        $smsSendRs = $sms->send($mobile, $content );
        print_r($smsSendRs);


    }

}