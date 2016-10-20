<?php


namespace Working\Controller;

use Think\Controller;
use Weibo\Api\WeiboApi;

class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree = D('MeetType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);

        $sub_menu =
            array(
                'left' =>
                    array(
                        array('tab' => 'home', 'title' => '首页', 'href' => U('meet/index/index')),
                        array('tab' => 'mymeet', 'title' => '我的会议', 'href' => U('meet/index/mymeet')),
                    ),
            );
        $this->assign('sub_menu', $sub_menu);
        $this->assign('current', 'home');
    }


    public function index()
    {
        $group=get_group(get_uid());
        switch ($group){
            case '政协办公室':
                if(I('get.status')<2) $this->error('无权访问!');
                break;
            case '办公室主任':
                if(I('get.status')<3) $this->error('无权访问!');
                break;
        }
        $status = I('get.status');
        $bstatus = I('get.bstatus');
        $work = D('Working'); // 实例化User对象
        if (IS_POST) {
            $title = I('post.title');
            $stime = I('post.stime');
            $etime = I('post.etime');
            $stime = strtotime($stime);
            $etime = strtotime($etime);

            if (!empty($stime) && !empty($etime)) {
                $map['time'] = array(array('gt', $stime), array('lt', $etime));
            } elseif (!empty($stime)) {
                $map['time'] = array('gt', $stime);
            } elseif (!empty($etime)) {
                $map['time'] = array('lt', $etime);
            }
            if (!empty($title)) {
                $map['title'] = array('like', '%' . $title . '%');
            };
            $map = array_filter($map);
        }
        $name = get_username();
        if (!empty($status)) {
            $map['status'] = $status;
        }
        if (!empty($bstatus)) {
            $map['bstatus'] = $bstatus;
        }
        $count = $work->where($map)->count();
	
        $Page = new \Think\Page($count, 10);
        $list = $work->where($map)->order('id desc')->limit($Page->firstRow . ',' . $Page->listRows)->select();
        /*  echo $work->getLastSql();
          exit;*/
        $this->assign('name', $name);
        $this->assign('status', $status);
        $this->assign('list', $list);
        $this->assign('page', $Page->show());
        $this->display();
    }

    /**
     * 委员、集体、政协办公室添加活动
     */
    public function dopost($title = '', $content = '')
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
        $type=get_group(get_uid());
        switch ($type){
            case '委员':
                $url=U('Working/Index/index',array('status'=>1));
                break;
            case '政协办公室':
                $url=U('Working/Index/index',array('status'=>2,'bstatus'=>1));
                break;
            case '办公室主任':
                $url=U('Working/Index/index',array('status'=>3,'bstatus'=>1));
                break;
            case '集体':
                $url=U('Working/Index/index',array('status'=>1));
                break;
        }

        if (IS_POST) {
            if (trim(op_t($title)) == '') {
                $this->error('请输入标题。');
            }
            if (trim(op_t($content)) == '') {
                $this->error('请输入内容。');
            }
            //如果接收到了post请求，就添加数据
            $model = D('Working');
            $data = I('post.');
            $data['time']= strtotime( $data['time']);
            $data['status']= $data['status']? $data['status']:1;
            $data['uid'] = get_uid();
            if($data['id']){
                $id=$model->save($data);
            }else{
                $rs=$model->add($data);
            }
	        if($rs){
		        $map_f['user_id'] = get_uid();
		        $map_f['model'] = MODULE_NAME;
		        $map_f['record_id'] = 0;
		        D('Fileu')->where($map_f)->setField('record_id',$rs);
	        }
            if ($id || $rs) {

                $this->success('操作成功！',$url);
            } else {
                $this->error('操作失败！',$url);
            }

        }
        $name = get_username();
        $user=D('Ucenter_member')->where(array('username'=>$name))->find();//得到UID
        $truename=D('Field')->where(array('uid'=>$user['id'],'field_id'=>38))->find();//38姓名
        $this->assign('name', $truename['field_data']);
        $read = D('Working')->where(array('id' => I('get.id')))->find();
        $this->assign('url', $url);
        $this->assign('read', $read);
        $this->display();
    }

//修改
    public function edit($id)
    {
        $read = D('Working')->where(array('id' => $id))->find();
        $this->assign('read', $read);
        $this->display();
    }

    //删除
    public function del()
    {
        $id = I('post.id');
        $model = D('Working');
        $id = $model->where(array('id' => $id))->delete();
        $exit = $this->return_exit_arr($id, '成功！', '删除失败');
        echo $exit;
    }

    //查看
    public function detail($id)
    {
        $read = D('Working')->where(array('id' => $id))->find();
        $this->assign('read', $read);
        $this->display();

    }
    //工作状态变换
    public function sub_work_status()
    {
        $id = I('post.id');
        $data = I('post.');
        $data['status'] = I('post.status');
        $data['bstatus'] = I('post.bstatus');
        $data['back'] = I('post.back');
        $id = D('Working')->where(array('id' => $id))->save($data);
        $exit = $this->return_exit_arr($id, '成功！', '提交失败');
        echo $exit;
    }

//返回ajax_exit函数
    public function return_exit_arr($id, $str_suc, $str_err)
    {
        if ($id) {
            $exit = json_encode(array('code' => 1, 'msg' => $str_suc));
        } else {
            $exit = json_encode(array('code' => 0, 'msg' => $str_err));
        }
        return $exit;
    }
}