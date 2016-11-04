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


class ProposalController extends AdminController
{
    protected $proposalModel;

    function _initialize()
    {
        $this->proposalModel = D('Proposal/Proposal');
        parent::_initialize();
    }
    public function config()
    {
        $admin_config = new AdminConfigBuilder();
        $data = $admin_config->handleConfig();

        $admin_config->title('提案交办基本设置')
            ->keyBool('NEED_VERIFY', '创建提案交办是否需要审核','默认无需审核')
            ->buttonSubmit('', '保存')->data($data);
        $admin_config->display();
    }
    public function proposal($page = 1, $r = 10)
    {
        //读取列表
        $map = array('status' => 1);
        $model = $this->proposalModel;
        $list = $model->where($map)->page($page, $r)->select();
        unset($li);
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();

        $attr['class'] = 'btn ajax-post';
        $attr['target-form'] = 'ids';

        $builder->title('内容管理')
            ->setStatusUrl(U('setPollsContentStatus'))->buttonDisable('', '审核不通过')->buttonDelete()->button('设为推荐', array_merge($attr, array('url' => U('doRecommend', array('tip' => 1)))))->button('取消推荐', array_merge($attr, array('url' => U('doRecommend', array('tip' => 0)))))
            ->keyId()->keyLink('title', '标题', 'Proposal/Index/detail?id=###')->keyUid()->keyCreateTime()->keyStatus()->keyMap('is_recommend', '是否推荐', array(0 => '否', 1 => '是'))
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

    /**
     * 设置推荐or取消推荐
     * @param $ids
     * @param $tip
     * autor:xjw129xjt
     */
    public function doRecommend($ids, $tip)
    {
        D('Polls')->where(array('id' => array('in', $ids)))->setField('is_recommend', $tip);
        $this->success('设置成功', $_SERVER['HTTP_REFERER']);
    }

    /**
     * 审核页面
     * @param int $page
     * @param int $r
     * autor:xjw129xjt
     */
    public function verify($page = 1, $r = 10)
    {
        //读取列表
        $map = array('status' => 0);
        $model = $this->proposalModel;
        $list = $model->where($map)->page($page, $r)->select();
        unset($li);
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $attr['class'] = 'btn ajax-post';
        $attr['target-form'] = 'ids';
        $builder->title('审核内容')
            ->setStatusUrl(U('setPollsContentStatus'))->buttonEnable('', '审核通过')->buttonDelete()
            ->keyId()->keyLink('title', '标题', 'Polls/Index/detail?id=###')->keyUid()->keyCreateTime()->keyStatus()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

    /**
     * 设置状态
     * @param $ids
     * @param $status
     * autor:xjw129xjt
     */
    public function setPollsContentStatus($ids, $status)
    {
        $builder = new AdminListBuilder();
        if ($status == 1) {
            foreach ($ids as $id) {
                $content = D('Polls')->find($id);
                D('Common/Message')->sendMessage($content['uid'], "管理员审核通过了您发布的内容。现在可以在列表看到该内容了。", $title = '专辑内容审核通知', U('Polls/Index/detail', array('id' => $id)), is_login(), 2);
                /*同步微博*/
                $user = query_user(array('username', 'space_link'), $content['uid']);
                $weibo_content = '管理员审核通过了@' . $user['username'] . ' 的内容：【' . $content['title'] . '】，快去看看吧：' . "http://$_SERVER[HTTP_HOST]" . U('Polls/Index/detail', array('id' => $content['id']));
                $model = D('Weibo/Weibo');
                $model->addWeibo(is_login(), $weibo_content);
                /*同步微博end*/
            }

        }
        $builder->doSetStatus('Polls', $ids, $status);

    }

    /**
     * @param int $page
     * @param int $r
     */
    public function contentTrash($page = 1, $r = 10)
    {
        //读取微博列表
        $map = array('status' => -1);
        $model = D('Polls');
        $list = $model->where($map)->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('内容回收站')
            ->setStatusUrl(U('setPollsContentStatus'))->buttonRestore()
            ->keyId()->keyLink('title', '标题', 'Polls/Index/detail?id=###')->keyUid()->keyCreateTime()->keyStatus()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
   

	}



    /*
     * 盘点积分    清算  会议 活动的积分
     * status 2  为盘点信息标记 针对action_log表
     * author: MR.Z <327778155@qq.com>
     * crreate: 2016/09/26
     */
    public function makeScore(){
        //首先查找出所有的委员
        $m = D('User/User');
        $m->setModel(WEIYUAN);
        $users = $m->getUsers([],[]);


        foreach($users as $u){
            //盘点 出席区政协全体委员会议  积分 40  只有一次
            $meet_id_qh = D('Meet')->where(['meet_type'=>'全会'])->order('id desc')->getField('id');
            if($meet_id_qh){
                $qh = D('Attendance')->where(['record_id'=>$meet_id_qh,'type'=>'meet','uid'=>$u['uid']])->order('create_time desc')->find();
              /*  if($u['uid'] == 128){getsql();exit;}*/
                $y_mark_qh = $qh['y_mark'];
                $s_mark_qh = $qh['s_mark'];


            }
            $score_qh = $y_mark_qh ? (40 * $s_mark_qh / $y_mark_qh) : 0;

            //盘点 常委会 积分 20    有多次
            $meet_id_cwh = D('Meet')->where(['meet_type'=>'常委会'])->order('id desc')->getField('id',true);
            if($meet_id_cwh){
                $y_mark_cwh = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_cwh)],'type'=>'meet','uid'=>$u['uid']])->sum('y_mark');
                $s_mark_cwh = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_cwh)],'type'=>'meet','uid'=>$u['uid']])->sum('s_mark');


            }
            $score_cwh = $y_mark_cwh ? (20 * $s_mark_cwh / $y_mark_cwh) : 0;

            //盘点 参加区政协办公室、委员工作委员会组织的活动  会议 20
            $meet_id_qzx = D('Meet')->where(['meet_type'=>['in',['主席会','临时会','专题协商会']]])->order('id desc')->getField('id',true);
            if($meet_id_qzx){
                $y_mark_qzx_m = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_qzx)],'type'=>'meet','uid'=>$u['uid']])->sum('y_mark');
                $s_mark_qzx_m = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_qzx)],'type'=>'meet','uid'=>$u['uid']])->sum('s_mark');

                $event_id_qzx = D('Event')->where(['meet_type'=>['in',['区政协组织']]])->order('id desc')->getField('id',true);
                $y_mark_qzx_e = D('Attendance')->where(['record_id'=>['in',implode(',',$event_id_qzx)],'type'=>'event','uid'=>$u['uid']])->sum('y_mark');
                $s_mark_qzx_e = D('Attendance')->where(['record_id'=>['in',implode(',',$event_id_qzx)],'type'=>'event','uid'=>$u['uid']])->sum('s_mark');

            }
            $score_qzx = ($y_mark_qzx_m + $y_mark_qzx_e) ? (20 * ($s_mark_qzx_m + $s_mark_qzx_e) / ($y_mark_qzx_m + $y_mark_qzx_e)) : 0;
            //盘点 参加专委会（组）、街道联络委员会组织的活动 20

            $meet_id_zwhjdllw = D('Meet')->where(['meet_type'=>['in',['对口协商会','部门协商会','专委会','街道联络委会']]])->order('id desc')->getField('id',true);
            if($meet_id_zwhjdllw){
                $y_mark_zwhjdllw_m = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_zwhjdllw)],'type'=>'meet','uid'=>$u['uid']])->sum('y_mark');
                $s_mark_zwhjdllw_m = D('Attendance')->where(['record_id'=>['in',implode(',',$meet_id_zwhjdllw)],'type'=>'meet','uid'=>$u['uid']])->sum('s_mark');

                $event_id_zwhjdllw = D('Meet')->where(['meet_type'=>['in',['对口协商会','部门协商会','专委会','街道联络委会']]])->order('id desc')->getField('id',true);
                $y_mark_zwhjdllw_e = D('Attendance')->where(['record_id'=>['in',implode(',',$event_id_zwhjdllw)],'type'=>'event','uid'=>$u['uid']])->sum('y_mark');
                $s_mark_zwhjdllw_e = D('Attendance')->where(['record_id'=>['in',implode(',',$event_id_zwhjdllw)],'type'=>'event','uid'=>$u['uid']])->sum('s_mark');

            }
            $score_zwhjdllw = ($y_mark_zwhjdllw_m + $y_mark_zwhjdllw_e) ? (20 * ($s_mark_zwhjdllw_m + $s_mark_zwhjdllw_e) / ($y_mark_zwhjdllw_m + $y_mark_zwhjdllw_e)) : 0;

            $make_score = $score_qh + $score_cwh + $score_qzx + $score_zwhjdllw;


            $data['uid'] = $u['uid'];
            $data['make_score'] = $make_score;
            $flag = D('Member')->save( $data);
            $time = explode('~',C('STOCKTAK_DATE'));
            $msm = D('StocktakMeet');

            $map_sm['uid'] = $u['uid'];
            $map_sm['create_time'] = ['between',$time[0].','.$time[1]];

            $map_sm['type'] = 'qh';
            $qh_flag = $msm->where($map_sm)->find();
            $data_sm_qh['uid'] = $u['uid'];
            $data_sm_qh['type'] = 'qh';
            $data_sm_qh['mark']= $s_mark_qh;
            $data_sm_qh['score'] = $score_qh;
            $data_sm_qh['create_time'] = time();
            if($qh_flag){
                $msm->where($map_sm)->save($data_sm_qh);
            }else{
                $msm->add($data_sm_qh);
            }


            $map_sm['type'] = 'qzx';
            $qzx_flag = $msm->where($map_sm)->find();
            $data_sm_qzx['uid'] = $u['uid'];
            $data_sm_qzx['type'] = 'qzx';
            $data_sm_qzx['mark']= $s_mark_qzx_m + $s_mark_qzx_e;
            $data_sm_qzx['score'] = $score_qzx;
            $data_sm_qzx['create_time'] = time();
            if($qzx_flag){
                $msm->where($map_sm)->save($data_sm_qzx);
            }else{
                $msm->add($data_sm_qzx);
            }


            $map_sm['type'] = 'zwhjdllw';
            $zwhjdllw_flag = $msm->where($map_sm)->find();
            $data_sm_zwhjdllw['uid'] = $u['uid'];
            $data_sm_zwhjdllw['type'] = 'zwhjdllw';
            $data_sm_zwhjdllw['mark']= $s_mark_zwhjdllw_m + $s_mark_zwhjdllw_e;
            $data_sm_zwhjdllw['score'] = $score_zwhjdllw;
            $data_sm_zwhjdllw['create_time'] = time();
            if($zwhjdllw_flag){
                $msm->where($map_sm)->save($data_sm_zwhjdllw);
            }else{
                $msm->add($data_sm_zwhjdllw);
            }




        }

            $this->success('盘点积分更新完成');

        /*//   if(IS_POST){
              $map_a['is_make'] = ['eq',1];
              $actions =  D('Action')->where($map_a)->getField('id', 'rule');
              $start_time = time();
              $end_time = time();
          //测试设置is_make 为1
              $map_al['model'] = 'proposal';
              $map_al['is_make'] = ['eq',0];
           //   $map_al['create_time'] = ['between',$start_time.','.$end_time];

              $data = D('ActionLog')->where($map_al)->group('record_id,action_id')->order('create_time desc')->select();

         18 出席区政协全体委员会议
          19 参加专委会（组）、街道联络委员会组织的活动
          43 参加区政协办公室、委员工作委员会组织的活动
          当前只有这三个行为是需要手工盘点积分


          $action_arr = [18,43,19];
          $mu = D('User/User');
          $mu->setModel(WEIYUAN);
          $uids = $mu->getUsers();



          $total_18 = S('total_18');
          $total_19 = S('total_19');
          $total_43 = S('total_43');
          foreach($uids as $v){
              $rule_18 = parse_action(18,$v['uid']);
              $rule_43 = parse_action(43,$v['uid']);
              $rule_19 = parse_action(19,$v['uid']);
              $map_u['user_id'] = $v['uid'];
              $map_u['action_id'] = 18;
              $count_18 =  M('ActionLog')->where($map_u)->count();
              $map_u['action_id'] = 19;
              $count_19 =  M('ActionLog')->where($map_u)->count();
              $map_u['action_id'] = 43;
              $count_43 =  M('ActionLog')->where($map_u)->count();

              $score_18 = 40 * ($count_18/$total_18);

              $score_19 = 20 * ($count_19/$total_19);

              $score_43 = 20 * ($count_43/$total_43);

              $make_score = $score_18 + $score_19 + $score_43;

              //清除之前的盘点积分
             M('Member')->where('uid='.$v['uid'])->setDec('score','make_score');

              M('Member')->where('uid='.$v['uid'])->save(['make_score'=>0]);


              $data['uid'] = $v['uid'];
              $data['make_score'] = $make_score;
              M('Member')->save($data);

          }*/



        //   }
    }
}
