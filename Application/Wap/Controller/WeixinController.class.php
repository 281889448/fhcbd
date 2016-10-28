<?php
namespace Wap\Controller;
use Common\Controller\BaseController;
//继承Home/Common/function微信公共函数
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
                $exit=json_encode(array('code'=>0,'msg'=>'已经绑定，不需要重新绑定!'));
            }
        }else{
            $exit=json_encode(array('code'=>0,'msg'=>'密码错误，或者您的账户不存在，请联系管理员!'));
        }

        echo $exit;
    }
    public function jion(){
            //查找用户
            $userdb=D('Ucenter_member')->where(array('openid'=>$this->openid))->find();
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
            //发送模板消息
            //步骤1得到活动或者会议审核人openid
            //步骤2发送消息
        }else{
            $data['status']=1;
        }
        if($data['type']=='event'){
            $data['event_id']=$data['e_m_id'];
            $id=D('Event_attend')->add($data);
            $map_f['model'] = 'event_attend';
        }else{
            $data['meet_id']=$data['e_m_id'];
            $id=D('Meet_attend')->add($data);
            $map_f['model'] = 'meet_attend';
        }
        if($id){
            $map_f['user_id'] = get_uid();
            $map_f['record_id'] = 0;
            D('Fileu')->where($map_f)->setField('record_id',$id);
        }
        $exit=$this->return_exit_arr($id,'提交成功','提交失败');
        echo $exit;
    }
    //微信审核请假
    public function atu_apply(){
        //审核通过改变status为4
        //审核不通过改变status为3

    }

    public function mark() {
            //查找用户
            $userdb = D('Ucenter_member')->where(array('openid' => $this->openid))->find();
            $truename = D('Field')->where(array('uid' => $userdb['id'], 'field_id' => 38))->find();
            $userdb['truename'] = $truename['field_data'];
            $this->assign('userdb', $userdb);
            //查找会议
            $id = I('get.id');
            $type = I('get.type');
            if($type=='event') {
                $eventdb = D('event')->where(array('id' => $id))->find();
                if (empty($eventdb)) $this->error("未找到活动数据");
                $this->assign('data', $eventdb);
                //计算签到逻辑 1、已过期 2、未开始 3、已签到 4、签到
                $nowtime = time();
                if ($eventdb['eTime'] < $nowtime) $showtype = 1;
                if ($eventdb['sTime'] > ($nowtime + 60 * 60)) $showtype = 2;
                $max_mark_id = D('Event_marknum')->where(array('uid' => $this->uid, 'event_id' => $id))->max('id');
                $data_mark_time=D('Event_marknum')->where(array('id'=>$max_mark_id))->find();
                if ($data_mark_time['mark_time']+60 * 60 > time()&& $data_mark_time['mark_time']<time() && $data_mark_time['status']>0) $showtype = 3;
                //读取签到数据
                $markset = D('Event_markset')->where(array('event_id' => $id))->order('id')->select();
            }else{
                $meetdb = D('Meet')->where(array('id' => $id))->find();
                if (empty($meetdb)) $this->error("未找到会议数据");
                $this->assign('data', $meetdb);
                //计算签到逻辑 1、已过期 2、未开始 3、已签到 4、签到
                $nowtime = time();
                if ($meetdb['eTime'] < $nowtime) $showtype = 1;
                if ($meetdb['sTime'] > ($nowtime + 60 * 60)) $showtype = 2;
                $max_mark_id = D('Meet_marknum')->where(array('uid' => $this->uid, 'meet_id' => $id))->max('id');
                $data_mark_time=D('Meet_marknum')->where(array('id'=>$max_mark_id))->find();
                if ($data_mark_time['mark_time']+60 * 60 > time()&& $data_mark_time['mark_time']<time() && $data_mark_time['status']>0) $showtype = 3;
                //读取签到数据
                $markset = D('Meet_markset')->where(array('meet_id' => $id))->order('id')->select();
            }
            if ($markset[0]['mark_time'] > $nowtime) {
                $max_mark_sort = 1;
            } else {
                foreach ($markset as $k => $v) {
                    if ($markset[$k]['mark_time'] < $nowtime && $nowtime < $markset[$k + 1]['mark_time']){
                        $max_mark_sort = $k + 2;
                    }else{
                        $max_mark_sort = 1;
                    }
                }
            }
            $this->assign('mark_sort', $max_mark_sort);
            $this->assign('showtype', $showtype);
            $this->assign('type', $type);
            $this->display();
    }

    public function saveMark(){
        $data=I('get.');
        $data['mark_time']=time();
        if($data['type']=='event'){
            $mark_set=D('Event_markset')->where(array('uid'=>$this->uid,'event_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            $is_user=D('Event_marknum')->where(array('uid'=>$this->uid,'event_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            //查找用户信息
            $user=$this->uid_get_detail($this->uid);
            $data['truename']=$user['truename'];
            $data['company']=$user['company'];
            $data['phone']=$user['phone'];
            $data['event_id']=$data['e_m_id'];
            if($mark_set['mark_time']<time()){
                $data['mark_attr']='迟到了';
                $data['status']=2;//迟到状态
                if($data['mark_sort']>1 || empty($is_user)){
                    $id=D('Event_marknum')->add($data);
                }else{
                    $data['id']=$is_user['id'];
                    $id=D('Event_marknum')->where(array('id'=>$data['id']))->save($data);
                }
                $exit=$this->return_exit_arr($id,'签到成功,但您迟到了','签到失败');
            }else{
                $data['status']=1;//迟到状态
                if($data['mark_sort']>1 || empty($is_user)){
                    $id=D('Event_marknum')->add($data);
                }else{
                    $data['id']=$is_user['id'];
                    $id=D('Event_marknum')->where(array('id'=>$data['id']))->save($data);
                }
                $exit=$this->return_exit_arr($id,'签到成功！','签到失败');
            }
        }else{
            $mark_set=D('Meet_markset')->where(array('uid'=>$this->uid,'meet_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            $is_user=D('Meet_marknum')->where(array('uid'=>$this->uid,'meet_id'=>$data['e_m_id'],'mark_sort'=>$data['mark_sort']))->find();
            //查找用户信息
            $user=$this->uid_get_detail($this->uid);
            $data['truename']=$user['truename'];
            $data['company']=$user['company'];
            $data['phone']=$user['phone'];
            $data['meet_id']=$data['e_m_id'];
            if($mark_set['mark_time']<time()){
                $data['mark_attr']='迟到了';
                $data['status']=2;//迟到状态
                if($data['mark_sort']>1 || empty($is_user)){
                    $id=D('Meet_marknum')->add($data);
                }else{
                    $data['id']=$is_user['id'];
                    $id=D('Meet_marknum')->where(array('id'=>$data['id']))->save($data);
                }
                $exit=$this->return_exit_arr($id,'签到成功,但您迟到了','签到失败');
            }else{
                $data['status']=1;//迟到状态
                if($data['mark_sort']>1 || empty($is_user)){
                    $id=D('Meet_marknum')->add($data);
                }else{
                    $data['id']=$is_user['id'];
                    $id=D('Meet_marknum')->where(array('id'=>$data['id']))->save($data);
                }
                $exit=$this->return_exit_arr($id,'签到成功！','签到失败');
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
}


