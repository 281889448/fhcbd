<?php

namespace Addons\CheckinModule;
use Common\Controller\Addon;

/**
 * 会议签到插件
 * @author MR.Z
 */

    class CheckinModuleAddon extends Addon{

        public $info = array(
            'name'=>'CheckinModule',
            'title'=>'会议签到',
            'description'=>'模块签到插件',
            'status'=>1,
            'author'=>'MR.Z',
            'version'=>'0.1'
        );

        public function install(){
            return true;
        }

        public function uninstall(){
            return true;
        }

         //实现的checkin钩子方法
		public function checkinModule($param)
		{

         }

	
	 /**
     * @param $checkinfo
     * @auth 陈一枭
     */
    private function getOverRate($checkinfo)
    {
        $db_prefix = C('DB_PREFIX');
        $over_count = D()->query("select count(uid)  AS rank from (SELECT *,max(total_num) as total FROM `{$db_prefix}check_info`  WHERE 1 group by uid ) as checkin where total>{$checkinfo['total_num']}");

        $users_count = D('Member')->count('uid');
        $over_rate =((1- number_format($over_count[0]['rank']  / $users_count, '3'))*100)."%";
        return $over_rate;
    }
	
    }