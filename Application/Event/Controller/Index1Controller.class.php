<?php


namespace Event\Controller;

use Think\Controller;
use Common\Api\WeixinApi;
use Weibo\Api\WeiboApi;
use User\Model\User;
class Index1Controller extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree = D('EventType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);

        $sub_menu =
            array(
                'left' =>
                    array(
                        array('tab' => 'home', 'title' => '首页', 'href' => U('event/index/index')),
                        array('tab' => 'myevent', 'title' => '我的活动', 'href' => U('event/index/myevent')),
                    ),
            );
        $this->assign('sub_menu', $sub_menu);
        $this->assign('current', 'home');
    }

    /**
     * 活动首页
     *
     *
     * @param int $page
     * @param int $type_id
     * @param string $norh
     * autor:xjw129xjt
     */
    public function index()
    {
        if (IS_POST) {
            $map['title'] = array('like', '%' . $_POST['keyword'] . '%');
            $event = D("event")->where($map)->order('id desc')->select();
            $this->assign("lockback", 1);
        } else {
            $event = D("event")->order('id desc')->select();
        }
        $this->assign("event", $event);
        $this->display();

    }

 

}