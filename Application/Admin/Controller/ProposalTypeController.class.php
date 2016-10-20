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


class ProposalTypeController extends AdminController
{
    protected $proposalTypeModel;
    function _initialize()
    {
        $this->proposalTypeModel = D('Proposal/ProposalType');
        parent::_initialize();
    }

    public function index()
    {

        //显示页面
        $builder = new AdminTreeListBuilder();

        $tree = D('Proposal/ProposalType')->getTree(0, 'id,title,sort,pid,status');


        $builder->title('提案交办分类管理')
            ->buttonNew(U('ProposalType/add'))
            ->data($tree)
            ->display();
    }

    public function add($id = 0, $pid = 0)
    {
        if (IS_POST) {
            if ($id != 0) {
                $proposaltype = $this->proposalTypeModel->create();
                if ($this->proposalTypeModel->save($proposaltype)) {

                    $this->success('编辑成功。');
                } else {
                    $this->error('编辑失败。');
                }
            } else {
	            $proopsaltype = $this->proposalTypeModel->create();
                if ($this->proposalTypeModel->add($proopsaltype)) {

                    $this->success('新增成功。');
                } else {
                    $this->error('新增失败。');
                }
            }

        } else {
            $builder = new AdminConfigBuilder();
	         $proposaltypes =$this->proposalTypeModel->select();
            $opt = array();
            foreach ($proposaltypes as $proposaltype) {
                $opt[$proposaltype['id']] = $proposaltype['title'];
            }
            if ($id != 0) {
	            $proposaltype = $this->proposalTypeModel->find($id);
            } else {
	            $proposaltype = array('pid' => $pid, 'status' => 1);
            }


            $builder->title('新增分类')->keyId()->keyText('title', '标题')->keySelect('pid', '父分类', '选择父级分类', array('0' => '顶级分类')+$opt)
                ->keyStatus()->keyCreateTime()->keyUpdateTime()
                ->data($proposaltype)
                ->buttonSubmit(U('proposal_type/add'))->buttonBack()->display();
        }

    }

    public function operate($type = 'move', $from = 0)
    {
        $builder = new AdminConfigBuilder();
        $from = D('proposaltype')->find($from);

        $opt = array();
        $types = $this->proposalTypeModel->select();
        foreach ($types as $meet) {
            $opt[$meet['id']] = $meet['title'];
        }
        if ($type === 'move') {

            $builder->title('移动分类')->keyId()->keySelect('pid', '父分类', '选择父分类', $opt)->buttonSubmit(U('proposalTypeModel/add'))->buttonBack()->data($from)->display();
        } else {

            $builder->title('合并分类')->keyId()->keySelect('toid', '合并至的分类', '选择合并至的分类', $opt)->buttonSubmit(U('proposalTypeModel/doMerge'))->buttonBack()->data($from)->display();
        }

    }

    public function doMerge($id, $toid)
    {
        $effect_count=D('Polls')->where(array('type_id'=>$id))->setField('type_id',$toid);
        D('ProposalTypeModel')->where(array('id'=>$id))->setField('status',-1);
        $this->success('合并分类成功。共影响了'.$effect_count.'个内容。',U('index'));
        //TODO 实现合并功能 issue
    }




    public function proposaltypeTrash($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => -1);
        $model = $this->proposalTypeModel;
        $list = $model->where($map)->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('提案交办类型回收站')
            ->setStatusUrl(U('setStatus'))->buttonRestore()
            ->keyId()->keyText('title', '标题')->keyStatus()->keyCreateTime()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

}
