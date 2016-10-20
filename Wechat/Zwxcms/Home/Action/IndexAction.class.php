<?php
namespace Home\Action;
use Think\Action;
class IndexAction extends Action {
    public function index(){
		if(IS_POST){
			$signnum=$_POST['signnum'];
			//获取openid
			//$access_token=get_access_token();
		}
	//获取用户信息
		$userOpenid=get_user_openid();
		if(empty($userOpenid)) exit('Can not get user OPENID!');
		//echo("您的用户openid为：".$userOpenid);
		$this->assign('openid',$userOpenid);
			//判断是否绑定手机号
			//是->签到
			//否->绑定手机号->签到
       $this->display();
    }
	//设置自定义菜单
	public function setNav() {
		$navArr=array(
			'button'=>array(
				array(
				  "type"=>"view",
				  "name"=>urlencode("测试签到"),
				  "url"=>"http://thinkox.zwx518.com/wechat/index.php?g=Home&a=Index&f=index"
				),
				array(
				   "name"=>urlencode("最新资讯"),
                   "sub_button"=>array(
						array(
						   "type"=>"view",
						   "name"=>urlencode("搜索"),
						   "url"=>"http://www.soso.com/"
						),
						array(
						   "type"=>"view",
						   "name"=>urlencode("视频"),
						   "url"=>"http://www.soso.com/"
						),
						array(
						   "type"=>"click",
						   "name"=>urlencode("赞一下我们"),
						   "key"=>urlencode("非常感谢")
						)
					)
				)
			)
		);
		$postJson=urldecode(json_encode($navArr));
		$access_token=get_access_token();
		$url="https://api.weixin.qq.com/cgi-bin/menu/create?access_token=".$access_token;
		$res=https_request($url,$postJson);
		if($res[errcode]){
			//Return $res['errmsg'];
			dump($res);
		}else{
			echo('设置成功！');		
		};
		
	}
}