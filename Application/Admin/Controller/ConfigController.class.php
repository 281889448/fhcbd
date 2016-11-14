<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;

/**
 * 后台配置控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class ConfigController extends AdminController {

    /**
     * 配置管理
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index(){
        /* 查询条件初始化 */
        $map = array();
        $map  = array('status' => 1);
        if(isset($_GET['group'])){
            $map['group']   =   I('group',0);
        }
        if(isset($_GET['name'])){
            $map['name']    =   array('like', '%'.(string)I('name').'%');
        }

        $list = $this->lists('Config', $map,'sort,id');
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('group',C('CONFIG_GROUP_LIST'));
        $this->assign('group_id',I('get.group',0));
        $this->assign('list', $list);
        $this->meta_title = '配置管理';
        $this->display();
    }

    /**
     * 新增配置
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function add(){
        if(IS_POST){
            $Config = D('Config');
            $data = $Config->create();
            if($data){
                if($Config->add()){
                    S('DB_CONFIG_DATA',null);
                    $this->success('新增成功', U('index'));
                } else {
                    $this->error('新增失败');
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            $this->meta_title = '新增配置';
            $this->assign('info',null);
            $this->display('edit');
        }
    }

    /**
     * 编辑配置
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function edit($id = 0){
        if(IS_POST){
            $Config = D('Config');
            $data = $Config->create();
            if($data){
                if($Config->save()){
                    S('DB_CONFIG_DATA',null);
                    //记录行为
                    action_log('update_config','config',$data['id'],UID);
                    $this->success('更新成功', Cookie('__forward__'));
                } else {
                    $this->error('更新失败');
                }
            } else {
                $this->error($Config->getError());
            }
        } else {
            $info = array();
            /* 获取数据 */
            $info = M('Config')->field(true)->find($id);

            if(false === $info){
                $this->error('获取配置信息错误');
            }
            $this->assign('info', $info);
            $this->meta_title = '编辑配置';
            $this->display();
        }
    }

    /**
     * 批量保存配置
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function save($config){

        if($config && is_array($config)){
            $Config = M('Config');
            foreach ($config as $name => $value) {
                $map = array('name' => $name);
                $Config->where($map)->setField('value', $value);
            }
        }
        S('DB_CONFIG_DATA',null);

        //处理盘点时间的更新加入到历史记录中   补丁
        if($config['PROPOSAL_MEET'] && $config['STOCKTAK_DATE']){
            $rs = M('ConfigMeet')->where('meet=\''.$config['PROPOSAL_MEET'].'\' and status=1 ')->find();

            $meetTime = explode('~',$config['STOCKTAK_DATE']);
            $data['start_time'] =  strtotime( $meetTime[0]);
            $data['end_time'] = strtotime($meetTime[1]);
            $data['meet'] = $config['PROPOSAL_MEET'];
            $data['status'] = 1;

            if($rs){
                $data['id'] = $rs['id'];
                M('ConfigMeet')->save($data);
            }else{


                M('ConfigMeet')->add($data);
            }

        }
        $this->success('保存成功！');
    }

    /**
     * 删除配置
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function del(){
        $id = array_unique((array)I('id',0));

        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }

        $map = array('id' => array('in', $id) );
        if(M('Config')->where($map)->delete()){
            S('DB_CONFIG_DATA',null);
            //记录行为
            action_log('update_config','config',$id,UID);
            $this->success('删除成功');
        } else {
            $this->error('删除失败！');
        }
    }

    // 获取某个标签的配置参数
    public function group() {
        $id     =   I('get.id',1);
        $type   =   C('CONFIG_GROUP_LIST');
        $list   =   M("Config")->where(array('status'=>1,'group'=>$id))->field('id,name,title,extra,value,remark,type')->order('sort')->select();
        if($list) {
            $this->assign('list',$list);
        }
        $this->assign('id',$id);
        $this->meta_title = $type[$id].'设置';
        $this->display();
    }

    /**
     * 配置排序
     * @author huajie <banhuajie@163.com>
     */
    public function sort(){
        if(IS_GET){
            $ids = I('get.ids');

            //获取排序的数据
            $map = array('status'=>array('gt',-1));
            if(!empty($ids)){
                $map['id'] = array('in',$ids);
            }elseif(I('group')){
                $map['group']	=	I('group');
            }
            $list = M('Config')->where($map)->field('id,title')->order('sort asc,id asc')->select();

            $this->assign('list', $list);
            $this->meta_title = '配置排序';
            $this->display();
        }elseif (IS_POST){
            $ids = I('post.ids');
            $ids = explode(',', $ids);
            foreach ($ids as $key=>$value){
                $res = M('Config')->where(array('id'=>$value))->setField('sort', $key+1);
            }
            if($res !== false){
                $this->success('排序成功！',Cookie('__forward__'));
            }else{
                $this->eorror('排序失败！');
            }
        }else{
            $this->error('非法请求！');
        }
    }
    
    
    /*
     * 更新扩展信息
     * create: 2016/8/18
     * author: MR.Z <327778155@qq.com>
     *
     */
    public function edit_expandinfo($profile_group_id,$uid){
	    $field_setting_list = D('field_setting')->where(array('profile_group_id' => $profile_group_id, 'status' => '1'))->order('sort asc')->select();

	    if (!$field_setting_list) {
		    $this->error('没有要修改的信息！');
	    }

	    $data = null;
	    foreach ($field_setting_list as $key => $val) {
		    $data[$key]['uid'] = $uid;
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
				    $val['value'] = $_POST['expand_' . $val['id']];
             
				    $data[$key]['field_data'] = reset($val['value']);

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
	    $map['uid'] = $uid;
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
	    clean_query_user_cache($uid, 'expand_info');
	    if ($is_success) {
		    $this->success('保存成功！');
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
}
