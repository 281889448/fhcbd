<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/10/8 0008
 * Time: 下午 18:00
 */

namespace Common\Controller;


use Think\Controller;
use Sms\Sms;

class BaseController extends Controller
{
    protected static $sms;
    /* 空操作，用于输出404页面 */
    public function _empty(){
        $this->redirect('Index/index');
    }

    protected function _initialize(){

        //初始化短信功能
        self::$sms = Sms::instance('Smszx', C('SMS.Smszx'));

        $a =  D('Home/Member')->need_login();

        define('UID',is_login());

        /************当前委员是否是主任*******************/
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $user = $m->getUser(get_uid());
        $roler = $user['主任'];
        if($roler){
         $this->assign('roler',$roler);
        }



        //首先判断是否手机端登陆，如果不是手机端则进行else 里的操作
        if(sp_is_mobile()  && ACTION_NAME != 'login' ){
            //redirect(U('Wap/Proposal/Index',['status'=>1]));
            session('redirect_url',str_replace('/','\\',serialize(__SELF__)));

            if(session('openid') ){
                $this->openid=session('openid');
            }else{
                $this->openid=get_user_openid();
            }
            //判断是否绑定
            if($this->openid){ 
                $user=D('Ucenter_member')->where(array('openid'=>$this->openid))->find();
                if(empty($user) && ACTION_NAME != 'binding' && ACTION_NAME != 'savebind'){
                    $this->redirect('Wap/Weixin/binding');
                }else{

                    if(!empty($user)){
                        $auth = array(
                            'uid' => $user['id'],
                            'username' => get_username($user['id']),
                            'last_login_time' => $user['last_login_time'],
                        );
                        session('user_auth', $auth);
                        session('user_auth_sign', data_auth_sign($auth));
                    }
                }
            }else{
                $this->error('无法获取您的微信信息！');
            }
        }else{

            //验证登陆，如果是在登陆页面就不再进行跳转
            if( !UID && ACTION_NAME != 'login'){// 还没登录 跳转到登录页面
                $this->redirect('Home/User/login',['redirect_url'=>session('redirect_url')]);
            }else{

            }
        }
        /* 读取站点配置 */
        $config = api('Config/lists');
        C($config); //添加配置

        if(!C('WEB_SITE_CLOSE')){
            $this->error('站点已经关闭，请稍后访问~');
        }
    }



    /* 用户登录检测 */
    protected function login(){
        /* 用户登录检测 */
        is_login() || $this->error('您还没有登录，请先登录！', U('User/login'));
    }

    protected function ensureApiSuccess($result)
    {
        if (!$result['success']) {
            $this->error($result['message'], $result['url']);
        }
    }
}