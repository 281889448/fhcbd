<?php


namespace History\Controller;
use Common\Controller\BaseController;
use History\Model\HistorytModel;
use History\Model\Polls_historytModel;

use Weibo\Api\WeiboApi;

class IndexController extends BaseController
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree = D('HistoryType')->select();
        $this->assign('tree', $tree);
        
        $sub_menu =
            array(
                'left' =>
                    array(
                        array('tab' => 'home', 'title' => '首页', 'href' => U('meet/index/index')),
                        array('tab' => 'mymeet', 'title' => '我的会议', 'href' => U('meet/index/mymeet')),
                    ),
            );
        $this->assign('sub_menu', $sub_menu);
        $this->assign('current', 'home');
    }

    //主页面显示
    public function index(){

        $status =I('get.status');
        $work = D('History'); // 实例化User对象
        if(IS_POST){
            $type 	= I('post.type');
            $author	=I("post.author");
            $stime 	= I('post.stime');
            $status = I('post.status');
            $etime= I('POST.etime');

            $map['time'] = array('gt',$stime);
            $map['type'] = array('eq',$type);
            $map['author'] = array('eq',$author);
            $map['status'] = array('eq',$status);
            $map['time'] = array('le',$etime);
            $map = array_filter($map);

        }
        $map['status'] = array('in',$status);
        $count= $work->where($map)->count();
        $Page= new \Think\Page($count,10);
        $content = $work->where($map)->order('id asc')->limit($Page->firstRow.','.$Page->listRows)->select();
        $this->assign('content',$content);
        $this->assign('page',$Page->show());
        $this->display();
    }

   //未提交状态的删除
    public function remove($id){

        $app=D("History")->where(array('id' => $id))->delete();
        if ($app>0){
            $this->success("删除成功");
        }else{
            $this->error("删除失败","{:U('Event/Index/index')}");
        }

    }
    


    public function detail($id){
        $content=D('History')->where("id={$id}")->find();
        $this->assign('content',$content);
        $this->display();
    }


//查看编辑未提交文史
    public function edit($id)
    {
        $his = D('History')->where(array('id' => $id))->find();
        $this->assign('his',$his);
        $this->display();
    }


    //修改未提交的文史
    public function save($id)
{
    $model =D('History');
    $data=I('post.');
    $data['status']=2;
    $resaut=$model->where(array('id' => $id))->save($data);
        if($resaut){
            $this->success('提交成功');
        }else{
            $this->error('提交失败');
        }
    }
    

    //审核成功
    public function save1($id,$adopt='')
    {
        if (trim(op_t($adopt)) == '') {
        $this->error('采用情况不能为空');
    }
        $model =D('History');
        $data=I('post.');
        $data['status']=4;
        $re=$model->where(array('id' => $id))->save($data);

            if($re)
        {
            $this->success("审核成功");
        }else{
            $this->error("审核失败");
        }
    }
//退回后从新提交
    public function save2($id,$adopt='')
    {
        $model =D('History');
        $data=I('post.');
        $data['status']=2;
        if($model->where(array('id' => $id))->save($data)) {
            $this->success("提交成功");
        }else{
            $this->error("提交失败");
        }
    }
    //查看已提交状态
public function show($id){
    $model=D('History');
    $tw = $model->where(array('id' => $id))->find();
    $this->assign('tw',$tw);
    $this->display();
}
    //查看已通过审核详情页
    public function show1($id){
        $fou = D('History')->where(array('id' => $id))->find();
        $this->assign('fou',$fou);
        $this->display();
    }

    public function show2($id){
        $thr = D('History')->where(array('id' => $id))->find();
        $this->assign('thr',$thr);
        $this->display();
    }
//提交文史资料
    public function upload($type='',$title ='', $time = '',$remake='',$id=0)
    {
        if (trim(op_t($type)) == '') {
            $this->error('请输入发言类别。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入发言或者报告题目。');
        }
        if (trim(op_t($time)) == '') {
            $this->error('请输入时间。');
        }
        if (trim(op_t($remake)) == '') {
            $this->error('请输入备注内容。');
        }

        import("ORG.Net.UploadFile");
        $upload=new \Think\Upload();
        //设置大小
        $upload->Maxsize=1000000;
        //设置格式
        $upload->exts=array();
        $upload->savePath="/Uploads/Download/";
        if ($upload->upload()){
            $this->success('上传成功！');
        }else{

        }
        $data=I('post.');
        $model=D('History');
        if($id){
            $flag=$model->save($data);
        }else{
            $flag = $model->add($data);
        }
        if ($flag == null) {
            $this->error("添加失败");
        }else{
            $this->success("添加成功");
        }

    }

    //添加页面直接提交
    public function inseter($id=0)
    {
        if (IS_POST) {
            //如果接收到了post请求，就添加数据
            $model = D('History');
            $data = I('post.');
            $data['status']=2;
            if ($id) {
                $flag = $model->save($data);
            } else {
                $flag = $model->add($data);
            }
            if ($flag) {
                return $this->ajaxReturn('1');
            } else {
                return $this->ajaxReturn($model->getError());
            }
        }
    }


    public function add(){
        $time=date('Y-m-d H:i:s');
        $this->assign('time',$time);
        $this->display();
    }



  /*  public function search(){
        //接收
        $type 	= I('post.type');
        $author	=I("post.author");
        $stime 	= I('post.stime');
        $status = I('post.status');
        $etime= I('POST.etime');

        //判断是否有值
        if(!empty($author)){
            $where['author']=$author;
        };
        if(!empty($type)){
            $where['type']=$type;
        };
        if(!empty($stime)&&!empty($etime)){
            $where['time'] =array(array('egt',$stime),array('elt',$etime));
        }elseif(!empty($stime)){
            $where['time'] =array('egt',$stime);
        }elseif(!empty($etime)){
            $where['time'] =array('elt',$etime);
        }
        if($status||$status=='0'){
            $where['status']=$status;
        };

        //实例化模型
        $model=D('History');
        //查询
        $re=$model->where($where)->select();
        $this->assign('uid',$uid);
        $this->assign('type',$type);
        $this->assign('status',$status);
        $this->assign('stime',$stime);
        $this->assign('etime',$etime);
        $this->assign('re', $re);
        $this->display();
    }*/

    public function qdadd(){
        $this->display();
    }

}