<?php


namespace Meet\Controller;

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

    /**
     * 会议首页
     * @param int    $page
     * @param int    $type_id
     * @param string $norh
     * autor:
     */
    public function index()
    {
        $meet = D("Meet")->order('id desc')->select();
        $this->assign("meet",$meet);
        $this->display();
    }

    /**
     * 获取推荐会议数据
     * autor:xjw129xjt
     */
    public function getRecommend()
    {
        $rec_meet = D('Meet')->where(array('is_recommend' => 1))->limit(2)->order('rand()')->select();
        foreach ($rec_meet as &$v) {
            $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
            $v['type'] = $this->getType($v['type_id']);
            $v['check_isSign'] = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $v['id']))->select();
        }
        unset($v);

        $this->assign('rec_meet', $rec_meet);


    }

    /**
     * 我的会议页面
     * @param int    $page
     * @param int    $type_id
     * @param string $norh
     * autor:xjw129xjt
     */

    private function getType($type_id)
    {
        $type = D('MeetType')->where('id=' . $type_id)->find();
        return $type;
    }

    /**
     * 发布会议
     * @param int    $id
     * @param int    $cover_id
     * @param string $title
     * @param string $explain
     * @param string $sTime
     * @param string $eTime
     * @param string $address
     * @param int    $limitCount
     * @param string $deadline
     * autor:xjw129xjt
     */
    public function doPost($id = 0, $cover_id = 0, $title = '', $explain = '', $sTime = '', $eTime = '', $address = '', $limitCount = 0, $deadline = '', $type_id = 0)
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
		//检查是否有提交提案的权限
		if (!check_auth('addProposalContent')) {
            $this->error('抱歉，您不具备提交提案权限。');
        }
		
        if (!$cover_id) {
            $this->error('请上传封面。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }
        if ($type_id == 0) {
            $this->error('请选择分类。');
        }
        if (trim(op_h($explain)) == '') {
            $this->error('请输入内容。');
        }
        if (trim(op_h($address)) == '') {
            $this->error('请输入地点。');
        }
        if ($sTime < $deadline) {
            $this->error('报名截止不能大于会议开始时间');
        }
        if ($deadline == '') {
            $this->error('请输入截止日期');
        }
        if ($sTime > $eTime) {
            $this->error('会议开始时间不能大于会议结束时间');
        }
        $content = D('Meet')->create();
        $content['explain'] = op_h($content['explain']);
        $content['title'] = op_t($content['title']);
        $content['sTime'] = strtotime($content['sTime']);
        $content['eTime'] = strtotime($content['eTime']);
        $content['deadline'] = strtotime($content['deadline']);
        $content['type_id'] = intval($type_id);
        if ($id) {
            $content_temp = D('Meet')->find($id);
            if (!is_administrator(is_login())) { //不是管理员则进行检测
                if ($content_temp['uid'] != is_login()) {
                    $this->error('越权操作。');
                }
            }
            $content['uid'] = $content_temp['uid']; //权限矫正，防止被改为管理员
            $rs = D('Meet')->save($content);

            $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Meet/Index/detail', array('id' => $id));
            $weiboApi = new WeiboApi();
            $weiboApi->resetLastSendTime();
            $weiboApi->sendWeibo("我修改了会议【" . $title . "】：" . $postUrl);


            if ($rs) {
                $this->success('编辑成功。', U('detail', array('id' => $content['id'])));
            } else {
                $this->success('编辑失败。', '');
            }
        } else {
            if (modC('NEED_VERIFY',0) && !is_administrator()) //需要审核且不是管理员
            {
                $content['status'] = 0;
                $tip = '但需管理员审核通过后才会显示在列表中，请耐心等待。';
                $user = query_user(array('username', 'nickname'), is_login());
                D('Common/Message')->sendMessage(C('USER_ADMINISTRATOR'), "{$user['nickname']}发布了一个会议，请到后台审核。", $title = '会议发布提醒', U('Admin/Meet/verify'), is_login(), 2);
            }
            $rs = D('Meet')->add($content);


//同步到微博
            $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Meet/Index/detail', array('id' => $rs));
            $weiboApi = new WeiboApi();
            $weiboApi->resetLastSendTime();
            $weiboApi->sendWeibo("我发布了一个新的会议【" . $title . "】：" . $postUrl);


            if ($rs) {
                $this->success('发布成功。' . $tip, U('index'));
            } else {
                $this->success('发布失败。', '');
            }
        }
    }

    /**
     * 会议详情
     * @param int $id
     * autor:xjw129xjt
     */
//查看详情页

    public function detail($id){
        $meet=D('Meet')->where("id={$id}")->find();
        $this->assign('meet',$meet);
        $this->display();
    }


public function qddetail(){
    $this->display();
}


   /* public function detail($id = 0)
    {

        $check_isSign = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $id))->select();

        $this->assign('check_isSign', $check_isSign);

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $id))->find();
        if (!$meet_content) {
            $this->error('404 not found');
        }
        D('Meet')->where(array('id' => $id))->setInc('view_count');

        $meet_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $meet_content['uid']);
        $meet_content['type'] = $this->getType($meet_content['type_id']);


        $menber = D('meet_attend')->where(array('meet_id' => $id, 'status' => 1))->select();
        foreach ($menber as $k => $v) {
            $meet_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

        }

        $this->assign('content', $meet_content);
        $this->setTitle('{$content.title|op_t}' . '——会议');
        $this->setKeywords('{$content.title|op_t}' . ',会议');
        $this->getRecommend();
        $this->display();
    }*/

    /**
     * 会议成员
     * @param int    $id
     * @param string $tip
     * autor:xjw129xjt
     */
    public function member($id = 0, $tip = 'all')
    {
        if ($tip == 'sign') {
            $map['status'] = 0;
        }
        if ($tip == 'attend') {
            $map['status'] = 1;
        }
        $check_isSign = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $id))->select();
        $this->assign('check_isSign', $check_isSign);

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $id))->find();
        if (!$meet_content) {
            $this->error('404 not found');
        }
        $map['meet_id'] = $id;
        $meet_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $meet_content['uid']);
        $menber = D('meet_attend')->where($map)->select();
        foreach ($menber as $k => $v) {
            $meet_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'avatar128', 'rank_html', 'signature'), $v['uid']);
            $meet_content['member'][$k]['name'] = $v['name'];
            $meet_content['member'][$k]['phone'] = $v['phone'];
            $meet_content['member'][$k]['status'] = $v['status'];
        }

        $this->assign('all_count', D('meet_attend')->where(array('meet_id' => $id))->count());
        $this->assign('sign_count', D('meet_attend')->where(array('meet_id' => $id, 'status' => 0))->count());
        $this->assign('attend_count', D('meet_attend')->where(array('meet_id' => $id, 'status' => 1))->count());

        $this->assign('content', $meet_content);
        $this->assign('tip', $tip);
        $this->setTitle('{$content.title|op_t}' . '——会议');
        $this->setKeywords('{$content.title|op_t}' . ',会议');
        $this->display();
    }

    /**
     * 编辑会议
     * @param $id
     * autor:xjw129xjt
     */

    //修改显示页面
    public function edit($id)
    {

        $meet = D('Meet')->where(array('id' => $id))->find();
        $this->assign('meet',$meet);
        $this->display();
        
    }
    //修改会议
    public function del($id){
        $result = D("Meet")->where("id={$id}")->save($_POST);

        if($result > 0)
        {
            $this->success("修改记录成功！");
        }
        else
        {
            $this->success("修改记录失败！");
        }

    }


    public function inset($type='',$title ='', $sTime = '', $eTime = '', $address = '',$people='',$content='',$qdsTime='',$qdeTime='')
    {
        if (trim(op_t($type)) == '') {
            $this->error('请输入活动类型。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入活动名称。');
        }
        if (trim(op_t($sTime)) == '') {
            $this->error('请输入开始时间。');
        }
        if (trim(op_t($eTime)) == '') {
            $this->error('请输入结束时间。');
        }

        if ($sTime > $eTime) {
            $this->error('会议开始时间不能大于活动结束时间');
        }
        if (trim(op_h($address)) == '') {
            $this->error('请输入活动地点。');
        }

        if (trim(op_h($people)) == '') {
            $this->error('请输入参加活动人员。');
        }
        if (trim($content) == '') {
            $this->error('请输入活动内容。');
        }

        if (trim(op_h($qdsTime)) == ''){
            $this->error('请输入签到开始时间。');
        }
        if (trim(op_h($qdeTime)) == ''){
            $this->error('请输入签到结束时间。');
        }
        if ($qdsTime > $qdeTime) {
            $this->error('会议开始签到时间不能大于会议签到结束时间');
        }
        $result = D('Meet')->add($_POST);
        if ($result == null) {
            $this->error("添加失败");
        }else{
            $this->success("添加成功");
        }

    }
// 删除会议
    public function doDel($id){

        $app=M("Meet")->where(array('id' => $id))->delete();
        if ($app>0){
            $this->success("删除成功");
        }else{
            $this->error("删除失败");
        }

    }




    public function add(){
        $this->display();
    }

    /**
     * 报名参加会议
     * @param $meet_id
     * @param $name
     * @param $phone
     * autor:xjw129xjt
     */
    public function doSign($meet_id, $name, $phone)
    {
        if (!is_login()) {
            $this->error('请登陆后再报名。');
        }
        if (!$meet_id) {
            $this->error('参数错误');
        }
        if (trim(op_t($name)) == '') {
            $this->error('请输入姓名。');
        }
        if (trim($phone) == '') {
            $this->error('请输入手机号码。');
        }
        $check = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $meet_id))->select();
        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }
        /*      if ($meet_content['attentionCount'] + 1 > $meet_content['limitCount']) {
                  $this->error('超过限制人数，报名失败');
              }*/
        if (time() > $meet_content['deadline']) {
            $this->error('报名已经截止');
        }
        if (!$check) {
            $data['uid'] = is_login();
            $data['meet_id'] = $meet_id;
            $data['name'] = $name;
            $data['phone'] = $phone;
            $data['creat_time'] = time();
            $res = D('meet_attend')->add($data);
            if ($res) {

                D('Message')->sendMessageWithoutCheckSelf($meet_content['uid'], query_user('nickname', is_login()) . '报名参加了会议]' . $meet_content['title'] . ']，请速去审核！', '报名通知', U('Meet/Index/member', array('id' => $meet_id)), is_login());

                D('Meet')->where(array('id' => $meet_id))->setInc('signCount');
                $this->success('报名成功。', 'refresh');
            } else {
                $this->error('报名失败。', '');
            }
        } else {
            $this->error('您已经报过名了。', '');
        }
    }

    /**
     * 审核
     * @param $uid
     * @param $meet_id
     * @param $tip
     * autor:xjw129xjt
     */
    public function shenhe($uid, $meet_id, $tip)
    {
        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }
        if ($meet_content['uid'] == is_login()) {
            $res = D('meet_attend')->where(array('uid' => $uid, 'meet_id' => $meet_id))->setField('status', $tip);
            if ($tip) {
                D('Meet')->where(array('id' => $meet_id))->setInc('attentionCount');
                D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '已经通过了您对会议' . $meet_content['title'] . '的报名请求', '审核通知', U('Meet/Index/detail', array('id' => $meet_id)), is_login());
            } else {
                D('Meet')->where(array('id' => $meet_id))->setDec('attentionCount');
                D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '取消了您对会议[' . $meet_content['title'] . ']的报名请求', '取消审核通知', U('Meet/Index/member', array('id' => $meet_id)), is_login());
            }
            if ($res) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('操作失败，非会议发起者操作！');
        }
    }

    /**
     * 取消报名
     * @param $meet_id
     * autor:xjw129xjt
     */
    public function unSign($meet_id)
    {

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }

        $check = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $meet_id))->find();

        $res = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $meet_id))->delete();
        if ($res) {
            if ($check['status']) {
                D('Meet')->where(array('id' => $meet_id))->setDec('attentionCount');
            }
            D('Meet')->where(array('id' => $meet_id))->setDec('signCount');

            D('Message')->sendMessageWithoutCheckSelf($meet_content['uid'], query_user('nickname', is_login()) . '取消了对会议[' . $meet_content['title'] . ']的报名', '取消报名通知', U('Meet/Index/detail', array('id' => $meet_id)), is_login());

            $this->success('取消报名成功');
        } else {
            $this->error('操作失败');
        }
    }

    /**
     * 报名弹出框页面
     * @param $meet_id
     * autor:xjw129xjt
     */
    public function ajax_sign($meet_id)
    {

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }

        D('Meet')->where(array('id' => $meet_id))->setInc('view_count');
        $meet_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $meet_content['uid']);
        $meet_content['type'] = $this->getType($meet_content['type_id']);

        $menber = D('meet_attend')->where(array('meet_id' => $meet_id, 'status' => 1))->select();
        foreach ($menber as $k => $v) {
            $meet_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

        }

        $this->assign('content', $meet_content);
        $this->display();
    }

    /**
     * ajax删除会议
     * @param $meet_id
     * autor:xjw129xjt
     */
   /* public function doDelMeet($meet_id)
    {

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }
        if ($meet_content['uid'] == is_login() || is_administrator(is_login())) {
            $res = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->setField('status', 0);
            if ($res) {
                $this->success('删除成功！', U('Meet/Index/index'));
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('非会议发起者操作！');
        }

    }*/

    /**
     * ajax提前结束会议
     * @param $meet_id
     * autor:xjw129xjt
     */
    public function doEndMeet($meet_id)
    {

        $meet_content = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->find();
        if (!$meet_content) {
            $this->error('会议不存在！');
        }
        if ($meet_content['uid'] == is_login() || is_administrator(is_login())) {
            $res = D('Meet')->where(array('status' => 1, 'id' => $meet_id))->setField('eTime', time());
            if ($res) {
                $this->success('操作成功！');
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('非会议发起者操作！');
        }

    }

    public function search(){
        $this->display();
    }

public function qdadd(){
    $this->display();
}

}