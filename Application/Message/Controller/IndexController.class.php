<?php


namespace Message\Controller;

use Common\Controller\BaseController;
use Common\Api\WeixinApi;
use Weibo\Api\WeiboApi;

class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {   parent::_initialize();


        $this->assign('current', 'message');
    }

    /**
     * 会议首页
     * @param int    $page
     * @param int    $type_id
     * @param string $norh
     * autor:xjw129xjt
     */
    
    public function detail($id){
        $resaut=D('Message')->where(array('id' => $id))->find();
        //查询人员名称
        $people_str = $resaut['people'];
        $people_str = $resaut['people'];
        $people_arr = explode(',', $people_str);
        $temp_arr = array();
        foreach ($people_arr as $k => $v) {
            $name = D('Field')->where(array('uid' => $v, 'field_id' => 38))->find();
            $temp_arr[$k] = $name['field_data'];
        }

        $this->assign('back_url',I('server.HTTP_REFERER'));
        $this->assign('people', $temp_arr);

        $this->assign('resaut',$resaut);
        $this->display();
    }
    //修改页面
    public function edit($id){
        $me=D('Message')->where(array('id' => $id))->find();

        //查找人员名单
        $group_ids = C('CONTACT_GROUP');
        $group = array();
        foreach ($group_ids as $k => $v) {
            if ($v['is_final'] == true && $v['parent_id'] == 0) {
                $group[$k]['name'] = $v['name'];
            } elseif ($v['is_final'] == true && $v['parent_id'] != 0) {
                $group[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
                $group[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
            }
        }
        ksort($group);
        $this->assign('contact_group', $group);

        //查找人员名称
        $temp_arr = $this->uid_to_get_detail($me['people']);
        $this->assign('people', $temp_arr);

        $this->assign('me',$me);
        $this->display();
    }
    //获取人员详细信息公共函数 $str="1,2,3,4,5,6"格式

    public function uid_to_get_detail($str)
    {
        $people_arr = explode(',', $str);
        $temp_arr = array();
        foreach ($people_arr as $k => $v) {
            $truename = D('Field')->where(array('uid' => $v, 'field_id' => 38))->find();//38姓名
            $compay = D('Field')->where(array('uid' => $v, 'field_id' => 50))->find();//50工作单位
            $phone = D('Field')->where(array('uid' => $v, 'field_id' => 62))->find();//62电话
            $temp_arr[$k]['uid'] = $v;
            $temp_arr[$k]['truename'] = $truename['field_data'];
            $temp_arr[$k]['company'] = $compay['field_data'];
            $temp_arr[$k]['phone'] = $phone['field_data'];
        }
        return $temp_arr;
    }

    //删除
    public function del($id){
        $app=D("Message")->where("id={$id}")->delete();
        if ($app){
            $this->success("删除成功");
        }else{
            $this->error("删除失败","{:U('Message/Index/index')}");
        }

    }
    
    public function index()
    {
        if (IS_POST) {
            $map['title'] = array('like', '%' . $_POST['keyword'] . '%');
            $resaut = D("Message")->where($map)->order('id desc')->select();
            $this->assign("lockback", 1);
        } else {
            $resaut = D('Message')->order('id desc')->select();
        }
        foreach ($resaut as $key => $val) {
            $name = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
            $resaut[$key]['truename'] = $name['field_data'];
        }
        $this->assign('resaut', $resaut);
        $this->display();
    }
    //发送通知
    public function sendtemplateMsg()
    {
        $id=I('post.id');
        $tempid='iHR1nEK2XcDLzGFhbskC7AfONuFJkvkmSM5MpdArRas';
        $data = D('Message')->where(array('id' =>$id ))->find();
        $arr = array(
            'href' => C('WX_CALLBACK_URL'). U('Home/Weixin/tongzhi', array('id' => $id)),
            'first' => '关于' . $data['title'] . '通知',
            'keyword1' => date('Y-m-d H:i:s', $data['stime']),
            'keyword2' => $data['title'],
            'keyword3' => $data['address'],
            'remark' => '点击详情查看公告信息'
        );
        $map['id'] = array('in', $data['people']);
        $userdata = D('Ucenter_member')->where($map)->field('openid')->select();
        $wxapi = new WeixinApi();
        $time = 0;
        foreach ($userdata as $key => $val) {
            $res = $wxapi->sendTempMsg_Event_Meet($val['openid'], $arr,$tempid);
            if ($res['rt']) $time++;
        }
        echo json_encode(array('time' => $time));
    }
public function add(){
    //查找人员名单
    $group_ids = C('CONTACT_GROUP');
    $group = array();
    foreach ($group_ids as $k => $v) {
        if ($v['is_final'] == true && $v['parent_id'] == 0) {
            $group[$k]['name'] = $v['name'];
        } elseif ($v['is_final'] == true && $v['parent_id'] != 0) {
            $group[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
            $group[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
        }
    }
    ksort($group);
    $this->assign('contact_group', $group);

    $this->display();
}
    public function upload($type='',$title ='', $stime = '',$people='',$content='')
    {

        if (trim(op_t($type)) == '') {
            $this->error('请输入活动类型。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入活动名称。');
        }
        if (trim(op_t($stime)) == '') {
            $this->error('请输入发布时间。');
        }
   /*     if (trim(op_h($people)) == '') {
            $this->error('请输入参加活动人员。');
        }
     */   if (trim($content) == '') {
            $this->error('请输入活动内容。');
        }
        //导入上传类
        import("ORG.Net.UploadFile");
        $upload=new \Think\Upload();
        //设置大小
        $upload->Maxsize=1000000;
        //设置格式
        $upload->exts=array();
        $upload->savePath="/Uploads/Download/";
        if ($upload->upload()){
            $this->success('上传成功！');
        }else{

        }
        $data=I('post.');
        $data['stime']=strtotime($data['stime']);
        $data['uid']=get_uid();
        if($data['id']){
            $result = D('Message')->save($data);
        }else{
            $result = D('Message')->add($data);
        }

	    //更新附件
	    $map_f['user_id'] = get_uid();
	    $map_f['model'] = MODULE_NAME;
	    $map_f['record_id'] = 0;
	    D('Fileu')->where($map_f)->setField('record_id',$result);

        if ($result == null) {
            $this->error("添加失败",U('add'));
        }else{
            $this->success("添加成功",U('index'));
        }
    }

    public function search(){
        $this->display();
    }

public function qdadd(){
    $this->display();
}

}