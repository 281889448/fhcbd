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
        $uid=get_uid();
        $auth_group=array('秘书长','主席','政协工作人员');
        if(!get_permission($uid,$auth_group)){
            $map['uid']=$uid;
        }
        if (IS_POST) {
            $map['title'] = array('like', '%' . $_POST['keyword'] . '%');
            $event = D("event")->where($map)->order('id desc')->select();
            $this->assign("lockback", 1);
        } else {
            $event = D("event")->where($map)->order('id desc')->select();
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
        //查找参会名称
        $temp_arr =uid_to_get_detail($edit['people']);
        $this->assign('event_type', get_event_type());
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
            $a=strtotime($mark_time[$i + 1]);
            $b=strtotime($mark_time[$i]);
            if (($a < $b &&($i+1)<$count) ||(($i+1)<$count && 7200>($a-$b))) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间至少2小时');
            }
        }
        $data['uid'] = get_uid();
        $data['event_type'] = $_POST['event_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['address'] = $_POST['address'];
        $data['people_view'] = I('post.people_view');
        $data['create_time'] = time();
        $result = D('Event')->add($data);
        if ($result == null) {
            $this->error("添加失败", U('Event/Index/add'));
        } else {
            $temp_arr =uid_to_get_detail($data['people']);//签到名单人员
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'event_id' => $result,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                D('Event_markset')->add($mark_set_arr[$i]);//保存签到设置

                foreach ($temp_arr as $k => $v) {
                    $temp_arr[$k]['event_id'] = $result;
                    $temp_arr[$k]['status'] = 0;
                    $temp_arr[$k]['mark_sort'] = $i;
                    //添加签到详情
                    D('Event_marknum')->add($temp_arr[$k]);//保存所有签到数据
                }
            }
            //保存参会人员名单,保存参会率名单
            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['event_id'] = $result;
                $temp_arr[$k]['status'] = 0;
                D('Event_attend')->add($temp_arr[$k]);//保存参会人员
                $temp_arr[$k]['record_id'] = $result;//参会率
                $temp_arr[$k]['type'] = 'event';//参会率
                $temp_arr[$k]['create_time'] = time();//参会率
                $temp_arr[$k]['y_mark'] = $count-1;//参会率
                D('Attendance')->add($temp_arr[$k]);//保存参会率

            }
            $this->success("添加成功", U('Event/Index/index'));
        }


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
            $a=strtotime($mark_time[$i + 1]);
            $b=strtotime($mark_time[$i]);
            if (($a < $b &&($i+1)<$count) ||(($i+1)<$count && 7200>($a-$b))) {
                $this->error('第' . ($i + 1) . '次签到的时间要大于第' . $i . '次签到的时间至少2小时');
            }
        }
        $data['uid'] = get_uid();
        $data['event_type'] = $_POST['event_type'];
        $data['sTime'] = strtotime($_POST['sTime']);
        $data['eTime'] = strtotime($_POST['eTime']);
        $data['title'] = $_POST['title'];
        $data['explain'] = $_POST['explain'];
        $data['people'] = $_POST['people'];
        $data['people_view'] =  I('post.people_view');
        $data['address'] = $_POST['address'];
        $data['create_time'] = time();

        $result = D('Event')->where(array('id' => $id))->save($data);

        if ($result == null) {
            $this->error("修改失败", U('Event/Index/add'));
        } else {
            $temp_arr =uid_to_get_detail($data['people']);//签到名单人员

            //删除减少人员
            $people_arr = explode(',', $data['people']);
            $old_user=D('Event_attend')->where(array('event_id' => $id))->select();
            foreach ($old_user as $k=>$v){
                if(!in_array($v['uid'],$people_arr)){
                    D('Event_marknum')->where(array('event_id' => $id,'uid'=>$v['uid']))->delete();
                    D('Event_attend')->where(array('event_id' => $id,'uid'=>$v['uid']))->delete();
                    D('Attendance')->where(array('record_id' => $id,'uid'=>$v['uid'],'type'=>'event'))->delete();
                }
            }
            //更新改变内容
            for ($i = 1; $i < $count; $i++) {
                $mark_set_arr[$i] = array(
                    'event_id' => $id,
                    'mark_sort' => $i,
                    'mark_time' => strtotime($mark_time[$i])
                );
                if ($_POST['id'][$i]) {
                    D('Event_markset')->where(array('id' => $_POST['id'][$i]))->save($mark_set_arr[$i]);
                } else {
                    D('Event_markset')->where(array('event_id' => $id))->add($mark_set_arr[$i]);//添加或保存签到设置
                }

                foreach ($temp_arr as $k => $v) {
                    $temp_arr[$k]['event_id'] = $id;
                    $temp_arr[$k]['status'] = 0;
                    $temp_arr[$k]['mark_sort'] = $i;
                    $map['event_id']=$id;
                    $map['uid']=$temp_arr[$k]['uid'];
                    $map['mark_sort']=$i;
                    $temp_arr[$k]['uid'] = $v['uid'];
                    $markuser=D('Event_marknum')->where($map)->find();
                    if(!$markuser)D('Event_marknum')->add($temp_arr[$k]);//保存所有签到数据
                }

            }

            //保存参会人员名单,保存参会率名单

            foreach ($temp_arr as $k => $v) {
                $temp_arr[$k]['event_id'] = $id;
                $temp_arr[$k]['status'] = 0;
                $temp_arr[$k]['record_id'] = $id;//参会率
                $temp_arr[$k]['type'] = 'event';//参会率
                $temp_arr[$k]['creat_time'] = time();//参会率
                $temp_arr[$k]['y_mark'] = $count-1;//参会率
                unset($temp_arr[$k]['id']);
                //查找条件
                $map['event_id']=$id;
                $map['uid']=$temp_arr[$k]['uid'];
                $user = D('EventAttend')->where($map)->find();
                if (!$user) D('Event_attend')->add($temp_arr[$k]);
                $attend_map['uid']=$temp_arr[$k]['uid'];
                $attend_map['record_id']=$id;
                $attend_map['type']='event';
                $attend_user=D('Attendance')->where($attend_map)->find();
                //更新应签总数
                if($attend_user['y_mark']!=($count-1)){
                    D('Attendance')->where(array('id'=>$attend_user['id']))->save($temp_arr[$k]);

                }
                if(!$attend_user)D('Attendance')->add($temp_arr[$k]);//保存所有签到数据
            }

            $this->success("修改成功", U('Event/Index/index'));
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
        $this->assign('event_type', get_event_type());
        $this->display();
    }

//删除活动
    public function doDel($id)
    {
        //如果有人签到，则不允许删除
        $map['event_id']=$id;
        $map['status']=array('neq','0');
        $is_jion=D("Event_attend")->where($map)->find();
        if(!empty($is_jion)){
            $this->error("该会议已有人进行参会操作，不能删除！", U('Event/Index/index'));
        }
        $app = D("Event")->where("id={$id}")->delete();
        if ($app > 0) {
            //删除attend表，删除marknum表，删除markset表删除，删除attendence请假率表
            $temp_map['event_id']=$id;
            D("Event_attend")->where($temp_map)->delete();
            D("Event_marknum")->where($temp_map)->delete();
            D("Event_markset")->where($temp_map)->delete();
            $attendance_map['type']='event';
            $attendance_map['record_id']=$id;
            D("Attendance")->where($attendance_map)->delete();
            $this->success("删除成功");
        } else {
            $this->error("删除失败", U('Event/Index/index'));
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
                $map['name'] = $data['truename'];
                $map['status'] = $data['status'];
                //按照名称查询
            } elseif (I('post.truename') && $data['status'] == 5) {
                $map['name'] = $data['truename'];
            }
            //查询全部数据
            $attend = D('Event_attend')->where($map)->select();
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
        }
        foreach ($attend as $key => $val) {
            $truename = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 38))->find();
            $attend[$key]['truename'] = $truename['field_data'];
            $company = D('Field')->where(array('uid' => $val['uid'], 'field_id' => 50))->find();
            $attend[$key]['company'] = $company['field_data'];
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
            $this->assign('search_mark_sort',intval(I('post.mark_sort')));
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
            $data=D('Event_marknum')->where(array('id' => $id))->find();
            if($data['status']>0){
                D('Attendance')->where(array('uid'=>$data['uid'],'record_id'=>$data['event_id'],'type'=>'event'))->setInc('s_mark',1);
            }else{
                D('Attendance')->where(array('uid'=>$data['uid'],'record_id'=>$data['event_id'],'type'=>'event'))->setDec('s_mark',1);
            }
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
            'href' => C('WX_CALLBACK_URL') . U('Wap/Weixin/jion/type/event', array('id' => $id)),
            'first' => '关于' . $data['title'] . '通知',
            'keyword1' => date('Y-m-d H:i:s', $data['sTime']),
            'keyword2' => $data['title'],
            'keyword3' => $data['address'],
            'remark' => '点击详情即可进入在线报名'
        );
        $last_uids=D('Event_attend')->where(array('event_id'=>$id,'status'=>0))->getField('uid',true);
        $map['id'] = array('in', $last_uids);
        $userdata = D('Ucenter_member')->where($map)->field('username,openid')->select();
        $wxapi = new WeixinApi();
        $time = 0;
        foreach ($userdata as $key => $val) {
            if($val['openid']) {
                $res = $wxapi->sendTempMsg_Event_Meet($val['openid'], $arr, $tempid);
            }
            self::$sms->send($val['username'],$data['explain']);
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
        if($event_type['findmembers']){
            $mapp['uid']=get_uid();//谁建的会议会谁审核

        }
        $eventdb=D('Event')->where($mapp)->getField('id',true);

        $map['status']=2;
        $map['event_id']=array('in',$eventdb);
        //是否需要查看管理成员
       /* if($event_type['findmembers']){
            $members=return_director_members(get_uid());
            //成员不为空或者false
            if($members){
                $map['uid']=array('in',$members);
            }
        }*/
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
        if($id){
            $user=D('Event_attend')->where(array('id' => I('post.id')))->find();
            $openid=D('Ucenter_member')->where(array('id'=>$user['uid']))->getField('openid'); //查找openid
            $eventdata=D('Event')->where(array('id'=>$user['event_id']))->find();
            if($data['status']==4){
                //如果是批准请假，签到中标明请假，状态为6
                $map['uid']=$user['uid'];
                $map['event_id']=$user['event_id'];
                D('Event_marknum')->where($map)->save(array('status'=>6));
                //被批准在更改签到数据
                $atten_map['uid']=$user['uid'];
                $atten_map['record_id']=$user['event_id'];
                $atten_map['type']='event';
                $atten_data=D('Attendance')->where($atten_map)->find();
                D('Attendance')->where(array('id'=>$atten_data['id']))->save(array('s_mark'=>$atten_data['y_mark']));
                //发送通知模板
                $tempid='C28HkUceHbqV-K1AizUCypfQYImEGgl5AP5Fvtp1eX8';
                $arr = array(
                    'href' => C('WX_CALLBACK_URL') . U('Wap/Weixin/jion/type/event', array('id' => $eventdata['id'])),
                    'first' => '您的' . $eventdata['title'] . '活动请假已被审核批准',
                    'keyword1' => date('Y-m-d H:i:s', $eventdata['sTime']),
                    'keyword2' => $eventdata['address'],
                    'keyword3' => $eventdata['title'],
                    'remark' => '点击查看详情'
                );
            }else{
                $tempid='5ktf-tXzSw76ciFPTMZ7ZXkdBGnn0ncKBbGA_6RgWEU';
                $arr = array(
                    'href' => C('WX_CALLBACK_URL') . U('Wap/Weixin/jion/type/event', array('id' => $eventdata['id'])),
                    'first' => '您的' . $eventdata['title'] . '活动请假已被拒绝',
                    'keyword1' => date('Y-m-d H:i:s', $eventdata['sTime']),
                    'keyword2' => $eventdata['address'],
                    'keyword3' => $eventdata['title'],
                    'keyword4' => $data['back'],
                    'remark' => '点击查看详情'
                );
            }
            $wxapi = new WeixinApi();
            $wxapi->sendTempMsg_Event_Meet($openid, $arr,$tempid);
        }
        $exit = return_exit_arr($id, '成功！', '提交失败');
        echo $exit;
    }
}