<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Wap\Widget;

use Think\Action;

/**
 * 分类widget
 * 用于动态调用分类信息
 */
class ProposalWidget extends Action
{

    /* 显示指定分类的同级分类或子分类列表 */
    public function menumark()
    {
        $this->menu_mark();

        $this->display('Widget/menumark');

    }

  /*
   * 搜索页面
   * create: 2016/10/8
   * author: MR.Z <327778155@qq.com>
   */
  public function search(){
      $this->display('Widget/proposal_search');
  }

    /*
  * 为当前的module controller action param 给个标记
  *  author: MR.Z <327778155@qq.com>
  *  create: 2016/09/24
  */
    private function  menu_mark(){
        $param = implode('-',I('get.'));
        $module = MODULE_NAME;
        $controller = CONTROLLER_NAME;
        $action = ACTION_NAME;
        $this->assign('menu_mark', array_filter(str2arr($module.','.$controller.','.$action.','.$param,',')));
    }
}
