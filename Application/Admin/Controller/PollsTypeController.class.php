<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-11
 * Time: PM5:41
 */

namespace Admin\Controller;

use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminTreeListBuilder;


class PollsTypeController extends AdminController
{
    protected $pollsTypeModel;
    function _initialize()
    {
        $this->pollsTypeModel = D('Polls/PollsType');
        parent::_initialize();
    }

    public function index()
    {

        //显示页面
        $builder = new AdminTreeListBuilder();

        $tree = D('Polls/PollsType')->getTree(0, 'id,title,sort,pid,status');


        $builder->title('社情民意分类管理')
            ->buttonNew(U('PollsType/add'))
            ->data($tree)
            ->display();
    }

    public function add($id = 0, $pid = 0)
    {
        if (IS_POST) {
            if ($id != 0) {
                $pollstype = $this->pollsTypeModel->create();
                if ($this->pollsTypeModel->save($pollstype)) {

                    $this->success('编辑成功。');
                } else {
                    $this->error('编辑失败。');
                }
            } else {
	            $pollstype = $this->pollsTypeModel->create();
                if ($this->pollsTypeModel->add($pollstype)) {

                    $this->success('新增成功。');
                } else {
                    $this->error('新增失败。');
                }
            }

        } else {
            $builder = new AdminConfigBuilder();
	        $pollstypes =$this->pollsTypeModel->select();
            $opt = array();
            foreach ($pollstypes as $pollstype) {
                $opt[$pollstype['id']] = $pollstype['title'];
            }
            if ($id != 0) {
	            $pollstype = $this->pollsTypeModel->find($id);
            } else {
	            $pollstype = array('pid' => $pid, 'status' => 1);
            }


            $builder->title('新增分类')->keyId()->keyText('title', '标题')->keySelect('pid', '父分类', '选择父级分类', array('0' => '顶级分类')+$opt)
                ->keyStatus()->keyCreateTime()->keyUpdateTime()
                ->data($pollstype)
                ->buttonSubmit(U('polls_type/add'))->buttonBack()->display();
        }

    }

    public function operate($type = 'move', $from = 0)
    {
        $builder = new AdminConfigBuilder();
        $from = D('pollstype')->find($from);

        $opt = array();
        $types = $this->pollsTypeModel->select();
        foreach ($types as $meet) {
            $opt[$meet['id']] = $meet['title'];
        }
        if ($type === 'move') {

            $builder->title('移动分类')->keyId()->keySelect('pid', '父分类', '选择父分类', $opt)->buttonSubmit(U('pollstype/add'))->buttonBack()->data($from)->display();
        } else {

            $builder->title('合并分类')->keyId()->keySelect('toid', '合并至的分类', '选择合并至的分类', $opt)->buttonSubmit(U('pollstype/doMerge'))->buttonBack()->data($from)->display();
        }

    }

    public function doMerge($id, $toid)
    {
        $effect_count=D('Polls')->where(array('type_id'=>$id))->setField('type_id',$toid);
        D('pollstype')->where(array('id'=>$id))->setField('status',-1);
        $this->success('合并分类成功。共影响了'.$effect_count.'个内容。',U('index'));
        //TODO 实现合并功能 issue
    }




    public function pollstypeTrash($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => -1);
        $model = $this->pollsTypeModel;
        $list = $model->where($map)->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('社情民意类型回收站')
            ->setStatusUrl(U('setStatus'))->buttonRestore()
            ->keyId()->keyText('title', '标题')->keyStatus()->keyCreateTime()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

}
