<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-7-2
 * Time: 上午11:18
 * @author 郑钟良<zzl@ourstu.com>
 */

namespace Common\Widget;
use Think\Action;

/**input类型输入渲染
 * Class InputWidget
 * @package Usercenter\Widget
 * @郑钟良
 */
class TongxunluWidget extends Action {

    /**关注渲染
     * @param int $is_allow 是否已关注
     * @param int $uid
     * @author MR.Z <327778155@qq.com>
     */
    public function index(){
        $uid = get_uid();
        $group = get_group($uid);
        $m = D('User/User');

        //通讯录数组
        $group_ids = C('CONTACT_GROUP');



        $group_tmp = array();
        foreach ($group_ids as $k => $v) {
            if ($v['is_final'] == true && $v['parent_id'] == 0) {
                $group_tmp[$k]['name'] = $v['name'];
            } elseif ($v['is_final'] == true && $v['parent_id'] != 0) {
                $group_tmp[$v[parent_id]]['name'] = $group_ids[$v[parent_id]]['name'];
                $group_tmp[$v[parent_id]]['subgroup'][$k][name] = $v['name'];
            }
        }
        ksort($group_tmp);
        $this->assign('contact_group', $group_tmp);

        if(is_administrator()){
            $com_name = 'all';
            $group = 'all';
        }else{
            switch($group){
                case '委员':
                    $m->setModel(WEIYUAN);
                    $user = $m->getUser($uid);
                    $com_name = $user['主任'];
                    break;
                case '集体':
                    $m->setModel(TEAM);
                    $user = $m->getUser($uid);
                    $com_name = $user['名称'];
                    break;
            }

            //其最上级父类只能为专委会和街道联络委
            $parent_ids = [1,8];
            foreach($group_ids as $k=>$v){
               if(in_array($v['parent_id'],$parent_ids) && $com_name == $v['name'] ){
                   $group = $v;
                   $group['id'] = $k;
                   break;
               }

            }


        }

        //以com_name 来看权限
        $this->assign('group_view',$group);


	    $this->display(T('Application://Common@Widget/tongxunlu'));
    }
}