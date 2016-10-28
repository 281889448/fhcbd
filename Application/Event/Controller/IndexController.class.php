<?php


namespace Event\Controller;
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
    {   parent::_initialize();
        $tree = D('EventType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);


        $this->assign('current', 'event');
    }

    /**
     * 活动首页
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
            $event = D("event")->where($map)->order('id desc')->select();
            $this->assign("lockback", 1);
        } else {
            $event = D("event")->order('id desc')->select();
        }
        $this->assign("event", $event);
        $this->display();

    }


    public function detail($id)
    {
        $edit = D('Event')->where(array('id' => $id))->find();
        $people_str = $edit['people'];
        $people_arr = explode(',', $people_str);
        $temp_arr = array();
        foreach ($people_arr as $k => $v) {
            $name = D('Field')->where(array('uid' => $v, 'field_id' => 38))->find();
            $temp_arr[$k] = $name['field_data'];
        }
        $markset = D('Event_markset')->where(array('event_id' => $id))->select();
        $this->assign('markset', $markset);
        $this->assign('people', $temp_arr);
        $this->assign('edit', $edit);
        $this->display();
    }

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
        $markset = D('Event_markset')->where(array('event_id' => $id))->select();
        $edit = D('Event')->where(array('id' => $id))->find();
        $event_type = D('Event_type')->where(array('status' => 1))->select();
        //查找参会名称
        $temp_arr = $this->uid_to_get_detail($edit['people']);
        $this->assign('event_type', $event_type);
        $this->assign('people', $temp_arr);
        $this->assign('markset', $markset);
        $this->assign('edit', $edit);
        $this->display();
    }

    //添加活动
    public function inset($event_type = '', $title = '', $sTime = '', $eTime = '', $address = '', $people = '', $explain = '')
    {

        if (trim(op_t($event_type)) == '') {
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
        if (strtotime($mark_time[count($mark_time)]) >strtotime($eTime)) $this->error('最后一次签到时间不能大于会议结束时间');
        for ($i = 1; $i < $count; $i++) {
            if (strtotime($mark_time[$i + 1]) < strtotime($mark_time[$i]) && $i + 1 < $count) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间');
            }
        }
        $data['uid'] = 1;
        $data['event_type'] = $_POST['event_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['address'] = $_POST['address'];
        $data['create_time'] = time();
        $result = D('Event')->add($data);
        if ($result == null) {
            $this->error("添加失败", U('Event/Index/add'));
        } else {
            //保存设置签到数据;
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'event_id' => $result,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                D('Event_markset')->add($mark_set_arr[$i]);
            }
            //保存签到名单人员
            $temp_arr = $this->uid_to_get_detail($data['people']);
            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['event_id'] = $result;
                $temp_arr[$k]['status'] = 0;
                $temp_arr[$k]['mark_sort'] = 1;
                //添加签到详情
                D('Event_marknum')->add($temp_arr[$k]);
                //添加参会详情
                D('Event_attend')->add($temp_arr[$k]);
            }
            $this->success("添加成功", U('Event/Index/index'));
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

    //修改活动
    public function save()
    {
        $id = I('get.id');
        if (trim($_POST['event_type']) == '') {
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
        if ((strtotime($mark_time[1])+60*60) <strtotime($_POST['sTime'])) $this->error('第一次签到时间不能提前会议开始1小时');
        if (strtotime($mark_time[count($mark_time)]) >strtotime($_POST['eTime'])) $this->error('最后一次签到时间不能大于会议结束时间');
        for ($i = 1; $i < $count; $i++) {
            if (strtotime($mark_time[$i + 1]) < strtotime($mark_time[$i]) && $i + 1 < $count) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间');
            }
        }
        $data['uid'] = 1;
        $data['event_type'] = $_POST['event_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['address'] = $_POST['address'];
        $data['create_time'] = time();
        $result = D('Event')->where(array('id' => $id))->save($data);
        if ($result == null) {
            $this->error("修改失败", U('Event/Index/add'));
        } else {
            //保存设置签到数据;
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'event_id' => $id,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                if ($_POST['id'][$i]) {
                    D('Event_markset')->where(array('id' => $_POST['id'][$i]))->save($mark_set_arr[$i]);
                } else {
                    D('Event_markset')->where(array('event_id' => $id))->add($mark_set_arr[$i]);
                }
            }
            //保存签到名单人员
            $temp_arr = $this->uid_to_get_detail($data['people']);
            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['event_id'] = $id;
                $temp_arr[$k]['status'] = 0;
                $temp_arr[$k]['mark_sort'] = 1;
                $user = D('Event_marknum')->where(array('uid' => $temp_arr[$k]['uid']))->find();
                if (!$user) D('Event_marknum')->add($temp_arr[$k]);
            }
            $this->success("修改成功", U('Event/Index/index'));
        }
    }

    /*    public function bianji($id){

            $edit = D('Event')->where(array('status' => 1, 'id' => $id))->find();
            $this->assign('edit', $edit);
            $this->display();
        }*/

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

        $event_type = D('Event_type')->where('status=1')->select();
        $this->assign('event_type', $event_type);
        $this->display();
    }

    /*    //搜索页面
       public function search(){
            $keyword = $_POST["keyword"];
           var_dump($keyword);
           exit;
            $model=D('Event');
            $set=$model->where("'id','type','title','time','content','address' like '%{$keyword}%'")->select();
            $this->assign('keyword',$keyword);
            $this->assign('set',$set);
            $this->display();

        }*/
    /*    public function doSign($event_id, $name, $phone)
        {
            if (!is_login()) {
                $this->error('请登陆后再报名。');
            }
            if (!$event_id) {
                $this->error('参数错误');
            }
            if (trim(op_t($name)) == '') {
                $this->error('请输入姓名。');
            }
            if (trim($phone) == '') {
                $this->error('请输入手机号码。');
            }
            $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->select();
            $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
            if (!$event_content) {
                $this->error('活动不存在！');
            }
            /*      if ($event_content['attentionCount'] + 1 > $event_content['limitCount']) {
                      $this->error('超过限制人数，报名失败');
                  }*/
    /*        if (time() > $event_content['deadline']) {
                $this->error('报名已经截止');
            }
            if (!$check) {
                $data['uid'] = is_login();
                $data['event_id'] = $event_id;
                $data['name'] = $name;
                $data['phone'] = $phone;
                $data['creat_time'] = time();
                $res = D('event_attend')->add($data);
                if ($res) {

                    D('Message')->sendMessageWithoutCheckSelf($event_content['uid'], query_user('nickname', is_login()) . '报名参加了活动]' . $event_content['title'] . ']，请速去审核！', '报名通知', U('Event/Index/member', array('id' => $event_id)), is_login());

                    D('Event')->where(array('id' => $event_id))->setInc('signCount');
                    $this->success('报名成功。', 'refresh');
                } else {
                    $this->error('报名失败。', '');
                }
            } else {
                $this->error('您已经报过名了。', '');
            }
        }*/

    /**
     * 审核
     * @param $uid
     * @param $event_id
     * @param $tip
     * autor:xjw129xjt
     */
    /*    public function shenhe($uid, $event_id, $tip)
        {
            $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
            if (!$event_content) {
                $this->error('活动不存在！');
            }
            if ($event_content['uid'] == is_login()) {
                $res = D('event_attend')->where(array('uid' => $uid, 'event_id' => $event_id))->setField('status', $tip);
                if ($tip) {
                    D('Event')->where(array('id' => $event_id))->setInc('attentionCount');
                    D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '已经通过了您对活动' . $event_content['title'] . '的报名请求', '审核通知', U('Event/Index/detail', array('id' => $event_id)), is_login());
                } else {
                    D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
                    D('Message')->sendMessageWithoutCheckSelf($uid, query_user('nickname', is_login()) . '取消了您对活动[' . $event_content['title'] . ']的报名请求', '取消审核通知', U('Event/Index/member', array('id' => $event_id)), is_login());
                }
                if ($res) {
                    $this->success('操作成功');
                } else {
                    $this->error('操作失败！');
                }
            } else {
                $this->error('操作失败，非活动发起者操作！');
            }
        }*/

    /**
     * 取消报名
     * @param $event_id
     * autor:xjw129xjt
     */
    /*   public function unSign($event_id)
       {

           $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
           if (!$event_content) {
               $this->error('活动不存在！');
           }

           $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->find();

           $res = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->delete();
           if ($res) {
               if ($check['status']) {
                   D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
               }
               D('Event')->where(array('id' => $event_id))->setDec('signCount');

               D('Message')->sendMessageWithoutCheckSelf($event_content['uid'], query_user('nickname', is_login()) . '取消了对活动[' . $event_content['title'] . ']的报名', '取消报名通知', U('Event/Index/detail', array('id' => $event_id)), is_login());

               $this->success('取消报名成功');
           } else {
               $this->error('操作失败');
           }
       }*/

    /*    public function ajax_sign($event_id)
        {

            $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
            if (!$event_content) {
                $this->error('活动不存在！');
            }

            D('Event')->where(array('id' => $event_id))->setInc('view_count');
            $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);
            $event_content['type'] = $this->getType($event_content['type_id']);

            $menber = D('event_attend')->where(array('event_id' => $event_id, 'status' => 1))->select();
            foreach ($menber as $k => $v) {
                $event_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

            }

            $this->assign('content', $event_content);
            $this->display();
        }*/

    /**
     * ajax删除活动
     * @param $event_id
     * autor:xjw129xjt
     */
    /*   public function doDelEvent($id)
       {

           $event_content = D('Event')->where(array('status' => 1, 'id' => $id))->find();
           if (!$event_content) {
               $this->error('活动不存在！');
           }
           if ($event_content['id'] == is_login() || is_administrator(is_login())) {
               $res = D('Event')->where(array('status' => 1, 'id' => $id))->setField('status', 0);
               if ($res) {
                   $this->success('删除成功！', U('Event/Index/index'));
               } else {
                   $this->error('操作失败！');
               }
           } else {
               $this->error('非活动发起者操作！');
           }

       }*/

    /**
     * ajax提前结束活动
     * @param $event_id
     * autor:xjw129xjt
     */
    /*  public function doEndEvent($event_id)
      {

          $event_content = D('Event')->where(array('status' => 1, 'id' => $event_id))->find();
          if (!$event_content) {
              $this->error('活动不存在！');
          }
          if ($event_content['uid'] == is_login() || is_administrator(is_login())) {
              $res = D('Event')->where(array('status' => 1, 'id' => $event_id))->setField('eTime', time());
              if ($res) {
                  $this->success('操作成功！');
              } else {
                  $this->error('操作失败！');
              }
          } else {
              $this->error('非活动发起者操作！');
          }

      }*/
//删除活动
    public function doDel($id)
    {
        $app = D("Event")->where("id={$id}")->delete();
        if ($app > 0) {
            $this->success("删除成功");
        } else {
            $this->error("删除失败", "{:U('Event/Index/index')}");
        }

    }


//参会详情
    public function jion($id)
    {
        if (IS_POST) {
            $data['truename'] = array('like', '%' . I('post.truename') . '%');
            $data['status'] = intval(I('post.status'));
            $map['event_id'] = $id;
            //按照状态查询
            if (empty(I('post.truename')) && $data['status'] !== 5) {
                $map['status'] = $data['status'];
                //按照名称和状态
            } elseif ((!empty(I('post.truename'))) && $data['status'] != 5) {
                $map['truename'] = $data['truename'];
                $map['status'] = $data['status'];
                //按照名称查询
            } elseif (I('post.truename') && $data['status'] == 5) {
                $map['truename'] = $data['truename'];
            }
            //查询全部数据
            $attend = D('Event_marknum')->where($map)->select();
            $number_attend=count($attend);
            switch ($data['status']){
                case 0:
                    $search_text='未选择';
                    $search_status=0;
                    break;
                case 1:
                    $search_text='参加';
                    $search_status=1;
                    break;
                case 2:
                    $search_text='请假中';
                    $search_status=2;
                    break;
                case 3:
                    $search_text='请假被拒绝';
                    $search_status=3;
                    break;
                case 4:
                    $search_text='请假被批准';
                    $search_status=4;
                    break;
                default:
                    $search_text='共';
                    break;
            }
            $search_total_num=$search_text."：".$number_attend."人";
            $this->assign('search_name',I('post.truename'));
            $this->assign('search_total_num',$search_total_num);
            $this->assign('search_status',$search_status);
        }else{
            $attend = D('Event_attend')->where(array('event_id' => $id))->select();
            foreach ($attend as $key => $val) {
                $truename = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
                $attend[$key]['truename'] = $truename['field_data'];
                $company = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 50))->find();
                $attend[$key]['company'] = $company['field_data'];
            }
        }
        $total_count=count(D('Event_attend')->where(array('event_id' => $id))->select());
        $this->assign('total_count',$total_count);
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
            $map['event_id'] = $id;
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
            $attend = D('Event_marknum')->where($map)->select();
            $number_attend=count($attend);
            switch ($data['status']){
                case 0:
                    $search_text='未签';
                    $search_status=0;
                    break;
                case 1:
                    $search_text='已签';
                    $search_status=1;
                    break;
                case 2:
                    $search_text='迟到';
                    $search_status=2;
                    break;
                case 3:
                    $search_text='已请假';
                    $search_status=3;
                    break;
                case 4:
                    $search_text='已补签';
                    $search_status=4;
                    break;
                default:
                    $search_text='共';
                    break;
            }
            $search_total_num=$search_text."：".$number_attend."人";
            $this->assign('search_name',I('post.truename'));
            $this->assign('search_total_num',$search_total_num);
            $this->assign('search_status',$search_status);
        } else {
            //默认第一次签到
            $attend = D('Event_marknum')->where(array('event_id' => $id, 'mark_sort' => 1))->select();
        }
        $markset = D('EventMarkset')->where(array('event_id' => $id))->select();


        $where['status']=array('in','1,2,4');
        $where['event_id']=$id;
        if(empty($where['mark_sort']) && IS_POST){
            $total_count =D('EventMarknum')->where(array('event_id'=>$id))->count();
        }else{
            $where['mark_sort']=$data['mark_sort']?$data['mark_sort']:1;
            $total_count =count($attend);
        }
        $this->assign('total_count',$total_count);
        $this->assign('markset', $markset);
        $this->assign('event_id', $id);
        $this->assign('data', $attend);
        $this->display();
    }

/*//活动请假页面退回请假申请
public function back($id){
    $data['id']=I('post.id');
    $data['back']=I('post.back');
    $data=I('post.');
    $id=D('Event_attend')->where(array('id'=>$id))->save($data);
    $back = $this->return_exit_arr($id, '成功！', '提交失败');
    echo $back;

}*/
    

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
        $res = D('Event_marknum')->where(array('id' => $id))->save($data);
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
        $tempid="Peo-p-dtXVASb0zppGuqIM-YePwz2zUmK6egJLLP43U";
        $data = D('Event')->where(array('id' =>$id ))->find();
        $arr = array(
            'href' => 'http://zxlz.daifayuan.com' . U('Wap/Weixin/jion/type/event', array('id' => $id)),
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
            $res = $wxapi->sendTempMsg_Event_Event($val['openid'], $arr,$tempid);
            if ($res['rt']) $time++;
        }
        echo json_encode(array('time' => $time));
        // echo $res;
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
    //活动请假页面
    public function leave(){
        //审核活动或者会议类型
        $event_type=auth_apply('event',get_uid());
        $mapp['event_type']=array('in',$event_type['type']);
        $eventdb=D('Event')->where($mapp)->getField('id',true);
        $map['status']=2;
        $map['event_id']=array('in',$eventdb);
        //是否需要查看管理成员
        if($event_type['findmembers']){
            $members=return_director_members(get_uid());
            //成员不为空或者false
            if($members){
                $map['uid']=array('in',$members);
            }
        }
        $attend = D('Event_attend')->where($map)->select();
        foreach ($attend as $key => $val) {
            //$val['uid'];
            $truename = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
            $attend[$key]['truename'] = $truename['field_data'];
            $company = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 50))->find();
            $attend[$key]['company'] = $company['field_data'];
            $event=D('Event')->where(array('id'=>$val['event_id']))->find();
            $attend[$key]['event_name']=$event['title'];
            $attend[$key]['event_type']=$event['event_type'];
            //如果登陆者为主席，会议类型全会，只留下uid为常委
            //如果登陆者为秘书长或者委主任，只留下uid为委员
        }
        $this->assign('data', $attend);
        $this->display();
    }
    public function save_leave(){
        $data=I('post.');
        $id = I('post.id');
        $data['status'] = I('post.status');
        $data['back'] = I('post.back');
        $id = D('Event_attend')->where(array('id' => $id))->save($data);
        if($id && $data['status']==4){
            //如果是批准请假，签到中标明请假，状态为6
            $user=D('Event_attend')->where(array('id' => I('post.id')))->find();
            $map['uid']=$user['uid'];
            $map['event_id']=$user['event_id'];
            D('Event_marknum')->where($map)->save(array('status'=>6));
        }
        $exit = return_exit_arr($id, '成功！', '提交失败');
        echo $exit;
    }
}