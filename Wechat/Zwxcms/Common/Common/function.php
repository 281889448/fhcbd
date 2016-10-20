<?php
	//获取access_token
	function get_access_token() {
		$subtraction=time()-$_SESSION['access_token_time'];
		if($subtraction>7200 || !$_SESSION['access_token_time']){
			$appid=C('WX_APPID');
			$appsecret=C('WX_SECRET');
			$url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$appid."&secret=".$appsecret;
			$res=https_request($url);
			if($res['errcode']){
					Return($res['errcode']);
			}else{
				session('access_token',$res['access_token']);
				session('access_token_time',time());
				Return ($res['access_token']);
			}
		}else{
			Return ($_SESSION['access_token']);
		}
	}
	//获取用户openid
	function get_user_openid(){
		$info=array('appid'=>C('WX_APPID'),'oauthinfo'=>C('WX_OAUTHINFO'),'appsecret'=>C('WX_SECRET'));
		$redirect_uri= "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		$now=time();
		$codeUrl =get_code_url($info,$redirect_uri);
		if(empty($_GET['code']) && empty($_GET['state'])){
			header("Location: $codeUrl"); 
			exit;			
		}else{
			//拿到第一步获取到的code，在用来获取access_token
				$code 	= $_GET['code'];
				if(!empty($code)){
					$res 	=get_web_access_token($info,$code);
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
		$url 	=  "https://open.weixin.qq.com/connect/oauth2/authorize?appid={$info['appid']}&redirect_uri={$redirect_uri}&response_type=code&scope={$info['oauthinfo']}&state={$state}";
		$url .= '#wechat_redirect';
		return $url;
	}

	//第二步  通过code获取access_token，需要的参数code，以及info的appid和appsecret
	function get_web_access_token($info,$code){		
		$tokenurl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$info['appid']."&secret=".$info['appsecret']."&code=".$code."&grant_type=authorization_code";
		$res= https_request($tokenurl);
		return $res;
				
	}