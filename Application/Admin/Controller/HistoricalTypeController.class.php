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


class HistoricalTypeController extends AdminController
{
    protected $historicalTypeModel;
    function _initialize()
    {
        $this->historicalTypeModel = D('Historical/HistoricalType');
        parent::_initialize();
    }

    public function index()
    {

        //显示页面
        $builder = new AdminTreeListBuilder();

        $tree = D('Historical/HistoricalType')->getTree(0, 'id,title,sort,pid,status');


        $builder->title('提案交办分类管理')
            ->buttonNew(U('HistoricalType/add'))
            ->data($tree)
            ->display();
    }

    public function add($id = 0, $pid = 0)
    {
        if (IS_POST) {
            if ($id != 0) {
                $historicaltype = $this->historicalTypeModel->create();
                if ($this->historicalTypeModel->save($historicaltype)) {

                    $this->success('编辑成功。');
                } else {
                    $this->error('编辑失败。');
                }
            } else {
	            $historicaltype = $this->historicalTypeModel->create();
                if ($this->historicalTypeModel->add($historicaltype)) {

                    $this->success('新增成功。');
                } else {
                    $this->error('新增失败。');
                }
            }

        } else {
            $builder = new AdminConfigBuilder();
	        $historicaltypes =$this->historicalTypeModel->select();
            $opt = array();
            foreach ($historicaltypes as $historicaltype) {
                $opt[$historicaltype['id']] = $historicaltype['title'];
            }
            if ($id != 0) {
	            $historicaltype = $this->historicalTypeModel->find($id);
            } else {
	            $historicaltype = array('pid' => $pid, 'status' => 1);
            }


            $builder->title('新增分类')->keyId()->keyText('title', '标题')->keySelect('pid', '父分类', '选择父级分类', array('0' => '顶级分类')+$opt)
                ->keyStatus()->keyCreateTime()->keyUpdateTime()
                ->data($historicaltype)
                ->buttonSubmit(U('Historical_type/add'))->buttonBack()->display();
        }

    }

    public function operate($type = 'move', $from = 0)
    {
        $builder = new AdminConfigBuilder();
        $from = D('historicaltype')->find($from);

        $opt = array();
        $types = $this->historicalTypeModel->select();
        foreach ($types as $meet) {
            $opt[$meet['id']] = $meet['title'];
        }
        if ($type === 'move') {

            $builder->title('移动分类')->keyId()->keySelect('pid', '父分类', '选择父分类', $opt)->buttonSubmit(U('historicaltype/add'))->buttonBack()->data($from)->display();
        } else {

            $builder->title('合并分类')->keyId()->keySelect('toid', '合并至的分类', '选择合并至的分类', $opt)->buttonSubmit(U('historicaltype/doMerge'))->buttonBack()->data($from)->display();
        }

    }

    public function doMerge($id, $toid)
    {
        $effect_count=D('Historical')->where(array('type_id'=>$id))->setField('type_id',$toid);
        D('historicaltype')->where(array('id'=>$id))->setField('status',-1);
        $this->success('合并分类成功。共影响了'.$effect_count.'个内容。',U('index'));
        //TODO 实现合并功能 issue
    }




    public function historicaltypeTrash($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => -1);
        $model = $this->historicalTypeModel;
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
