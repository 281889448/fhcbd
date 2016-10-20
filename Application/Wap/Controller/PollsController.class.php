<?php
/**
 * Created by PhpStorm.
 * User: MR.Z
 * Date: 16-10-14
 *
 */

namespace Wap\Controller;

use Common\Controller\BaseController;


class PollsController extends BaseController
{
    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $tree = D('PollsType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);
    }

    /*
     * 社情民意列表
     *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/14
     */
    public function index(){
        $map = [];

        if(IS_POST){
            $map = array_filter(I('post.'));
            $this->assign('map',$map);

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
        $contents = D('Polls')->where($map)->order('time desc')->select();

        foreach($contents as &$v){
            $v['type'] = $this->getType($v['type_id']);
        }

        $this->assign('contents',$contents);
		$this->display();
	}

	/*
	 * 社情民意添加
	 *  author: MR.Z <327778155@qq.com>
     * create: 2016/10/14
	 */
	public function add(){


        $this->display();
    }

    /*
     *  社情民意修改
     *  author: MR.Z <327778155@qq.com>
     *  create: 2016/10/14
     */
    public function edit($polls_id){
        $polls = D('Polls')->find($polls_id);

        if(in_array($polls['status'],[4,5])){
            $polls['back_suggest'] = D('PollsProcess')->where(['polls_id'=>$polls_id,'status'=>$polls['status']])->order('create_time desc')->getField('suggest');
        }




        $this->assign('polls',$polls);
        $this->display();
    }

    /*
     * 社情民间提交处理
     *
     */
    public function doPost($id = 0,$title,$type_id,$content){
        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }
        if ($type_id == 0) {
            $this->error('请选择提案类型。');
        }
        if (trim(op_h($content)) == '') {
            $this->error('请输入内容。');
        }
        $m =  M('Polls');

        $m->create();
        $m->uid = get_uid();
        $m->time = time();
        $m->people = I('post.author_id');
        $m->people_view = I('post.author');

        //更新附件
        $map_f['user_id'] = get_uid();
        $map_f['model'] = 'polls';
        $map_f['record_id'] = 0;


        if($id){

            $content['create_time'] = time();
           $flag = $m->save();
            if($flag){
                D('Fileu')->where($map_f)->setField('record_id',$id);
                $this->success('修改成功');
                exit;
            }
        }else{
           $id = $m->add();
            if($id){
                D('Fileu')->where($map_f)->setField('record_id',$id);
              $this->success('添加成功',U('myindex'));
                exit;
            }
        }
        $this->error('操作失败');

    }

    /*
     * 社情民意详情页
     *  author: MR.Z <327778155@qq.com>
     *  create: 2016/10/14
     */
    public function detail($polls_id){
        $polls = D('Polls')->find($polls_id);

        if(in_array($polls['status'],[4,5])){
            $polls['back_suggest'] = D('PollsProcess')->where(['polls_id'=>$polls_id,'status'=>$polls['status']])->order('create_time desc')->getField('suggest');
        }

        $this->assign('polls',$polls);
        $this->display();
    }

    /*
     * 查看我的社情民意
     *  author: MR.Z <327778155@qq.com>
     *  create: 2016/10/14
     */
    public function myindex(){
        $map['uid'] = get_uid();
        $contents = D('Polls')->where($map)->order('time desc')->select();
        $polls_status = C('POLLS_STATUS');
        foreach($contents as &$v){
            $v['type'] = $this->getType($v['type_id']);
        }
        $this->assign('polls_status',$polls_status);
        $this->assign('contents',$contents);
        $this->display();
    }

    /**
     * 获取社情民意类型
     * @param $type_id
     * @return mixed
     * autor:MR.Z <327778155@qq.com>
     */
    private function getType($type_id)
    {
        $type = D('PollsType')->where('id=' . $type_id)->find();

        return $type;
    }
    /******************************以下为ajax请求************************************/
    /*
    * 通过输入的作者名称检索出符合条件的作者
    * author: MR.Z <327778155@qq.com>
    * create: 2016/9/30
    */
    public function search_user_ajax(){
        $status = 0;
        if(IS_POST){
            $status = 1;
            $m = D('User/User');
            $author = I('post.author');
            $map['名称'] = ['like',"%{$author}%"];
            $m->setModel(WEIYUAN);
            $users = $m->getUsers($map);
            $rdata['status'] = $status;
            $rdata['content'] = $users;

        }
        $this->ajaxReturn($rdata);
    }

}