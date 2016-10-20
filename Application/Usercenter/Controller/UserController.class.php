<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/9/28 0028
 * Time: 下午 15:13
 */

namespace Usercenter\Controller;

use Common\Controller\BaseController;
use User\Model\User;
/*
 * 会员资料审核表
 *  author: MR.Z <327778155@qq.com>
 * create: 2016/9/29
 *
 */
class UserController extends BaseController
{
    public function _initialize()
    {
        parent::_initialize();

        $this->assign('current', 'user');
    }

    /*
     * 主页展示
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/28
     */
    public function index(){
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $users = $m->getUsers([],['名称','性别','籍贯','民族','专委会','街道联络委','政治面貌','是否常委','手机号','办公电话','届别']);

        $this->assign('users',$users);
        $this->display();
    }


    /*
     * 待审核列表展示
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/28
     */
    public function review(){
        $map_fs['profile_group_id'] = WEIYUAN;
        $map_fs['status'] = 1;
        $field_setting = M('FieldSetting')->where($map_fs)->getField('id,field_name',true);
        //新添加信息的状态是  审核为0  is_now为1
        $map['is_review'] = 0;
        $map['is_now'] = 1;
        $users = M('UserHistory')->where($map)->order('create_time desc')->getField('uid,id,data,create_time',true);

        $user_tmp = [];
        foreach($users as $k=>$v){
            $user_tmp[$k] = unserialize($v['data']);
            $user_tmp[$k]['id'] = $v['id'];
            $user_tmp[$k]['create_time'] = $v['create_time'];
            foreach($user_tmp[$k] as $key=>$value){
                if(is_numeric($key)){
                    $user_tmp[$k][$field_setting[$key]] = $value;
                    unset( $user_tmp[$k][$key]);
                }
            }

        }

        $this->assign('users',$user_tmp);
        $this->display();
    }

    /*
     * 资料对比展示页面
     * author： MR.Z <327778155@qq.com>
     * create: 2016/9/29
     *
     */
    public function compare($id){

        $map_u['id'] = $id;
        $new_user = D('UserHistory')->where($map_u)->find();
         $user = $this->parse_user($new_user);



        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $old_user = $m->getUser($user['uid']);

        if(IS_POST){
            $data = I('post.');
            if($data['is_review']==1){
                //设置之前的记录不是当前的@￥#@#@！#@￥#
                $map_u2['uid'] = $new_user['uid'];
                D('UserHistory')->where($map_u2)->save(['is_now'=>0]);

                //设置最新的记录
                $data['is_now'] = 1;
                D('UserHistory')->where($map_u)->save($data);
                $new_data = unserialize($new_user['data']);
                //更新扩展资料表
                foreach($new_data as $k=>$v){
                    $map_nd['field_id'] = $k;
                    $map_nd['uid'] = $new_user['uid'];
                    D('Field')->where($map_nd)->save(['field_data'=>$v]);
                }
            }



        }

        $compare = [];
        foreach($user as $k=>$v){
            $tmp_arr['new'] = $v;
            $tmp_arr['old'] = $old_user[$k];
            $tmp_arr['property'] = $k;

            if(in_array($k,['id','uid'])){  continue;}
            if($user[$k]==$old_user[$k]){
                $tmp_arr['result'] = 1;
            }else{
                $tmp_arr['result'] = 2;
            }
            array_push($compare,$tmp_arr);
        }
        $this->assign('id',$id);
        $this->assign('compare',$compare);
        $this->display();
    }

    /*
     * 委员资料审核通过
     * @param id 当前申请审核记录的id
     * author: MR.Z <327778155@qq.com>
     * create: 2016/10/13
     */
    public function passed($id){
        //更新当前记录为is_now ，并is_review = 1  取消用户之前的is_now标记
        if(IS_POST){
            $m = D('UserHistory');
            $user_history = $m->find($id);
            //取消之前的用户is_now标记
            $m->where(['uid'=>$user_history['uid']])->setField('is_now',0);

            //设置当前记录的状态
           $m->where(['id'=>$id])->save(['is_now'=>1,'is_review'=>1]);

            //设置当前的的用户资料
            $map['uid'] = $user_history['uid'] ;



            $user = unserialize($user_history['data']);
            //获取扩展资料数据
            $field_setting_list = D('field_setting')->where(array('profile_group_id' => WEIYUAN, 'status' => '1'))->order('sort asc')->select();
            foreach ($field_setting_list as $key => $val) {
                $data[$key]['uid'] = $user_history['uid'];
                $data[$key]['field_id'] = $val['id'];



                 $data[$key]['field_data'] = $user[$val['id']];


            }

            $is_success = false;


            foreach ($data as $dl) {
                $map['field_id'] = $dl['field_id'];
                $res = D('field')->where($map)->find();

                if (!$res) {
                    if ($dl['field_data'] != '' && $dl['field_data'] != null) {
                        $dl['createTime'] = $dl['changeTime'] = time();
                        if (!D('field')->add($dl)) {
                            $this->error('信息添加时出错！');
                        }
                        $is_success = true;
                    }
                } else {
                    $dl['changeTime'] = time();
                    if (!D('field')->where('id=' . $res['id'])->save($dl)) {
                        $this->error('信息修改时出错！');
                    }

                    $is_success = true;
                }
                unset($map['field_id']);
            }
          if($is_success){
              $this->success('审核成功',U('Usercenter/User/review'));

          } else{
              $this->error('审核失败');
          }

        }
    }


    /*
     * 历史记录流程
     * author: MR.Z <327778155@qq.com>
     * create: 2016/9/30
     *
     */
    public function process($uid){

        if(empty(S('FieldSetting_'.WEIYUAN))){
            $map_fs['profile_group_id'] = WEIYUAN;
            $map_fs['status'] = 1;
            $field_setting = M('FieldSetting')->where($map_fs)->getField('id,field_name',true);
            S('FieldSetting_'.WEIYUAN,$field_setting,3600);
        }

        $fields = S('FieldSetting_'.WEIYUAN);

        $historys = D('UserHistory')->where('uid='.$uid)->order('create_time desc')->select();
        foreach($historys as &$v){
            $data = array_unique(unserialize($v['data']));

            $pre_data  = unserialize($v['pre_data']);
            $compare_tmp = [];
            foreach($data as $k=>$value){
                $data_tmp = [];

                if($value == $pre_data[$k]){
                    continue;
                }else{
                    $data_tmp['new'] = $value;
                    $data_tmp['old'] = $pre_data[$k];
                    $data_tmp['property'] = $fields[$k];
                    $data_tmp['result'] = 2;
                }

                array_push($compare_tmp,$data_tmp);

            }
            $v['compare'] =  $compare_tmp;
        }

        $this->assign('process',$historys);
        $this->display();
    }


    /*
     * 处理user_history 转化为通用的格式
     *  参数 @array [id,uid,data]
     *  返回值 [id]=>[id,uid,unser(data)]
     */
    public function parse_user($array){

        $params = $array;

        $data = unserialize($params['data']);

        $data['id'] = $array['id'];
        $data['uid'] = $array['uid'];
        if(empty(S('FieldSetting_'.WEIYUAN))){
            $map_fs['profile_group_id'] = WEIYUAN;
            $map_fs['status'] = 1;
            $field_setting = M('FieldSetting')->where($map_fs)->getField('id,field_name',true);
            S('FieldSetting_'.WEIYUAN,$field_setting,3600);
        }

        $fields = S('FieldSetting_'.WEIYUAN);


        $user_tmp = [];
        foreach($data as $k=>$v){
            if(is_numeric($k)){
                $user_tmp[$fields[$k]] = $v;
            }else{
                $user_tmp[$k] = $v;
            }

        }

        return $user_tmp;

    }

}