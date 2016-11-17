<?php
namespace Common\Api;
class WeixinApi{
    public $appid='wx07fdd9a4503cca15';
    public $appsecret='6682cef161cd61003e561cde96336ec0';
    public $access_token;
    public function __construct()
    {
        $this->access_token=$this->get_access_token();
    }
    public function sendTempMsg_Event_Meet($openid,$dataArr,$tempid){
        // 获取配置信息
        $dbinfo = array('textcolor'=>'#000000');
        // 准备发送请求的数据
        $requestUrl = 'https://api.weixin.qq.com/cgi-bin/message/template/send?access_token='.$this->access_token;
        $sendData=array(
            'touser'=>$openid,
            "template_id"=>$tempid,
            "url"=>$dataArr['href'],
            "data"=>array(
                "first"=>array(
                    "value"=>urlencode($dataArr['first']),
                    "color"=>"#173177"
                ),
                "keyword1"=>array(
                    "value"=>urlencode($dataArr['keyword1']),
                    "color"=>"#173177"
                ),
                "keyword2"=>array(
                    "value"=>urlencode($dataArr['keyword2']),
                    "color"=>"#173177"
                ),
                "keyword3"=>array(
                    "value"=>urlencode($dataArr['keyword3']),
                    "color"=>"#173177"
                ),
                "keyword4"=>array(
                    "value"=>urlencode($dataArr['keyword4']),
                    "color"=>"#173177"
                ),
                "remark"=>array(
                    "value"=>urlencode($dataArr['remark']),
                    "color"=>"#173177"
                )
            )
        );
        $res= $this->postCurl($requestUrl,urldecode(json_encode($sendData)));
        return $res;

    }
    public function sendTempMsg_proposal($openid,$name,$content,$url){
        $requestUrl = 'https://api.weixin.qq.com/cgi-bin/message/template/send?access_token='.$this->access_token;
        $tempid='voC9EYqqxBQXyVHHnQUXiZ6RWB1-vHk0JlV08_y4aqw';
        $first='关于“'.$name.'”提案办理提醒';
        $keyword2=$content;
        $remark='';
        $sendData=array(
            'touser'=>$openid,
            "template_id"=>$tempid,
            "url"=>'',
            "data"=>array(
                "first"=>array(
                    "value"=>urlencode($first),
                    "color"=>"#173177"
                ),
                "keyword1"=>array(
                    "value"=>urlencode(date('Y-m-d H:i:s',time())),
                    "color"=>"#173177"
                ),
                "keyword2"=>array(
                    "value"=>urlencode($keyword2),
                    "color"=>"#173177"
                ),
                "remark"=>array(
                    "value"=>urlencode($remark),
                    "color"=>"#173177"
                )
            )
        );
        $res= $this->postCurl($requestUrl,urldecode(json_encode($sendData)));
        return $res;
    }
// Post Request
    function postCurl($url, $data){
        $ch = curl_init();
        $header = "Accept-Charset: utf-8";
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        $tmpInfo = curl_exec($ch);
        $errorno=curl_errno($ch);
        if ($errorno){
            Return (array('rt'=>false,'errorno'=>$errorno));
        }else{
            $js=json_decode($tmpInfo,1);
            if ($js['errcode']=='0'){
                Return (array('rt'=>true,'errorno'=>0));
            }else {
                //exit('模板消息发送失败。错误代码'.$js['errcode'].',错误信息：'.$js['errmsg']);
                Return (array('rt'=>false,'errorno'=>$js['errcode'],'errmsg'=>$js['errmsg']));
            }
        }
    }

// Get Access_token Request
    function curlGet($url){
        $ch = curl_init();
        $header = "Accept-Charset: utf-8";
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        curl_setopt($ch, CURLOPT_SSLVERSION, CURL_SSLVERSION_TLSv1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($ch, CURLOPT_AUTOREFERER, 1);
        //curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        $temp = curl_exec($ch);
        return $temp;
    }

    function curl_getinfo($url){
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        curl_exec($ch);
// Check if any error occurred
        if (!curl_errno($ch)) {
            $info = curl_getinfo($ch);
            return $info;
        }
// Close handle
        curl_close($ch);
    }
    function get_access_token() {
        $subtraction=time()-session('access_token_time');
        if($subtraction>7200 || !session('access_token_time')){
            $url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$this->appid."&secret=".$this->appsecret;
            $res=$this->https_request($url);
            if($res['errcode']){
                Return($res['errcode']);
            }else{
                session('access_token',$res['access_token']);
                session('access_token_time',time());
                Return ($res['access_token']);
            }
        }else{
            Return (session('access_token'));
        }
    }
    //获取用户openid
    function get_user_openid(){
        $info=array('appid'=>$this->appid,'oauthinfo'=>"snsapi_base",'appsecret'=>$this->appsecret);
        $redirect_uri= "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
        $codeUrl =$this->get_code_url($info,$redirect_uri);
        if(empty($_GET['code']) && empty($_GET['state'])){
            header("Location: $codeUrl");
            exit;
        }else{
            //拿到第一步获取到的code，在用来获取access_token
            $code 	= $_GET['code'];
            if(!empty($code)){
                $res 	=$this->get_web_access_token($info,$code);
                if(empty($res['errcode'])){
                    session('web_access_token',$res['access_token']);
                    session('web_access_token_time',time());
                    return $res['openid'];
                }else{
                    //$this->error['-4'] = ' 网页授权错误:'.$res['errcode'];
                    header("Location: $codeUrl");
                    //以上解决带有code无法重新获取问题2016-7-17郝
                }
            }
        }

    }
    //网页请求
    function https_request($url, $data = null)
    {
        $curl = curl_init();//初始化curl对象
        $header = "Accept-Charset: utf-8";//规定处理表单字符为UTF-8
        curl_setopt($curl, CURLOPT_URL, $url);//curl会话设置：地址为$url
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
        //curl_setopt($curl, CURLOPT_SSLVERSION, 3);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        if (!empty($data)){
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
        }
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_IPRESOLVE, CURL_IPRESOLVE_V4);
        $output = curl_exec($curl);//执行curl会话
        $errorno= curl_errno($curl);//获取执行错误信息
        if ($errorno) {
            return array('curl'=>false,'errorno'=>$errorno);
        }else{
            $res = json_decode($output,1);

            if ($res['errcode']){
                return array('errcode'=>$res['errcode'],'errmsg'=>$res['errmsg']);
            }else{
                return $res;
            }
        }
        curl_close($curl);
    }
    //拼接code获取url
    function get_code_url($info,$redirect_uri = '') {
        $redirect_uri = urlencode($redirect_uri);
        $state='haozhili';
        $url  ="https://open.weixin.qq.com/connect/oauth2/authorize?appid={$info['appid']}&redirect_uri={$redirect_uri}&response_type=code&scope={$info['oauthinfo']}&state={$state}";
        $url .= '#wechat_redirect';
        return $url;
    }

    //第二步  通过code获取access_token，需要的参数code，以及info的appid和appsecret
    function get_web_access_token($info,$code){
        $tokenurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$info['appid']."&secret=".$info['appsecret']."&code=".$code."&grant_type=authorization_code";
        $res= https_request($tokenurl);
        return $res;
    }


}
