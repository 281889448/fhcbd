<?php
 // 分析枚举类型字段值 格式 a:名称1,b:名称2
 // 暂时和 parse_config_attr功能相同
 // 但请不要互相使用，后期会调整
 //解析模型字段
function parse_field_attr($string) {
    if(0 === strpos($string,':')){
        // 采用函数定义
        return   eval(substr($string,1).';');
    }
    $array = preg_split('/[,;\r\n]+/', trim($string, ",;\r\n"));
    if(strpos($string,':')){
        $value  =   array();
        foreach ($array as $val) {
            list($k, $v) = explode(':', $val);
            $value[$k]   = $v;
        }
    }else{
        $value  =   $array;
    }
    return $value;
}

/*
 * //提案流程录入
*	16-8-8
*	MR.Z <327778155@qq.com>
 * $model 模型名称
 * $user_id 执行人ID
 * $action 操作命令
 * $proposal_id 操作的文件id
*/

function process_log( $action = null,$model = null, $proposal_id = null, $user_id = null,$record_id)
{
		
    //参数检查
    if ( empty($proposal_id)) {
        return '参数不能为空';
    }
    if (empty($user_id)) {
        $user_id = get_uid();
    }

    $suggest = I('post.suggest');
		$m = D('Proposal');
		$mr = D('ProposalResult');
		$mj = D('ProposalJoint');
		//获取当前提案信息
		$proposal = $m->find($proposal_id);
		// 获取当前提案人的信息
		$mu = D('User/User');

    $group = get_permission($proposal['uid'],['集体'])? TEAM : WEIYUAN;

		$mu->setModel($group);
		$proposal_user = $mu->getUser($proposal['uid']);
	
		//执行人相关信息
		$do_u = array('5'=>WEIYUAN,'6'=>TEAM,'8'=>UNIT);
		$group_id = D('Member')->alias('m')->join('__AUTH_GROUP_ACCESS__ aga ON m.uid=aga.uid')->where('m.uid='.$user_id)->getField('group_id');

		$mu->setModel($do_u[$group_id]);
		$do_user = $mu->getUser($user_id);
		$do_user['名称'] = $do_user['名称'] ?  $do_user['名称'] : $do_user['nickname'];
	
		switch(strtolower($model)){
			case 'proposal':
				
				break;
			case 'proposalresult':
				$result = $mr->find($record_id);
				$result_user = $mu->getUser($result['user_id']);
				break;
			case 'proposaljoint':
	
	
				$joint = $mj->find($record_id);
		}
	
		$data['suggest'] = $suggest;
		switch(strtolower($model)){
			case 'proposal':
				$data['user_id'] = $user_id;
				$data['proposal_id'] = $proposal_id;
				$data['create_time'] = NOW_TIME;
                    //默认取第一个身份
				$data['group'] = reset(get_group($user_id));
				$data['to_status'] = $proposal['status'];

				switch(strtolower($action)){
					
					case 'dopost':
						$data['remark'] = "提案人【{$do_user['名称']}】向提案委提交了预案号【{$proposal['ycode']}】，案由【{$proposal['title']}】的提案";
						break;
				//被联名操作
					case 'joint_agree':
						

						$status = $joint['is_agree'] == 1 ? '同意':'不同意';
						$data['remark'] = "委员【{$do_user['名称']}】对提案人【{$proposal_user['名称']}】，案由【{$proposal['title']}】的提案执行{$status}联名操作";
						break;
						
					case 'changestatus':
						$status = C('PROPOSAL_STATUS');
						
						//已交办，重回重办，结案
						if(in_array($proposal['status'],array(19,14,9))) {
							
						//	$unit = D('User/Unit')->getUnit($user_id);

							$data['remark'] = "政府督查室【{$do_user['名称']}】对办理单位【{$result['单位']}】，提案人【{$proposal['名称']}】，预案号【{$proposal['ycode']}】,案由【{$proposal['title']}】的提案执行了{$status[$proposal['status']]}操作";
								//立案/退回/不立案/撤案/委员来信/不再管辖区
						}elseif(in_array($proposal['status'],array(3,4,5,6,7,8))){
							$data['remark'] = "提案委【{$do_user['nickname']}】对提案人【{$proposal_user['名称']}】，预案号【{$proposal['ycode']}】,案由【{$proposal['title']}】的提案执行了{$status[$proposal['status']]}操作";
						}
						break;
					case 'merge':
						$proposal_merge = $m->find($proposal['merge_id']);
						$mu->setModel(WEIYUAN);
						$merge_user = $mu->getUser($proposal_merge['user_id']);
						
						$data['remark'] = "提案委【{$do_user['nickname']}】将提案人【{$proposal_user['名称']}】，预案号【{$proposal['ycode']}】,案由【{$proposal['title']}】的提案合并到提案人【{$merge_user['名称']}】，预案号【{$proposal_merge['ycode']}】,案由【{$proposal_merge['title']}】的提案";
						break;
					
				
					
				}
				
				M('ProposalProcess')->add($data);
				break;
			case 'proposalresult':
				$data['user_id'] = $user_id;
				$data['proposal_id'] = $proposal_id;
				$data['create_time'] = NOW_TIME;
                //默认取第一个身份
				$data['group'] = reset(get_group($user_id));
				$data['to_status'] = $proposal['status'];
                $data['result_id'] = $record_id;
				switch(strtolower($action)){
					case 'handover':
						
						$data['proposal_id'] = $proposal['id'];

						$data['to_status'] = 193;
						$data['remark'] = "办理单位【{$do_user['名称']}】对提案人【{$proposal_user['名称']}】，案号【{$proposal['code']}】,案由【{$proposal['title']}】的提案执行了移交办理操作";
						break;
					case 'handreply':
						
						$data['remark'] = "办理单位【{$do_user['名称']}】对提案人【{$proposal_user['名称']}】，案号【{$proposal['code']}】,案由【{$proposal['title']}】的提案执行了办理反馈操作";
						break;
					case 'handagain':
						

						$data['remark'] = "政府督查室【{$do_user['名称']}】对办理单位【{$result_user['名称']}】，案号【{$proposal['code']}】,案由【{$proposal['title']}】的提案执行了办理反馈操作";
						break;

                    case 'denyback':
                       
                        $data['to_status'] = 193;
                        $data['remark'] = "政府督查室【{$do_user['名称']}】对办理单位【{$proposal_user['名称']}】，案号【{$proposal['code']}】,案由【{$proposal['title']}】的提案执行了拒绝退回操作";
                        break;
				}
				
				M('ProposalProcess')->add($data);

				break;
					
				
				
				//插入行为日志
				
			

				break;
			case 'event':
				
				break;
			case 'polls':
				
				break;
			case 'survey':
				
				break;
			case 'historical':
				
				break;
			case 'meet':
				
				break;
			
		}
	

		


}


function int_to_string(&$data,$map=array('status'=>array(1=>'正常',-1=>'删除',0=>'禁用',2=>'未审核',3=>'草稿'))) {
	if($data === false || $data === null ){
		return $data;
	}
	$data = (array)$data;
	foreach ($data as $key => $row){
		foreach ($map as $col=>$pair){
			if(isset($row[$col]) && isset($pair[$row[$col]])){
				$data[$key][$col.'_text'] = $pair[$row[$col]];
			}
		}
	}
	return $data;
}


/**
 * 根据HTML代码获取word文档内容
 * 创建一个本质为mht的文档，该函数会分析文件内容并从远程下载页面中的图片资源
 * 该函数依赖于类MhtFileMaker
 * 该函数会分析img标签，提取src的属性值。但是，src的属性值必须被引号包围，否则不能提取
 *
 * @param string $content HTML内容
 * @param string $absolutePath 网页的绝对路径。如果HTML内容里的图片路径为相对路径，那么就需要填写这个参数，来让该函数自动填补成绝对路径。这个参数最后需要以/结束
 * @param bool $isEraseLink 是否去掉HTML内容中的链接
 */
function getWordDocument( $content , $absolutePath = "" , $isEraseLink = true )
{	//@import("Org.Util.MhtFileMaker");
	
	$mht = new \Vendor\MhtFileMaker();
	
	if ($isEraseLink)
		$content = preg_replace('/<a\s*.*?\s*>(\s*.*?\s*)<\/a>/i' , '$1' , $content);   //去掉链接
	//$content = "<xml><w:WordDocument><w:View>Print</w:View>< /xml>".$content;
	$images = array();
	$files = array();
	$matches = array();
	//这个算法要求src后的属性值必须使用引号括起来
	if ( preg_match_all('/<img[.\n]*?src\s*?=\s*?[\"\'](.*?)[\"\'](.*?)\/>/i',$content ,$matches ) )
	{
		$arrPath = $matches[1];
		for ( $i=0;$i<count($arrPath);$i++)
		{
			$path = $arrPath[$i];
			$imgPath = trim( $path );
			if ( $imgPath != "" )
			{
				$files[] = $imgPath;
				if( substr($imgPath,0,7) == 'http://')
				{
					//绝对链接，不加前缀
				}
				else
				{
					$imgPath = $absolutePath.$imgPath;
				}
				$images[] = $imgPath;
			}
		}
	}
	$mht->AddContents("tmp.html",$mht->GetMimeType("tmp.html"),$content);
	
	for ( $i=0;$i<count($images);$i++)
	{
		$image = $images[$i];
		if ( @fopen($image , 'r') )
		{
			$imgcontent = @file_get_contents( $image );
			if ( $content )
				$mht->AddContents($files[$i],$mht->GetMimeType($image),$imgcontent);
		}
		else
		{
			echo "file:".$image." not exist!<br />";
		}
	}
	
	return $mht->GetFile();
}

?>