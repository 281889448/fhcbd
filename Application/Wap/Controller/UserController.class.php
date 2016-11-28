<?php
/**
 * Created by PhpStorm.
 * User: MR.Z
 * Date: 16-10-8
 * Time: AM9:45
 */

namespace Wap\Controller;

use Common\Controller\BaseController;


class UserController extends BaseController
{

	public function index(){
	    //获取操作记录中，当时记录值
        $map_u['uid'] = get_uid();
        $map_u['is_now'] = 1;
        $map_u['is_review'] = 0;
        $new_user = D('UserHistory')->where($map_u)->find();

        $user_history = $this->parse_user($new_user);

        if($new_user){
            $this->assign('review',1);
        }
        //获取 原 用户资料信息
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $user = $m->getUser(get_uid());

       //合并数组，操作数组替换原用户资料
        $user =  array_merge($user,$user_history);
        $this->assign('user',$user);

		$this->display();
	}

	public function add(){

    }


    /**修改用户扩展信息
     * @author MR.Z<327778155@qq.com>
     */
    public function edit_expandinfo($profile_group_id)
    {

        $field_setting_list = D('field_setting')->where(array('profile_group_id' => $profile_group_id, 'status' => '1'))->order('sort asc')->select();



        if (!$field_setting_list) {
            $this->error('没有要修改的信息！');
        }

        $data = null;
        foreach ($field_setting_list as $key => $val) {
            $data[$key]['uid'] = is_login();
            $data[$key]['field_id'] = $val['id'];
            switch ($val['form_type']) {
                case 'input':
                    $val['value'] = op_t($_POST['expand_' . $val['id']]);
                    if (!$val['value'] || $val['value'] == '') {
                        if ($val['required'] == 1) {
                            $this->error($val['field_name'] . '内容不能为空！');
                        }
                    } else {
                        $val['submit'] = $this->_checkInput($val);
                        if ($val['submit'] != null && $val['submit']['succ'] == 0) {
                            $this->error($val['submit']['msg']);
                        }
                    }
                    $data[$key]['field_data'] = $val['value'];
                    break;
                case 'radio':
                    $val['value'] = op_t($_POST['expand_' . $val['id']]);
                    $data[$key]['field_data'] = $val['value'];
                    break;
                case 'checkbox':
                    $val['value'] = $_POST['expand_' . $val['id']];
                    if (!is_array($val['value']) && $val['required'] == 1) {
                        $this->error('请至少选择一个：' . $val['field_name']);
                    }
                    $data[$key]['field_data'] = is_array($val['value']) ? implode('|', $val['value']) : '';
                    break;
                case 'select':
                    $val['value'] = op_t($_POST['expand_' . $val['id']]);
                    $data[$key]['field_data'] = $val['value'];
                    break;
                case 'time':
                    $val['value'] = op_t($_POST['expand_' . $val['id']]);
                    $val['value'] = strtotime($val['value']);
                    $data[$key]['field_data'] = $val['value'];
                    break;
                case 'textarea':
                    $val['value'] = op_t($_POST['expand_' . $val['id']]);
                    if (!$val['value'] || $val['value'] == '') {
                        if ($val['required'] == 1) {
                            $this->error($val['field_name'] . '内容不能为空！');
                        }
                    } else {
                        $val['submit'] = $this->_checkInput($val);
                        if ($val['submit'] != null && $val['submit']['succ'] == 0) {
                            $this->error($val['submit']['msg']);
                        }
                    }
                    $val['submit'] = $this->_checkInput($val);
                    if ($val['submit'] != null && $val['submit']['succ'] == 0) {
                        $this->error($val['submit']['msg']);
                    }
                    $data[$key]['field_data'] = $val['value'];
                    break;
            }
        }
        $map['uid'] = is_login();
        $is_success = false;

        /*    foreach ($data as $dl) {
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
        */
        //当前用户信息存入历史记录
        $map_od['is_now'] = 1;
        $map_od['uid'] = get_uid();
        $old_data = M('UserHistory')->where( $map_od)->getField('data');
        if(!$old_data){
            $old_data = M('Field')->where('uid='.get_uid())->getField('field_id,field_data');
            $old_data  = serialize($old_data);
        }

        //委员资料入库历史记录
        $rs = $this->insertHistory(get_uid(),$data,$old_data);
        clean_query_user_cache(is_login(), 'expand_info');
        if ($rs) {
            $this->success('信息申请中！');
        } else {
            $this->error('没有要保存的信息！');
        }
    }


    /**input类型验证
     * @param $data
     * @return mixed
     * @author 郑钟良<zzl@ourstu.com>
     */
    function _checkInput($data)
    {
        if ($data['form_type'] == "textarea") {
            $validation = $this->_getValidation($data['validation']);
            if (($validation['min'] != 0 && mb_strlen($data['value'], "utf-8") < $validation['min']) || ($validation['max'] != 0 && mb_strlen($data['value'], "utf-8") > $validation['max'])) {
                if ($validation['max'] == 0) {
                    $validation['max'] = '';
                }
                $info['succ'] = 0;
                $info['msg'] = $data['field_name'] . "长度必须在" . $validation['min'] . "-" . $validation['max'] . "之间";
            }
        } else {
            switch ($data['child_form_type']) {
                case 'string':
                    $validation = $this->_getValidation($data['validation']);
                    if (($validation['min'] != 0 && mb_strlen($data['value'], "utf-8") < $validation['min']) || ($validation['max'] != 0 && mb_strlen($data['value'], "utf-8") > $validation['max'])) {
                        if ($validation['max'] == 0) {
                            $validation['max'] = '';
                        }
                        $info['succ'] = 0;
                        $info['msg'] = $data['field_name'] . "长度必须在" . $validation['min'] . "-" . $validation['max'] . "之间";
                    }
                    break;
                case 'number':
                    if (preg_match("/^\d*$/", $data['value'])) {
                        $validation = $this->_getValidation($data['validation']);
                        if (($validation['min'] != 0 && mb_strlen($data['value'], "utf-8") < $validation['min']) || ($validation['max'] != 0 && mb_strlen($data['value'], "utf-8") > $validation['max'])) {
                            if ($validation['max'] == 0) {
                                $validation['max'] = '';
                            }
                            $info['succ'] = 0;
                            $info['msg'] = $data['field_name'] . "长度必须在" . $validation['min'] . "-" . $validation['max'] . "之间，且为数字";
                        }
                    } else {
                        $info['succ'] = 0;
                        $info['msg'] = $data['field_name'] . "必须是数字";
                    }
                    break;
                case 'email':
                    if (!preg_match("/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i", $data['value'])) {
                        $info['succ'] = 0;
                        $info['msg'] = $data['field_name'] . "格式不正确，必需为邮箱格式";
                    }
                    break;
                case 'phone':
                    if (!preg_match("/^\d{11}$/", $data['value'])) {
                        $info['succ'] = 0;
                        $info['msg'] = $data['field_name'] . "格式不正确，必须为手机号码格式";
                    }
                    break;
            }
        }
        return $info;
    }

    /**处理$validation
     * @param $validation
     * @return mixed
     * @author 郑钟良<zzl@ourstu.com>
     */
    function _getValidation($validation)
    {
        $data['min'] = $data['max'] = 0;
        if ($validation != '') {
            $items = explode('&', $validation);
            foreach ($items as $val) {
                $item = explode('=', $val);
                if ($item[0] == 'min' && is_numeric($item[1]) && $item[1] > 0) {
                    $data['min'] = $item[1];
                }
                if ($item[0] == 'max' && is_numeric($item[1]) && $item[1] > 0) {
                    $data['max'] = $item[1];
                }
            }
        }
        return $data;
    }

    /*
    * 将扩展信息入库历史记录
    * author : MR.Z <327778155@qq.com>
    *  create: 2016/09/24
    */
    private function insertHistory($uid,$data,$old_data){
        if(empty($data)){return false;}
        $newdata = [];
        foreach($data as $v){
            if($uid==$v['uid']){
                $newdata[$v['field_id']] = $v['field_data'];
            }
        }
        $data['data'] = serialize(array_filter($newdata));

        $data['pre_data'] = $old_data;
        $data['uid'] = $uid;
        $data['create_time'] = time();
        $data['is_now'] = 1;
        $hid = M('UserHistory')->add($data);
        return $hid;

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