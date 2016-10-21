<?php


namespace Meet\Controller;

use Common\Controller\BaseController;
use Common\Api\WeixinApi;
use Weibo\Api\WeiboApi;
use User\Model\User;
class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        parent::_initialize();
        $tree = D('MeetType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);


        $this->assign('current', 'meet');
    }

    /**
     * 会议首页
     *
     *
     * @param int $page
     * @param int $type_id
     * @param string $norh
     * autor:xjw129xjt
     */
    public function index()
    {
        if (IS_POST) {
            $map['title'] = array('like', '%' . $_POST['keyword'] . '%');
            $meet = D("meet")->where($map)->order('id desc')->select();
            $this->assign("lockback", 1);
        } else {
            $meet = D("meet")->order('id desc')->select();
        }
        $this->assign("meet", $meet);
        $this->display();

    }

    /**
     * 获取推荐会议数据
     * autor:xjw129xjt
     */
    /*   public function getRecommend()
       {
           $rec_meet = D('Meet')->where(array('is_recommend' => 1))->limit(2)->order('rand()')->select();
           foreach ($rec_meet as &$v) {
               $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
               $v['type'] = $this->getType($v['type_id']);
               $v['check_isSign'] = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $v['id']))->select();
           }
           unset($v);

           $this->assign('rec_meet', $rec_meet);


       }*/

    /**
     * 我的会议页面
     * @param int $page
     * @param int $type_id
     * @param string $norh
     * autor:xjw129xjt
     */
    /*    public function mymeet($page = 1, $type_id = 0, $lora = '')
        {

            $type_id = intval($type_id);
            if ($type_id != 0) {
                $map['type_id'] = $type_id;
            }

            $map['status'] = 1;
            $order = 'create_time desc';
            if ($lora == 'attend') {
                $attend = D('meet_attend')->where(array('uid' => is_login()))->select();
                $enentids = getSubByKey($attend, 'meet_id');
                $map['id'] = array('in', $enentids);
            } else {
                $map['uid'] = is_login();
            }
            $content = D('Meet')->where($map)->order($order)->page($page, 10)->select();

            $totalCount = D('Meet')->where($map)->count();
            foreach ($content as &$v) {
                $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
                $v['type'] = $this->getType($v['type_id']);

                $v['check_isSign'] = D('meet_attend')->where(array('uid' => is_login(), 'meet_id' => $v['id']))->select();


            }
            unset($v);
            $this->assign('type_id', $type_id);
            $this->assign('contents', $content);
            $this->assign('lora', $lora);
            $this->assign('totalPageCount', $totalCount);
            $this->getRecommend();
            $this->setTitle('我的会议——会议');
            $this->assign('current', 'mymeet');
            $this->display();
        }*/

    /*  private function getType($type_id)
      {
          $type = D('MeetType')->where('id=' . $type_id)->find();
          return $type;
      }*/

    /**
     * 发布会议
     * @param int $id
     * @param int $cover_id
     * @param string $title
     * @param string $explain
     * @param string $sTime
     * @param string $eTime
     * @param string $address
     * @param int $limitCount
     * @param string $deadline
     * autor:xjw129xjt
     */
    /* public function doPost($id = 0, $cover_id = 0, $title = '', $explain = '', $sTime = '', $eTime = '', $address = '', $limitCount = 0, $deadline = '', $type_id = 0)
     {
         if (!is_login()) {
             $this->error('请登陆后再投稿。');
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
     }*/

    public function detail($id)
    {
        $edit = D('Meet')->where(array('id' => $id))->find();
        $people_str = $edit['people'];
        $people_arr = explode(',', $people_str);
        $temp_arr = array();
        foreach ($people_arr as $k => $v) {
            $name = D('Field')->where(array('uid' => $v, 'field_id' => 38))->find();
            $temp_arr[$k] = $name['field_data'];
        }
        $markset = D('Meet_markset')->where(array('meet_id' => $id))->select();
        $this->assign('markset', $markset);
        $this->assign('people', $temp_arr);
        $this->assign('edit', $edit);
        $this->display();
    }

    /*   public function member($id = 0, $tip = 'all')
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
       }*/

    /**
     * 编辑会议
     * @param $id
     * autor:xjw129xjt
     */
    public function edit($id)
    {
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
        //结束
        //查找mark_time
        $markset = D('Meet_markset')->where(array('meet_id' => $id))->select();
        $edit = D('Meet')->where(array('id' => $id))->find();
        //查找参会名称
        $temp_arr = $this->uid_to_get_detail($edit['people']);
        $this->assign('people', $temp_arr);
        $this->assign('markset', $markset);
        $this->assign('edit', $edit);
        $this->display();
    }

    //添加会议
    public function inset($meet_type = '', $title = '', $sTime = '', $eTime = '', $address = '', $people = '', $explain = '')
    {

        if (trim(op_t($meet_type)) == '') {
            $this->error('请输入会议类型。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入会议名称。');
        }
        if (trim(op_t($sTime)) == '') {
            $this->error('请输入开始时间。');
        }
        if (trim(op_t($eTime)) == '') {
            $this->error('请输入结束时间。');
        }

        if ($sTime > $eTime) {
            $this->error('会议开始时间不能大于会议结束时间');
        }
        if (trim(op_h($address)) == '') {
            $this->error('请输入会议地点。');
        }

        if (trim(op_h($people)) == '') {
            $this->error('请输入参加会议人员。');
        }
        if (trim($explain) == '') {
            $this->error('请输入会议内容。');
        }
        //判断签到时间  第二次总比第一次大，最后一次消息会议结束时间
        $mark_time = $_POST['mark_time'];
        $count = count($mark_time) + 1;
        if ($mark_time[1] == 0) $this->error('会议签到次数至少设定一次！');
        if ((strtotime($mark_time[1])+60*60) <strtotime($sTime)) $this->error('第一次签到时间不能提前会议开始1小时');
        for ($i = 1; $i < $count; $i++) {
            if (strtotime($mark_time[$i + 1]) < strtotime($mark_time[$i]) && $i + 1 < $count) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间');
            }
        }
        $data['uid'] = 1;
        $data['meet_type'] = $_POST['meet_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['address'] = $_POST['address'];
        $data['create_time'] = time();
        $result = D('Meet')->add($data);
        if ($result == null) {
            $this->error("添加失败", U('Meet/Index/add'));
        } else {
            //保存设置签到数据;
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'meet_id' => $result,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                D('Meet_markset')->add($mark_set_arr[$i]);
            }
            //保存签到名单人员
            $temp_arr = $this->uid_to_get_detail($data['people']);
            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['meet_id'] = $result;
                $temp_arr[$k]['status'] = 0;
                $temp_arr[$k]['mark_sort'] = 1;
                D('Meet_marknum')->add($temp_arr[$k]);
            }
            $this->success("添加成功", U('Meet/Index/index'));
        }


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

    //修改会议
    public function save()
    {
        $id = I('get.id');
        if (trim($_POST['meet_type']) == '') {
            $this->error('请输入会议类型。');
        }
        if (trim($_POST['title']) == '') {
            $this->error('请输入会议名称。');
        }
        if (trim($_POST['sTime']) == '') {
            $this->error('请输入开始时间。');
        }
        if (trim($_POST['eTime']) == '') {
            $this->error('请输入结束时间。');
        }

        if ($_POST['sTime'] > $_POST['eTime']) {
            $this->error('会议开始时间不能大于会议结束时间');
        }
        if (trim($_POST['address']) == '') {
            $this->error('请输入会议地点。');
        }

        if (trim($_POST['people']) == '') {
            $this->error('请输入参加会议人员。');
        }
        if (trim($_POST['explain']) == '') {
            $this->error('请输入会议内容。');
        }
        //判断签到时间  第二次总比第一次大，最后一次消息会议结束时间
        $mark_time = $_POST['mark_time'];
        $count = count($mark_time) + 1;
        if ($mark_time[1] == 0) $this->error('会议签到次数至少设定一次！');
        for ($i = 1; $i < $count; $i++) {
            if (strtotime($mark_time[$i + 1]) < strtotime($mark_time[$i]) && $i + 1 < $count) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间');
            }
        }
        $data['uid'] = 1;
        $data['meet_type'] = $_POST['meet_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['address'] = $_POST['address'];
        $data['create_time'] = time();
        $result = D('Meet')->where(array('id' => $id))->save($data);
        if ($result == null) {
            $this->error("修改失败", U('Meet/Index/add'));
        } else {
            //保存设置签到数据;
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'meet_id' => $id,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                if ($_POST['id'][$i]) {
                    D('Meet_markset')->where(array('id' => $_POST['id'][$i]))->save($mark_set_arr[$i]);
                } else {
                    D('Meet_markset')->where(array('meet_id' => $id))->add($mark_set_arr[$i]);
                }
            }
            //保存签到名单人员
            $temp_arr = $this->uid_to_get_detail($data['people']);
            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['meet_id'] = $id;
                $temp_arr[$k]['status'] = 0;
                $temp_arr[$k]['mark_sort'] = 1;
                $user = D('Meet_marknum')->where(array('uid' => $temp_arr[$k]['uid']))->find();
                if (!$user) D('Meet_marknum')->add($temp_arr[$k]);
            }
            $this->success("修改成功", U('Meet/Index/index'));
        }
    }


    public function add()
    {
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

        $meet_type = D('Meet_type')->where('status=1')->select();
        $this->assign('meet_type', $meet_type);
        $this->display();
    }


//删除会议
    public function doDel($id)
    {
        $app = D("Meet")->where("id={$id}")->delete();
        if ($app > 0) {
            $this->success("删除成功");
        } else {
            $this->error("删除失败", "{:U('Meet/Index/index')}");
        }

    }


//参会详情
    public function jion($id)
    {
        $attend = D('Meet_attend')->where(array('meet_id' => $id))->select();
        foreach ($attend as $key => $val) {
            //$val['uid'];
            $truename = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
            $attend[$key]['truename'] = $truename['field_data'];
            $company = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 50))->find();
            $attend[$key]['company'] = $company['field_data'];
            // $marknum=D('Meet_marknum')->where(array('uid'=>$val['uid']))->select();
            // $attend[$key]['marknum']=count($marknum);
            // $attend[$key]['marktime']=array();
            // foreach($marknum as $kk=>$vv){
            //array_push($attend[$key]['marktime'],$vv['mark_time']);
            //}
        }
        print_r($attend);
        $this->assign('data', $attend);
        $this->display();
    }

    //签到详情
    public function mark($id)
    {
        //默认第一次    状态status 0未签到 1签到 2迟到 3已请假 4已补签
        if (IS_POST) {
            $data['truename'] = array('like', '%' . I('post.truename') . '%');
            $data['status'] = intval(I('post.status'));
            $data['mark_sort'] = intval(I('post.mark_sort'));
            $map['meet_id'] = $id;
            //按照状态查询
            if (empty(I('post.truename')) && $data['status'] !== 5 && $data['mark_sort'] == 0) {
                $map['status'] = $data['status'];
                //按照次数查询
            } elseif (empty(I('post.truename')) && $data['status'] == 5 && $data['mark_sort'] !== 0) {
                $map['mark_sort'] = $data['mark_sort'];
                //按照名称查询
            } elseif (I('post.truename') && $data['status'] == 5 && $data['mark_sort'] == 0) {
                $map['truename'] = $data['truename'];
                //按照名称和状态查询
            } elseif (I('post.truename') && $data['status'] !== 5 && $data['mark_sort'] == 0) {
                $map['truename'] = $data['truename'];
                $map['status'] = $data['status'];
                //按照名称和次数
            } elseif (I('post.truename') && $data['status'] == 5 && $data['mark_sort'] !== 0) {
                $map['truename'] = $data['truename'];
                $map['mark_sort'] = $data['mark_sort'];
                //按照状态和次数
            } elseif (empty(I('post.truename')) && $data['status'] !== 5 && $data['mark_sort'] !== 0) {
                $map['status'] = $data['status'];
                $map['mark_sort'] = $data['mark_sort'];
            } elseif (I('post.truename') && $data['status'] !== 5 && $data['mark_sort'] !== 0) {
                //按照名称和状态和次数
                $map['truename'] = $data['truename'];
                $map['status'] = $data['status'];
                $map['mark_sort'] = $data['mark_sort'];
            }
            //查询全部数据
            $attend = D('Meet_marknum')->where($map)->select();
        } else {
            //默认第一次签到
            $attend = D('Meet_marknum')->where(array('meet_id' => $id, 'mark_sort' => 1))->select();
        }
        $markset = D('MeetMarkset')->where(array('meet_id' => $id))->select();


        $where['status']=array('in','1,2,4');
        $where['meet_id']=$id;
        if(empty($where['mark_sort']) && IS_POST){
            $total_count =D('MeetMarknum')->where(array('meet_id'=>$id))->count();
            $checkin_count = D('MeetMarknum')->where($where)->count();
        }else{
            $where['mark_sort']=$data['mark_sort']?$data['mark_sort']:1;
            $total_count =count($attend);
            $checkin_count = D('MeetMarknum')->where($where)->count();
        }
        $this->assign('checkin_count',$checkin_count);
        $this->assign('total_count',$total_count);
        $this->assign('markset', $markset);
        $this->assign('meet_id', $id);
        $this->assign('data', $attend);
        $this->display();
    }

    public function up_status()
    {
        $id = I('post.id');
        $status = I('post.status');
        if ($status == 'qxbq') {
            $data['status'] = 0;
            $msg = "取消补签";
        } else if ($status == 'bq') {
            $data['status'] = 4;
            $msg = "补签";
        } else if ($status == 'qj') {
            $data['status'] = 3;
            $msg = "请假";
        } else {
            $data['status'] = 0;
            $msg = "取消请假";
        }
        $res = D('Meet_marknum')->where(array('id' => $id))->save($data);
        if ($res) {
            $exit = json_encode(array('code' => 1, 'msg' => $msg . '成功!'));
        } else {
            $exit = json_encode(array('code' => 0, 'msg' => $msg . '失败!'));
        }
        echo $exit;

    }

    //发送模板消息
    public function sendtemplateMsg()
    {
        $id=I('post.id');
        $tempid='XGCR0O9UVy1WNZ0TjLvO78gZg9FK9Z-0JnesVNlDp1I';
        $data = D('Meet')->where(array('id' =>$id ))->find();
        $arr = array(
            'href' => 'http://zxlz.daifayuan.com' . U('Home/Weixin/jion/type/meet', array('id' => $id)),
            'first' => '关于' . $data['title'] . '通知',
            'keyword1' => date('Y-m-d H:i:s', $data['sTime']),
            'keyword2' => $data['title'],
            'keyword3' => $data['address'],
            'remark' => '点击详情即可进入在线报名'
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
        // echo $res;
    }
    //会议请假列表页面
    public function leave(){
        //审核活动或者会议类型
        $meet_type=auth_apply('meet',get_uid());
        $mapp['meet_type']=array('in',$meet_type['type']);
        $meetdb=D('Meet')->where($mapp)->getField('id',true);

        $map['status']=2;
     //   $map['meet_id']=array('in',$meetdb);
        //是否需要查看管理成员
        if($meet_type['findmembers']){
            $members=return_director_members(get_uid());
            //成员不为空或者false
            if($members){
                $map['uid']=array('in',$members);
            }
        }
        $attend = D('Meet_attend')->where($map)->select();

        foreach ($attend as $key => $val) {
            //$val['uid'];
            $truename = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
            $attend[$key]['truename'] = $truename['field_data'];
            $company = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 50))->find();
            $attend[$key]['company'] = $company['field_data'];
            $meet=D('Meet')->where(array('id'=>$val['meet_id']))->find();
            $attend[$key]['meet_name']=$meet['title'];
            $attend[$key]['meet_type']=$meet['meet_type'];
            //单独判断会议为全会
            if($meet['meet_type']=='全会'){
                if(!in_array($val['uid'],$meet_type['ArrUid'])){
                    unset ($attend[$key]);
                }
            };

        }
        $this->assign('data', $attend);
        $this->display();
    }
    public function save_leave(){
        $data=I('post.');
        $id = I('post.id');
        $data['status'] = I('post.status');
        $data['back'] = I('post.back');
        $id = D('Meet_attend')->where(array('id' => $id))->save($data);
        $exit = return_exit_arr($id, '成功！', '提交失败');
        echo $exit;
    }



}