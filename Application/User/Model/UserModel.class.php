<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: MR.Z <327778155@qq.com>
// +----------------------------------------------------------------------
namespace User\Model;

use Think\Model;
use Home\Model\MemberModel;



/**
 * User模型   包括扩展属性的增删改查
 */
class UserModel extends Model
{

		private $group_id,$expand_id;
		//委员 办理单位 集体的组与扩展属性ID对应关系
		private $grouptoexpand = array(WEIYUAN=>array(5,13),UNIT=>array(8,14),TEAM=>array(6,15));
    /**
     * 虚拟模型
     */
		Protected $autoCheckFields = false;
	

     private $review_fields = ['曾用名','婚否','email','邮政编码','职称','现任职称','工作单位','单位地址','家庭电话','家庭地址','办公电话','qq','兴趣爱好','是否华侨','头像'];
		/*
		 * 设置用户的user_id 和扩展信息ID,以便于后续操作
		 * 此方法必须在实例化后马上调用
		 *  $group   weiyuan unit team
		 */
		public function setModel($group_id){
			$gtoe = $this->grouptoexpand[$group_id];
			$this->group_id = $gtoe[0];
			$this->expand_id = $gtoe[1];
			
		}
	
	
		private function check_model(){
			if(empty($this->group_id) || empty($this->expand_id)){
				return false;
			}else{
				return true;
			}
		}
		
		
	/**
	 * 通过uid 获取用户信息
	 * @var string
	 */
		public function getUser($user_id){
			if(!$this->check_model()){return false;}
				$member = D('Member')->find($user_id);

				$map_profile['status'] = 1;
				$field_group = D('field_group')->where($map_profile)->select();
			//	$field_group_ids = array_column($field_group, 'id');
				$field_group_ids = $this->expand_id;
				$map_profile['profile_group_id'] = array('in', array($field_group_ids));
				$fields_list = D('field_setting')->where($map_profile)->getField('id,field_name,form_type');
				$fields_list = array_combine(array_column($fields_list, 'field_name'), $fields_list);
				$map_field['uid'] = $member['uid'];

				foreach ($fields_list as $key => $val) {
					$map_field['field_id'] = $val['id'];
					
					$field_data = D('field')->where($map_field)->getField('field_data');

					if ($field_data == null || $field_data == '') {
						$member[$key] = '';
					} else {
						$member[$key] = $field_data;
					}
				}
				
				return $member;
			
		}
	
	
	/**
	 * 通过条件获取用户列表
	 * fields 中文字段名=>条件 为委员字段
	 * @var string
	 * $viewFields 要展示的字段
	 */
		public function getUsers($fields = array(),$viewFields = array()){

			if(!$this->check_model()){return false;}
				//获取到 中文字段 与其对应的 字段id值的键值对
				$fields = array_filter($fields);

				$map_setting['profile_group_id'] = $this->expand_id;
				$field_setting = M('FieldSetting')->where($map_setting)->getField('field_name,id');

				//将条件中的中文字段值替换成数字为key
               $map['aga.uid'] = $fields['user_id'];
                unset($fields['user_id']);

				foreach($fields as $key=>$value){
					if($field_setting[$key]){

						$fields_tmp[$field_setting[$key]] = $value;

					//卸载原来的数组元素
						unset($fields[$key]);
					}else{
						//主表筛选字段

						$map[$key] =$value;
						
					}
				}
            $fields = $fields_tmp;


				$map['group_id'] = $this->group_id;
				$map['status'] = 1;
                $map = array_filter($map);
				$list = M('Member')->alias('m')->join(' __AUTH_GROUP_ACCESS__ aga on m.uid=aga.uid')->where($map)->order('last_login_time desc')->select();

				$totalCount = M('Member')->where($map)->count();
		//		int_to_string($list);
		
				//扩展信息查询
				$map_profile['status'] = 1;
				$field_group = D('field_group')->where($map_profile)->select();
			
				$field_group_ids = array_column($field_group, 'id');
				$map_profile['profile_group_id'] = array('in', array($this->expand_id));
				$fields_list = D('field_setting')->where($map_profile)->getField('id,field_name,form_type'); //TODO
		
				$fields_list = array_combine(array_column($fields_list, 'field_name'), $fields_list);

			//如果设置了展示字段
				if(!empty($viewFields)){
					$newFields = array();


					foreach($viewFields as $v){
						$newFields[$v] = $fields_list[$v];
					}
					$fields_list = $newFields;
				}else{
					$fields_list = array_slice($fields_list, 0, 8);//取出前8条，用户扩展资料默认显示8条
				}
				//遍历用户基本信息表
				//fields_list   为展示的扩展字段的详情信息

				foreach ($list as $k=>&$tkl) {
					$tkl['id'] = $tkl['uid'];
					
					
					//通过用户基本表里的uid的字段，查询出扩展字段的值
					//fields_list   为展示的扩展字段的详情信息
				//查询扩展字段

					foreach ($fields_list as $key => $val) {
						//设置setting表里对应用户ID字段

						//$fields[$val['id']] 为筛选条件  如果与筛选字段传过来有值 ，就将其作为有交筛选字段

						if(!empty($fields[$val['id']])){
							$map_field['uid'] = $tkl['uid'];
							$map_field['field_id'] = $val['id'];
							$map_field['field_data'] = $fields[$val['id']];
							$field_data = D('field')->where($map_field)->getField('field_data');

							unset($map_field);
							if(empty($field_data)){
								unset($list[$k]);
								break;
							}else{
								$tkl[$key] = $field_data;
							}
						}else{
							$map_field['uid'] = $tkl['uid'];
							$map_field['field_id'] = $val['id'];
							$field_data = D('field')->where($map_field)->getField('field_data');
							$tkl[$key] = $field_data;
							
						}
						

					
						//通过查询条件获取到获取到对应字段，如果值不存在，就删除该条数据
						
						
			/*			echo $field_data;echo '--';
					//	print_r($fields);
				//	print_r(D('field')->getlastsql());echo '-';
						//如果当前查询的数据结果为空
						if ($field_data == null || $field_data == '') {
						//	$tkl[$key] = '';
							//如果当前条件下field_data 为空 说明当前信息不符合需要检索的数据，便从list数组中删除此条数据
							unset($list[$k]);
							if($fields[$val['id']]){
								
								unset($list[$k]);
								break;
							}
					
						} else {
							$tkl[$key] = $field_data;
							
						}
			*/
						
					}
				}

				return array_values($list);
		}








    /**
     * 获取用户信息
     * @param  string  $uid 用户ID或用户名
     * @param  boolean $is_username 是否使用用户名查询
     * @return array                用户信息
     */
    public function info($uid, $is_username = false)
    {
        $map = array();
        if ($is_username) { //通过用户名获取
            $map['username'] = $uid;
        } else {
            $map['id'] = $uid;
        }

        $user = $this->where($map)->field('id,username,email,mobile,status')->find();
        if (is_array($user) && $user['status'] = 1) {
            return array($user['id'], $user['username'], $user['email'], $user['mobile']);
        } else {
            return -1; //用户不存在或被禁用
        }
    }

 


}
