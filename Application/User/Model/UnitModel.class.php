<?php


//可以废弃  用USERMODEL 代替
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
 *  办理单位模型
 */
class UnitModel extends Model
{
		//办理单位组为13
		const GROUP_ID = 8;
		const EXPAND_ID = 14;

    /**
     * 虚拟模型
     */
		Protected $autoCheckFields = false;
	
	
	/**
	 * 通过uid 获取办理单位信息
	 * @var string
	 */
		public function getUnit($uid){
			$member = D('Member')->find($uid);

			$map_profile['status'] = 1;
			$field_group = D('field_group')->where($map_profile)->select();
		//	$field_group_ids = array_column($field_group, 'id');
			$field_group_ids = self::EXPAND_ID;
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
	 * 通过条件获取办理单位列表
	 * fields 中文字段名=>条件 为委员字段
	 * @var string
	 */
		public function getUnits($fields = array()){
				
				//获取到 中文字段 与其对应的 字段id值的键值对
				$map_setting['profile_group_id'] = self :: EXPAND_ID;
				$field_setting = M('FieldSetting')->where($map_setting)->getField('field_name,id');
			
				//将条件中的中文字段值替换成数字为key
				foreach($fields as $key=>$value){
						$fields[$field_setting[$key]] = $value;
					
					
					//卸载原来的数组元素
						unset($fields[$key]);
				}
		
				$map['group_id'] = self::GROUP_ID;
				$list = M('Member')->join('INNER JOIN __AUTH_GROUP_ACCESS__ on __MEMBER__.uid=__AUTH_GROUP_ACCESS__.uid')->where($map)->order('last_login_time desc')->page($page, $r)->select();

				$totalCount = M('Member')->where($map)->count();
				int_to_string($list);
		
				//扩展信息查询
				$map_profile['status'] = 1;
				$field_group = D('field_group')->where($map_profile)->select();
			
				$field_group_ids = array_column($field_group, 'id');
				$map_profile['profile_group_id'] = array('in', array(self::EXPAND_ID));
				$fields_list = D('field_setting')->where($map_profile)->getField('id,field_name,form_type'); //TODO

				$fields_list = array_combine(array_column($fields_list, 'field_name'), $fields_list);
				$fields_list = array_slice($fields_list, 0, 8);//取出前8条，用户扩展资料默认显示8条


				foreach ($list as $k=>&$tkl) {
					$tkl['id'] = $tkl['uid'];
					$map_field['uid'] = $tkl['uid'];
					//循环通过uid 与对应的 字段id值 获取到field_data
					foreach ($fields_list as $key => $val) {
						$map_field['field_id'] = $val['id'];
						//$fields[$val['id']] 为筛选条件
						if($fields[$val['id']]){
							$map_field['field_data'] = $fields[$val['id']];
						}
						
						$field_data = D('field')->where($map_field)->getField('field_data');
				
						if ($field_data == null || $field_data == '') {
							$tkl[$key] = '';
							//如果当前条件下field_data 为空 说明当前信息不符合需要检索的数据，便从list数组中删除此条数据
							if($fields[$val['id']]){
								unset($list[$k]);
								break;
							}
						} else {
							$tkl[$key] = $field_data;
						}
					}
				}

				return $list;
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
