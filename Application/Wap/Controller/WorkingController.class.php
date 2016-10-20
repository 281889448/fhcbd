<?php
/**
 * Created by PhpStorm.
 * User: MR.Z
 * Date: 16-10-8
 * Time: AM9:45
 */

namespace Wap\Controller;

use Common\Controller\BaseController;


class WorkingController extends BaseController
{

	public function index(){
        $map = [];

        if(IS_POST){
            $map = I('post.');
            $this->assign('map',$map);
            $map = array_filter($map);
            $stime = $map['stime'] ? strtotime($map['stime']) : 0 ;
            $etime = $map['etime'] ? strtotime($map['etime'])+ (3600*24-1) : 0;
            if($stime && $etime){
                $map['time'] = ['between',$stime.','.$etime];
            }else{
                if($stime){
                    $map['time'] = ['gt',$stime];
                }elseif($etime){
                    $map['time'] = ['lt',$etime];
                }
            }
            if($map['title']){
                $map['title'] = ['like',"%{$map['title']}%"];
            }
        }
        $map['status'] = 6;
        $contents = D('Working')->where($map)->order('time desc')->select();

        $m = D('User/User');
        $m->setModel(WEIYUAN);
        foreach($contents as &$v){
            $v['user'] = $m->getUser($v['uid']);
        }


        $this->assign('contents',$contents);
        $this->display();
	}

	public function detail($working_id){
        $working = D('Working')->find($working_id);

        $this->assign('working',$working);
        $this->display();
    }


}