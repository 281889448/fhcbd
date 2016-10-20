<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-8-8
 * Time: 上午8:59
 * @author MR.Z<327778155@qq.com>
 */

namespace Common\Widget;
use Think\Action;

/**input类型输入渲染
 * Class InputWidget
 * @package Usercenter\Widget
 * @郑钟良
 */
class InputRenderWidget extends Action {

	//通过modelid获取和字段名，获取对应的组件
    public function inputRender($modelid,$name){
        $model = M('Model')->where(array('status' => 1))->find($modelid);
		//$model || return false;
        $fields = get_model_attribute($modelid);
		$fields = reset($fields);
		foreach($fields as $key=>$value){
			if($name==$value['name']){
				$field = $value; 
				break;
			}
		}

        $this->assign('field', $field);
	
		$this->display(T('Application://Common@Widget/InputRender'));
    }
	
    function _getValidation($validation){
        $data['min']=$data['max']=0;
        if($validation!=''){
            $items=explode('&',$validation);
            foreach($items as $val){
                $item=explode('=',$val);
                if($item[0]=='min'&&is_numeric($item[1])&&$item[1]>0){
                    $data['min']=$item[1];
                }
                if($item[0]=='max'&&is_numeric($item[1])&&$item[1]>0){
                    $data['max']=$item[1];
                }
            }
        }
        return $data;
    }

} 