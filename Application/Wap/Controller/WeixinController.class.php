<?php
namespace Wap\Controller;
use Common\Controller\BaseController;
use Common\Api\WeixinApi;
define('UC_AUTH_KEY', '.,3lA:u;T0wBPi[}C5>F6g^xy_(2hz4IU]tfasd9'); //加密KEY
class WeixinController extends BaseController {
    public $openid;
    public $uid;
    function  _initialize()
    {
        parent::_initialize();
        $this->openid=session('openid');
        $this->uid=get_uid();
    }
    public function binding(){
        $id=D('Ucenter_member')->where(array('openid'=>array('like',str_replace('-','%',$this->openid))))->find();
        if($id){
            $this->assign('id','ok');
        }
        $this->display();
    }

    public function savebind(){

        $password=think_ucenter_md5(I('post.pwd'),UC_AUTH_KEY);



        $username = I('post.mobile');
        $map['_string'] = "(username='{$username}' or mobile='{$username}')";
        $map['password'] = $password;
        $userdb=D('Ucenter_member')->where($map)->find();

        if($userdb){
            $data['openid']=$this->openid;
            $id=D('Ucenter_member')->where(array('id'=>$userdb['id']))->save($data);

            if($id){
                $exit=json_encode(array('code'=>1,'msg'=>'绑定成功！'));
            }else{
                $exit=json_encode(array('code'=>0,'msg'=>'绑定失败，请重新再试！'));
            }
        }else{
            $exit=json_encode(array('code'=>0,'msg'=>'密码错误，或者您的账户不存在，请联系管理员!'));
        }
        echo $exit;
    }
    public function jion(){
            //查找用户
        $userdb=D('Ucenter_member')->where(array('openid'=>array('like',str_replace('-','%',$this->openid))))->find();
            $truename=D('Field')->where(array('uid'=>$userdb['id'],'field_id'=>38))->find();
            $userdb['truename']=$truename['field_data'];
            $this->assign('userdb',$userdb);
            $id=I('get.id');
            $type=I('get.type');
            //查找会议
            if($type=='event'){
                $eventdb=D('Event')->where(array('id'=>$id))->find();
                //查找参会信息
                $event_attend=D('Event_attend')->where(array('uid'=>$this->uid,'event_id'=>$id))->find();
                $this->assign('attenddb',$event_attend);
                $this->assign('nowtime',time());
                $this->assign('data',$eventdb);
                $this->assign('type','event');
                $this->assign('typename','活动');
            }else{
                $meetdb=D('Meet')->where(array('id'=>$id))->find();
                //查找参会信息
                $meet_attend=D('Meet_attend')->where(array('uid'=>$this->uid,'meet_id'=>$id))->find();
                $this->assign('attenddb',$meet_attend);
                $this->assign('nowtime',time());
                $this->assign('data',$meetdb);
                $this->assign('type','meet');
                $this->assign('typename','会议');

            }
            $this->display();
    }
    //保存参会
    public function saveJion(){
        $data=I('get.');
        $data['creat_time']=time();

        if(I('post.whytext')){
            $data['whytext']=I('post.whytext');
            $data['status']=2;
        }else{
            $data['status']=1;
        }
        if($data['type']=='event'){
            $data['event_id']=$data['e_m_id'];
            $flag=D('Event_attend')->where(array('uid'=>$data['uid'],'event_id'=>$data['event_id']))->save($data);
            $map_f['model'] = 'event_attend';
        }else{
            $data['meet_id']=$data['e_m_id'];
            $flag=D('Meet_attend')->where(array('uid'=>$data['uid'],'meet_id'=>$data['meet_id']))->save($data);
            $map_f['model'] = 'meet_attend';
        }
        if($flag){
            $map_f['user_id'] = get_uid();
            $map_f['record_id'] = 0;
            D('Fileu')->where($map_f)->setField('record_id',$flag);
        }
        $exit=$this->return_exit_arr($flag,'提交成功','您未收到邀请，暂时不能参与！');
        echo $exit;


    }
    //微信审核请假
    public function atu_apply(){
        //审核通过改变status为4
        //审核不通过改变status为3

    }

    public function mark() {
            //查找用户
            $userdb = D('Ucenter_member')->where(array('openid' => array('like',str_replace('-','%',$this->openid))))->find();
            $truename = D('Field')->where(array('uid' => $userdb['id'], 'field_id' => 38))->find();
            $userdb['truename'] = $truename['field_data'];
            $this->assign('userdb', $userdb);
            //查找会议
            $id = I('get.id');
            $type = I('get.type');
            if($type=='event') {
                $eventdb = D('Event')->where(array('id' => $id))->find();
                if (empty($eventdb)) $this->error("未找到会议数据");
                $this->assign('data', $eventdb);
                //计算签到逻辑 1、已过期 2、未开始 3、已签到 4、未到签到时间 5、未收到邀请参加活动
                $nowtime = time();
                if ($eventdb['eTime'] < $nowtime) $showtype = 1;
                if ($eventdb['sTime'] > ($nowtime + 60 * 60)) $showtype = 2;
                $is_user=D('Event_attend')->where(array('uid'=>$this->uid,'event_id'=>$id))->find();
                if(empty($is_user))$showtype = 5;
                //读取签到数据
                $markset = D('Event_markset')->where(array('event_id' => $id))->order('id')->select();
                foreach ($markset as $key=>$val){
                    $dirt=$val['mark_time']-$nowtime;
                    if(abs($dirt)<=60*60){
                        $mark_sort=$val['mark_sort'];
                    }
                }
                if(!$mark_sort){
                    $showtype=4;
                }else{
                    $temp_mark_data = D('Event_marknum')->where(array('uid'=>$userdb['id'],'event_id' => $id,'mark_sort'=>$mark_sort))->find();
                    if($temp_mark_data['mark_time']>0)$showtype = 3;
                }
                $this->assign('typename','活动');
            }else{
                $meetdb = D('Meet')->where(array('id' => $id))->find();
                if (empty($meetdb)) $this->error("未找到会议数据");
                $this->assign('data', $meetdb);
                //计算签到逻辑 1、已过期 2、未开始 3、已签到 4、未到签到时间 5、未收到邀请参加会议
                $nowtime = time();
                if ($meetdb['eTime'] < $nowtime) $showtype = 1;
                if ($meetdb['sTime'] > ($nowtime + 60 * 60)) $showtype = 2;
                $is_user=D('Meet_attend')->where(array('uid'=>$this->uid,'meet_id'=>$id))->find();
                if(empty($is_user))$showtype = 5;
                //读取签到数据
                $markset = D('Meet_markset')->where(array('meet_id' => $id))->order('id')->select();
                foreach ($markset as $key=>$val){
                    $dirt=$val['mark_time']-$nowtime;
                    if(abs($dirt)<=60*60){
                        $mark_sort=$val['mark_sort'];
                    }
                }
                if(!$mark_sort){
                    $showtype=4;
                }else{
                    $temp_mark_data = D('Meet_marknum')->where(array('uid'=>$userdb['id'],'meet_id' => $id,'mark_sort'=>$mark_sort))->find();
                    if($temp_mark_data['mark_time']>0)$showtype = 3;
                }
                $this->assign('typename','会议');
            }

            $this->assign('mark_sort', $mark_sort);
            $this->assign('showtype', $showtype);
            $this->assign('type', $type);
            $this->display();
    }

    public function saveMark(){
        $data=I('get.');
        $data['position']=$_POST['position'];
        $data['mark_time']=time();
        if($data['type']=='event'){
            $mark_set=D('Event_markset')->where(array('uid'=>$this->uid,'event_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            $is_user=D('Event_marknum')->where(array('uid'=>$this->uid,'event_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            if(!empty($is_user)){
                //查找用户信息
                $user=$this->uid_get_detail($this->uid);
                $data['truename']=$user['truename'];
                $data['company']=$user['company'];
                $data['phone']=$user['phone'];
                $data['event_id']=$data['e_m_id'];
                if($mark_set['mark_time']<time()){
                    $data['mark_attr']='迟到了';
                    $data['status']=2;//迟到状态
                    $data['id']=$is_user['id'];
                    $id=D('Event_marknum')->where(array('id'=>$data['id']))->save($data);
                    $exit=$this->return_exit_arr($id,'签到成功,但您迟到了','签到失败');
                }else{
                    $data['status']=1;//正常签到
                    $data['id']=$is_user['id'];
                    $id=D('Event_marknum')->where(array('id'=>$data['id']))->save($data);
                    if($id){
                        //增加一次签到
                        D('Attendance')->where(array('uid'=>$this->uid,'record_id'=>$data['event_id'],'type'=>'event'))->setInc('s_mark',1);
                    }
                    $exit=$this->return_exit_arr($id,'签到成功！','签到失败');
                }
                //只要是签到了就算是可以加积分
                // author: MR.Z start
                $event = D('Event')->find( $data['event_id']);
                if(in_array($event['event_type'],['其它形式政协活动'])){

                  action_log('weiyuan_event_other','proposal',$event['id'] ,$this->uid);
                }
                if(in_array($event['event_type'],['公益活动'])){

                    action_log('weiyuan_event_gy','proposal',$event['id'] ,$this->uid);
                }
                //end
            }else{
                $exit=$this->return_exit_arr(0,'您无权参加签到该活动！','您无权参加签到该活动！');
            }
        }else{
            $mark_set=D('Meet_markset')->where(array('uid'=>$this->uid,'meet_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            $is_user=D('Meet_marknum')->where(array('uid'=>$this->uid,'meet_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            if(!empty($is_user)){
                //查找用户信息
                $user=$this->uid_get_detail($this->uid);
                $data['truename']=$user['truename'];
                $data['company']=$user['company'];
                $data['phone']=$user['phone'];
                $data['meet_id']=$data['e_m_id'];
                if($mark_set['mark_time']<time()){
                    $data['mark_attr']='迟到了';
                    $data['status']=2;//迟到状态
                    $data['id']=$is_user['id'];
                    $id=D('Meet_marknum')->where(array('id'=>$data['id']))->save($data);
                    $exit=$this->return_exit_arr($id,'签到成功,但您迟到了','签到失败');
                }else{
                    $data['status']=1;//迟到状态
                    $data['id']=$is_user['id'];
                    $id=D('Meet_marknum')->where(array('id'=>$data['id']))->save($data);
                    if($id){
                        //增加一次签到
                        $ss=D('Attendance')->where(array('uid'=>$this->uid,'record_id'=>$data['meet_id'],'type'=>'meet'))->setInc('s_mark',1);
                    }
                    $exit=$this->return_exit_arr($id,'签到成功！','签到失败');
                }
            }else{
                $exit=$this->return_exit_arr(0,'您无权参加签到该会议！','您无权参加签到该会议！');
            }
        }
        // data['type'] meet event data['e_m_id']  data[type_id]
        if($data['type'] == 'meet'){
            switch($data['type_id']){
                //全体委员会议
                case '1':
                    action_log('weiyuan_basic_meet_all',$data['type'],$data['e_m_id'],is_login());
                    break;
                //常委会
                case '2':
                    action_log('weiyuan_basic_meet_cw',$data['type'],$data['e_m_id'],is_login());
                    break;
            }
            switch($data['type_id']){
                case '1':
                    action_log('weiyuan_basic_event_qzx',$data['type'],$data['e_m_id'],is_login());
                    break;
                case '2':
                    action_log('weiyuan_basic_event_join',$data['type'],$data['e_m_id'],is_login());
                    break;
                case '3':
                    action_log('weiyuan_basic_event_join',$data['type'],$data['e_m_id'],is_login());
                    break;
                case '4':
                    action_log('weiyuan_event_other',$data['type'],$data['e_m_id'],is_login());
                    break;
                case '5':
                    action_log('weiyuan_event_gy',$data['type'],$data['e_m_id'],is_login());
                    break;
            }
        }
        echo $exit;
    }

    public function tongzhi(){
        $data=D('Message')->where(array('id'=>I('get.id')))->find();
        $this->assign('data', $data);
        $this->display();
    }
/////*******************************以下公共函数**************************************/////
    //返回$exit函数
    public function return_exit_arr($id,$str_suc,$str_err)
    {
        if($id){
            $exit=json_encode(array('code'=>1,'msg'=>$str_suc));
        }else{
            $exit=json_encode(array('code'=>0,'msg'=>$str_err));
        }
        return $exit;
    }
    //更具个人uid查找姓名和电话
    public function uid_get_detail($uid){
        $temp_arr=array();
        $truename=D('Field')->where(array('uid'=>$uid,'field_id'=>38))->find();//38姓名
        $compay=D('Field')->where(array('uid'=>$uid,'field_id'=>50))->find();//50工作单位
        $phone=D('Field')->where(array('uid'=>$uid,'field_id'=>62))->find();//62电话
        $temp_arr['truename']=$truename['field_data'];
        $temp_arr['company']=$compay['field_data'];
        $temp_arr['phone']=$phone['field_data'];
        return $temp_arr;
    }
    //高德获取地理位置
    public function lng_lat_get_address(){
        $lng=I('post.lng');
        $lat=I('post.lat');//key
        $url="http://restapi.amap.com/v3/geocode/regeo?key=6d8f18c73be900086e2fdff750406d03&location=".$lng.",".$lat."&poitype=&radius=50&extensions=all&batch=false&roadlevel=1";
        $wxapi = new WeixinApi();
        $res=$wxapi->curlGet($url);
        $this->ajaxReturn( json_decode($res));
    }

}


