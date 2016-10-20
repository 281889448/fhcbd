<?php
namespace Home\Action;
use Think\Action;
class WeixinAction extends Action {
	public function index(){
		$signature = $_GET["signature"];
        $timestamp = $_GET["timestamp"];
        $nonce = $_GET["nonce"]; 
		$echoStr = $_GET["echostr"];
		$token = C('WX_TOKEN');
		$tmpArr = array($token, $timestamp, $nonce);
        // use SORT_STRING rule
		sort($tmpArr, SORT_STRING);
		$tmpStr = implode( $tmpArr );
		$tmpStr = sha1( $tmpStr );
		if( $tmpStr == $signature && $echoStr){
			echo $echoStr;
        	exit;
		}else{
			$this->replyMsg();
			//list($content, $type) = $this->reply($data);
			//$this->response($content, $type);
		}
	
	}
	public function replyMsg(){
		$postArr=$GLOBALS['HTTP_RAW_POST_DATA'];
		$postObj=simplexml_load_string($postArr);
		$toUser=$postObj->FromUserName;
		$fromUser=$postObj->ToUserName;
		//关注事件
			if(strtolower($postObj->MsgType)=='event'){
				if(strtolower($postObj->Event)=='subscribe'){
					//回复用户消息
					$time=time();
					$Msgtype='text';
					$Content=C('WX_SUB_REPLY');
					$this->replyText($toUser,$fromUser,$Content);
				}
			}
		//关键词文本回复
			if(strtolower($postObj->MsgType)=='text'){
				$Content=$postObj->Content;
				$keyArr=C('WX_KEY_REPLY');//替换此处
				 if(in_array($Content,$keyArr)){
					$Content='您输入了'.$Content;
				 }else{
					$Content='您输入的关键词没有找到，请联系管理员设置！';
				 }
				 $this->replyText($toUser,$fromUser,$Content);
			}
		//事件类型
			if(strtolower($postObj->MsgType)=='event'){
				//菜单点击事件
				if($postObj->Event=='CLICK'){
					//此处设置菜单关键词回复
					$this->replyText($toUser,$fromUser,'点击了菜单'.$postObj->EventKey);
				
				}
			}
	
	}
		//回复文本函数
		public function replyText($toUser,$fromUser,$Content){
			$time=time();
			$template="<xml>
						<ToUserName><![CDATA[%s]]></ToUserName>
						<FromUserName><![CDATA[%s]]></FromUserName>
						<CreateTime>%s</CreateTime>
						<MsgType><![CDATA[text]]></MsgType>
						<Content><![CDATA[%s]]></Content>
						</xml>";
			$info=sprintf($template,$toUser,$fromUser,$time,$Content);
			echo $info;
		}





}




?>