<?php

namespace Addons\uploadFiles;
use Common\Controller\Addon;

/**
 * 批量上传文件插件
 * @author MR.Z
 */

    class UploadFilesAddon extends Addon{

        public $info = array(
            'name'=>'UploadFiles',
            'title'=>'批量上传文件',
            'description'=>'批量上传文件',
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

        //实现的moduleUpload钩子方法
        public function moduleUpload($param){

	        $this->display('/View/edit');
        }

    }