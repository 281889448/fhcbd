<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-6-18
 * Time: 上午10:07
 * @author MR.Z <327778155@qq.com>
 */
namespace Admin\Controller;

use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminTreeListBuilder;

use Think\Model;

/**
 * Class ShopController
 * @package Admin\controller
 * @author MR.Z <327778155@qq.com>
 */
class AnnounceController extends AdminController
{

    protected $announceModel;
    protected $announce_configModel;


    function _initialize()
    {
        $this->announceModel = D('Announce/Announce');

        parent::_initialize();
    }



    /**
     * 设置公告状态：删除=-1，禁用=0，启用=1
     * @param $ids
     * @param $status
     * @author MR.Z <327778155@qq.com>
     */
    public function setStatus($ids, $status)
    {
        $builder = new AdminListBuilder();
        $builder->doSetStatus('Announce', $ids, $status);
    }

    /**公告列表
     * @param int $page
     * @param int $r
     * @author MR.Z <327778155@qq.com>
     */
    public function lists($page = 1, $r = 20)
    {
       $map['status'] = array('neq',-1);
        $announceList = $this->announceModel->where($map)->order('addtime desc')->page($page, $r)->select();
        $totalCount = $this->announceModel->where($map)->count();
        $builder = new AdminListBuilder();
        $builder->title('公告列表');
        $builder->meta_title = '公告列表';

        unset($val);
        $builder->buttonNew(U('Announce/Edit'))->buttonDelete(U('setStatus'))->setStatusUrl(U('setStatus'));
        $builder->keyId()->keyLink('title', '标题', 'Announce/edit?id=###')->keyCreateTime('addtime')->keyText('hits', '查阅数')->keyStatus()->keyDoActionEdit('Announce/edit?id=###');
        $builder->data($announceList);
        $builder->pagination($totalCount, $r);
        $builder->display();
    }

   

    /**公告回收站
     * @param int $page
     * @param int $r
     * @author MR.Z <327778155@qq.com>
     */
    public function trash($page = 1, $r = 10,$model='')
    {
        $builder = new AdminListBuilder();
        $builder->clearTrash($model);
        //读取微博列表
        $map = array('status' => -1);
        $goodsList = $this->announceModel->where($map)->order('addtime desc')->page($page, $r)->select();
        $totalCount = $this->announceModel->where($map)->count();

        //显示页面

        $builder->title('公告回收站')
            ->setStatusUrl(U('setStatus'))->buttonRestore()->buttonClear('Announce/Announce')
            ->keyId()->keyLink('title', '标题', 'Announce/edit?id=###')->keyCreateTime()->keyStatus()
            ->data($goodsList)
            ->pagination($totalCount, $r)
            ->display();
    }

    /**
     * @param int $id
     * @param $goods_name
     * @param $goods_ico
     * @param $goods_introduct
     * @author MR.Z <327778155@qq.com>
     */
    public function edit($id=0, $title = '', $content = '')
    {	
        $isEdit = $id ? 1 : 0;
        if (IS_POST) {
            if ($title == '' || $title == null) {
                $this->error('请输入公告名称');
            }
           
            $data['title'] = $title;
            
            $data['content'] = $content;
           

			 $data['status'] = 1;
            $data['updatetime'] = time();
            if ($isEdit) {
                $rs = $this->announceModel->where('id=' . $id)->save($data);
            } else {
                //公告名存在验证
              
                $map['title'] = $title;
                if ($this->announceModel->where($map)->count()) {
                    $this->error('已存在同名公告');
                }

                $data['addtime'] = time();
                $rs = $this->announceModel->add($data);
            }
            if ($rs) {
                $this->success($isEdit ? '编辑成功' : '添加成功', U('Announce/lists'));
            } else {
                $this->error($isEdit ? '编辑失败' : '添加失败');
            }
        } else {
            $builder = new AdminConfigBuilder();
            $builder->title($isEdit ? '编辑公告' : '添加公告');
            $builder->meta_title = $isEdit ? '编辑公告' : '添加公告';


  
            $builder->keyId()->keyText('title', '公告名称')->keyEditor('content', '公告详情');
            if ($isEdit) {
                $data = $this->announceModel->where('id=' . $id)->find();
                $builder->data($data);
                $builder->buttonSubmit(U('Announce/edit'));
                $builder->buttonBack();
                $builder->display();
            } else {
                $data['status'] = 1;
                $builder->buttonSubmit(U('Announce/edit'));
                $builder->buttonBack();
                $builder->data($data);
                $builder->display();
            }
        }
    }

    

   

}
