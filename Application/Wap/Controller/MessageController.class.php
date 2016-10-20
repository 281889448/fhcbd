<?php
/**
 * Created by PhpStorm.
 * User: MR.Z
 * Date: 16-10-8
 * Time: AM9:45
 */

namespace Wap\Controller;

use Common\Controller\BaseController;


class MessageController extends BaseController
{

	public function index(){



        if(IS_POST){
            $map = I('post.');
            $this->assign('map',$map);
        }
        //需要根据权限来显示动态的列表
        $user_id = get_uid();
        $map['_string'] = "(find_in_set({$user_id},people) or people='')";

        $map = array_filter($map);
        if($map['title']){
            $map['title'] = ['like',"%{$map['title']}%"];
        }

        $message = D('Message')->where($map)->order('stime desc')->select();

        $m = D('User/User');
        $m->setModel(WEIYUAN);

        foreach($message as &$v){
            $v['user'] = $m->getUser($v['uid']);

        }

        $this->assign('message',$message);
		$this->display();
	}

	public function detail($id){
	    $message = D('Message')->find($id);
        $this->assign('message',$message);
        $this->display();
    }
}