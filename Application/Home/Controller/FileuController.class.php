<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;

/**
 * 文件控制器
 * 主要用于下载模型的文件上传和下载
 */

class FileuController extends HomeController
{
    /* 文件上传 */
    public function upload()
    {
        $return = array('status' => 1, 'info' => '上传成功', 'data' => '');




	    $filename = $_POST['fileName'];

	    if ($filename) {
		 //   $filename = mb_convert_encoding( $filename,'GBK', 'utf-8');
		    
		    $filepath = 'Uploads/'.date('Y-m-d',time()).'/'.get_uid().'/';
		    if(!is_dir($filepath)){
		    	mkdir($filepath,0777,true);
			   
		    }
		    
		    $ext = substr($filename, strrpos($filename, '.')+1);
		    
		    
		    /*$xmlstr =  $GLOBALS[HTTP_RAW_POST_DATA];//$_POST["data"];//
				if(empty($xmlstr)) $xmlstr = file_get_contents('php://input');
				$raw = $xmlstr;//得到post过来的二进制原始数据*/
		    //file_put_contents('uploads/'.$filename,$_FILES["file"]["tmp_name"],FILE_APPEND);
		    //处理文件名
		   $savename =  substr(pathinfo($_FILES["file"]["tmp_name"], PATHINFO_FILENAME), 1);
		
		    $savename = $savename.'.'.$ext;
		        
	
		    
		    file_put_contents($filepath.'/'.$savename,file_get_contents($_FILES["file"]["tmp_name"]),FILE_APPEND);
		   
			
		  
		    $mf = M('Fileu');
		    $mf->create();
		    $mf->size = $_FILES['file']['size'];
		    $mf->savename = $savename;
		    $mf->name = $filename;
		    $mf->create_time = time();
		    $mf->ext =  $ext;
		    $mf->savepath = $filepath;
		    $mf->location = 0;
		    $flag = $mf->add();

		    if($flag){
			    $return['data']['size'] = $_FILES['file']['size'];
			    $return['data']['filename'] =  $filename;
			    $return['data']['success'] = true;
			
			    $return['data']['create_time'] = time();
			    $return['data']['ext'] =  substr($filename, strrpos($filename, '.')+1);
			
			    $return['data']['record_id'] = I('record_id');
			    $return['data']['user_id'] = I('user_id');
			    $return['data']['model'] = I('model');
		      $this->ajaxReturn($return);
		    }else{

		    	$return['status'] = 0;
			    $return['info'] = '上传失败';
			    $this->ajaxReturn($return);
		    }
		    //echo json_encode($array);
	    }

	    
	    
        /* 调用文件上传组件上传文件 */
/*        $File = D('File');
        $file_driver = C('DOWNLOAD_UPLOAD_DRIVER');
        $info = $File->upload(
            $_FILES,
            C('DOWNLOAD_UPLOAD'),
            C('DOWNLOAD_UPLOAD_DRIVER'),
            C("UPLOAD_{$file_driver}_CONFIG")
        );
	    
	    
        /* 记录附件信息 */
/*        if ($info) {
            $return['data'] = think_encrypt(json_encode($info['download']));
        } else {
            $return['status'] = 0;
            $return['info'] = $File->getError();
        }

        /* 返回JSON数据 */
//        $this->ajaxReturn($return);
    }

    /* 下载文件 */
    public function download($id = null)
    {
        if (empty($id) || !is_numeric($id)) {
            $this->error('参数错误！');
        }

        $file = D('Fileu');
        if (!$file->download($id)) {
            $this->error($file->getError());
        }

    }
    
    /*  删除上传文件 */
    public function delete($id = null){
	    if (empty($id) || !is_numeric($id)) {
		    $this->error('参数错误！');
	    }
	    $file = D('Fileu');
	    if (!$file->delete($id)) {
		    $this->error($file->getError());
	    }
    }


    /**
     * 上传图片
     * @author huajie <banhuajie@163.com>
     */
    public function uploadPicture()
    {
        //TODO: 用户登录检测

        /* 返回标准数据 */
        $return = array('status' => 1, 'info' => '上传成功', 'data' => '');

        /* 调用文件上传组件上传文件 */
        $Picture = D('Admin/Picture');
        $pic_driver = C('PICTURE_UPLOAD_DRIVER');
        $info = $Picture->upload(
            $_FILES,
            C('PICTURE_UPLOAD'),
            C('PICTURE_UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器

        /* 记录图片信息 */
        if ($info) {
            $return['status'] = 1;
            if ($info['Filedata']) {
                $return = array_merge($info['Filedata'], $return);
            }
            if ($info['download']) {
                $return = array_merge($info['download'], $return);
            }
            /*适用于自动表单的图片上传方式*/
            if ($info['file']) {
                $return['data']['file'] = $info['file'];
            }
            /*适用于自动表单的图片上传方式end*/

        } else {
            $return['status'] = 0;
            $return['info'] = $Picture->getError();
        }


        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

    /**用于兼容UM编辑器的图片上传方法
     * @auth 陈一枭
     */
    public function uploadPictureUM()
    {
        header("Content-Type:text/html;charset=utf-8");
        //TODO: 用户登录检测
        /* 返回标准数据 */
        $return = array('status' => 1, 'info' => '上传成功', 'data' => '');

        //实际有用的数据只有name和state，这边伪造一堆数据保证格式正确
        $originalName = 'u=2830036734,2219770442&fm=21&gp=0.jpg';
        $newFilename = '14035912861705.jpg';
        $filePath = 'upload\/20140624\/14035912861705.jpg';
        $size = '7446';
        $type = '.jpg';
        $status = 'success';
        $rs = array(
            "originalName" => $originalName,
            'name' => $newFilename,
            'url' => $filePath,
            'size' => $size,
            'type' => $type,
            'state' => $status
        );
        /* 调用文件上传组件上传文件 */
        $Picture = D('Admin/Picture');
        $pic_driver = C('PICTURE_UPLOAD_DRIVER');
        $info = $Picture->upload(
            $_FILES,
            C('PICTURE_UPLOAD'),
            C('PICTURE_UPLOAD_DRIVER'),
            C("UPLOAD_{$pic_driver}_CONFIG")
        ); //TODO:上传到远程服务器

        /* 记录图片信息 */
        if ($info) {
            $return['status'] = 1;
            if ($info['Filedata']) {
                $return = array_merge($info['Filedata'], $return);
            }
            if ($info['download']) {
                $return = array_merge($info['download'], $return);
            }
            $rs['state'] = 'SUCCESS';
            $rs['url'] = $info['upfile']['path'];
            if ($type == 'ajax') {
                echo json_encode($rs);
                exit;
            } else {
                echo json_encode($rs);
                exit;
            }


        } else {
            $return['state'] = 0;
            $return['info'] = $Picture->getError();
        }


        /* 返回JSON数据 */
        $this->ajaxReturn($return);
    }

}
