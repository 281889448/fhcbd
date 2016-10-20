/*
Navicat MySQL Data Transfer

Source Server         : 测试服务器
Source Server Version : 50714
Source Host           : 120.76.72.51:3306
Source Database       : lxlz

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2016-09-13 18:30:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for thinkox_action
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_action`;
CREATE TABLE `thinkox_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of thinkox_action
-- ----------------------------
INSERT INTO `thinkox_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `thinkox_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `thinkox_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `thinkox_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一个微博。\r\n表[model]，记录编号[record]。', '1', '0', '1394866289');
INSERT INTO `thinkox_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `thinkox_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `thinkox_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `thinkox_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `thinkox_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `thinkox_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `thinkox_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');
INSERT INTO `thinkox_action` VALUES ('13', 'add_weibo', '发微博', '积分+2，金币+1，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+2|cycle:24|max:5|tox_money_rule:tox_money+1|tox_money_field:tox_money', '', '1', '1', '1408935799');
INSERT INTO `thinkox_action` VALUES ('14', 'add_weibo_comment', '微博评论', '积分+1，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+1|cycle:24|max:5', '', '1', '1', '1396342907');
INSERT INTO `thinkox_action` VALUES ('15', 'add_post', '发帖子', '积分+3，金币+1，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+3|cycle:24|max:5|tox_money_rule:tox_money+1|tox_money_field:tox_money', '', '1', '1', '1408935783');
INSERT INTO `thinkox_action` VALUES ('16', 'add_post_reply', '发帖子回复', '积分+1，每天上限5次，', 'table:member|field:score|condition:uid={$self}|rule:score+1|cycle:24|max:5', '', '1', '1', '1408935759');
INSERT INTO `thinkox_action` VALUES ('17', 'weiyuan_basic_proposal_add', '提出一份提案', '基础分，会员当年提出一份提案，即可加10分，不重复加分', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:1', '委员{user}在{time}成功提交了一份提案。', '1', '1', '1471675790');
INSERT INTO `thinkox_action` VALUES ('18', 'weiyuan_basic_meet_all', '出席区政协全体委员会议', '出席区政协全体委员会议，每次+10分，最高40分', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:4', '{user}出席了会议', '1', '1', '1471675816');
INSERT INTO `thinkox_action` VALUES ('19', 'weiyuan_basic_event_join', '参加专委会（组）、街道联络委员会组织的活动', '参加会议、活动的得分按“分值×出勤率”计算', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:8760|max:2', '{user}参加了活动', '2', '1', '1470815065');
INSERT INTO `thinkox_action` VALUES ('20', 'weiyuan_basic_polls_add', '反映一条社情民意或提出一条建议', '反映一条社情民意或提出一条建议 +10分', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:1', '{user}反应了一条社情民意', '1', '1', '1471675823');
INSERT INTO `thinkox_action` VALUES ('21', 'weiyuan_basic_meet_cw', '常委出席历次常委会活动', '常委出席历次常委会活动 +5分，最高20分', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:4', '{user}出席了常委会议', '1', '1', '1471675829');
INSERT INTO `thinkox_action` VALUES ('22', 'weiyuan_proposal_do', '提出提案并立案', '多件提案，可累计加分，每次2分，最多加20分；', 'table:member|field:score|condition:uid={$self}|rule:score+2|cycle:END_DATE|max:10', '{user}提出的提案被立案了', '1', '1', '1471675842');
INSERT INTO `thinkox_action` VALUES ('23', 'weiyuan_proposal_important', '被确定为重点提案', '被确定为重点提案，每次+8分，无上限', 'table:member|field:score|condition:uid={$self}|rule:score+8|cycle:END_DATE|max:999', '{user}的提案被确定为重点提案', '1', '1', '1471675853');
INSERT INTO `thinkox_action` VALUES ('24', 'weiyuan_proposal_good', '被评选为优秀提案', '被确定为优秀提案，每次+10分，无上限', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:999', '{user}的提案被确定为优秀提案', '1', '1', '1471675859');
INSERT INTO `thinkox_action` VALUES ('25', 'weiyuan_proposal_advise', '被确定为建议案', '被确定为建议案，每次+15分，无上限', 'table:member|field:score|condition:uid={$self}|rule:score+15|cycle:END_DATE|max:999', '{user}的提案被确定为建议案', '1', '1', '1471675865');
INSERT INTO `thinkox_action` VALUES ('26', 'weiyuan_polls_adopt_q', '被区政协采用', '被区政协采用，每次2分，不重复加分', 'table:member|field:score|condition:uid={$self}|rule:score+2|cycle:END_DATE|max:1', '{user}的建议{record}被被区政协采用', '1', '1', '1471675877');
INSERT INTO `thinkox_action` VALUES ('27', 'weiyuan_polls_adopt_s', '被市委、市政协或市级新闻媒体采用', '被市委、市政协或市级新闻媒体采用,每次+8分，不重复加分', 'table:member|field:score|condition:uid={$self}|rule:score+8|cycle:END_DATE|max:1', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1', '1471675884');
INSERT INTO `thinkox_action` VALUES ('28', 'weiyuan_polls_adopt_shen', '被省委、省政协或省级新闻媒体采用', '被省委、省政协或省级新闻媒体采用,+10分', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:99', '{user}的建议{record}被省委、省政协或省级新闻媒体采用', '1', '1', '1471675893');
INSERT INTO `thinkox_action` VALUES ('29', 'weiyuan_polls_adopt_g', '被全国政协或国家级新闻媒体采用', '被全国政协或国家级新闻媒体采用 +20分', 'table:member|field:score|condition:uid={$self}|rule:score+20|cycle:8760|max:99', '{user}的建议{record}被全国政协或国家级新闻媒体采用', '2', '1', '1470817506');
INSERT INTO `thinkox_action` VALUES ('30', 'weiyuan_polls_awaiting_q', '被区级领导批示', '被区级领导批示', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:999', '{user}的建议{record}被区级领导批示', '1', '1', '1471675903');
INSERT INTO `thinkox_action` VALUES ('31', 'weiyuan_polls_awaiting_s', '被市级领导批示', '被市级领导批示 +10分', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:999', '{user}的建议{record}被市级领导批示', '1', '1', '1471675909');
INSERT INTO `thinkox_action` VALUES ('32', 'weiyuan_polls_awaiting_shen', '被省级领导批示', '被省级领导批示', 'table:member|field:score|condition:uid={$self}|rule:score+15|cycle:END_DATE|max:999', '{user}的建议{record}被省级领导批示', '1', '1', '1471675922');
INSERT INTO `thinkox_action` VALUES ('33', 'weiyuan_polls_awaiting_z', '被中央领导批示', '被中央领导批示 +30', 'table:member|field:score|condition:uid={$self}|rule:score+30|cycle:END_DATE|max:999', '{user}的建议{record}被中央领导批示', '1', '1', '1471675928');
INSERT INTO `thinkox_action` VALUES ('34', 'weiyuan_polls_survey_allfy', '在全体委员会议上作大会发言', '1、调研、视察、考察形成的报告在会议上交流，执笔人按篇加分，参与调研、视察、考察的人员每人加2分；\r\n2、同一篇报告在不同会议上交流，按最高级别加分，不重复加分。', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:END_DATE|max:999', '{user}的调研报告{record}在全体委员会议上作大会发言', '1', '1', '1471675934');
INSERT INTO `thinkox_action` VALUES ('35', 'weiyuan_polls_survey_allsm', '在全体委员会议上作书面交流', '1、调研、视察、考察形成的报告在会议上交流，执笔人按篇加分，参与调研、视察、考察的人员每人加2分；\r\n2、同一篇报告在不同会议上交流，按最高级别加分，不重复加分。', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:999', '{user}的调研报告{record}在全体委员会议上作书面交流', '1', '1', '1471675940');
INSERT INTO `thinkox_action` VALUES ('36', 'weiyuan_polls_survey_cwfy', '在常委会议或主席会议上就协商问题进行发言交流', '1、调研、视察、考察形成的报告在会议上交流，执笔人按篇加分，参与调研、视察、考察的人员每人加2分；\r\n2、同一篇报告在不同会议上交流，按最高级别加分，不重复加分。', 'table:member|field:score|condition:uid={$self}|rule:score+8|cycle:END_DATE|max:999', '{user}的调研报告{record}在常委会议或主席会议上就协商问题进行发言交流', '1', '1', '1471675948');
INSERT INTO `thinkox_action` VALUES ('37', 'weiyuan_polls_survey_cwsm', '在常委会议或主席会议上就协商问题进行书面交流', '1、调研、视察、考察形成的报告在会议上交流，执笔人按篇加分，参与调研、视察、考察的人员每人加2分；\r\n2、同一篇报告在不同会议上交流，按最高级别加分，不重复加分。', 'table:member|field:score|condition:uid={$self}|rule:score+4|cycle:END_DATE|max:999', '{user}的调研报告{record}在常委会议或主席会议上就协商问题进行书面交流', '1', '1', '1471675954');
INSERT INTO `thinkox_action` VALUES ('38', 'weiyuan_historical_adopt', '撰写文史资料并被采用', '可累计加分，最多加20分', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:4', '{user}的文史资料{record}撰写文史资料并被采用', '1', '1', '1471675963');
INSERT INTO `thinkox_action` VALUES ('39', 'weiyuan_event_other', '参加其它政治协商、民主监督、参政议政或相关专委会、街道组织的活动', '5分/次，在本人的履职报告中有所表述，并经基层组织认定，最多加20分', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:4', '{user}参加了其它政治协商、民主监督、参政议政或相关专委会、街道组织的活动', '1', '1', '1471675968');
INSERT INTO `thinkox_action` VALUES ('40', 'weiyuan_event_gy', '参加结对帮扶、送温暖等各类公益活动', '5分/次，在本人的履职报告中有所表述，并经基层组织认定，最多加20分', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:END_DATE|max:4', '{user}参加结对帮扶、送温暖等各类公益活动', '1', '1', '1471675980');
INSERT INTO `thinkox_action` VALUES ('41', 'weiyuan_polls_survey_unit', '调研报告参与人加分', '调研、视察、考察形成的报告在会议上交流，执笔人按篇加分，参与调研、视察、考察的人员每人加2分；', 'table:member|field:score|condition:uid={$self}|rule:score+2|cycle:END_DATE|max:4', '{user}参与调研、视察、考察{record}', '1', '1', '1471675986');
INSERT INTO `thinkox_action` VALUES ('42', 'weiyuan_proposal_goodandimport', '被列为重点加优秀提案', '被列为重点加优秀提案', 'table:member|field:score|condition:uid={$self}|rule:score+12|cycle:END_DATE|max:999', '被列为重点加优秀提案', '1', '1', '1473066977');
INSERT INTO `thinkox_action` VALUES ('43', 'weiyuan_basic_event_qzx', '参加区政协办公室、委员工作委员会组织的活动', '参加会议、活动的得分按“分值×出勤率”计算；\r\n3、常委出席全部常委会会议为20、缺席一次会议扣5分（每年按四次常委会会议计算）。', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:8760|max:2', '{user}参加了活动', '1', '1', '1473584862');

-- ----------------------------
-- Table structure for thinkox_action_log
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_action_log`;
CREATE TABLE `thinkox_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8451 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of thinkox_action_log
-- ----------------------------
INSERT INTO `thinkox_action_log` VALUES ('7888', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-04 09:50登录了后台', '1', '1472953843');
INSERT INTO `thinkox_action_log` VALUES ('7889', '1', '82', '-1062731751', 'member', '82', 'jt1在2016-09-04 14:08登录了后台', '1', '1472969333');
INSERT INTO `thinkox_action_log` VALUES ('7890', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-04 14:55登录了后台', '1', '1472972106');
INSERT INTO `thinkox_action_log` VALUES ('7891', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-04 17:49登录了后台', '1', '1472982549');
INSERT INTO `thinkox_action_log` VALUES ('7892', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-04 17:53登录了后台', '1', '1472982782');
INSERT INTO `thinkox_action_log` VALUES ('7893', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-05 09:03登录了后台', '1', '1473037434');
INSERT INTO `thinkox_action_log` VALUES ('7894', '1', '1', '-1062731751', 'member', '1', 'admin在2016-09-05 10:28登录了后台', '1', '1473042535');
INSERT INTO `thinkox_action_log` VALUES ('7895', '7', '1', '-1062731751', 'model', '2', '操作url：/index.php?s=/admin/model/update.html', '1', '1473044592');
INSERT INTO `thinkox_action_log` VALUES ('7896', '8', '1', '-1062731751', 'attribute', '83', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473065677');
INSERT INTO `thinkox_action_log` VALUES ('7897', '1', '1', '-1062731664', 'member', '1', 'admin在2016-09-06 20:15登录了后台', '1', '1473164108');
INSERT INTO `thinkox_action_log` VALUES ('7898', '1', '58', '-1062731751', 'member', '58', 'dominator在2016-09-07 09:14登录了后台', '1', '1473210899');
INSERT INTO `thinkox_action_log` VALUES ('7899', '1', '1', '-1062731751', 'member', '1', 'admin在2016-09-07 09:33登录了后台', '1', '1473212034');
INSERT INTO `thinkox_action_log` VALUES ('7900', '1', '71', '-1062731661', 'member', '71', 'wyy1在2016-09-07 10:11登录了后台', '1', '1473214289');
INSERT INTO `thinkox_action_log` VALUES ('7901', '1', '1', '-1062731661', 'member', '1', 'admin在2016-09-07 11:18登录了后台', '1', '1473218305');
INSERT INTO `thinkox_action_log` VALUES ('7902', '1', '86', '-1062731751', 'member', '86', 'dominator在2016-09-08 09:08登录了后台', '1', '1473296887');
INSERT INTO `thinkox_action_log` VALUES ('7903', '8', '1', '-1062731751', 'attribute', '60', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473301899');
INSERT INTO `thinkox_action_log` VALUES ('7904', '1', '58', '2002945241', 'member', '58', 'dominator在2016-09-08 12:00登录了后台', '1', '1473307202');
INSERT INTO `thinkox_action_log` VALUES ('7905', '1', '58', '2002945241', 'member', '58', 'dominator在2016-09-08 14:04登录了后台', '1', '1473314660');
INSERT INTO `thinkox_action_log` VALUES ('7906', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-08 15:33登录了后台', '1', '1473319998');
INSERT INTO `thinkox_action_log` VALUES ('7907', '7', '1', '2002945241', 'model', '7', '操作url：/index.php?s=/admin/model/update.html', '1', '1473320020');
INSERT INTO `thinkox_action_log` VALUES ('7908', '8', '1', '2002945241', 'attribute', '120', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7909', '8', '1', '2002945241', 'attribute', '121', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7910', '8', '1', '2002945241', 'attribute', '122', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7911', '8', '1', '2002945241', 'attribute', '123', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7912', '8', '1', '2002945241', 'attribute', '124', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7913', '8', '1', '2002945241', 'attribute', '125', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7914', '8', '1', '2002945241', 'attribute', '126', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320074');
INSERT INTO `thinkox_action_log` VALUES ('7915', '8', '1', '2002945241', 'attribute', '127', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7916', '8', '1', '2002945241', 'attribute', '128', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7917', '8', '1', '2002945241', 'attribute', '129', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7918', '8', '1', '2002945241', 'attribute', '130', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7919', '8', '1', '2002945241', 'attribute', '131', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7920', '8', '1', '2002945241', 'attribute', '132', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7921', '8', '1', '2002945241', 'attribute', '133', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7922', '8', '1', '2002945241', 'attribute', '134', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7923', '8', '1', '2002945241', 'attribute', '135', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320087');
INSERT INTO `thinkox_action_log` VALUES ('7924', '8', '1', '2002945241', 'attribute', '136', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7925', '8', '1', '2002945241', 'attribute', '137', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7926', '8', '1', '2002945241', 'attribute', '138', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7927', '8', '1', '2002945241', 'attribute', '139', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7928', '8', '1', '2002945241', 'attribute', '140', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7929', '8', '1', '2002945241', 'attribute', '141', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7930', '8', '1', '2002945241', 'attribute', '142', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473320161');
INSERT INTO `thinkox_action_log` VALUES ('7931', '8', '1', '2002945241', 'attribute', '119', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473320184');
INSERT INTO `thinkox_action_log` VALUES ('7932', '17', '58', '2002945241', 'proposal', '151', '委员{user}在{time}成功提交了一份提案。', '1', '1473323749');
INSERT INTO `thinkox_action_log` VALUES ('7933', '1', '64', '2002945241', 'member', '64', 'taw在2016-09-08 16:36登录了后台', '1', '1473323782');
INSERT INTO `thinkox_action_log` VALUES ('7934', '1', '64', '2002945241', 'member', '64', 'taw在2016-09-08 16:39登录了后台', '1', '1473323982');
INSERT INTO `thinkox_action_log` VALUES ('7935', '1', '65', '2002945241', 'member', '65', 'dcs在2016-09-08 17:21登录了后台', '1', '1473326509');
INSERT INTO `thinkox_action_log` VALUES ('7936', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-08 17:31登录了后台', '1', '1473327089');
INSERT INTO `thinkox_action_log` VALUES ('7937', '1', '66', '2002945241', 'member', '66', 'bldw1在2016-09-08 17:35登录了后台', '1', '1473327309');
INSERT INTO `thinkox_action_log` VALUES ('7938', '1', '65', '2002945241', 'member', '65', 'dcs在2016-09-08 17:41登录了后台', '1', '1473327715');
INSERT INTO `thinkox_action_log` VALUES ('7939', '1', '67', '2002945241', 'member', '67', 'bldw2在2016-09-08 17:42登录了后台', '1', '1473327777');
INSERT INTO `thinkox_action_log` VALUES ('7940', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-08 17:55登录了后台', '1', '1473328532');
INSERT INTO `thinkox_action_log` VALUES ('7941', '1', '58', '2002945241', 'member', '58', 'dominator在2016-09-08 17:57登录了后台', '1', '1473328635');
INSERT INTO `thinkox_action_log` VALUES ('7942', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-08 18:26登录了后台', '1', '1473330408');
INSERT INTO `thinkox_action_log` VALUES ('7943', '1', '58', '2002945241', 'member', '58', 'dominator在2016-09-08 18:27登录了后台', '1', '1473330447');
INSERT INTO `thinkox_action_log` VALUES ('7944', '1', '68', '2002945241', 'member', '68', 'bldw3在2016-09-08 18:50登录了后台', '1', '1473331834');
INSERT INTO `thinkox_action_log` VALUES ('7945', '1', '65', '2002945241', 'member', '65', 'dcs在2016-09-08 18:51登录了后台', '1', '1473331914');
INSERT INTO `thinkox_action_log` VALUES ('7946', '1', '68', '2002945241', 'member', '68', 'bldw3在2016-09-08 18:59登录了后台', '1', '1473332378');
INSERT INTO `thinkox_action_log` VALUES ('7947', '1', '65', '2002945241', 'member', '65', 'dcs在2016-09-08 19:00登录了后台', '1', '1473332426');
INSERT INTO `thinkox_action_log` VALUES ('7948', '1', '64', '2002945241', 'member', '64', 'taw在2016-09-08 19:00登录了后台', '1', '1473332459');
INSERT INTO `thinkox_action_log` VALUES ('7949', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-08 19:26登录了后台', '1', '1473333979');
INSERT INTO `thinkox_action_log` VALUES ('7950', '1', '58', '2002945241', 'member', '58', 'dominator在2016-09-08 19:27登录了后台', '1', '1473334050');
INSERT INTO `thinkox_action_log` VALUES ('7951', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-08 19:35登录了后台', '1', '1473334543');
INSERT INTO `thinkox_action_log` VALUES ('7952', '17', '59', '2002945241', 'proposal', '153', '委员{user}在{time}成功提交了一份提案。', '1', '1473334563');
INSERT INTO `thinkox_action_log` VALUES ('7953', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-08 19:44登录了后台', '1', '1473335095');
INSERT INTO `thinkox_action_log` VALUES ('7954', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-08 20:35登录了后台', '1', '1473338103');
INSERT INTO `thinkox_action_log` VALUES ('7955', '1', '69', '2002945241', 'member', '69', 'zxbgs在2016-09-08 20:36登录了后台', '1', '1473338177');
INSERT INTO `thinkox_action_log` VALUES ('7956', '1', '70', '2002945241', 'member', '70', 'bgszr在2016-09-08 20:38登录了后台', '1', '1473338298');
INSERT INTO `thinkox_action_log` VALUES ('7957', '6', '1', '2002945241', 'config', '96', '操作url：/index.php?s=/admin/config/edit.html', '1', '1473339048');
INSERT INTO `thinkox_action_log` VALUES ('7958', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-08 21:07登录了后台', '1', '1473340053');
INSERT INTO `thinkox_action_log` VALUES ('7959', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-08 21:29登录了后台', '1', '1473341368');
INSERT INTO `thinkox_action_log` VALUES ('7960', '1', '67', '2002945241', 'member', '67', 'bldw2在2016-09-08 21:30登录了后台', '1', '1473341436');
INSERT INTO `thinkox_action_log` VALUES ('7961', '1', '66', '2002945241', 'member', '66', 'bldw1在2016-09-08 21:30登录了后台', '1', '1473341452');
INSERT INTO `thinkox_action_log` VALUES ('7962', '1', '68', '2002945241', 'member', '68', 'bldw3在2016-09-08 21:31登录了后台', '1', '1473341463');
INSERT INTO `thinkox_action_log` VALUES ('7963', '1', '65', '2002945241', 'member', '65', 'dcs在2016-09-08 21:31登录了后台', '1', '1473341478');
INSERT INTO `thinkox_action_log` VALUES ('7964', '1', '66', '2002945241', 'member', '66', 'bldw1在2016-09-08 21:32登录了后台', '1', '1473341522');
INSERT INTO `thinkox_action_log` VALUES ('7965', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-09 10:32登录了后台', '1', '1473388324');
INSERT INTO `thinkox_action_log` VALUES ('7966', '6', '1', '2002945241', 'config', '96', '操作url：/index.php?s=/admin/config/edit.html', '1', '1473388484');
INSERT INTO `thinkox_action_log` VALUES ('7967', '1', '1', '2002945241', 'member', '1', 'admin在2016-09-09 12:45登录了后台', '1', '1473396343');
INSERT INTO `thinkox_action_log` VALUES ('7968', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-09 13:46登录了后台', '1', '1473399974');
INSERT INTO `thinkox_action_log` VALUES ('7969', '1', '59', '2002945241', 'member', '59', 'wyy1在2016-09-09 13:46登录了后台', '1', '1473399977');
INSERT INTO `thinkox_action_log` VALUES ('7970', '1', '58', '2002830702', 'member', '58', 'dominator在2016-09-09 15:30登录了后台', '1', '1473406215');
INSERT INTO `thinkox_action_log` VALUES ('7971', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 15:34登录了后台', '1', '1473406470');
INSERT INTO `thinkox_action_log` VALUES ('7972', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 16:44登录了后台', '1', '1473410649');
INSERT INTO `thinkox_action_log` VALUES ('7973', '8', '1', '2002830702', 'attribute', '80', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473411027');
INSERT INTO `thinkox_action_log` VALUES ('7974', '8', '1', '2002830702', 'attribute', '89', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473411228');
INSERT INTO `thinkox_action_log` VALUES ('7975', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 16:59登录了后台', '1', '1473411558');
INSERT INTO `thinkox_action_log` VALUES ('7976', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-09 17:52登录了后台', '1', '1473414753');
INSERT INTO `thinkox_action_log` VALUES ('7977', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 17:58登录了后台', '1', '1473415115');
INSERT INTO `thinkox_action_log` VALUES ('7978', '17', '59', '2002830702', 'proposal', '157', '委员{user}在{time}成功提交了一份提案。', '1', '1473415757');
INSERT INTO `thinkox_action_log` VALUES ('7979', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-09 18:11登录了后台', '1', '1473415906');
INSERT INTO `thinkox_action_log` VALUES ('7980', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-09 18:14登录了后台', '1', '1473416043');
INSERT INTO `thinkox_action_log` VALUES ('7981', '17', '59', '2002830702', 'proposal', '155', '委员{user}在{time}成功提交了一份提案。', '1', '1473416329');
INSERT INTO `thinkox_action_log` VALUES ('7982', '17', '59', '2002830702', 'proposal', '154', '委员{user}在{time}成功提交了一份提案。', '1', '1473416354');
INSERT INTO `thinkox_action_log` VALUES ('7983', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-09 18:19登录了后台', '1', '1473416380');
INSERT INTO `thinkox_action_log` VALUES ('7984', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-09 19:46登录了后台', '1', '1473421580');
INSERT INTO `thinkox_action_log` VALUES ('7985', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 20:28登录了后台', '1', '1473424134');
INSERT INTO `thinkox_action_log` VALUES ('7986', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-09 21:38登录了后台', '1', '1473428325');
INSERT INTO `thinkox_action_log` VALUES ('7987', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-09 21:38登录了后台', '1', '1473428332');
INSERT INTO `thinkox_action_log` VALUES ('7988', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 21:53登录了后台', '1', '1473429229');
INSERT INTO `thinkox_action_log` VALUES ('7989', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-09 21:53登录了后台', '1', '1473429233');
INSERT INTO `thinkox_action_log` VALUES ('7990', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-09 22:00登录了后台', '1', '1473429600');
INSERT INTO `thinkox_action_log` VALUES ('7991', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-09 22:01登录了后台', '1', '1473429682');
INSERT INTO `thinkox_action_log` VALUES ('7992', '17', '59', '2002830702', 'proposal', '154', '委员{user}在{time}成功提交了一份提案。', '1', '1473434625');
INSERT INTO `thinkox_action_log` VALUES ('7993', '17', '59', '2002830702', 'proposal', '154', '委员{user}在{time}成功提交了一份提案。', '1', '1473434696');
INSERT INTO `thinkox_action_log` VALUES ('7994', '22', '59', '2002830702', 'proposal', '154', '{user}提出的提案被立案了', '1', '1473435043');
INSERT INTO `thinkox_action_log` VALUES ('7995', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-09 23:32登录了后台', '1', '1473435155');
INSERT INTO `thinkox_action_log` VALUES ('7996', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-09 23:35登录了后台', '1', '1473435359');
INSERT INTO `thinkox_action_log` VALUES ('7997', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-09 23:41登录了后台', '1', '1473435691');
INSERT INTO `thinkox_action_log` VALUES ('7998', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-09 23:43登录了后台', '1', '1473435785');
INSERT INTO `thinkox_action_log` VALUES ('7999', '17', '59', '2002830702', 'proposal', '158', '委员{user}在{time}成功提交了一份提案。', '1', '1473435949');
INSERT INTO `thinkox_action_log` VALUES ('8000', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-09 23:46登录了后台', '1', '1473435965');
INSERT INTO `thinkox_action_log` VALUES ('8001', '22', '59', '2002830702', 'proposal', '158', '{user}提出的提案被立案了', '1', '1473435985');
INSERT INTO `thinkox_action_log` VALUES ('8002', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-09 23:50登录了后台', '1', '1473436251');
INSERT INTO `thinkox_action_log` VALUES ('8003', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-09 23:51登录了后台', '1', '1473436271');
INSERT INTO `thinkox_action_log` VALUES ('8004', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-09 23:54登录了后台', '1', '1473436483');
INSERT INTO `thinkox_action_log` VALUES ('8005', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-09 23:55登录了后台', '1', '1473436504');
INSERT INTO `thinkox_action_log` VALUES ('8006', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-09 23:59登录了后台', '1', '1473436758');
INSERT INTO `thinkox_action_log` VALUES ('8007', '26', '59', '2002830702', 'proposal', '154', '{user}的建议{record}被被区政协采用', '1', '1473436997');
INSERT INTO `thinkox_action_log` VALUES ('8008', '31', '59', '2002830702', 'proposal', '154', '{user}的建议{record}被市级领导批示', '1', '1473436997');
INSERT INTO `thinkox_action_log` VALUES ('8009', '22', '59', '2002830702', 'proposal', '154', '{user}提出的提案被立案了', '1', '1473436997');
INSERT INTO `thinkox_action_log` VALUES ('8010', '29', '71', '2002830702', 'proposal', '146', '{user}的建议{record}被全国政协或国家级新闻媒体采用', '1', '1473437032');
INSERT INTO `thinkox_action_log` VALUES ('8011', '33', '71', '2002830702', 'proposal', '146', '{user}的建议{record}被中央领导批示', '1', '1473437032');
INSERT INTO `thinkox_action_log` VALUES ('8012', '22', '71', '2002830702', 'proposal', '146', '{user}提出的提案被立案了', '1', '1473437032');
INSERT INTO `thinkox_action_log` VALUES ('8013', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 00:05登录了后台', '1', '1473437104');
INSERT INTO `thinkox_action_log` VALUES ('8014', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 10:54登录了后台', '1', '1473476056');
INSERT INTO `thinkox_action_log` VALUES ('8015', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-10 11:50登录了后台', '1', '1473479410');
INSERT INTO `thinkox_action_log` VALUES ('8016', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 11:56登录了后台', '1', '1473479779');
INSERT INTO `thinkox_action_log` VALUES ('8017', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 12:01登录了后台', '1', '1473480114');
INSERT INTO `thinkox_action_log` VALUES ('8018', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-10 14:29登录了后台', '1', '1473488966');
INSERT INTO `thinkox_action_log` VALUES ('8019', '1', '61', '2002830702', 'member', '61', 'wyy3在2016-09-10 14:43登录了后台', '1', '1473489786');
INSERT INTO `thinkox_action_log` VALUES ('8020', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 15:29登录了后台', '1', '1473492564');
INSERT INTO `thinkox_action_log` VALUES ('8021', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 15:30登录了后台', '1', '1473492626');
INSERT INTO `thinkox_action_log` VALUES ('8022', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 15:35登录了后台', '1', '1473492935');
INSERT INTO `thinkox_action_log` VALUES ('8023', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 15:43登录了后台', '1', '1473493383');
INSERT INTO `thinkox_action_log` VALUES ('8024', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-10 15:43登录了后台', '1', '1473493433');
INSERT INTO `thinkox_action_log` VALUES ('8025', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 15:44登录了后台', '1', '1473493485');
INSERT INTO `thinkox_action_log` VALUES ('8026', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 15:46登录了后台', '1', '1473493606');
INSERT INTO `thinkox_action_log` VALUES ('8027', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 16:16登录了后台', '1', '1473495404');
INSERT INTO `thinkox_action_log` VALUES ('8028', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 16:17登录了后台', '1', '1473495464');
INSERT INTO `thinkox_action_log` VALUES ('8029', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 16:20登录了后台', '1', '1473495644');
INSERT INTO `thinkox_action_log` VALUES ('8030', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 16:22登录了后台', '1', '1473495760');
INSERT INTO `thinkox_action_log` VALUES ('8031', '17', '59', '2002830702', 'proposal', '161', '委员{user}在{time}成功提交了一份提案。', '1', '1473496096');
INSERT INTO `thinkox_action_log` VALUES ('8032', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 16:58登录了后台', '1', '1473497901');
INSERT INTO `thinkox_action_log` VALUES ('8033', '17', '59', '2002830702', 'proposal', '162', '委员{user}在{time}成功提交了一份提案。', '1', '1473498360');
INSERT INTO `thinkox_action_log` VALUES ('8034', '17', '59', '2002830702', 'proposal', '163', '委员{user}在{time}成功提交了一份提案。', '1', '1473498403');
INSERT INTO `thinkox_action_log` VALUES ('8035', '8', '1', '2002830702', 'attribute', '143', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473498443');
INSERT INTO `thinkox_action_log` VALUES ('8036', '8', '1', '2002830702', 'attribute', '144', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473498443');
INSERT INTO `thinkox_action_log` VALUES ('8037', '8', '1', '2002830702', 'attribute', '145', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473498443');
INSERT INTO `thinkox_action_log` VALUES ('8038', '8', '1', '2002830702', 'attribute', '146', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473498443');
INSERT INTO `thinkox_action_log` VALUES ('8039', '8', '1', '2002830702', 'attribute', '147', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473498443');
INSERT INTO `thinkox_action_log` VALUES ('8040', '8', '1', '2002830702', 'attribute', '147', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473498577');
INSERT INTO `thinkox_action_log` VALUES ('8041', '8', '1', '2002830702', 'attribute', '145', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473498643');
INSERT INTO `thinkox_action_log` VALUES ('8042', '8', '1', '2002830702', 'attribute', '145', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473498664');
INSERT INTO `thinkox_action_log` VALUES ('8043', '22', '58', '2002830702', 'proposal', '151', '{user}提出的提案被立案了', '1', '1473498982');
INSERT INTO `thinkox_action_log` VALUES ('8044', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 17:17登录了后台', '1', '1473499076');
INSERT INTO `thinkox_action_log` VALUES ('8045', '8', '1', '2002830702', 'attribute', '80', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473501847');
INSERT INTO `thinkox_action_log` VALUES ('8046', '8', '1', '2002830702', 'attribute', '80', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473501888');
INSERT INTO `thinkox_action_log` VALUES ('8047', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 18:17登录了后台', '1', '1473502662');
INSERT INTO `thinkox_action_log` VALUES ('8048', '17', '59', '2002830702', 'proposal', '162', '委员{user}在{time}成功提交了一份提案。', '1', '1473502995');
INSERT INTO `thinkox_action_log` VALUES ('8049', '17', '59', '2002830702', 'proposal', '164', '委员{user}在{time}成功提交了一份提案。', '1', '1473506206');
INSERT INTO `thinkox_action_log` VALUES ('8050', '17', '59', '2002830702', 'proposal', '156', '委员{user}在{time}成功提交了一份提案。', '1', '1473506380');
INSERT INTO `thinkox_action_log` VALUES ('8051', '17', '59', '2002830702', 'proposal', '156', '委员{user}在{time}成功提交了一份提案。', '1', '1473506409');
INSERT INTO `thinkox_action_log` VALUES ('8052', '17', '59', '2002830702', 'proposal', '156', '委员{user}在{time}成功提交了一份提案。', '1', '1473506440');
INSERT INTO `thinkox_action_log` VALUES ('8053', '22', '59', '2002830702', 'proposal', '156', '{user}提出的提案被立案了', '1', '1473506447');
INSERT INTO `thinkox_action_log` VALUES ('8054', '17', '59', '2002830702', 'proposal', '165', '委员{user}在{time}成功提交了一份提案。', '1', '1473506488');
INSERT INTO `thinkox_action_log` VALUES ('8055', '17', '59', '2002830702', 'proposal', '166', '委员{user}在{time}成功提交了一份提案。', '1', '1473506520');
INSERT INTO `thinkox_action_log` VALUES ('8056', '22', '59', '2002830702', 'proposal', '166', '{user}提出的提案被立案了', '1', '1473506608');
INSERT INTO `thinkox_action_log` VALUES ('8057', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 19:35登录了后台', '1', '1473507358');
INSERT INTO `thinkox_action_log` VALUES ('8058', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 19:38登录了后台', '1', '1473507522');
INSERT INTO `thinkox_action_log` VALUES ('8059', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-10 19:38登录了后台', '1', '1473507538');
INSERT INTO `thinkox_action_log` VALUES ('8060', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 19:49登录了后台', '1', '1473508159');
INSERT INTO `thinkox_action_log` VALUES ('8061', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 20:00登录了后台', '1', '1473508840');
INSERT INTO `thinkox_action_log` VALUES ('8062', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 20:04登录了后台', '1', '1473509095');
INSERT INTO `thinkox_action_log` VALUES ('8063', '8', '1', '2002830702', 'attribute', '93', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473509221');
INSERT INTO `thinkox_action_log` VALUES ('8064', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 21:10登录了后台', '1', '1473513030');
INSERT INTO `thinkox_action_log` VALUES ('8065', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-10 21:11登录了后台', '1', '1473513077');
INSERT INTO `thinkox_action_log` VALUES ('8066', '28', '59', '2002830702', 'proposal', '158', '{user}的建议{record}被省委、省政协或省级新闻媒体采用', '1', '1473513301');
INSERT INTO `thinkox_action_log` VALUES ('8067', '32', '59', '2002830702', 'proposal', '158', '{user}的建议{record}被省级领导批示', '1', '1473513301');
INSERT INTO `thinkox_action_log` VALUES ('8068', '22', '59', '2002830702', 'proposal', '158', '{user}提出的提案被立案了', '1', '1473513301');
INSERT INTO `thinkox_action_log` VALUES ('8069', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-10 21:15登录了后台', '1', '1473513317');
INSERT INTO `thinkox_action_log` VALUES ('8070', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-10 21:20登录了后台', '1', '1473513613');
INSERT INTO `thinkox_action_log` VALUES ('8071', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-10 21:20登录了后台', '1', '1473513650');
INSERT INTO `thinkox_action_log` VALUES ('8072', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-10 21:21登录了后台', '1', '1473513682');
INSERT INTO `thinkox_action_log` VALUES ('8073', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-10 21:23登录了后台', '1', '1473513781');
INSERT INTO `thinkox_action_log` VALUES ('8074', '17', '62', '2002830702', 'proposal', '168', '委员{user}在{time}成功提交了一份提案。', '1', '1473514447');
INSERT INTO `thinkox_action_log` VALUES ('8075', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 21:34登录了后台', '1', '1473514482');
INSERT INTO `thinkox_action_log` VALUES ('8076', '22', '62', '2002830702', 'proposal', '168', '{user}提出的提案被立案了', '1', '1473514531');
INSERT INTO `thinkox_action_log` VALUES ('8077', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 21:37登录了后台', '1', '1473514643');
INSERT INTO `thinkox_action_log` VALUES ('8078', '17', '62', '2002830702', 'proposal', '169', '委员{user}在{time}成功提交了一份提案。', '1', '1473514845');
INSERT INTO `thinkox_action_log` VALUES ('8079', '17', '62', '2002830702', 'proposal', '169', '委员{user}在{time}成功提交了一份提案。', '1', '1473515328');
INSERT INTO `thinkox_action_log` VALUES ('8080', '17', '62', '2002830702', 'proposal', '169', '委员{user}在{time}成功提交了一份提案。', '1', '1473515337');
INSERT INTO `thinkox_action_log` VALUES ('8081', '22', '62', '2002830702', 'proposal', '169', '{user}提出的提案被立案了', '1', '1473515355');
INSERT INTO `thinkox_action_log` VALUES ('8082', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 21:50登录了后台', '1', '1473515407');
INSERT INTO `thinkox_action_log` VALUES ('8083', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 21:50登录了后台', '1', '1473515430');
INSERT INTO `thinkox_action_log` VALUES ('8084', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 21:51登录了后台', '1', '1473515485');
INSERT INTO `thinkox_action_log` VALUES ('8085', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 21:51登录了后台', '1', '1473515500');
INSERT INTO `thinkox_action_log` VALUES ('8086', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 21:51登录了后台', '1', '1473515519');
INSERT INTO `thinkox_action_log` VALUES ('8087', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-10 21:53登录了后台', '1', '1473515606');
INSERT INTO `thinkox_action_log` VALUES ('8088', '1', '62', '2002830702', 'member', '62', 'jt1在2016-09-10 22:02登录了后台', '1', '1473516136');
INSERT INTO `thinkox_action_log` VALUES ('8089', '17', '62', '2002830702', 'proposal', '170', '委员{user}在{time}成功提交了一份提案。', '1', '1473516387');
INSERT INTO `thinkox_action_log` VALUES ('8090', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 22:06登录了后台', '1', '1473516414');
INSERT INTO `thinkox_action_log` VALUES ('8091', '17', '62', '2002830702', 'proposal', '170', '委员{user}在{time}成功提交了一份提案。', '1', '1473516442');
INSERT INTO `thinkox_action_log` VALUES ('8092', '22', '62', '2002830702', 'proposal', '170', '{user}提出的提案被立案了', '1', '1473516449');
INSERT INTO `thinkox_action_log` VALUES ('8093', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-10 22:35登录了后台', '1', '1473518118');
INSERT INTO `thinkox_action_log` VALUES ('8094', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 22:36登录了后台', '1', '1473518206');
INSERT INTO `thinkox_action_log` VALUES ('8095', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-10 22:37登录了后台', '1', '1473518257');
INSERT INTO `thinkox_action_log` VALUES ('8096', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-10 22:39登录了后台', '1', '1473518375');
INSERT INTO `thinkox_action_log` VALUES ('8097', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-10 22:39登录了后台', '1', '1473518385');
INSERT INTO `thinkox_action_log` VALUES ('8098', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-10 22:41登录了后台', '1', '1473518466');
INSERT INTO `thinkox_action_log` VALUES ('8099', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-10 22:51登录了后台', '1', '1473519066');
INSERT INTO `thinkox_action_log` VALUES ('8100', '22', '58', '2002830702', 'proposal', '142', '{user}提出的提案被立案了', '1', '1473519371');
INSERT INTO `thinkox_action_log` VALUES ('8101', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 09:02登录了后台', '1', '1473555769');
INSERT INTO `thinkox_action_log` VALUES ('8102', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 09:03登录了后台', '1', '1473555839');
INSERT INTO `thinkox_action_log` VALUES ('8103', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 09:06登录了后台', '1', '1473556019');
INSERT INTO `thinkox_action_log` VALUES ('8104', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 09:56登录了后台', '1', '1473558978');
INSERT INTO `thinkox_action_log` VALUES ('8105', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 10:24登录了后台', '1', '1473560671');
INSERT INTO `thinkox_action_log` VALUES ('8106', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 10:26登录了后台', '1', '1473560760');
INSERT INTO `thinkox_action_log` VALUES ('8107', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 10:26登录了后台', '1', '1473560807');
INSERT INTO `thinkox_action_log` VALUES ('8108', '6', '1', '2002830702', 'config', '60', '操作url：/index.php?s=/admin/config/edit.html', '1', '1473560929');
INSERT INTO `thinkox_action_log` VALUES ('8109', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 10:28登录了后台', '1', '1473560932');
INSERT INTO `thinkox_action_log` VALUES ('8110', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 10:33登录了后台', '1', '1473561189');
INSERT INTO `thinkox_action_log` VALUES ('8111', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-11 10:34登录了后台', '1', '1473561256');
INSERT INTO `thinkox_action_log` VALUES ('8112', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-11 10:34登录了后台', '1', '1473561271');
INSERT INTO `thinkox_action_log` VALUES ('8113', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 10:35登录了后台', '1', '1473561332');
INSERT INTO `thinkox_action_log` VALUES ('8114', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 10:52登录了后台', '1', '1473562341');
INSERT INTO `thinkox_action_log` VALUES ('8115', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 10:59登录了后台', '1', '1473562783');
INSERT INTO `thinkox_action_log` VALUES ('8116', '17', '59', '2002830702', 'proposal', '161', '委员{user}在{time}成功提交了一份提案。', '1', '1473562849');
INSERT INTO `thinkox_action_log` VALUES ('8117', '17', '59', '2002830702', 'proposal', '161', '委员{user}在{time}成功提交了一份提案。', '1', '1473562866');
INSERT INTO `thinkox_action_log` VALUES ('8118', '17', '59', '2002830702', 'proposal', '161', '委员{user}在{time}成功提交了一份提案。', '1', '1473562879');
INSERT INTO `thinkox_action_log` VALUES ('8119', '22', '59', '2002830702', 'proposal', '161', '{user}提出的提案被立案了', '1', '1473562888');
INSERT INTO `thinkox_action_log` VALUES ('8120', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 11:05登录了后台', '1', '1473563122');
INSERT INTO `thinkox_action_log` VALUES ('8121', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 11:05登录了后台', '1', '1473563142');
INSERT INTO `thinkox_action_log` VALUES ('8122', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 11:13登录了后台', '1', '1473563607');
INSERT INTO `thinkox_action_log` VALUES ('8123', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 11:13登录了后台', '1', '1473563619');
INSERT INTO `thinkox_action_log` VALUES ('8124', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 11:13登录了后台', '1', '1473563638');
INSERT INTO `thinkox_action_log` VALUES ('8125', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 11:20登录了后台', '1', '1473564043');
INSERT INTO `thinkox_action_log` VALUES ('8126', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 11:21登录了后台', '1', '1473564114');
INSERT INTO `thinkox_action_log` VALUES ('8127', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 11:23登录了后台', '1', '1473564205');
INSERT INTO `thinkox_action_log` VALUES ('8128', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 11:32登录了后台', '1', '1473564742');
INSERT INTO `thinkox_action_log` VALUES ('8129', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 12:21登录了后台', '1', '1473567683');
INSERT INTO `thinkox_action_log` VALUES ('8130', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 12:23登录了后台', '1', '1473567791');
INSERT INTO `thinkox_action_log` VALUES ('8131', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 13:44登录了后台', '1', '1473572690');
INSERT INTO `thinkox_action_log` VALUES ('8132', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 13:48登录了后台', '1', '1473572929');
INSERT INTO `thinkox_action_log` VALUES ('8133', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 13:49登录了后台', '1', '1473572993');
INSERT INTO `thinkox_action_log` VALUES ('8134', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 14:49登录了后台', '1', '1473576563');
INSERT INTO `thinkox_action_log` VALUES ('8135', '23', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:04登录了后台', '1', '1473577479');
INSERT INTO `thinkox_action_log` VALUES ('8136', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:06登录了后台', '1', '1473577583');
INSERT INTO `thinkox_action_log` VALUES ('8137', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 15:10登录了后台', '1', '1473577826');
INSERT INTO `thinkox_action_log` VALUES ('8138', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 15:24登录了后台', '1', '1473578659');
INSERT INTO `thinkox_action_log` VALUES ('8139', '22', '71', '2002830702', 'proposal', '139', '{user}提出的提案被立案了', '1', '1473578735');
INSERT INTO `thinkox_action_log` VALUES ('8140', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:27登录了后台', '1', '1473578827');
INSERT INTO `thinkox_action_log` VALUES ('8141', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:28登录了后台', '1', '1473578914');
INSERT INTO `thinkox_action_log` VALUES ('8142', '17', '59', '2002830702', 'proposal', '172', '委员{user}在{time}成功提交了一份提案。', '1', '1473578933');
INSERT INTO `thinkox_action_log` VALUES ('8143', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 15:29登录了后台', '1', '1473578954');
INSERT INTO `thinkox_action_log` VALUES ('8154', '8', '1', '2002830702', 'attribute', '83', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473579517');
INSERT INTO `thinkox_action_log` VALUES ('8145', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473579001');
INSERT INTO `thinkox_action_log` VALUES ('8146', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 15:30登录了后台', '1', '1473579019');
INSERT INTO `thinkox_action_log` VALUES ('8147', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-11 15:30登录了后台', '1', '1473579043');
INSERT INTO `thinkox_action_log` VALUES ('8148', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 15:31登录了后台', '1', '1473579072');
INSERT INTO `thinkox_action_log` VALUES ('8149', '27', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1473579370');
INSERT INTO `thinkox_action_log` VALUES ('8150', '32', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被省级领导批示', '1', '1473579370');
INSERT INTO `thinkox_action_log` VALUES ('8151', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473579370');
INSERT INTO `thinkox_action_log` VALUES ('8152', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:38登录了后台', '1', '1473579485');
INSERT INTO `thinkox_action_log` VALUES ('8153', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 15:38登录了后台', '1', '1473579500');
INSERT INTO `thinkox_action_log` VALUES ('8155', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:39登录了后台', '1', '1473579580');
INSERT INTO `thinkox_action_log` VALUES ('8156', '23', '59', '2002830702', 'proposal', '172', '{user}的提案被确定为重点提案', '1', '1473579595');
INSERT INTO `thinkox_action_log` VALUES ('8157', '27', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1473579595');
INSERT INTO `thinkox_action_log` VALUES ('8158', '32', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被省级领导批示', '1', '1473579595');
INSERT INTO `thinkox_action_log` VALUES ('8159', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473579595');
INSERT INTO `thinkox_action_log` VALUES ('8160', '42', '59', '2002830702', 'proposal', '172', '被列为重点加优秀提案', '1', '1473579735');
INSERT INTO `thinkox_action_log` VALUES ('8161', '27', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1473579735');
INSERT INTO `thinkox_action_log` VALUES ('8162', '32', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被省级领导批示', '1', '1473579735');
INSERT INTO `thinkox_action_log` VALUES ('8163', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473579735');
INSERT INTO `thinkox_action_log` VALUES ('8164', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:45登录了后台', '1', '1473579957');
INSERT INTO `thinkox_action_log` VALUES ('8165', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:47登录了后台', '1', '1473580065');
INSERT INTO `thinkox_action_log` VALUES ('8166', '25', '59', '2002830702', 'proposal', '172', '{user}的提案被确定为建议案', '1', '1473580224');
INSERT INTO `thinkox_action_log` VALUES ('8167', '27', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1473580224');
INSERT INTO `thinkox_action_log` VALUES ('8168', '32', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被省级领导批示', '1', '1473580224');
INSERT INTO `thinkox_action_log` VALUES ('8169', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473580224');
INSERT INTO `thinkox_action_log` VALUES ('8170', '24', '59', '2002830702', 'proposal', '172', '{user}的提案被确定为优秀提案', '1', '1473580284');
INSERT INTO `thinkox_action_log` VALUES ('8171', '27', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被市委、市政协或市级新闻媒体采用', '1', '1473580284');
INSERT INTO `thinkox_action_log` VALUES ('8172', '32', '59', '2002830702', 'proposal', '172', '{user}的建议{record}被省级领导批示', '1', '1473580284');
INSERT INTO `thinkox_action_log` VALUES ('8173', '22', '59', '2002830702', 'proposal', '172', '{user}提出的提案被立案了', '1', '1473580284');
INSERT INTO `thinkox_action_log` VALUES ('8174', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:52登录了后台', '1', '1473580344');
INSERT INTO `thinkox_action_log` VALUES ('8175', '17', '59', '2002830702', 'proposal', '173', '委员{user}在{time}成功提交了一份提案。', '1', '1473580361');
INSERT INTO `thinkox_action_log` VALUES ('8176', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-11 15:53登录了后台', '1', '1473580386');
INSERT INTO `thinkox_action_log` VALUES ('8177', '22', '59', '2002830702', 'proposal', '173', '{user}提出的提案被立案了', '1', '1473580403');
INSERT INTO `thinkox_action_log` VALUES ('8178', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 15:53登录了后台', '1', '1473580436');
INSERT INTO `thinkox_action_log` VALUES ('8179', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 15:54登录了后台', '1', '1473580485');
INSERT INTO `thinkox_action_log` VALUES ('8180', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:55登录了后台', '1', '1473580501');
INSERT INTO `thinkox_action_log` VALUES ('8181', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 15:56登录了后台', '1', '1473580588');
INSERT INTO `thinkox_action_log` VALUES ('8182', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-11 16:07登录了后台', '1', '1473581269');
INSERT INTO `thinkox_action_log` VALUES ('8183', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-11 16:08登录了后台', '1', '1473581281');
INSERT INTO `thinkox_action_log` VALUES ('8184', '8', '1', '2002830702', 'attribute', '148', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8185', '8', '1', '2002830702', 'attribute', '149', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8186', '8', '1', '2002830702', 'attribute', '150', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8187', '8', '1', '2002830702', 'attribute', '151', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8188', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8189', '8', '1', '2002830702', 'attribute', '153', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8190', '8', '1', '2002830702', 'attribute', '154', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8191', '8', '1', '2002830702', 'attribute', '155', '操作url：/index.php?s=/admin/model/generate.html', '1', '1473583597');
INSERT INTO `thinkox_action_log` VALUES ('8192', '8', '1', '2002830702', 'attribute', '154', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473583677');
INSERT INTO `thinkox_action_log` VALUES ('8193', '8', '1', '2002830702', 'attribute', '154', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473583694');
INSERT INTO `thinkox_action_log` VALUES ('8194', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 17:15登录了后台', '1', '1473585337');
INSERT INTO `thinkox_action_log` VALUES ('8195', '8', '1', '2002830702', 'attribute', '151', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473585375');
INSERT INTO `thinkox_action_log` VALUES ('8196', '8', '1', '2002830702', 'attribute', '151', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473585724');
INSERT INTO `thinkox_action_log` VALUES ('8197', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 17:27登录了后台', '1', '1473586022');
INSERT INTO `thinkox_action_log` VALUES ('8198', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 17:27登录了后台', '1', '1473586047');
INSERT INTO `thinkox_action_log` VALUES ('8199', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 17:27登录了后台', '1', '1473586062');
INSERT INTO `thinkox_action_log` VALUES ('8200', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-11 17:28登录了后台', '1', '1473586082');
INSERT INTO `thinkox_action_log` VALUES ('8201', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586128');
INSERT INTO `thinkox_action_log` VALUES ('8202', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586164');
INSERT INTO `thinkox_action_log` VALUES ('8203', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586235');
INSERT INTO `thinkox_action_log` VALUES ('8204', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586278');
INSERT INTO `thinkox_action_log` VALUES ('8205', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586383');
INSERT INTO `thinkox_action_log` VALUES ('8206', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586438');
INSERT INTO `thinkox_action_log` VALUES ('8207', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586723');
INSERT INTO `thinkox_action_log` VALUES ('8208', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586806');
INSERT INTO `thinkox_action_log` VALUES ('8209', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586830');
INSERT INTO `thinkox_action_log` VALUES ('8210', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586855');
INSERT INTO `thinkox_action_log` VALUES ('8211', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586921');
INSERT INTO `thinkox_action_log` VALUES ('8212', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473586935');
INSERT INTO `thinkox_action_log` VALUES ('8213', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473587150');
INSERT INTO `thinkox_action_log` VALUES ('8214', '8', '1', '2002830702', 'attribute', '152', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473587326');
INSERT INTO `thinkox_action_log` VALUES ('8215', '8', '1', '2002830702', 'attribute', '124', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473593955');
INSERT INTO `thinkox_action_log` VALUES ('8216', '8', '1', '2002830702', 'attribute', '121', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473594077');
INSERT INTO `thinkox_action_log` VALUES ('8217', '8', '1', '2002830702', 'attribute', '123', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473594176');
INSERT INTO `thinkox_action_log` VALUES ('8218', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 20:06登录了后台', '1', '1473595618');
INSERT INTO `thinkox_action_log` VALUES ('8219', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-11 20:09登录了后台', '1', '1473595794');
INSERT INTO `thinkox_action_log` VALUES ('8220', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-11 20:14登录了后台', '1', '1473596083');
INSERT INTO `thinkox_action_log` VALUES ('8221', '17', '60', '2002830702', 'proposal', '174', '委员{user}在{time}成功提交了一份提案。', '1', '1473596100');
INSERT INTO `thinkox_action_log` VALUES ('8222', '17', '60', '2002830702', 'proposal', '176', '委员{user}在{time}成功提交了一份提案。', '1', '1473596133');
INSERT INTO `thinkox_action_log` VALUES ('8223', '8', '1', '2002830702', 'attribute', '156', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473596476');
INSERT INTO `thinkox_action_log` VALUES ('8224', '17', '60', '2002830702', 'proposal', '177', '委员{user}在{time}成功提交了一份提案。', '1', '1473596605');
INSERT INTO `thinkox_action_log` VALUES ('8225', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-11 20:29登录了后台', '1', '1473596981');
INSERT INTO `thinkox_action_log` VALUES ('8226', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-11 20:32登录了后台', '1', '1473597172');
INSERT INTO `thinkox_action_log` VALUES ('8227', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-11 20:37登录了后台', '1', '1473597422');
INSERT INTO `thinkox_action_log` VALUES ('8228', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-11 20:37登录了后台', '1', '1473597447');
INSERT INTO `thinkox_action_log` VALUES ('8229', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-11 20:37登录了后台', '1', '1473597458');
INSERT INTO `thinkox_action_log` VALUES ('8230', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-11 20:37登录了后台', '1', '1473597473');
INSERT INTO `thinkox_action_log` VALUES ('8231', '6', '1', '2002830702', 'config', '47', '操作url：/index.php?s=/admin/config/edit.html', '1', '1473644046');
INSERT INTO `thinkox_action_log` VALUES ('8232', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 10:12登录了后台', '1', '1473646334');
INSERT INTO `thinkox_action_log` VALUES ('8233', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 10:14登录了后台', '1', '1473646455');
INSERT INTO `thinkox_action_log` VALUES ('8234', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 10:16登录了后台', '1', '1473646603');
INSERT INTO `thinkox_action_log` VALUES ('8235', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 10:17登录了后台', '1', '1473646649');
INSERT INTO `thinkox_action_log` VALUES ('8236', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 10:23登录了后台', '1', '1473647029');
INSERT INTO `thinkox_action_log` VALUES ('8237', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2367.html', '1', '1473647369');
INSERT INTO `thinkox_action_log` VALUES ('8238', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2368.html', '1', '1473647381');
INSERT INTO `thinkox_action_log` VALUES ('8239', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2369.html', '1', '1473647401');
INSERT INTO `thinkox_action_log` VALUES ('8240', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2370.html', '1', '1473647409');
INSERT INTO `thinkox_action_log` VALUES ('8241', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2371.html', '1', '1473647414');
INSERT INTO `thinkox_action_log` VALUES ('8242', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2372.html', '1', '1473647421');
INSERT INTO `thinkox_action_log` VALUES ('8243', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2373.html', '1', '1473647427');
INSERT INTO `thinkox_action_log` VALUES ('8244', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2374.html', '1', '1473647432');
INSERT INTO `thinkox_action_log` VALUES ('8245', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2375.html', '1', '1473647439');
INSERT INTO `thinkox_action_log` VALUES ('8246', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2376.html', '1', '1473647445');
INSERT INTO `thinkox_action_log` VALUES ('8247', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2377.html', '1', '1473647451');
INSERT INTO `thinkox_action_log` VALUES ('8248', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2378.html', '1', '1473647457');
INSERT INTO `thinkox_action_log` VALUES ('8249', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2379.html', '1', '1473647462');
INSERT INTO `thinkox_action_log` VALUES ('8250', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2366.html', '1', '1473647469');
INSERT INTO `thinkox_action_log` VALUES ('8251', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2365.html', '1', '1473647521');
INSERT INTO `thinkox_action_log` VALUES ('8252', '10', '1', '2002830702', 'Menu', '0', '操作url：/index.php?s=/admin/menu/del/id/2364.html', '1', '1473647540');
INSERT INTO `thinkox_action_log` VALUES ('8253', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 10:37登录了后台', '1', '1473647872');
INSERT INTO `thinkox_action_log` VALUES ('8254', '1', '68', '2002830702', 'member', '68', 'bldw3在2016-09-12 10:39登录了后台', '1', '1473647947');
INSERT INTO `thinkox_action_log` VALUES ('8255', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 10:40登录了后台', '1', '1473648004');
INSERT INTO `thinkox_action_log` VALUES ('8256', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 10:43登录了后台', '1', '1473648222');
INSERT INTO `thinkox_action_log` VALUES ('8257', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 10:44登录了后台', '1', '1473648278');
INSERT INTO `thinkox_action_log` VALUES ('8258', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 10:44登录了后台', '1', '1473648278');
INSERT INTO `thinkox_action_log` VALUES ('8259', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 10:45登录了后台', '1', '1473648305');
INSERT INTO `thinkox_action_log` VALUES ('8260', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-12 10:46登录了后台', '1', '1473648405');
INSERT INTO `thinkox_action_log` VALUES ('8261', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 10:47登录了后台', '1', '1473648438');
INSERT INTO `thinkox_action_log` VALUES ('8262', '1', '65', '2002830702', 'member', '65', 'dcs在2016-09-12 10:49登录了后台', '1', '1473648546');
INSERT INTO `thinkox_action_log` VALUES ('8263', '8', '1', '2002830702', 'attribute', '135', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473648673');
INSERT INTO `thinkox_action_log` VALUES ('8264', '8', '1', '2002830702', 'attribute', '131', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473648695');
INSERT INTO `thinkox_action_log` VALUES ('8265', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473648737');
INSERT INTO `thinkox_action_log` VALUES ('8266', '8', '1', '2002830702', 'attribute', '132', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473649038');
INSERT INTO `thinkox_action_log` VALUES ('8267', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-12 10:57登录了后台', '1', '1473649061');
INSERT INTO `thinkox_action_log` VALUES ('8268', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 11:11登录了后台', '1', '1473649886');
INSERT INTO `thinkox_action_log` VALUES ('8269', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473650696');
INSERT INTO `thinkox_action_log` VALUES ('8270', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473650729');
INSERT INTO `thinkox_action_log` VALUES ('8271', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473650752');
INSERT INTO `thinkox_action_log` VALUES ('8272', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473650874');
INSERT INTO `thinkox_action_log` VALUES ('8273', '8', '1', '2002830702', 'attribute', '127', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473651054');
INSERT INTO `thinkox_action_log` VALUES ('8274', '8', '1', '2002830702', 'attribute', '157', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473652483');
INSERT INTO `thinkox_action_log` VALUES ('8275', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 13:08登录了后台', '1', '1473656902');
INSERT INTO `thinkox_action_log` VALUES ('8276', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 13:16登录了后台', '1', '1473657410');
INSERT INTO `thinkox_action_log` VALUES ('8277', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 13:21登录了后台', '1', '1473657709');
INSERT INTO `thinkox_action_log` VALUES ('8278', '8', '1', '2002830702', 'attribute', '135', '操作url：/index.php?s=/admin/attribute/remove/id/135.html', '1', '1473658618');
INSERT INTO `thinkox_action_log` VALUES ('8279', '8', '1', '2002830702', 'attribute', '160', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473658666');
INSERT INTO `thinkox_action_log` VALUES ('8280', '41', '59', '2002830702', 'survey', '146', '{user}参与调研、视察、考察{record}', '1', '1473661316');
INSERT INTO `thinkox_action_log` VALUES ('8281', '41', '71', '2002830702', 'survey', '146', '{user}参与调研、视察、考察{record}', '1', '1473661316');
INSERT INTO `thinkox_action_log` VALUES ('8282', '41', '60', '2002830702', 'survey', '146', '{user}参与调研、视察、考察{record}', '1', '1473661316');
INSERT INTO `thinkox_action_log` VALUES ('8283', '41', '61', '2002830702', 'survey', '146', '{user}参与调研、视察、考察{record}', '1', '1473661316');
INSERT INTO `thinkox_action_log` VALUES ('8284', '41', '59', '2002830702', 'survey', '147', '{user}参与调研、视察、考察{record}', '1', '1473661397');
INSERT INTO `thinkox_action_log` VALUES ('8285', '41', '71', '2002830702', 'survey', '147', '{user}参与调研、视察、考察{record}', '1', '1473661397');
INSERT INTO `thinkox_action_log` VALUES ('8286', '41', '60', '2002830702', 'survey', '147', '{user}参与调研、视察、考察{record}', '1', '1473661397');
INSERT INTO `thinkox_action_log` VALUES ('8287', '41', '61', '2002830702', 'survey', '147', '{user}参与调研、视察、考察{record}', '1', '1473661397');
INSERT INTO `thinkox_action_log` VALUES ('8288', '41', '59', '2002830702', 'survey', '148', '{user}参与调研、视察、考察{record}', '1', '1473661408');
INSERT INTO `thinkox_action_log` VALUES ('8289', '41', '71', '2002830702', 'survey', '148', '{user}参与调研、视察、考察{record}', '1', '1473661408');
INSERT INTO `thinkox_action_log` VALUES ('8290', '41', '60', '2002830702', 'survey', '148', '{user}参与调研、视察、考察{record}', '1', '1473661408');
INSERT INTO `thinkox_action_log` VALUES ('8291', '41', '61', '2002830702', 'survey', '148', '{user}参与调研、视察、考察{record}', '1', '1473661408');
INSERT INTO `thinkox_action_log` VALUES ('8292', '41', '59', '2002830702', 'survey', '149', '{user}参与调研、视察、考察{record}', '1', '1473661421');
INSERT INTO `thinkox_action_log` VALUES ('8293', '41', '71', '2002830702', 'survey', '149', '{user}参与调研、视察、考察{record}', '1', '1473661421');
INSERT INTO `thinkox_action_log` VALUES ('8294', '41', '60', '2002830702', 'survey', '149', '{user}参与调研、视察、考察{record}', '1', '1473661421');
INSERT INTO `thinkox_action_log` VALUES ('8295', '41', '61', '2002830702', 'survey', '149', '{user}参与调研、视察、考察{record}', '1', '1473661421');
INSERT INTO `thinkox_action_log` VALUES ('8296', '41', '59', '2002830702', 'survey', '150', '{user}参与调研、视察、考察{record}', '1', '1473661449');
INSERT INTO `thinkox_action_log` VALUES ('8297', '41', '71', '2002830702', 'survey', '150', '{user}参与调研、视察、考察{record}', '1', '1473661449');
INSERT INTO `thinkox_action_log` VALUES ('8298', '41', '60', '2002830702', 'survey', '150', '{user}参与调研、视察、考察{record}', '1', '1473661449');
INSERT INTO `thinkox_action_log` VALUES ('8299', '41', '61', '2002830702', 'survey', '150', '{user}参与调研、视察、考察{record}', '1', '1473661449');
INSERT INTO `thinkox_action_log` VALUES ('8300', '41', '59', '2002830702', 'survey', '151', '{user}参与调研、视察、考察{record}', '1', '1473661450');
INSERT INTO `thinkox_action_log` VALUES ('8301', '41', '71', '2002830702', 'survey', '151', '{user}参与调研、视察、考察{record}', '1', '1473661450');
INSERT INTO `thinkox_action_log` VALUES ('8302', '41', '60', '2002830702', 'survey', '151', '{user}参与调研、视察、考察{record}', '1', '1473661450');
INSERT INTO `thinkox_action_log` VALUES ('8303', '41', '61', '2002830702', 'survey', '151', '{user}参与调研、视察、考察{record}', '1', '1473661450');
INSERT INTO `thinkox_action_log` VALUES ('8304', '41', '59', '2002830702', 'survey', '152', '{user}参与调研、视察、考察{record}', '1', '1473661462');
INSERT INTO `thinkox_action_log` VALUES ('8305', '41', '71', '2002830702', 'survey', '152', '{user}参与调研、视察、考察{record}', '1', '1473661462');
INSERT INTO `thinkox_action_log` VALUES ('8306', '41', '60', '2002830702', 'survey', '152', '{user}参与调研、视察、考察{record}', '1', '1473661462');
INSERT INTO `thinkox_action_log` VALUES ('8307', '41', '61', '2002830702', 'survey', '152', '{user}参与调研、视察、考察{record}', '1', '1473661462');
INSERT INTO `thinkox_action_log` VALUES ('8308', '41', '59', '2002830702', 'survey', '153', '{user}参与调研、视察、考察{record}', '1', '1473661484');
INSERT INTO `thinkox_action_log` VALUES ('8309', '41', '71', '2002830702', 'survey', '153', '{user}参与调研、视察、考察{record}', '1', '1473661484');
INSERT INTO `thinkox_action_log` VALUES ('8310', '41', '60', '2002830702', 'survey', '153', '{user}参与调研、视察、考察{record}', '1', '1473661484');
INSERT INTO `thinkox_action_log` VALUES ('8311', '41', '61', '2002830702', 'survey', '153', '{user}参与调研、视察、考察{record}', '1', '1473661484');
INSERT INTO `thinkox_action_log` VALUES ('8312', '41', '59', '2002830702', 'survey', '154', '{user}参与调研、视察、考察{record}', '1', '1473661485');
INSERT INTO `thinkox_action_log` VALUES ('8313', '41', '71', '2002830702', 'survey', '154', '{user}参与调研、视察、考察{record}', '1', '1473661485');
INSERT INTO `thinkox_action_log` VALUES ('8314', '41', '60', '2002830702', 'survey', '154', '{user}参与调研、视察、考察{record}', '1', '1473661485');
INSERT INTO `thinkox_action_log` VALUES ('8315', '41', '61', '2002830702', 'survey', '154', '{user}参与调研、视察、考察{record}', '1', '1473661485');
INSERT INTO `thinkox_action_log` VALUES ('8316', '41', '59', '2002830702', 'survey', '155', '{user}参与调研、视察、考察{record}', '1', '1473661504');
INSERT INTO `thinkox_action_log` VALUES ('8317', '41', '71', '2002830702', 'survey', '155', '{user}参与调研、视察、考察{record}', '1', '1473661504');
INSERT INTO `thinkox_action_log` VALUES ('8318', '41', '60', '2002830702', 'survey', '155', '{user}参与调研、视察、考察{record}', '1', '1473661504');
INSERT INTO `thinkox_action_log` VALUES ('8319', '41', '61', '2002830702', 'survey', '155', '{user}参与调研、视察、考察{record}', '1', '1473661504');
INSERT INTO `thinkox_action_log` VALUES ('8320', '41', '59', '2002830702', 'survey', '156', '{user}参与调研、视察、考察{record}', '1', '1473661512');
INSERT INTO `thinkox_action_log` VALUES ('8321', '41', '71', '2002830702', 'survey', '156', '{user}参与调研、视察、考察{record}', '1', '1473661512');
INSERT INTO `thinkox_action_log` VALUES ('8322', '41', '60', '2002830702', 'survey', '156', '{user}参与调研、视察、考察{record}', '1', '1473661512');
INSERT INTO `thinkox_action_log` VALUES ('8323', '41', '61', '2002830702', 'survey', '156', '{user}参与调研、视察、考察{record}', '1', '1473661512');
INSERT INTO `thinkox_action_log` VALUES ('8324', '41', '59', '2002830702', 'survey', '157', '{user}参与调研、视察、考察{record}', '1', '1473661556');
INSERT INTO `thinkox_action_log` VALUES ('8325', '41', '71', '2002830702', 'survey', '157', '{user}参与调研、视察、考察{record}', '1', '1473661556');
INSERT INTO `thinkox_action_log` VALUES ('8326', '41', '60', '2002830702', 'survey', '157', '{user}参与调研、视察、考察{record}', '1', '1473661556');
INSERT INTO `thinkox_action_log` VALUES ('8327', '41', '61', '2002830702', 'survey', '157', '{user}参与调研、视察、考察{record}', '1', '1473661556');
INSERT INTO `thinkox_action_log` VALUES ('8328', '41', '59', '2002830702', 'survey', '158', '{user}参与调研、视察、考察{record}', '1', '1473661565');
INSERT INTO `thinkox_action_log` VALUES ('8329', '41', '71', '2002830702', 'survey', '158', '{user}参与调研、视察、考察{record}', '1', '1473661565');
INSERT INTO `thinkox_action_log` VALUES ('8330', '41', '60', '2002830702', 'survey', '158', '{user}参与调研、视察、考察{record}', '1', '1473661565');
INSERT INTO `thinkox_action_log` VALUES ('8331', '41', '61', '2002830702', 'survey', '158', '{user}参与调研、视察、考察{record}', '1', '1473661565');
INSERT INTO `thinkox_action_log` VALUES ('8332', '41', '59', '2002830702', 'survey', '159', '{user}参与调研、视察、考察{record}', '1', '1473661573');
INSERT INTO `thinkox_action_log` VALUES ('8333', '41', '71', '2002830702', 'survey', '159', '{user}参与调研、视察、考察{record}', '1', '1473661573');
INSERT INTO `thinkox_action_log` VALUES ('8334', '41', '60', '2002830702', 'survey', '159', '{user}参与调研、视察、考察{record}', '1', '1473661573');
INSERT INTO `thinkox_action_log` VALUES ('8335', '41', '61', '2002830702', 'survey', '159', '{user}参与调研、视察、考察{record}', '1', '1473661573');
INSERT INTO `thinkox_action_log` VALUES ('8336', '34', '59', '2002830702', 'survey', '159', '{user}的调研报告{record}在全体委员会议上作大会发言', '1', '1473661573');
INSERT INTO `thinkox_action_log` VALUES ('8337', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 14:28登录了后台', '1', '1473661724');
INSERT INTO `thinkox_action_log` VALUES ('8338', '41', '59', '2002830702', 'survey', '160', '{user}参与调研、视察、考察{record}', '1', '1473661924');
INSERT INTO `thinkox_action_log` VALUES ('8339', '41', '71', '2002830702', 'survey', '160', '{user}参与调研、视察、考察{record}', '1', '1473661924');
INSERT INTO `thinkox_action_log` VALUES ('8340', '41', '60', '2002830702', 'survey', '160', '{user}参与调研、视察、考察{record}', '1', '1473661924');
INSERT INTO `thinkox_action_log` VALUES ('8341', '41', '61', '2002830702', 'survey', '160', '{user}参与调研、视察、考察{record}', '1', '1473661924');
INSERT INTO `thinkox_action_log` VALUES ('8342', '35', '59', '2002830702', 'survey', '160', '{user}的调研报告{record}在全体委员会议上作书面交流', '1', '1473661924');
INSERT INTO `thinkox_action_log` VALUES ('8343', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 14:36登录了后台', '1', '1473662183');
INSERT INTO `thinkox_action_log` VALUES ('8344', '41', '59', '2002830702', 'survey', '161', '{user}参与调研、视察、考察{record}', '1', '1473662225');
INSERT INTO `thinkox_action_log` VALUES ('8345', '41', '71', '2002830702', 'survey', '161', '{user}参与调研、视察、考察{record}', '1', '1473662225');
INSERT INTO `thinkox_action_log` VALUES ('8346', '41', '60', '2002830702', 'survey', '161', '{user}参与调研、视察、考察{record}', '1', '1473662225');
INSERT INTO `thinkox_action_log` VALUES ('8347', '41', '61', '2002830702', 'survey', '161', '{user}参与调研、视察、考察{record}', '1', '1473662225');
INSERT INTO `thinkox_action_log` VALUES ('8348', '34', '59', '2002830702', 'survey', '161', '{user}的调研报告{record}在全体委员会议上作大会发言', '1', '1473662225');
INSERT INTO `thinkox_action_log` VALUES ('8349', '8', '1', '2002830702', 'attribute', '130', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473662380');
INSERT INTO `thinkox_action_log` VALUES ('8350', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 14:41登录了后台', '1', '1473662505');
INSERT INTO `thinkox_action_log` VALUES ('8351', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 14:46登录了后台', '1', '1473662781');
INSERT INTO `thinkox_action_log` VALUES ('8352', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 14:47登录了后台', '1', '1473662841');
INSERT INTO `thinkox_action_log` VALUES ('8353', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 15:03登录了后台', '1', '1473663790');
INSERT INTO `thinkox_action_log` VALUES ('8354', '8', '1', '2002830702', 'attribute', '138', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473664293');
INSERT INTO `thinkox_action_log` VALUES ('8355', '7', '1', '2002830702', 'model', '10', '操作url：/index.php?s=/admin/model/update.html', '1', '1473664673');
INSERT INTO `thinkox_action_log` VALUES ('8356', '8', '1', '2002830702', 'attribute', '137', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473664705');
INSERT INTO `thinkox_action_log` VALUES ('8357', '8', '1', '2002830702', 'attribute', '161', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473664745');
INSERT INTO `thinkox_action_log` VALUES ('8358', '8', '1', '2002830702', 'attribute', '141', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473664900');
INSERT INTO `thinkox_action_log` VALUES ('8359', '8', '1', '2002830702', 'attribute', '139', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473664924');
INSERT INTO `thinkox_action_log` VALUES ('8360', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 15:23登录了后台', '1', '1473665006');
INSERT INTO `thinkox_action_log` VALUES ('8361', '8', '1', '2002830702', 'attribute', '142', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473665779');
INSERT INTO `thinkox_action_log` VALUES ('8362', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 15:36登录了后台', '1', '1473665800');
INSERT INTO `thinkox_action_log` VALUES ('8363', '8', '1', '2002830702', 'attribute', '140', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473665800');
INSERT INTO `thinkox_action_log` VALUES ('8364', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 16:08登录了后台', '1', '1473667694');
INSERT INTO `thinkox_action_log` VALUES ('8365', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-12 16:10登录了后台', '1', '1473667853');
INSERT INTO `thinkox_action_log` VALUES ('8366', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 16:13登录了后台', '1', '1473668016');
INSERT INTO `thinkox_action_log` VALUES ('8367', '8', '1', '2002830702', 'attribute', '162', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473668117');
INSERT INTO `thinkox_action_log` VALUES ('8368', '1', '64', '2002830702', 'member', '64', 'taw在2016-09-12 16:40登录了后台', '1', '1473669618');
INSERT INTO `thinkox_action_log` VALUES ('8369', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 16:43登录了后台', '1', '1473669790');
INSERT INTO `thinkox_action_log` VALUES ('8370', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 16:53登录了后台', '1', '1473670405');
INSERT INTO `thinkox_action_log` VALUES ('8371', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 16:58登录了后台', '1', '1473670706');
INSERT INTO `thinkox_action_log` VALUES ('8372', '8', '1', '2002830702', 'attribute', '163', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473670778');
INSERT INTO `thinkox_action_log` VALUES ('8373', '8', '1', '2002830702', 'attribute', '118', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473677206');
INSERT INTO `thinkox_action_log` VALUES ('8374', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 18:46登录了后台', '1', '1473677207');
INSERT INTO `thinkox_action_log` VALUES ('8375', '8', '1', '2002830702', 'attribute', '113', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473677265');
INSERT INTO `thinkox_action_log` VALUES ('8376', '8', '1', '2002830702', 'attribute', '150', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473680228');
INSERT INTO `thinkox_action_log` VALUES ('8377', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 19:37登录了后台', '1', '1473680244');
INSERT INTO `thinkox_action_log` VALUES ('8378', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 19:44登录了后台', '1', '1473680699');
INSERT INTO `thinkox_action_log` VALUES ('8379', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 19:46登录了后台', '1', '1473680763');
INSERT INTO `thinkox_action_log` VALUES ('8380', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 19:47登录了后台', '1', '1473680846');
INSERT INTO `thinkox_action_log` VALUES ('8381', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 19:54登录了后台', '1', '1473681286');
INSERT INTO `thinkox_action_log` VALUES ('8382', '8', '1', '2002830702', 'attribute', '113', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473682246');
INSERT INTO `thinkox_action_log` VALUES ('8383', '8', '1', '2002830702', 'attribute', '113', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473682327');
INSERT INTO `thinkox_action_log` VALUES ('8384', '8', '1', '2002830702', 'attribute', '163', '操作url：/index.php?s=/admin/attribute/remove/id/163.html', '1', '1473682387');
INSERT INTO `thinkox_action_log` VALUES ('8385', '8', '1', '2002830702', 'attribute', '165', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473682444');
INSERT INTO `thinkox_action_log` VALUES ('8386', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 20:22登录了后台', '1', '1473682928');
INSERT INTO `thinkox_action_log` VALUES ('8387', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-12 20:22登录了后台', '1', '1473682978');
INSERT INTO `thinkox_action_log` VALUES ('8388', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 20:24登录了后台', '1', '1473683076');
INSERT INTO `thinkox_action_log` VALUES ('8389', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 20:27登录了后台', '1', '1473683279');
INSERT INTO `thinkox_action_log` VALUES ('8390', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 20:40登录了后台', '1', '1473684048');
INSERT INTO `thinkox_action_log` VALUES ('8391', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-12 20:43登录了后台', '1', '1473684204');
INSERT INTO `thinkox_action_log` VALUES ('8392', '1', '60', '2002830702', 'member', '60', 'wyy2在2016-09-12 20:48登录了后台', '1', '1473684504');
INSERT INTO `thinkox_action_log` VALUES ('8393', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-12 20:49登录了后台', '1', '1473684556');
INSERT INTO `thinkox_action_log` VALUES ('8394', '8', '1', '2002830702', 'attribute', '118', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473686121');
INSERT INTO `thinkox_action_log` VALUES ('8395', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-12 21:23登录了后台', '1', '1473686630');
INSERT INTO `thinkox_action_log` VALUES ('8396', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-12 21:27登录了后台', '1', '1473686846');
INSERT INTO `thinkox_action_log` VALUES ('8397', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-12 21:28登录了后台', '1', '1473686881');
INSERT INTO `thinkox_action_log` VALUES ('8398', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 09:05登录了后台', '1', '1473728707');
INSERT INTO `thinkox_action_log` VALUES ('8399', '1', '60', '3707332670', 'member', '60', 'wyy2在2016-09-13 09:07登录了后台', '1', '1473728820');
INSERT INTO `thinkox_action_log` VALUES ('8400', '1', '69', '3707332670', 'member', '69', 'zxbgs在2016-09-13 09:27登录了后台', '1', '1473730024');
INSERT INTO `thinkox_action_log` VALUES ('8401', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 09:31登录了后台', '1', '1473730294');
INSERT INTO `thinkox_action_log` VALUES ('8402', '1', '70', '3707332670', 'member', '70', 'bgszr在2016-09-13 09:33登录了后台', '1', '1473730392');
INSERT INTO `thinkox_action_log` VALUES ('8403', '29', '70', '3707332670', 'polls', '102', '{user}的建议{record}被全国政协或国家级新闻媒体采用', '1', '1473730501');
INSERT INTO `thinkox_action_log` VALUES ('8404', '33', '70', '3707332670', 'polls', '102', '{user}的建议{record}被中央领导批示', '1', '1473730501');
INSERT INTO `thinkox_action_log` VALUES ('8405', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 09:43登录了后台', '1', '1473731015');
INSERT INTO `thinkox_action_log` VALUES ('8406', '8', '1', '2002830702', 'attribute', '110', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473731191');
INSERT INTO `thinkox_action_log` VALUES ('8407', '8', '1', '2002830702', 'attribute', '112', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473731645');
INSERT INTO `thinkox_action_log` VALUES ('8408', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 10:05登录了后台', '1', '1473732300');
INSERT INTO `thinkox_action_log` VALUES ('8409', '1', '59', '3707332670', 'member', '59', 'wyy1在2016-09-13 10:06登录了后台', '1', '1473732383');
INSERT INTO `thinkox_action_log` VALUES ('8410', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 10:19登录了后台', '1', '1473733162');
INSERT INTO `thinkox_action_log` VALUES ('8411', '1', '59', '3707332670', 'member', '59', 'wyy1在2016-09-13 10:27登录了后台', '1', '1473733620');
INSERT INTO `thinkox_action_log` VALUES ('8412', '1', '1', '3707332670', 'member', '1', 'admin在2016-09-13 10:31登录了后台', '1', '1473733874');
INSERT INTO `thinkox_action_log` VALUES ('8413', '1', '64', '3707332670', 'member', '64', 'taw在2016-09-13 10:33登录了后台', '1', '1473734029');
INSERT INTO `thinkox_action_log` VALUES ('8414', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 10:40登录了后台', '1', '1473734436');
INSERT INTO `thinkox_action_log` VALUES ('8415', '1', '1', '3707332670', 'member', '1', 'admin在2016-09-13 10:46登录了后台', '1', '1473734778');
INSERT INTO `thinkox_action_log` VALUES ('8416', '1', '59', '3707332670', 'member', '59', 'wyy1在2016-09-13 10:48登录了后台', '1', '1473734932');
INSERT INTO `thinkox_action_log` VALUES ('8417', '1', '59', '3707332670', 'member', '59', 'wyy1在2016-09-13 10:49登录了后台', '1', '1473734997');
INSERT INTO `thinkox_action_log` VALUES ('8418', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 10:57登录了后台', '1', '1473735428');
INSERT INTO `thinkox_action_log` VALUES ('8419', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-13 11:03登录了后台', '1', '1473735833');
INSERT INTO `thinkox_action_log` VALUES ('8420', '29', '70', '2002830702', 'polls', '95', '{user}的建议{record}被全国政协或国家级新闻媒体采用', '1', '1473735859');
INSERT INTO `thinkox_action_log` VALUES ('8421', '33', '70', '2002830702', 'polls', '95', '{user}的建议{record}被中央领导批示', '1', '1473735859');
INSERT INTO `thinkox_action_log` VALUES ('8422', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 11:05登录了后台', '1', '1473735902');
INSERT INTO `thinkox_action_log` VALUES ('8423', '1', '96', '2002830702', 'member', '96', 'dominator在2016-09-13 11:14登录了后台', '1', '1473736440');
INSERT INTO `thinkox_action_log` VALUES ('8424', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 11:14登录了后台', '1', '1473736457');
INSERT INTO `thinkox_action_log` VALUES ('8425', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-13 11:14登录了后台', '1', '1473736490');
INSERT INTO `thinkox_action_log` VALUES ('8426', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 11:17登录了后台', '1', '1473736641');
INSERT INTO `thinkox_action_log` VALUES ('8427', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 11:41登录了后台', '1', '1473738099');
INSERT INTO `thinkox_action_log` VALUES ('8428', '1', '67', '2002830702', 'member', '67', 'bldw2在2016-09-13 11:46登录了后台', '1', '1473738382');
INSERT INTO `thinkox_action_log` VALUES ('8429', '1', '66', '2002830702', 'member', '66', 'bldw1在2016-09-13 11:46登录了后台', '1', '1473738396');
INSERT INTO `thinkox_action_log` VALUES ('8430', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 11:49登录了后台', '1', '1473738547');
INSERT INTO `thinkox_action_log` VALUES ('8431', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 12:42登录了后台', '1', '1473741778');
INSERT INTO `thinkox_action_log` VALUES ('8432', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 12:46登录了后台', '1', '1473742001');
INSERT INTO `thinkox_action_log` VALUES ('8433', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 12:47登录了后台', '1', '1473742064');
INSERT INTO `thinkox_action_log` VALUES ('8434', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 12:51登录了后台', '1', '1473742265');
INSERT INTO `thinkox_action_log` VALUES ('8435', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-13 12:51登录了后台', '1', '1473742280');
INSERT INTO `thinkox_action_log` VALUES ('8436', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-13 12:53登录了后台', '1', '1473742384');
INSERT INTO `thinkox_action_log` VALUES ('8437', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 13:12登录了后台', '1', '1473743544');
INSERT INTO `thinkox_action_log` VALUES ('8438', '17', '59', '2002830702', 'proposal', '164', '委员{user}在{time}成功提交了一份提案。', '1', '1473743668');
INSERT INTO `thinkox_action_log` VALUES ('8439', '1', '1', '2002830702', 'member', '1', 'admin在2016-09-13 13:21登录了后台', '1', '1473744067');
INSERT INTO `thinkox_action_log` VALUES ('8440', '8', '1', '2002830702', 'attribute', '121', '操作url：/index.php?s=/admin/attribute/update.html', '1', '1473744091');
INSERT INTO `thinkox_action_log` VALUES ('8441', '1', '59', '3707332670', 'member', '59', 'wyy1在2016-09-13 13:24登录了后台', '1', '1473744262');
INSERT INTO `thinkox_action_log` VALUES ('8442', '1', '70', '2002830702', 'member', '70', 'bgszr在2016-09-13 13:38登录了后台', '1', '1473745092');
INSERT INTO `thinkox_action_log` VALUES ('8443', '1', '69', '2002830702', 'member', '69', 'zxbgs在2016-09-13 13:38登录了后台', '1', '1473745113');
INSERT INTO `thinkox_action_log` VALUES ('8444', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 13:44登录了后台', '1', '1473745485');
INSERT INTO `thinkox_action_log` VALUES ('8445', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 15:17登录了后台', '1', '1473751041');
INSERT INTO `thinkox_action_log` VALUES ('8446', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 15:19登录了后台', '1', '1473751190');
INSERT INTO `thinkox_action_log` VALUES ('8447', '1', '59', '1035423181', 'member', '59', 'wyy1在2016-09-13 15:36登录了后台', '1', '1473752162');
INSERT INTO `thinkox_action_log` VALUES ('8448', '1', '60', '1035423177', 'member', '60', 'wyy2在2016-09-13 15:36登录了后台', '1', '1473752199');
INSERT INTO `thinkox_action_log` VALUES ('8449', '1', '59', '1035423180', 'member', '59', 'wyy1在2016-09-13 16:14登录了后台', '1', '1473754469');
INSERT INTO `thinkox_action_log` VALUES ('8450', '1', '59', '2002830702', 'member', '59', 'wyy1在2016-09-13 18:02登录了后台', '1', '1473760924');

-- ----------------------------
-- Table structure for thinkox_addons
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_addons`;
CREATE TABLE `thinkox_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of thinkox_addons
-- ----------------------------
INSERT INTO `thinkox_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `thinkox_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `thinkox_addons` VALUES ('89', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"\\u706b\\u51e4\\u51f0\\u4e91\\u57fa\\u5730\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1409038881', '0');
INSERT INTO `thinkox_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `thinkox_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `thinkox_addons` VALUES ('99', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1470377654', '1');
INSERT INTO `thinkox_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');
INSERT INTO `thinkox_addons` VALUES ('102', 'Avatar', '头像插件', '用于头像的上传', '1', '{\"random\":\"1\"}', 'caipeichao', '0.1', '1473056832', '1');
INSERT INTO `thinkox_addons` VALUES ('49', 'Checkin', '签到', '签到积分', '1', '{\"random\":\"1\"}', '想天软件工作室', '0.1', '1403764341', '1');
INSERT INTO `thinkox_addons` VALUES ('58', 'SyncLogin', '同步登陆', '同步登陆', '1', '{\"type\":null,\"meta\":\"\",\"bind\":\"0\",\"QqKEY\":\"\",\"QqSecret\":\"\",\"SinaKEY\":\"\",\"SinaSecret\":\"\"}', 'xjw129xjt', '0.1', '1406598876', '0');
INSERT INTO `thinkox_addons` VALUES ('41', 'LocalComment', '本地评论', '本地评论插件，不依赖社会化评论平台', '1', '{\"can_guest_comment\":\"1\"}', 'caipeichao', '0.1', '1399440324', '0');
INSERT INTO `thinkox_addons` VALUES ('44', 'InsertImage', '插入图片', '微博上传图片', '1', 'null', '想天软件工作室', '0.1', '1402390777', '0');
INSERT INTO `thinkox_addons` VALUES ('48', 'Repost', '转发', '转发', '1', 'null', '想天软件工作室', '0.1', '1403763025', '0');
INSERT INTO `thinkox_addons` VALUES ('63', 'Advertising', '广告位置', '广告位插件', '1', 'null', 'onep2p', '0.1', '1406689090', '1');
INSERT INTO `thinkox_addons` VALUES ('64', 'Advs', '广告管理', '广告插件', '1', 'null', 'onep2p', '0.1', '1406689131', '1');
INSERT INTO `thinkox_addons` VALUES ('68', 'ImageSlider', '图片轮播', '图片轮播，需要先通过 http://www.onethink.cn/topic/2153.html 的方法，让配置支持多图片上传', '1', '{\"second\":\"3000\",\"direction\":\"horizontal\",\"imgWidth\":\"760\",\"imgHeight\":\"350\",\"url\":\"\",\"images\":\"92,93,94\"}', 'birdy', '0.1', '1407144129', '0');
INSERT INTO `thinkox_addons` VALUES ('70', 'SuperLinks', '合作单位', '合作单位', '1', '{\"random\":\"1\"}', '苏南 newsn.net', '0.1', '1407156572', '1');
INSERT INTO `thinkox_addons` VALUES ('91', 'Rank_checkin', '签到排名', '设置每天某一时刻开始 按时间先后 签到排名，取前十', '1', '{\"random\":\"1\",\"ranktime\":null}', '嘉兴想天信息科技有限公司', '0.1', '1409109841', '1');
INSERT INTO `thinkox_addons` VALUES ('84', 'Support', '赞', '赞的功能', '1', 'null', '嘉兴想天信息科技有限公司', '0.1', '1408499141', '0');
INSERT INTO `thinkox_addons` VALUES ('94', 'ChinaCity', '中国省市区三级联动', '每个系统都需要的一个中国省市区三级联动插件。想天-駿濤修改，将镇级地区移除', '1', 'null', 'i友街', '2.0', '1469586339', '0');
INSERT INTO `thinkox_addons` VALUES ('97', 'CheckinModule', '会议签到', '模块签到插件', '1', '{\"random\":\"1\"}', 'MR.Z', '0.1', '1470033944', '0');
INSERT INTO `thinkox_addons` VALUES ('98', 'JqQrcode', 'jQuery二维码', '用jQuery 生成站点内所需要的二维码', '1', '{\"article_status\":\"1\",\"width\":\"200\",\"height\":\"200\",\"typeNumber\":\"-1\",\"correctLevel\":\"2\",\"background\":\"#ffffff\",\"foreground\":\"#000000\"}', 'yangweijie', '0.2', '1470040188', '0');
INSERT INTO `thinkox_addons` VALUES ('100', 'UploadFiles', '批量上传文件', '批量上传文件', '1', 'null', 'MR.Z', '0.1', '1471596341', '0');

-- ----------------------------
-- Table structure for thinkox_advertising
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_advertising`;
CREATE TABLE `thinkox_advertising` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告位置名称',
  `type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '广告位置展示方式  0为默认展示一张',
  `width` char(20) NOT NULL DEFAULT '' COMMENT '广告位置宽度',
  `height` char(20) NOT NULL DEFAULT '' COMMENT '广告位置高度',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `pos` varchar(50) NOT NULL,
  `s` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置表';

-- ----------------------------
-- Records of thinkox_advertising
-- ----------------------------
INSERT INTO `thinkox_advertising` VALUES ('1', '微博发布框下方', '2', '620', '87', '1', 'weibo_below_sendbox', '0');
INSERT INTO `thinkox_advertising` VALUES ('2', '微博首页签到排行下方', '4', '', '', '1', 'weibo_below_checkrank', '0');
INSERT INTO `thinkox_advertising` VALUES ('3', '首页1号广告位', '1', '756', '100', '1', 'home_ad1', '0');

-- ----------------------------
-- Table structure for thinkox_advs
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_advs`;
CREATE TABLE `thinkox_advs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告名称',
  `position` int(11) NOT NULL COMMENT '广告位置',
  `advspic` int(11) NOT NULL COMMENT '图片地址',
  `advstext` text NOT NULL COMMENT '文字广告内容',
  `advshtml` text NOT NULL COMMENT '代码广告内容',
  `link` char(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `level` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告表';

-- ----------------------------
-- Records of thinkox_advs
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_announce
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_announce`;
CREATE TABLE `thinkox_announce` (
  `id` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(80) NOT NULL,
  `content` text NOT NULL,
  `starttime` date NOT NULL DEFAULT '0000-00-00',
  `endtime` date NOT NULL DEFAULT '0000-00-00',
  `username` varchar(40) NOT NULL,
  `addtime` varchar(15) NOT NULL DEFAULT '0',
  `hits` smallint(5) unsigned NOT NULL DEFAULT '0',
  `updatetime` varchar(15) NOT NULL DEFAULT '0',
  `status` smallint(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `siteid` (`updatetime`,`endtime`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_announce
-- ----------------------------
INSERT INTO `thinkox_announce` VALUES ('2', '我是一个公告', '就是一个公告', '0000-00-00', '0000-00-00', '', '1469524418', '0', '1469524418', '1');

-- ----------------------------
-- Table structure for thinkox_attachment
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_attachment`;
CREATE TABLE `thinkox_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of thinkox_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_attribute
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_attribute`;
CREATE TABLE `thinkox_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of thinkox_attribute
-- ----------------------------
INSERT INTO `thinkox_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('33', 'zx', '附件', 'int(10) UNSIGNED NOT NULL', 'file', '', '', '1', '', '2', '0', '1', '1395988634', '1395988634', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('34', 'uid', '发起人', 'int(11) NOT NULL ', 'string', '', '', '1', '', '4', '0', '1', '1470387576', '1470387576', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('35', 'title', '提案名称', 'varchar(255) NOT NULL ', 'string', '', '--案由--', '1', '', '4', '0', '1', '1472802664', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('36', 'content', '详细内容', 'text NOT NULL ', 'textarea', '', '', '1', '', '4', '0', '1', '1470637982', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('37', 'create_time', '创建时间', 'int(11) NOT NULL ', 'datetime', '', '', '1', '', '4', '0', '1', '1471397421', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('53', 'ycode', '预案号', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '4', '0', '1', '1470391585', '1470391585', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('49', 'renshu', '人数', 'int(5) UNSIGNED NOT NULL', 'num', '1', '', '1', '', '4', '1', '1', '1470391483', '1470391483', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('40', 'status', '状态', 'int(11) NOT NULL ', 'string', '', '', '1', '', '4', '0', '1', '1470391295', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('41', 'update_time', '更新时间', 'int(11) NOT NULL ', 'string', '', '', '1', '', '4', '0', '1', '1470391269', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('44', 'type_id', '类别', 'int(11) NOT NULL ', 'string', '', '', '1', '', '4', '1', '1', '1470391228', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('46', 'is_public', '是否公开', 'tinyint(2) NOT NULL ', 'radio', '', '', '1', '是\r\n否', '4', '0', '1', '1470391044', '1470387576', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('47', 'jiebie', '界别组', 'varchar(30) NOT NULL ', 'selectzh', '', '--界别组--', '1', '中共\r\n群众\r\n团员\r\n中国国民党革命委员会\r\n中国民主同盟\r\n中国民主建国会\r\n中国民主促进会\r\n中国农工民主党\r\n中国致公党\r\n九三学社\r\n无党派人员\r\n中国共产主义青年团\r\n中华全国总工会\r\n中华全国妇女联合会\r\n中华全国青年联合会\r\n中国科学技术协会\r\n中华全国台湾同胞联谊会\r\n中华全国归国华侨联合会\r\n文化艺术界\r\n科学技术界\r\n社会科学界\r\n经济界\r\n农业界\r\n教育界\r\n体育节\r\n新闻出版界\r\n医药卫生界\r\n对外友好界\r\n社会福利和社会保障界\r\n少数民族界\r\n宗教界\r\n特别邀请人士', '4', '0', '1', '1472802609', '1470390388', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('80', 'meet', '会议次数', 'char(50) NOT NULL', 'string', '', '', '1', '', '4', '1', '1', '1473501888', '1470887855', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('51', 'author', '提案人', 'varchar(30) NOT NULL', 'string', '', '--提案人--', '1', '', '4', '1', '1', '1472802636', '1470391644', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('52', 'fujian', '附件', 'int(10) UNSIGNED NOT NULL', 'file', '', '', '1', '', '4', '0', '1', '1470391684', '1470391684', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('54', 'uid', '发起人', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707529', '1470707529', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('55', 'title', '活动名称', 'varchar(255) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('56', 'explain', '详细内容', 'text NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('57', 'sTime', '活动开始时间', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('58', 'eTime', '活动结束时间', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('59', 'address', '活动地点', 'varchar(255) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('60', 'create_time', '创建时间', 'int(11) NOT NULL ', 'datetime', '', '', '1', '', '5', '0', '1', '1473301899', '1470707530', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('61', 'limitCount', '限制人数', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('62', 'cover_id', '封面ID', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('64', 'attentionCount', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('65', 'status', '', 'int(11) NOT NULL ', 'string', '', '状态', '1', '', '5', '0', '1', '1470707664', '1470707530', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('66', 'update_time', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('67', 'view_count', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('68', 'reply_count', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('69', 'type_id', '类别', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707726', '1470707530', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('70', 'signCount', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707530', '1470707530', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('71', 'is_recommend', '是否推荐', 'tinyint(4) NOT NULL ', 'string', '', '', '1', '', '5', '0', '1', '1470707717', '1470707530', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('72', 'meet_type', '提出期间', 'varchar(30) NOT NULL', 'selectzh', '', '--提出期间--', '1', '会议期间\r\n闭会期间', '4', '1', '1', '1472802593', '1470391644', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('73', 'is_joint', '是否联名', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '是\r\n否', '4', '0', '1', '1470821072', '1470391644', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('74', 'contact', '联系人', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '4', '0', '1', '1470888675', '1470391644', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('75', 'telephone', '联系方式', 'varchar(30) NOT NULL', 'string', '', '', '1', '', '4', '1', '1', '1470830034', '1470830034', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('77', 'is_merge', '是否并案', 'tinyint(2) NOT NULL', 'bool', '0', '', '1', '否\r\n是', '4', '0', '1', '1470879352', '1470879146', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('83', 'recommend', '推荐', 'varchar(10) NOT NULL', 'checkbox', '', '', '1', '重点提案\r\n优秀提案\r\n建议案', '4', '0', '1', '1473579517', '1471241043', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('84', 'adopt', '采用', 'varchar(100) NOT NULL', 'checkbox', '', '', '1', '国家\r\n省\r\n市\r\n区', '4', '0', '1', '1471241097', '1471241097', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('85', 'write', '批示', 'varchar(100) NOT NULL', 'checkbox', '', '', '1', '国家\r\n省\r\n市\r\n区', '4', '0', '1', '1471241232', '1471241232', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('86', 'user_id', '执行用户id', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('87', 'group_id', '', 'int(10) NOT NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('88', 'proposal_id', '触发行为的数据id', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('89', 'rate', '自己评价', 'varchar(255) NOT NULL ', 'selectzh', '', '', '1', 'A 已经解决或采纳的\r\nB 列入计划拟解决的\r\nC 留做参考', '6', '0', '1', '1473411228', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('90', 'create_time', '执行行为的时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '6', '0', '1', '1472174231', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('91', 'status', '办理单位信息状态', 'tinyint(2) NOT NULL ', 'string', '1', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('92', 'to_status', '', 'tinyint(2) NOT NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('93', 'suggest', '内容', 'varchar(250) NULL ', 'textarea', '', '', '1', '', '6', '0', '1', '1473509221', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('94', 'leader', '分管领导', 'varchar(20) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('95', 'leaderphone', '领导电话', 'varchar(20) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('96', 'contact', '联系人', 'varchar(20) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('97', 'telephone', '联系电话', 'varchar(20) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1471312124', '1471312124', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('98', 'link_type', '沟通方式', 'varchar(30) NULL ', 'selectzh', '', '', '1', '电话\r\n走访\r\n坐谈', '6', '0', '1', '1472642122', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('99', 'link_time', '沟通时间', 'int(10) NULL ', 'datetime', '', '', '1', '', '6', '0', '1', '1472613396', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('100', 'fujian', '附件', 'varchar(200) NULL ', 'file', '', '', '1', '', '6', '0', '1', '1472117334', '1471312124', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('101', 'joint_content', '联名理由', 'text NOT NULL', 'textarea', '', '', '1', '', '4', '1', '1', '1471347853', '1471347853', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('102', 'contact_unit', '联系人单位', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '4', '0', '1', '1471397673', '1471397673', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('103', 'suggest', '提案委建议', 'text NOT NULL', 'textarea', '', '', '1', '', '4', '0', '1', '1472114355', '1472114355', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('104', 'wenhao', '文号', 'varchar(20) NOT NULL', 'string', '', '', '1', '', '6', '0', '1', '1472114550', '1472114550', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('105', 'handsuggest', '交办意见', 'text NOT NULL', 'textarea', '', '', '1', '', '4', '0', '1', '1472114780', '1472114780', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('106', 'unit', '单位', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '6', '0', '1', '1472195212', '1472195212', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('107', 'comment', '评价', 'char(10) NOT NULL', 'radio', '', '', '1', '满意\r\n基本满意\r\n不满意', '6', '0', '1', '1472641504', '1472641504', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('108', 'leibie', '类别', 'varchar(20) NOT NULL', 'string', '', '', '1', '', '4', '1', '1', '1472784392', '1472784392', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('109', 'jdllw', '街道联络委', 'varchar(255) NOT NULL', 'string', '', '隐藏表单用于排序', '0', '', '4', '1', '1', '1472784975', '1472784975', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('110', 'people', '作者ids', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '7', '0', '1', '1473731191', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('112', 'title', '标题', 'varchar(50) NOT NULL ', 'string', '', '--标题--', '1', '', '7', '0', '1', '1473731645', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('113', 'content', '内容', 'text NOT NULL ', 'editor', '', '', '1', '', '7', '0', '1', '1473682327', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('114', 'upload', '文件', 'varchar(50) NOT NULL ', 'file', '', '', '1', '', '7', '0', '1', '1472815758', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('115', 'adopt', '采用情况', 'varchar(50) NOT NULL ', 'checkbox', '', '', '1', '被区政协采用\r\n被市委、市政协或市级新闻媒体采用\r\n被省委、市政协或省级新闻媒体采用\r\n被全国政协或国家级新闻媒体采用', '7', '0', '1', '1472815720', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('116', 'make', '批示情况', 'varchar(80) NOT NULL ', 'checkbox', '', '', '1', '被区级领导批示\r\n被市级领导批示\r\n被省级领导批示\r\n被中央领导批示\r\n', '7', '0', '1', '1472815710', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('117', 'status', '状态', 'tinyint(4) NOT NULL ', 'string', '0', '', '1', '', '7', '0', '1', '1472813216', '1472813216', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('118', 'time', '时间', 'int(11) NOT NULL ', 'datetimejq', '', '', '1', '', '7', '0', '1', '1473686121', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('119', 'comments', '退回意见', 'text NOT NULL ', 'textarea', '', '', '1', '', '7', '0', '1', '1473320184', '1472813216', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('120', 'author', '发布人', 'varchar(40) NOT NULL ', 'string', '', '', '1', '', '8', '0', '1', '1473320074', '1473320074', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('121', 'time', '发布时间', 'timestamp NOT NULL ', 'datetimejq', 'CURRENT_TIMESTAMP', '', '1', '', '8', '0', '1', '1473744091', '1473320074', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('122', 'title', '标题', 'varchar(50) NOT NULL ', 'string', '', '', '1', '', '8', '0', '1', '1473320074', '1473320074', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('123', 'content', '内容', 'text NOT NULL ', 'editor', '', '', '1', '', '8', '0', '1', '1473594177', '1473320074', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('124', 'upload', '文件上传', 'varchar(50) NOT NULL ', 'file', '', '', '1', '', '8', '0', '1', '1473593955', '1473320074', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('125', 'status', '状态', 'int(11) NOT NULL ', 'string', '1', '', '1', '', '8', '0', '1', '1473320074', '1473320074', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('126', 'back', '退回意见', 'text NOT NULL ', 'string', '', '', '1', '', '8', '0', '1', '1473320074', '1473320074', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('127', 'time', '时间', 'int(11) NOT NULL ', 'datetimejq', '', '', '1', '', '9', '0', '1', '1473651054', '1473320087', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('128', 'author', '作者', 'varchar(150) NOT NULL ', 'string', '', '', '1', '', '9', '0', '1', '1473320087', '1473320087', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('129', 'type', '类别', 'varchar(150) NOT NULL ', 'string', '', '', '1', '', '9', '0', '1', '1473320087', '1473320087', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('130', 'title', '标题', 'varchar(150) NOT NULL ', 'string', '', '--标题--', '1', '', '9', '0', '1', '1473662380', '1473320087', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('131', 'content', '备注', 'text NOT NULL ', 'editor', '', '', '1', '', '9', '0', '1', '1473648695', '1473320087', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('132', 'upload', '文件上传', 'varchar(10) NOT NULL ', 'file', '', '', '1', '', '9', '0', '1', '1473649038', '1473320087', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('133', 'phone', '用户名', 'int(11) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1473320087', '1473320087', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('134', 'people', '姓名', 'text NOT NULL ', 'string', '', '', '1', '', '9', '0', '1', '1473320087', '1473320087', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('136', 'author', '作者', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1473320161', '1473320161', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('137', 'type_id', '类别', 'int(10) NOT NULL ', 'num', '', '', '1', '', '10', '0', '1', '1473664705', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('138', 'title', '标题', 'varchar(50) NOT NULL ', 'string', '', '--标题--', '1', '', '10', '0', '1', '1473664293', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('139', 'content', '备注', 'text NOT NULL ', 'editor', '', '', '1', '', '10', '0', '1', '1473664924', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('140', 'upload', '上传文件', 'varchar(50) NOT NULL ', 'file', '', '', '1', '', '10', '0', '1', '1473665800', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('141', 'time', '发表时间', 'int(11) NOT NULL ', 'datetimejq', '', '', '1', '', '10', '0', '1', '1473664900', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('142', 'adopt', '采用情况', 'varchar(9) NOT NULL ', 'radio', '', '', '1', '是\r\n否', '10', '0', '1', '1473665779', '1473320161', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('143', 'user_id', '执行用户id', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1473498443', '1473498443', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('144', 'proposal_id', '触发行为的数据id', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1473498443', '1473498443', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('145', 'is_agree', '是否同意联名', 'tinyint(2) NOT NULL ', 'radio', '', '', '1', '是\r\n否', '11', '0', '1', '1473498664', '1473498443', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('146', 'create_time', '创建的时间', 'int(10) unsigned NOT NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1473498443', '1473498443', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('147', 'suggest', '意见反馈', 'varchar(250) NULL ', 'textarea', '', '', '1', '', '11', '0', '1', '1473498577', '1473498443', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('148', 'uid', '', 'int(11) NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1473583597', '1473583597', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('149', 'title', '', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1473583597', '1473583597', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('150', 'content', '', 'text NOT NULL ', 'editor', '', '', '1', '', '12', '0', '1', '1473680228', '1473583597', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('151', 'stime', '', 'int(11) NOT NULL ', 'datetime', '', '', '1', '', '12', '0', '1', '1473585724', '1473583597', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('152', 'type', '公告类型', 'varchar(10) NOT NULL', 'selectzh', '', '', '1', '通知\r\n公告', '12', '0', '1', '1473587326', '1473583597', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('153', 'people', '', 'longtext NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1473583597', '1473583597', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('154', 'file', '附件', 'varchar(50) NOT NULL ', 'file', '', '', '1', '', '12', '0', '1', '1473583694', '1473583597', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `thinkox_attribute` VALUES ('155', 'status', '', 'tinyint(4) NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1473583597', '1473583597', '', '0', '', '', '', '0', '');
INSERT INTO `thinkox_attribute` VALUES ('156', 'zwh', '专委会', 'varchar(50) NOT NULL', 'string', '', '', '1', '', '4', '0', '1', '1473596477', '1473596477', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('160', 'speak', '发言情况', 'varchar(200) NOT NULL', 'checkbox', '', '', '1', '在全体委员会议上作大会发言\r\n在全体委员会议上作书面交流\r\n在常委会议或主席会议上就协商问题进行发言交流\r\n在常委会议或主席会议上就协商问题进行书面交流\r\n', '9', '0', '1', '1473658666', '1473658666', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('157', 'people_view', '展示参与人员', 'text NOT NULL', 'textarea', '', '', '1', '', '9', '1', '1', '1473652483', '1473652483', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('161', 'uid', '外键用户ID', 'int(10) UNSIGNED NOT NULL', 'num', '', '', '0', '', '10', '1', '1', '1473664745', '1473664745', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('162', 'type_id', '类型', 'varchar(255) NOT NULL', 'string', '', '', '1', '', '7', '0', '1', '1473668117', '1473668117', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `thinkox_attribute` VALUES ('165', 'people_view', '参与人员展示', 'text NOT NULL', 'textarea', '', '', '1', '', '7', '0', '1', '1473682444', '1473682444', '', '3', '', 'regex', '', '3', 'function');

-- ----------------------------
-- Table structure for thinkox_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_auth_extend`;
CREATE TABLE `thinkox_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of thinkox_auth_extend
-- ----------------------------
INSERT INTO `thinkox_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `thinkox_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for thinkox_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_auth_group`;
CREATE TABLE `thinkox_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` text NOT NULL COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_auth_group
-- ----------------------------
INSERT INTO `thinkox_auth_group` VALUES ('1', 'admin', '1', '普通用户', '', '1', '');
INSERT INTO `thinkox_auth_group` VALUES ('5', 'admin', '1', '委员', '个人可以提交提案。', '1', ',26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,88,94,95,324,325,327,407,408');
INSERT INTO `thinkox_auth_group` VALUES ('6', 'admin', '1', '集体', '集体可以提交提案。', '1', ',407,408');
INSERT INTO `thinkox_auth_group` VALUES ('9', 'admin', '1', '政府督查室', '对提案审核的工作人员。', '1', ',411,422,423,425,427,428,431');
INSERT INTO `thinkox_auth_group` VALUES ('7', 'admin', '1', '提案委', '针对提案进行审核操作。', '1', ',1,408,409,410,414,415,416,417,418,419,420,421,427,428');
INSERT INTO `thinkox_auth_group` VALUES ('8', 'admin', '1', '办理单位', '由政府办公室选定办理单位。', '1', ',424,425,429');
INSERT INTO `thinkox_auth_group` VALUES ('10', 'admin', '1', '政协办公室', '社情民意初审', '1', '');
INSERT INTO `thinkox_auth_group` VALUES ('11', 'admin', '1', '办公室主任', '社情民意终审。', '1', '');
INSERT INTO `thinkox_auth_group` VALUES ('12', 'admin', '1', '文史委工作人员', '', '1', '');
INSERT INTO `thinkox_auth_group` VALUES ('13', 'admin', '1', '专委会工作人员', '', '1', '');

-- ----------------------------
-- Table structure for thinkox_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_auth_group_access`;
CREATE TABLE `thinkox_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_auth_group_access
-- ----------------------------
INSERT INTO `thinkox_auth_group_access` VALUES ('0', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('1', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('58', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('59', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('59', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('60', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('60', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('61', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('61', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('62', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('63', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('64', '7');
INSERT INTO `thinkox_auth_group_access` VALUES ('65', '9');
INSERT INTO `thinkox_auth_group_access` VALUES ('66', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('67', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('68', '8');
INSERT INTO `thinkox_auth_group_access` VALUES ('69', '10');
INSERT INTO `thinkox_auth_group_access` VALUES ('70', '11');
INSERT INTO `thinkox_auth_group_access` VALUES ('71', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('72', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('73', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('74', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('75', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('77', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('78', '1');
INSERT INTO `thinkox_auth_group_access` VALUES ('79', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('81', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('82', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('83', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('84', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('85', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('86', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('94', '6');
INSERT INTO `thinkox_auth_group_access` VALUES ('95', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('96', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('97', '5');
INSERT INTO `thinkox_auth_group_access` VALUES ('98', '5');

-- ----------------------------
-- Table structure for thinkox_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_auth_rule`;
CREATE TABLE `thinkox_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=448 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_auth_rule
-- ----------------------------
INSERT INTO `thinkox_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '资讯', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '用户信息', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('217', 'admin', '1', 'Admin/Forum/forum', '板块管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('218', 'admin', '1', 'Admin/Forum/post', '帖子管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('219', 'admin', '1', 'Admin/Forum/editForum', '编辑／创建板块', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Forum/editPost', '编辑帖子', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('221', 'admin', '2', 'Admin//Admin/Forum/index', '讨论区', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('222', 'admin', '2', 'Admin//Admin/Weibo/index', '微博', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Forum/sortForum', '排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('224', 'admin', '1', 'Admin/SEO/editRule', '新增、编辑', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('225', 'admin', '1', 'Admin/SEO/sortRule', '排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('226', 'admin', '1', 'Admin/SEO/index', '规则管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('227', 'admin', '1', 'Admin/Forum/editReply', '新增/编辑回复', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('228', 'admin', '1', 'Admin/Weibo/editComment', '编辑回复', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('229', 'admin', '1', 'Admin/Weibo/editWeibo', '编辑微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('230', 'admin', '1', 'Admin/SEO/ruleTrash', '规则回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('231', 'admin', '1', 'Admin/Rank/userList', '查看用户', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('232', 'admin', '1', 'Admin/Rank/userRankList', '用户头衔列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('233', 'admin', '1', 'Admin/Rank/userAddRank', '关联新头衔', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('234', 'admin', '1', 'Admin/Rank/userChangeRank', '编辑头衔关联', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('235', 'admin', '1', 'Admin/Issue/add', '编辑专辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('236', 'admin', '1', 'Admin/Issue/issue', '专辑管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Issue/operate', '专辑操作', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('238', 'admin', '1', 'Admin/Weibo/weibo', '微博管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('239', 'admin', '1', 'Admin/Rank/index', '头衔列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('240', 'admin', '1', 'Admin/Forum/forumTrash', '板块回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('241', 'admin', '1', 'Admin/Weibo/weiboTrash', '微博回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('242', 'admin', '1', 'Admin/Rank/editRank', '添加头衔', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('243', 'admin', '1', 'Admin/Weibo/comment', '回复管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('244', 'admin', '1', 'Admin/Forum/postTrash', '帖子回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('245', 'admin', '1', 'Admin/Weibo/commentTrash', '回复回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('246', 'admin', '1', 'Admin/Issue/issueTrash', '专辑回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('247', 'admin', '1', 'Admin//Admin/Forum/reply', '回复管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('248', 'admin', '1', 'Admin/Forum/replyTrash', '回复回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('249', 'admin', '2', 'Admin/Forum/index', '论坛', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('250', 'admin', '2', 'Admin/Weibo/weibo', '微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('251', 'admin', '2', 'Admin/SEO/index', 'SEO', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('252', 'admin', '2', 'Admin/Rank/index', '头衔', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('253', 'admin', '2', 'Admin/Issue/issue', '专辑', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('254', 'admin', '1', 'Admin/Issue/contents', '内容管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('255', 'admin', '1', 'Admin/User/profile', '扩展资料', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('256', 'admin', '1', 'Admin/User/editProfile', '添加、编辑分组', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('257', 'admin', '1', 'Admin/User/sortProfile', '分组排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('258', 'admin', '1', 'Admin/User/field', '字段列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('259', 'admin', '1', 'Admin/User/editFieldSetting', '添加、编辑字段', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('260', 'admin', '1', 'Admin/User/sortField', '字段排序', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('261', 'admin', '1', 'Admin/Update/quick', '全部补丁', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('262', 'admin', '1', 'Admin/Update/addpack', '新增补丁', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('263', 'admin', '1', 'Admin/User/expandinfo_select', '委员列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('264', 'admin', '1', 'Admin/User/expandinfo_details', '扩展资料详情', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('265', 'admin', '1', 'Admin/Shop/shopLog', '商城信息记录', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('266', 'admin', '1', 'Admin/Shop/setStatus', '商品分类状态设置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('267', 'admin', '1', 'Admin/Shop/setGoodsStatus', '商品状态设置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('268', 'admin', '1', 'Admin/Shop/operate', '商品分类操作', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('269', 'admin', '1', 'Admin/Shop/add', '商品分类添加', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('270', 'admin', '1', 'Admin/Shop/goodsEdit', '添加、编辑商品', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('271', 'admin', '1', 'Admin/Shop/hotSellConfig', '热销商品阀值配置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('272', 'admin', '1', 'Admin/Shop/setNew', '设置新品', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('273', 'admin', '1', 'Admin/EventType/index', '活动分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('274', 'admin', '1', 'Admin/Event/event', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('275', 'admin', '1', 'Admin/EventType/eventTypeTrash', '活动分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('276', 'admin', '1', 'Admin/Event/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('277', 'admin', '1', 'Admin/Event/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('278', 'admin', '1', 'Admin/Rank/rankVerify', '待审核用户头衔', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('279', 'admin', '1', 'Admin/Rank/rankVerifyFailure', '被驳回的头衔申请', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('280', 'admin', '1', 'Admin/Weibo/config', '微博设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('281', 'admin', '1', 'Admin/Issue/verify', '内容审核', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('282', 'admin', '1', 'Admin/Shop/goodsList', '商品列表', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('283', 'admin', '1', 'Admin/Shop/shopCategory', '商品分类配置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('284', 'admin', '1', 'Admin/Shop/categoryTrash', '商品分类回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('285', 'admin', '1', 'Admin/Shop/verify', '待发货交易', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('286', 'admin', '1', 'Admin/Issue/contentTrash', '内容回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('287', 'admin', '1', 'Admin/Shop/goodsBuySuccess', '交易成功记录', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('288', 'admin', '1', 'Admin/Shop/goodsTrash', '商品回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('289', 'admin', '1', 'Admin/Shop/toxMoneyConfig', '货币配置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('290', 'admin', '2', 'Admin/Shop/shopCategory', '商城', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('291', 'admin', '2', 'Admin/EventType/index', '活动', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('344', 'admin', '1', 'Admin/MeetType/index', '会议分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('345', 'admin', '1', 'Admin/Meet/meet', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('346', 'admin', '1', 'Admin/MeetType/meetTypeTrash', '会议分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('297', 'Home', '1', 'deleteLocalComment', '删除本地评论', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('347', 'admin', '1', 'Admin/Meet/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('300', 'admin', '1', 'Admin/Issue/config', '专辑设置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('301', 'admin', '1', 'Admin/Event/config', '活动设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('302', 'admin', '1', 'Admin/User/config', '基础设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('303', 'admin', '1', 'admin/group/group', '群组管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('304', 'admin', '1', 'Admin/group/groupType', '分类管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('305', 'admin', '1', 'Admin/group/postType', '文章分类', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('306', 'admin', '1', 'Admin/group/editPostCate', '修改分类', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('307', 'admin', '1', 'Admin/group/sortPostCate', '类型排序', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('308', 'admin', '1', 'Admin/group/editGroupType', '修改群组分类', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('309', 'admin', '1', 'Admin/group/sortGroupType', '群组类型排序', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('310', 'admin', '1', 'Admin/group/editLzlReply', '编辑楼中楼回复', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('311', 'admin', '1', 'Admin/group/lzlreply', '楼中楼回复', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('312', 'admin', '1', 'Admin/group/lzlreplyTrash', '楼中楼回复回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('313', 'admin', '1', 'Admin/group/editReply', '编辑回复', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('314', 'admin', '1', 'Admin/group/groupTrash', '群组回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('315', 'admin', '1', 'Admin/group/post', '文章管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('316', 'admin', '1', 'Admin/group/postTrash', '文章回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('317', 'admin', '1', 'Admin/group/reply', '回复管理', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('318', 'admin', '1', 'Admin/group/replyTrash', '回复回收站', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('319', 'admin', '1', 'Admin/group/config', '群组设置', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('320', 'admin', '1', 'Admin/group/unverify', '未审核群组', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('321', 'admin', '1', 'Admin/module/lists', '模块管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('322', 'admin', '1', 'Admin/module/uninstall', '卸载模块', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('323', 'admin', '1', 'Admin/module/install', '模块安装', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('324', 'admin', '1', 'Admin/AuthManager/addNode', '新增权限节点', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('325', 'admin', '1', 'Admin/AuthManager/accessUser', '前台权限管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('326', 'admin', '1', 'Admin/User/changeGroup', '转移用户组', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('327', 'admin', '1', 'Admin/AuthManager/deleteNode', '删除权限节点', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('328', 'admin', '1', 'admin/expression/expressionList', '表情列表', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('329', 'admin', '1', 'Admin/adimn/expression/add', '新增表情包', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('330', 'admin', '1', 'Admin/Forum/addType', '新增/编辑分类', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('331', 'admin', '1', 'Admin/Forum/setTypeStatus', '设置分类状态', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('332', 'admin', '1', 'Admin/Forum/type', '分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('333', 'admin', '1', 'Admin/Forum/reply', '回复管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('334', 'admin', '1', 'Admin/Forum/config', '论坛设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('335', 'admin', '2', 'admin/group/index', '群组', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('336', 'admin', '1', 'admin/expression/index', '表情管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('348', 'admin', '1', 'Admin/Meet/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('349', 'admin', '2', 'Admin/MeetType/Index', '会议管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('350', 'admin', '1', 'Admin/Meet/config', '会议设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('361', 'Weibo', '1', 'beTopicAdmin', '抢先成为话题主持人', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('358', 'Weibo', '1', 'sendWeibo', '发微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('359', 'Weibo', '1', 'deleteWeibo', '删除微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('360', 'Weibo', '1', 'setWeiboTop', '微博置顶', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('362', 'Weibo', '1', 'manageTopic', '管理话题', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('363', 'admin', '1', 'Admin/ProposalType/index', '提案交办分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('364', 'admin', '1', 'Admin/Message/query', '消息查询', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('365', 'admin', '1', 'Admin/Message/Api', '消息接口', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('366', 'admin', '1', 'Admin/Statistics/Forum', '主题统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('367', 'admin', '1', 'Admin/Statistics/Announce', '公示公告统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('368', 'admin', '1', 'Admin/Point/Rules', '规则设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('369', 'admin', '1', 'Admin/Statistics/Weiyuan', '委员统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('370', 'admin', '1', 'Admin/Statistics/meet', '会议统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('371', 'admin', '1', 'Admin/Statistics/Event', '活动统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('372', 'admin', '1', 'Admin/Statistics/Proposal', '提案统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('373', 'admin', '1', 'Admin/Statistics/Polls', '社情民意统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('374', 'admin', '1', 'Admin/Statistics/Historical', '文史资料统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('375', 'admin', '1', 'Admin/Statistics/Survey', '调研统计', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('376', 'admin', '1', 'Admin/Point/Manager', '积分类别', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('377', 'admin', '1', 'Admin/Check/input', '录入签到', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('378', 'admin', '1', 'Admin/Check/wx', '签到管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('379', 'admin', '1', 'Admin/ProposalType/proposalTypeTrash', '提案交办分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('380', 'admin', '1', 'Admin/SurveyType/surveyTypeTrash', '调研报告分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('381', 'admin', '1', 'Admin/SurveyType/index', '调研报告分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('382', 'admin', '1', 'Admin/PollsType/pollsTypeTrash', '社情民意分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('383', 'admin', '1', 'Admin/PollsType/index', '社情民意分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('384', 'admin', '1', 'Admin/Announce/lists', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('385', 'admin', '1', 'Admin/Announce/trash', '公告回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('386', 'admin', '1', 'Admin/HistoricalType/index', '文史资料分类管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('387', 'admin', '1', 'Admin/HistoricalType/historicalTypeTrash', '文史资料分类回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('388', 'admin', '1', 'Admin/Proposal/proposal', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('389', 'admin', '1', 'Admin/Survey/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('390', 'admin', '1', 'Admin/Survey/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('391', 'admin', '1', 'Admin/Survey/survey', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('392', 'admin', '1', 'Admin/Polls/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('393', 'admin', '1', 'Admin/Polls/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('394', 'admin', '1', 'Admin/Polls/polls', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('395', 'admin', '1', 'Admin/Proposal/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('396', 'admin', '1', 'Admin/Proposal/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('397', 'admin', '1', 'Admin/Historical/historical', '内容管理', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('398', 'admin', '1', 'Admin/Historical/verify', '内容审核', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('399', 'admin', '1', 'Admin/Historical/contentTrash', '内容回收站', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('400', 'admin', '1', 'Admin/Polls/config', '社情民意设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('401', 'admin', '2', 'Admin/Announce/lists', '公示公告', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('402', 'admin', '1', 'Admin/Historical/config', '文史资料设置', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('403', 'admin', '2', 'Admin/ProposalType/Index', '提案交办', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('404', 'admin', '2', 'Admin/SurveyType/Index', '调研报告', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('405', 'admin', '2', 'Admin/PollsType/Index', '社情民意', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('406', 'admin', '2', 'Admin/HistoricalType/Index', '文史资料', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('407', 'Proposal', '1', 'addProposalContent', '提交提案', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('408', 'Proposal', '1', 'editProposalContent', '编辑提案', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('409', 'Proposal', '1', 'proposalSetStatus', '状态更新', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('410', 'Proposal', '1', 'proposalSetSuggest', '回复', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('411', 'Proposal', '1', 'batchHandover', '批量交办', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('412', 'Proposal', '1', 'changeStatus1', '保存1', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('413', 'Proposal', '1', 'changeStatus2', '已提交2', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('414', 'Proposal', '1', 'changeStatus3', '退回3', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('415', 'Proposal', '1', 'changeStatus4', '不立案4', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('416', 'Proposal', '1', 'changeStatus5', '撤案5', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('417', 'Proposal', '1', 'changeStatus6', '不在管辖区6', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('418', 'Proposal', '1', 'changeStatus7', '委员来信7', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('419', 'Proposal', '1', 'changeStatus8', '已立案8', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('420', 'Proposal', '1', 'changeStatus9', '已结案9', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('421', 'Proposal', '1', 'changeStatus11', '批量移交11', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('422', 'Proposal', '1', 'changeStatus19', '已交办19', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('423', 'Proposal', '1', 'handOver', '移交办理handOver', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('424', 'Proposal', '1', 'changeStatus13', '已办理13', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('425', 'Proposal', '1', 'changeStatus14', '退回重办14', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('426', 'Proposal', '1', 'changeStatus15', '被并案15', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('427', 'Proposal', '1', 'changeStatus17', '已办理反馈17', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('428', 'Proposal', '1', 'changestatus18', '待交办18', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('429', 'Proposal', '1', 'doUnit', '提交办理信息', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('430', 'admin', '1', 'Admin/Group/Index', '用户分组', '-1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('431', 'Proposal', '1', 'doHandsuggest', '提交交办意见', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('432', 'Weibo', '1', 'sendWeibo', '发微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('433', 'Weibo', '1', 'deleteWeibo', '删除微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('434', 'Weibo', '1', 'setWeiboTop', '微博置顶', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('435', 'Weibo', '1', 'beTopicAdmin', '抢先成为话题主持人', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('436', 'Weibo', '1', 'manageTopic', '管理话题', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('437', 'Home', '1', 'deleteLocalComment', '删除本地评论', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('438', 'Issue', '1', 'addIssueContent', '专辑投稿权限', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('439', 'Issue', '1', 'editIssueContent', '编辑专辑内容（管理）', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('440', 'Weibo', '1', 'sendWeibo', '发微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('441', 'Weibo', '1', 'deleteWeibo', '删除微博', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('442', 'Weibo', '1', 'setWeiboTop', '微博置顶', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('443', 'Weibo', '1', 'beTopicAdmin', '抢先成为话题主持人', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('444', 'Weibo', '1', 'manageTopic', '管理话题', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('445', 'Home', '1', 'deleteLocalComment', '删除本地评论', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('446', 'Issue', '1', 'addIssueContent', '专辑投稿权限', '1', '');
INSERT INTO `thinkox_auth_rule` VALUES ('447', 'Issue', '1', 'editIssueContent', '编辑专辑内容（管理）', '1', '');

-- ----------------------------
-- Table structure for thinkox_avatar
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_avatar`;
CREATE TABLE `thinkox_avatar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL,
  `uid` int(11) NOT NULL,
  `path` varchar(70) NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `is_temp` int(11) NOT NULL,
  `md5` varchar(20) DEFAULT NULL,
  `sha1` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_avatar
-- ----------------------------
INSERT INTO `thinkox_avatar` VALUES ('7', 'image/jpeg', '0', '/Uploads/Picture/2016-09-05/57cd18052525e.jpg', '1473058820', '1', '0', '9775b31ee180296c30c1', '5b7b19a163b5771887eb');
INSERT INTO `thinkox_avatar` VALUES ('8', 'image/jpeg', '58', '/Uploads/Picture/2016-09-05/57cd1a96e21d4.jpg', '1473059478', '1', '0', 'a691391e8b4479702213', '6662b4816fa41b55184b');

-- ----------------------------
-- Table structure for thinkox_category
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_category`;
CREATE TABLE `thinkox_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of thinkox_category
-- ----------------------------
INSERT INTO `thinkox_category` VALUES ('1', 'blog', '资讯', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1406206595', '1', '0');
INSERT INTO `thinkox_category` VALUES ('2', 'default_blog', 'APP', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1406171627', '1', '31');
INSERT INTO `thinkox_category` VALUES ('40', 'b3', '大数据', '1', '0', '10', '', '', '', '', '', '', '', '2', '2', '0', '1', '1', '1', '0', '', '', '1406169194', '1406183525', '1', '0');
INSERT INTO `thinkox_category` VALUES ('41', 'php', 'PHP', '1', '0', '10', '', '', '', '', '', '', '', '2', '2', '0', '1', '1', '1', '0', '', '', '1406171638', '1406171693', '1', '0');
INSERT INTO `thinkox_category` VALUES ('42', 'create_yeah', '创业', '0', '0', '10', '', '', '', '', '', '', '', '2', '', '0', '1', '1', '1', '0', '', '', '1406172024', '1406172024', '1', '0');

-- ----------------------------
-- Table structure for thinkox_channel
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_channel`;
CREATE TABLE `thinkox_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  `color` varchar(30) NOT NULL,
  `band_color` varchar(30) NOT NULL,
  `band_text` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_channel
-- ----------------------------
INSERT INTO `thinkox_channel` VALUES ('1', '0', '首页', 'Weibo/Index/index', '1', '1379475111', '1401628204', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('2', '0', '交流中心', 'Forum/Index/index', '2', '1379475131', '1470014786', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('4', '0', '专辑', 'Issue/Index/index', '123', '1399022492', '1406255246', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('5', '0', '会员', 'People/Index/index', '5', '1399784340', '1406256451', '0', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('11', '0', '商城', 'Shop/Index/index', '5', '1403056971', '1403085891', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('14', '0', '资讯', 'blog/index/index', '4', '1406084715', '1406084910', '0', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('13', '0', '活动', '/Event/index', '3', '1403797042', '1403797164', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('15', '0', '群组', 'group/index/index', '5', '1410771228', '1410771228', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('16', '0', '会议', 'Meet/Index/index', '2', '1470013228', '1470014107', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('17', '0', '公告', 'Announce/Index/index', '3', '1470124291', '1470124548', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('18', '0', '提案交办', 'Proposal/Index/index', '3', '1470124328', '1470124559', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('19', '0', '调研报告', 'Survey/Index/index', '3', '1470124365', '1470124567', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('20', '0', '社情民意', 'Polls/Index/index', '3', '1470124392', '1470124575', '1', '0', '', '', '');
INSERT INTO `thinkox_channel` VALUES ('21', '0', '文史资料', 'Historical/Index/index', '3', '1470124417', '1470124585', '1', '0', '', '', '');

-- ----------------------------
-- Table structure for thinkox_check_info
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_check_info`;
CREATE TABLE `thinkox_check_info` (
  `uid` int(11) DEFAULT NULL,
  `con_num` int(11) DEFAULT '1',
  `total_num` int(11) DEFAULT '1',
  `ctime` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_check_info
-- ----------------------------
INSERT INTO `thinkox_check_info` VALUES ('58', '1', '1', '1469582316');
INSERT INTO `thinkox_check_info` VALUES ('58', '1', '2', '1470032853');
INSERT INTO `thinkox_check_info` VALUES ('58', '1', '3', '1473055780');
INSERT INTO `thinkox_check_info` VALUES ('59', '1', '1', '1473421604');

-- ----------------------------
-- Table structure for thinkox_checkmodule_info
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_checkmodule_info`;
CREATE TABLE `thinkox_checkmodule_info` (
  `uid` int(11) DEFAULT NULL,
  `module` varchar(20) NOT NULL,
  `con_num` int(11) DEFAULT '1',
  `total_num` int(11) DEFAULT '1',
  `ctime` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_checkmodule_info
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_config
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_config`;
CREATE TABLE `thinkox_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_config
-- ----------------------------
INSERT INTO `thinkox_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `thinkox_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '8');
INSERT INTO `thinkox_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '鄂ICP备XX号', '12');
INSERT INTO `thinkox_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '11');
INSERT INTO `thinkox_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '14');
INSERT INTO `thinkox_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰\r\namaze:Amazu', '后台颜色风格', '1379122533', '1409279514', '1', 'amaze', '2');
INSERT INTO `thinkox_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统\r\n5:邮件\r\n6:微信', '15');
INSERT INTO `thinkox_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '17');
INSERT INTO `thinkox_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '20');
INSERT INTO `thinkox_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '10');
INSERT INTO `thinkox_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '9');
INSERT INTO `thinkox_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '24');
INSERT INTO `thinkox_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '12');
INSERT INTO `thinkox_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '13');
INSERT INTO `thinkox_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '16');
INSERT INTO `thinkox_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '18');
INSERT INTO `thinkox_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '22');
INSERT INTO `thinkox_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '25');
INSERT INTO `thinkox_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '26');
INSERT INTO `thinkox_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '2');
INSERT INTO `thinkox_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '3');
INSERT INTO `thinkox_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '4');
INSERT INTO `thinkox_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '27');
INSERT INTO `thinkox_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '7');
INSERT INTO `thinkox_config` VALUES ('38', 'WEB_SITE', '1', '网站名称', '1', '', '用于邮件,短信,站内信显示', '1388332311', '1388501500', '1', '江汉区政协履职平台', '3');
INSERT INTO `thinkox_config` VALUES ('39', 'MAIL_TYPE', '4', '邮件类型', '5', '1:SMTP 模块发送\r\n2:mail() 函数发送', '如果您选择了采用服务器内置的 Mail 服务，您不需要填写下面的内容', '1388332882', '1388931416', '1', '1', '0');
INSERT INTO `thinkox_config` VALUES ('40', 'MAIL_SMTP_HOST', '1', 'SMTP 服务器', '5', '', 'SMTP服务器', '1388332932', '1388332932', '1', '', '0');
INSERT INTO `thinkox_config` VALUES ('41', 'MAIL_SMTP_PORT', '0', 'SMTP服务器端口', '5', '', '默认25', '1388332975', '1388332975', '1', '25', '0');
INSERT INTO `thinkox_config` VALUES ('42', 'MAIL_SMTP_USER', '1', 'SMTP服务器用户名', '5', '', '填写完整用户名', '1388333010', '1388333010', '1', '', '0');
INSERT INTO `thinkox_config` VALUES ('43', 'MAIL_SMTP_PASS', '6', 'SMTP服务器密码', '5', '', '填写您的密码', '1388333057', '1389187088', '1', '', '0');
INSERT INTO `thinkox_config` VALUES ('50', 'MAIL_USER_PASS', '5', '密码找回模板', '0', '', '支持HTML代码', '1388583989', '1388672614', '1', '密码找回111223333555111', '0');
INSERT INTO `thinkox_config` VALUES ('51', 'PIC_FILE_PATH', '1', '图片文件保存根目录', '4', '', '图片文件保存根目录./目录/', '1388673255', '1388673255', '1', './Uploads/', '0');
INSERT INTO `thinkox_config` VALUES ('46', 'MAIL_SMTP_CE', '1', '邮件发送测试', '5', '', '填写测试邮件地址', '1388334529', '1388584028', '1', '', '11');
INSERT INTO `thinkox_config` VALUES ('47', 'MAIL_USER_REG', '5', '注册邮件模板', '3', '', '支持HTML代码', '1388337307', '1473644046', '1', '<a href=\"http://zxlz.daifayuan.com\" target=\"_blank\">点击进入</a><span style=\"color:#E53333;\">当您收到这封邮件，表明您已注册成功，以上为您的用户名和密码。。。。祝您生活愉快····</span>', '55');
INSERT INTO `thinkox_config` VALUES ('52', 'USER_NAME_BAOLIU', '1', '保留用户名', '3', '', '禁止注册用户名,用\" , \"号隔开', '1388845937', '1388845937', '1', '管理员,测试,admin,垃圾', '0');
INSERT INTO `thinkox_config` VALUES ('53', 'USER_REG_TIME', '0', '注册时间限制', '3', '', '同一IP注册时间限制，防恶意注册，格式分钟', '1388847715', '1388847715', '1', '2', '0');
INSERT INTO `thinkox_config` VALUES ('48', 'VERIFY_OPEN', '4', '验证码配置', '4', '0:全部关闭\r\n1:全部显示\r\n2:注册显示\r\n3:登陆显示', '验证码配置', '1388500332', '1405561711', '1', '2', '0');
INSERT INTO `thinkox_config` VALUES ('49', 'VERIFY_TYPE', '4', '验证码类型', '4', '1:中文\r\n2:英文\r\n3:数字\r\n4:算数', '验证码类型', '1388500873', '1405561731', '1', '1', '0');
INSERT INTO `thinkox_config` VALUES ('54', 'NO_BODY_TLE', '2', '空白说明', '2', '', '空白说明', '1392216444', '1392981305', '1', '呵呵，暂时没有内容哦！！', '0');
INSERT INTO `thinkox_config` VALUES ('55', 'USER_RESPASS', '5', '密码找回模板', '3', '', '密码找回文本', '1396191234', '1396191234', '1', '<span style=\"color:#009900;\">请点击以下链接找回密码，如无反应，请将链接地址复制到浏览器中打开(下次登录前有效)</span>', '0');
INSERT INTO `thinkox_config` VALUES ('56', 'COUNT_CODE', '2', '统计代码', '1', '', '用于统计网站访问量的第三方代码，推荐CNZZ统计', '1403058890', '1403058890', '1', '', '4');
INSERT INTO `thinkox_config` VALUES ('57', 'SHARE_WEIBO_ID', '0', '分享来源微博ID', '1', '', '来源的微博ID，不配置则隐藏顶部微博分享按钮。', '1403091490', '1403091490', '1', '', '5');
INSERT INTO `thinkox_config` VALUES ('60', 'AFTER_LOGIN_JUMP_URL', '2', '登陆后跳转的Url', '1', '', '支持形如weibo/index/index的ThinkPhp路由写法，支持普通的url写法', '1407145718', '1473560929', '1', 'home/index/index', '7');
INSERT INTO `thinkox_config` VALUES ('58', 'USER_REG_WEIBO_CONTENT', '1', '用户注册微博提示内容', '3', '', '留空则表示不发新微博，支持face', '1404965285', '1404965445', '1', '', '0');
INSERT INTO `thinkox_config` VALUES ('59', 'WEIBO_WORDS_COUNT', '0', '微博字数限制', '1', '', '最大允许的微博字数长度', '1405330568', '1405330622', '1', '200', '6');
INSERT INTO `thinkox_config` VALUES ('61', 'FOOTER_RIGHT', '2', '底部右侧链接部分', '1', '', '链接部分', '1408008354', '1408008354', '1', '', '10');
INSERT INTO `thinkox_config` VALUES ('62', 'FOOTER_SUMMARY', '2', '底部简介部分代码', '1', '', '', '1408008496', '1408008496', '1', '', '9');
INSERT INTO `thinkox_config` VALUES ('63', 'FOOTER_TITLE', '2', '底部介绍标题', '1', '', '公司标题', '1408008573', '1408008573', '1', '火凤凰', '8');
INSERT INTO `thinkox_config` VALUES ('64', 'FOOTER_QCODE', '2', '底部二维码部分代码', '1', '', '', '1408008644', '1408008738', '1', ' <img src=\"/Public/Core/images/erweima.png\"/>', '11');
INSERT INTO `thinkox_config` VALUES ('88', '_WEIBO_SHOW_TITLE', '0', '', '0', '', '', '1471661620', '1471661620', '1', '0', '0');
INSERT INTO `thinkox_config` VALUES ('75', '_WEIBO_SHOWTITLE', '0', '', '0', '', '', '1409670094', '1409670094', '1', '0', '0');
INSERT INTO `thinkox_config` VALUES ('80', '_FORUM_LIMIT_IMAGE', '0', '', '0', '', '', '1409711730', '1409711730', '1', '1', '0');
INSERT INTO `thinkox_config` VALUES ('82', '_ISSUE_NEED_VERIFY', '0', '', '0', '', '', '1409712596', '1409712596', '1', '0', '0');
INSERT INTO `thinkox_config` VALUES ('92', '_USER_LEVEL', '0', '', '0', '', '', '1473062083', '1473062083', '1', '', '0');
INSERT INTO `thinkox_config` VALUES ('95', '_EXPRESSION_EXPRESSION', '0', '', '0', '', '', '1417150390', '1417150390', '1', 'miniblog', '0');
INSERT INTO `thinkox_config` VALUES ('86', 'DEFUALT_HOME_URL', '1', '默认首页Url', '1', '', '支持形如weibo/index/index的ThinkPhp路由写法，支持普通的url写法，不填则显示默认聚合首页', '1417509438', '1470288343', '1', 'Home/index/index', '0');
INSERT INTO `thinkox_config` VALUES ('89', 'END_DATE', '1', '盘点时间', '1', '', '积分清算时间，用于总结当前履职信息的终结时间点。\r\n（YYYY-MM-DD）', '1471673358', '1471673404', '1', '2016-3-55', '0');
INSERT INTO `thinkox_config` VALUES ('93', '_USER_DEFAULT_GROUP', '0', '', '0', '', '', '1473062083', '1473062083', '1', '5', '0');
INSERT INTO `thinkox_config` VALUES ('96', 'WX_APPID', '1', '微信APPID', '6', '', '', '1473338915', '1473388484', '1', 'wx07fdd9a4503cca15', '0');
INSERT INTO `thinkox_config` VALUES ('97', 'WX_SECRET', '1', '微信WX_SECRET', '0', '', '', '1473339013', '1473339013', '1', '6682cef161cd61003e561cde96336ec0', '0');
INSERT INTO `thinkox_config` VALUES ('98', 'PROPOSAL_MEET', '1', '会议次数', '1', '', '用于提案撰写的会议次数', '1473501987', '1473501987', '1', '十五届一次会议', '0');

-- ----------------------------
-- Table structure for thinkox_district
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_district`;
CREATE TABLE `thinkox_district` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `level` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `upid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=910007 DEFAULT CHARSET=utf8 COMMENT='中国省市区乡镇数据表';

-- ----------------------------
-- Records of thinkox_district
-- ----------------------------
INSERT INTO `thinkox_district` VALUES ('110000', '北京市', '1', '0');
INSERT INTO `thinkox_district` VALUES ('120000', '天津市', '1', '0');
INSERT INTO `thinkox_district` VALUES ('130000', '河北省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('140000', '山西省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('150000', '内蒙古', '1', '0');
INSERT INTO `thinkox_district` VALUES ('210000', '辽宁省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('220000', '吉林省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('230000', '黑龙江', '1', '0');
INSERT INTO `thinkox_district` VALUES ('310000', '上海市', '1', '0');
INSERT INTO `thinkox_district` VALUES ('320000', '江苏省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('330000', '浙江省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('340000', '安徽省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('350000', '福建省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('360000', '江西省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('370000', '山东省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('410000', '河南省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('420000', '湖北省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('430000', '湖南省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('440000', '广东省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('450000', '广西省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('460000', '海南省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('500000', '重庆市', '1', '0');
INSERT INTO `thinkox_district` VALUES ('510000', '四川省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('520000', '贵州省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('530000', '云南省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('540000', '西　藏', '1', '0');
INSERT INTO `thinkox_district` VALUES ('610000', '陕西省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('620000', '甘肃省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('630000', '青海省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('640000', '宁　夏', '1', '0');
INSERT INTO `thinkox_district` VALUES ('650000', '新　疆', '1', '0');
INSERT INTO `thinkox_district` VALUES ('710000', '台湾省', '1', '0');
INSERT INTO `thinkox_district` VALUES ('810000', '香　港', '1', '0');
INSERT INTO `thinkox_district` VALUES ('820000', '澳　门', '1', '0');
INSERT INTO `thinkox_district` VALUES ('110100', '北京市', '2', '110000');
INSERT INTO `thinkox_district` VALUES ('110200', '县', '2', '110000');
INSERT INTO `thinkox_district` VALUES ('120100', '市辖区', '2', '120000');
INSERT INTO `thinkox_district` VALUES ('120200', '县', '2', '120000');
INSERT INTO `thinkox_district` VALUES ('130100', '石家庄市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130200', '唐山市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130300', '秦皇岛市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130400', '邯郸市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130500', '邢台市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130600', '保定市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130700', '张家口市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130800', '承德市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('130900', '沧州市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('131000', '廊坊市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('131100', '衡水市', '2', '130000');
INSERT INTO `thinkox_district` VALUES ('140100', '太原市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140200', '大同市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140300', '阳泉市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140400', '长治市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140500', '晋城市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140600', '朔州市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140700', '晋中市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140800', '运城市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('140900', '忻州市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('141000', '临汾市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('141100', '吕梁市', '2', '140000');
INSERT INTO `thinkox_district` VALUES ('150100', '呼和浩特市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150200', '包头市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150300', '乌海市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150400', '赤峰市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150500', '通辽市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150600', '鄂尔多斯市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150700', '呼伦贝尔市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150800', '巴彦淖尔市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('150900', '乌兰察布市', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('152200', '兴安盟', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('152500', '锡林郭勒盟', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('152900', '阿拉善盟', '2', '150000');
INSERT INTO `thinkox_district` VALUES ('210100', '沈阳市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210200', '大连市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210300', '鞍山市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210400', '抚顺市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210500', '本溪市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210600', '丹东市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210700', '锦州市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210800', '营口市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('210900', '阜新市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('211000', '辽阳市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('211100', '盘锦市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('211200', '铁岭市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('211300', '朝阳市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('211400', '葫芦岛市', '2', '210000');
INSERT INTO `thinkox_district` VALUES ('220100', '长春市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220200', '吉林市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220300', '四平市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220400', '辽源市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220500', '通化市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220600', '白山市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220700', '松原市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('220800', '白城市', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('222400', '延边朝鲜族自治州', '2', '220000');
INSERT INTO `thinkox_district` VALUES ('230100', '哈尔滨市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230200', '齐齐哈尔市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230300', '鸡西市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230400', '鹤岗市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230500', '双鸭山市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230600', '大庆市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230700', '伊春市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230800', '佳木斯市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('230900', '七台河市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('231000', '牡丹江市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('231100', '黑河市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('231200', '绥化市', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('232700', '大兴安岭地区', '2', '230000');
INSERT INTO `thinkox_district` VALUES ('310100', '市辖区', '2', '310000');
INSERT INTO `thinkox_district` VALUES ('310200', '县', '2', '310000');
INSERT INTO `thinkox_district` VALUES ('320100', '南京市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320200', '无锡市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320300', '徐州市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320400', '常州市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320500', '苏州市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320600', '南通市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320700', '连云港市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320800', '淮安市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('320900', '盐城市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('321000', '扬州市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('321100', '镇江市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('321200', '泰州市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('321300', '宿迁市', '2', '320000');
INSERT INTO `thinkox_district` VALUES ('330100', '杭州市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330200', '宁波市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330300', '温州市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330400', '嘉兴市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330500', '湖州市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330600', '绍兴市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330700', '金华市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330800', '衢州市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('330900', '舟山市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('331000', '台州市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('331100', '丽水市', '2', '330000');
INSERT INTO `thinkox_district` VALUES ('340100', '合肥市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340200', '芜湖市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340300', '蚌埠市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340400', '淮南市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340500', '马鞍山市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340600', '淮北市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340700', '铜陵市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('340800', '安庆市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341000', '黄山市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341100', '滁州市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341200', '阜阳市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341300', '宿州市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341500', '六安市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341600', '亳州市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341700', '池州市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('341800', '宣城市', '2', '340000');
INSERT INTO `thinkox_district` VALUES ('350100', '福州市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350200', '厦门市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350300', '莆田市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350400', '三明市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350500', '泉州市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350600', '漳州市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350700', '南平市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350800', '龙岩市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('350900', '宁德市', '2', '350000');
INSERT INTO `thinkox_district` VALUES ('360100', '南昌市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360200', '景德镇市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360300', '萍乡市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360400', '九江市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360500', '新余市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360600', '鹰潭市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360700', '赣州市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360800', '吉安市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('360900', '宜春市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('361000', '抚州市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('361100', '上饶市', '2', '360000');
INSERT INTO `thinkox_district` VALUES ('370100', '济南市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370200', '青岛市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370300', '淄博市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370400', '枣庄市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370500', '东营市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370600', '烟台市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370700', '潍坊市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370800', '济宁市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('370900', '泰安市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371000', '威海市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371100', '日照市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371200', '莱芜市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371300', '临沂市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371400', '德州市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371500', '聊城市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371600', '滨州市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('371700', '菏泽市', '2', '370000');
INSERT INTO `thinkox_district` VALUES ('410100', '郑州市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410200', '开封市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410300', '洛阳市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410400', '平顶山市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410500', '安阳市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410600', '鹤壁市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410700', '新乡市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410800', '焦作市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('410900', '濮阳市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411000', '许昌市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411100', '漯河市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411200', '三门峡市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411300', '南阳市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411400', '商丘市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411500', '信阳市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411600', '周口市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('411700', '驻马店市', '2', '410000');
INSERT INTO `thinkox_district` VALUES ('420100', '武汉市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420200', '黄石市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420300', '十堰市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420500', '宜昌市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420600', '襄樊市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420700', '鄂州市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420800', '荆门市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('420900', '孝感市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('421000', '荆州市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('421100', '黄冈市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('421200', '咸宁市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('421300', '随州市', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('422800', '恩施土家族苗族自治州', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('429000', '省直辖行政单位', '2', '420000');
INSERT INTO `thinkox_district` VALUES ('430100', '长沙市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430200', '株洲市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430300', '湘潭市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430400', '衡阳市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430500', '邵阳市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430600', '岳阳市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430700', '常德市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430800', '张家界市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('430900', '益阳市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('431000', '郴州市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('431100', '永州市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('431200', '怀化市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('431300', '娄底市', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('433100', '湘西土家族苗族自治州', '2', '430000');
INSERT INTO `thinkox_district` VALUES ('440100', '广州市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440200', '韶关市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440300', '深圳市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440400', '珠海市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440500', '汕头市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440600', '佛山市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440700', '江门市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440800', '湛江市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('440900', '茂名市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441200', '肇庆市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441300', '惠州市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441400', '梅州市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441500', '汕尾市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441600', '河源市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441700', '阳江市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441800', '清远市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('441900', '东莞市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('442000', '中山市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('445100', '潮州市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('445200', '揭阳市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('445300', '云浮市', '2', '440000');
INSERT INTO `thinkox_district` VALUES ('450100', '南宁市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450200', '柳州市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450300', '桂林市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450400', '梧州市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450500', '北海市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450600', '防城港市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450700', '钦州市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450800', '贵港市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('450900', '玉林市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('451000', '百色市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('451100', '贺州市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('451200', '河池市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('451300', '来宾市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('451400', '崇左市', '2', '450000');
INSERT INTO `thinkox_district` VALUES ('460100', '海口市', '2', '460000');
INSERT INTO `thinkox_district` VALUES ('460200', '三亚市', '2', '460000');
INSERT INTO `thinkox_district` VALUES ('469000', '省直辖县级行政单位', '2', '460000');
INSERT INTO `thinkox_district` VALUES ('500100', '市辖区', '2', '500000');
INSERT INTO `thinkox_district` VALUES ('500200', '县', '2', '500000');
INSERT INTO `thinkox_district` VALUES ('500300', '市', '2', '500000');
INSERT INTO `thinkox_district` VALUES ('510100', '成都市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510300', '自贡市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510400', '攀枝花市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510500', '泸州市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510600', '德阳市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510700', '绵阳市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510800', '广元市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('510900', '遂宁市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511000', '内江市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511100', '乐山市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511300', '南充市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511400', '眉山市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511500', '宜宾市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511600', '广安市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511700', '达州市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511800', '雅安市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('511900', '巴中市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('512000', '资阳市', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('513200', '阿坝藏族羌族自治州', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('513300', '甘孜藏族自治州', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('513400', '凉山彝族自治州', '2', '510000');
INSERT INTO `thinkox_district` VALUES ('520100', '贵阳市', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('520200', '六盘水市', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('520300', '遵义市', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('520400', '安顺市', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('522200', '铜仁地区', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('522300', '黔西南布依族苗族自治州', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('522400', '毕节地区', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('522600', '黔东南苗族侗族自治州', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('522700', '黔南布依族苗族自治州', '2', '520000');
INSERT INTO `thinkox_district` VALUES ('530100', '昆明市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530300', '曲靖市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530400', '玉溪市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530500', '保山市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530600', '昭通市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530700', '丽江市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530800', '思茅市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('530900', '临沧市', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('532300', '楚雄彝族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('532500', '红河哈尼族彝族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('532600', '文山壮族苗族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('532800', '西双版纳傣族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('532900', '大理白族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('533100', '德宏傣族景颇族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('533300', '怒江傈僳族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('533400', '迪庆藏族自治州', '2', '530000');
INSERT INTO `thinkox_district` VALUES ('540100', '拉萨市', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542100', '昌都地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542200', '山南地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542300', '日喀则地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542400', '那曲地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542500', '阿里地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('542600', '林芝地区', '2', '540000');
INSERT INTO `thinkox_district` VALUES ('610100', '西安市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610200', '铜川市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610300', '宝鸡市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610400', '咸阳市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610500', '渭南市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610600', '延安市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610700', '汉中市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610800', '榆林市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('610900', '安康市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('611000', '商洛市', '2', '610000');
INSERT INTO `thinkox_district` VALUES ('620100', '兰州市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620200', '嘉峪关市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620300', '金昌市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620400', '白银市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620500', '天水市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620600', '武威市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620700', '张掖市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620800', '平凉市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('620900', '酒泉市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('621000', '庆阳市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('621100', '定西市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('621200', '陇南市', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('622900', '临夏回族自治州', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('623000', '甘南藏族自治州', '2', '620000');
INSERT INTO `thinkox_district` VALUES ('630100', '西宁市', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632100', '海东地区', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632200', '海北藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632300', '黄南藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632500', '海南藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632600', '果洛藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632700', '玉树藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('632800', '海西蒙古族藏族自治州', '2', '630000');
INSERT INTO `thinkox_district` VALUES ('640100', '银川市', '2', '640000');
INSERT INTO `thinkox_district` VALUES ('640200', '石嘴山市', '2', '640000');
INSERT INTO `thinkox_district` VALUES ('640300', '吴忠市', '2', '640000');
INSERT INTO `thinkox_district` VALUES ('640400', '固原市', '2', '640000');
INSERT INTO `thinkox_district` VALUES ('640500', '中卫市', '2', '640000');
INSERT INTO `thinkox_district` VALUES ('650100', '乌鲁木齐市', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('650200', '克拉玛依市', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652100', '吐鲁番地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652200', '哈密地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652300', '昌吉回族自治州', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652700', '博尔塔拉蒙古自治州', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652800', '巴音郭楞蒙古自治州', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('652900', '阿克苏地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('653000', '克孜勒苏柯尔克孜自治州', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('653100', '喀什地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('653200', '和田地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('654000', '伊犁哈萨克自治州', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('654200', '塔城地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('654300', '阿勒泰地区', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('659000', '省直辖行政单位', '2', '650000');
INSERT INTO `thinkox_district` VALUES ('110101', '东城区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110102', '西城区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110103', '崇文区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110104', '宣武区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110105', '朝阳区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110106', '丰台区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110107', '石景山区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110108', '海淀区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110109', '门头沟区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110111', '房山区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110112', '通州区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110113', '顺义区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110114', '昌平区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110115', '大兴区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110116', '怀柔区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110117', '平谷区', '3', '110100');
INSERT INTO `thinkox_district` VALUES ('110228', '密云县', '3', '110200');
INSERT INTO `thinkox_district` VALUES ('110229', '延庆县', '3', '110200');
INSERT INTO `thinkox_district` VALUES ('120101', '和平区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120102', '河东区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120103', '河西区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120104', '南开区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120105', '河北区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120106', '红桥区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120107', '塘沽区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120108', '汉沽区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120109', '大港区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120110', '东丽区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120111', '西青区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120112', '津南区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120113', '北辰区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120114', '武清区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120115', '宝坻区', '3', '120100');
INSERT INTO `thinkox_district` VALUES ('120221', '宁河县', '3', '120200');
INSERT INTO `thinkox_district` VALUES ('120223', '静海县', '3', '120200');
INSERT INTO `thinkox_district` VALUES ('120225', '蓟　县', '3', '120200');
INSERT INTO `thinkox_district` VALUES ('130101', '市辖区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130102', '长安区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130103', '桥东区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130104', '桥西区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130105', '新华区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130107', '井陉矿区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130108', '裕华区', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130121', '井陉县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130123', '正定县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130124', '栾城县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130125', '行唐县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130126', '灵寿县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130127', '高邑县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130128', '深泽县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130129', '赞皇县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130130', '无极县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130131', '平山县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130132', '元氏县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130133', '赵　县', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130181', '辛集市', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130182', '藁城市', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130183', '晋州市', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130184', '新乐市', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130185', '鹿泉市', '3', '130100');
INSERT INTO `thinkox_district` VALUES ('130201', '市辖区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130202', '路南区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130203', '路北区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130204', '古冶区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130205', '开平区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130207', '丰南区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130208', '丰润区', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130223', '滦　县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130224', '滦南县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130225', '乐亭县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130227', '迁西县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130229', '玉田县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130230', '唐海县', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130281', '遵化市', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130283', '迁安市', '3', '130200');
INSERT INTO `thinkox_district` VALUES ('130301', '市辖区', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130302', '海港区', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130303', '山海关区', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130304', '北戴河区', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130321', '青龙满族自治县', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130322', '昌黎县', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130323', '抚宁县', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130324', '卢龙县', '3', '130300');
INSERT INTO `thinkox_district` VALUES ('130401', '市辖区', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130402', '邯山区', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130403', '丛台区', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130404', '复兴区', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130406', '峰峰矿区', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130421', '邯郸县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130423', '临漳县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130424', '成安县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130425', '大名县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130426', '涉　县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130427', '磁　县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130428', '肥乡县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130429', '永年县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130430', '邱　县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130431', '鸡泽县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130432', '广平县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130433', '馆陶县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130434', '魏　县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130435', '曲周县', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130481', '武安市', '3', '130400');
INSERT INTO `thinkox_district` VALUES ('130501', '市辖区', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130502', '桥东区', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130503', '桥西区', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130521', '邢台县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130522', '临城县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130523', '内丘县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130524', '柏乡县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130525', '隆尧县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130526', '任　县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130527', '南和县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130528', '宁晋县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130529', '巨鹿县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130530', '新河县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130531', '广宗县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130532', '平乡县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130533', '威　县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130534', '清河县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130535', '临西县', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130581', '南宫市', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130582', '沙河市', '3', '130500');
INSERT INTO `thinkox_district` VALUES ('130601', '市辖区', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130602', '新市区', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130603', '北市区', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130604', '南市区', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130621', '满城县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130622', '清苑县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130623', '涞水县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130624', '阜平县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130625', '徐水县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130626', '定兴县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130627', '唐　县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130628', '高阳县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130629', '容城县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130630', '涞源县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130631', '望都县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130632', '安新县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130633', '易　县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130634', '曲阳县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130635', '蠡　县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130636', '顺平县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130637', '博野县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130638', '雄　县', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130681', '涿州市', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130682', '定州市', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130683', '安国市', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130684', '高碑店市', '3', '130600');
INSERT INTO `thinkox_district` VALUES ('130701', '市辖区', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130702', '桥东区', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130703', '桥西区', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130705', '宣化区', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130706', '下花园区', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130721', '宣化县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130722', '张北县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130723', '康保县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130724', '沽源县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130725', '尚义县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130726', '蔚　县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130727', '阳原县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130728', '怀安县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130729', '万全县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130730', '怀来县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130731', '涿鹿县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130732', '赤城县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130733', '崇礼县', '3', '130700');
INSERT INTO `thinkox_district` VALUES ('130801', '市辖区', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130802', '双桥区', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130803', '双滦区', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130804', '鹰手营子矿区', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130821', '承德县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130822', '兴隆县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130823', '平泉县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130824', '滦平县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130825', '隆化县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130826', '丰宁满族自治县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130827', '宽城满族自治县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130828', '围场满族蒙古族自治县', '3', '130800');
INSERT INTO `thinkox_district` VALUES ('130901', '市辖区', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130902', '新华区', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130903', '运河区', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130921', '沧　县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130922', '青　县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130923', '东光县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130924', '海兴县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130925', '盐山县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130926', '肃宁县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130927', '南皮县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130928', '吴桥县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130929', '献　县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130930', '孟村回族自治县', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130981', '泊头市', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130982', '任丘市', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130983', '黄骅市', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('130984', '河间市', '3', '130900');
INSERT INTO `thinkox_district` VALUES ('131001', '市辖区', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131002', '安次区', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131003', '广阳区', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131022', '固安县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131023', '永清县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131024', '香河县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131025', '大城县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131026', '文安县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131028', '大厂回族自治县', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131081', '霸州市', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131082', '三河市', '3', '131000');
INSERT INTO `thinkox_district` VALUES ('131101', '市辖区', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131102', '桃城区', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131121', '枣强县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131122', '武邑县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131123', '武强县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131124', '饶阳县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131125', '安平县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131126', '故城县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131127', '景　县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131128', '阜城县', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131181', '冀州市', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('131182', '深州市', '3', '131100');
INSERT INTO `thinkox_district` VALUES ('140101', '市辖区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140105', '小店区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140106', '迎泽区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140107', '杏花岭区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140108', '尖草坪区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140109', '万柏林区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140110', '晋源区', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140121', '清徐县', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140122', '阳曲县', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140123', '娄烦县', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140181', '古交市', '3', '140100');
INSERT INTO `thinkox_district` VALUES ('140201', '市辖区', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140202', '城　区', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140203', '矿　区', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140211', '南郊区', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140212', '新荣区', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140221', '阳高县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140222', '天镇县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140223', '广灵县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140224', '灵丘县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140225', '浑源县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140226', '左云县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140227', '大同县', '3', '140200');
INSERT INTO `thinkox_district` VALUES ('140301', '市辖区', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140302', '城　区', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140303', '矿　区', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140311', '郊　区', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140321', '平定县', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140322', '盂　县', '3', '140300');
INSERT INTO `thinkox_district` VALUES ('140401', '市辖区', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140402', '城　区', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140411', '郊　区', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140421', '长治县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140423', '襄垣县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140424', '屯留县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140425', '平顺县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140426', '黎城县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140427', '壶关县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140428', '长子县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140429', '武乡县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140430', '沁　县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140431', '沁源县', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140481', '潞城市', '3', '140400');
INSERT INTO `thinkox_district` VALUES ('140501', '市辖区', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140502', '城　区', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140521', '沁水县', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140522', '阳城县', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140524', '陵川县', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140525', '泽州县', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140581', '高平市', '3', '140500');
INSERT INTO `thinkox_district` VALUES ('140601', '市辖区', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140602', '朔城区', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140603', '平鲁区', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140621', '山阴县', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140622', '应　县', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140623', '右玉县', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140624', '怀仁县', '3', '140600');
INSERT INTO `thinkox_district` VALUES ('140701', '市辖区', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140702', '榆次区', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140721', '榆社县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140722', '左权县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140723', '和顺县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140724', '昔阳县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140725', '寿阳县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140726', '太谷县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140727', '祁　县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140728', '平遥县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140729', '灵石县', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140781', '介休市', '3', '140700');
INSERT INTO `thinkox_district` VALUES ('140801', '市辖区', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140802', '盐湖区', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140821', '临猗县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140822', '万荣县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140823', '闻喜县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140824', '稷山县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140825', '新绛县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140826', '绛　县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140827', '垣曲县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140828', '夏　县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140829', '平陆县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140830', '芮城县', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140881', '永济市', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140882', '河津市', '3', '140800');
INSERT INTO `thinkox_district` VALUES ('140901', '市辖区', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140902', '忻府区', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140921', '定襄县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140922', '五台县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140923', '代　县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140924', '繁峙县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140925', '宁武县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140926', '静乐县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140927', '神池县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140928', '五寨县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140929', '岢岚县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140930', '河曲县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140931', '保德县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140932', '偏关县', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('140981', '原平市', '3', '140900');
INSERT INTO `thinkox_district` VALUES ('141001', '市辖区', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141002', '尧都区', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141021', '曲沃县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141022', '翼城县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141023', '襄汾县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141024', '洪洞县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141025', '古　县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141026', '安泽县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141027', '浮山县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141028', '吉　县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141029', '乡宁县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141030', '大宁县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141031', '隰　县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141032', '永和县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141033', '蒲　县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141034', '汾西县', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141081', '侯马市', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141082', '霍州市', '3', '141000');
INSERT INTO `thinkox_district` VALUES ('141101', '市辖区', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141102', '离石区', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141121', '文水县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141122', '交城县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141123', '兴　县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141124', '临　县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141125', '柳林县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141126', '石楼县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141127', '岚　县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141128', '方山县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141129', '中阳县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141130', '交口县', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141181', '孝义市', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('141182', '汾阳市', '3', '141100');
INSERT INTO `thinkox_district` VALUES ('150101', '市辖区', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150102', '新城区', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150103', '回民区', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150104', '玉泉区', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150105', '赛罕区', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150121', '土默特左旗', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150122', '托克托县', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150123', '和林格尔县', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150124', '清水河县', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150125', '武川县', '3', '150100');
INSERT INTO `thinkox_district` VALUES ('150201', '市辖区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150202', '东河区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150203', '昆都仑区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150204', '青山区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150205', '石拐区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150206', '白云矿区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150207', '九原区', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150221', '土默特右旗', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150222', '固阳县', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150223', '达尔罕茂明安联合旗', '3', '150200');
INSERT INTO `thinkox_district` VALUES ('150301', '市辖区', '3', '150300');
INSERT INTO `thinkox_district` VALUES ('150302', '海勃湾区', '3', '150300');
INSERT INTO `thinkox_district` VALUES ('150303', '海南区', '3', '150300');
INSERT INTO `thinkox_district` VALUES ('150304', '乌达区', '3', '150300');
INSERT INTO `thinkox_district` VALUES ('150401', '市辖区', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150402', '红山区', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150403', '元宝山区', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150404', '松山区', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150421', '阿鲁科尔沁旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150422', '巴林左旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150423', '巴林右旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150424', '林西县', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150425', '克什克腾旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150426', '翁牛特旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150428', '喀喇沁旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150429', '宁城县', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150430', '敖汉旗', '3', '150400');
INSERT INTO `thinkox_district` VALUES ('150501', '市辖区', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150502', '科尔沁区', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150521', '科尔沁左翼中旗', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150522', '科尔沁左翼后旗', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150523', '开鲁县', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150524', '库伦旗', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150525', '奈曼旗', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150526', '扎鲁特旗', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150581', '霍林郭勒市', '3', '150500');
INSERT INTO `thinkox_district` VALUES ('150602', '东胜区', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150621', '达拉特旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150622', '准格尔旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150623', '鄂托克前旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150624', '鄂托克旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150625', '杭锦旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150626', '乌审旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150627', '伊金霍洛旗', '3', '150600');
INSERT INTO `thinkox_district` VALUES ('150701', '市辖区', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150702', '海拉尔区', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150721', '阿荣旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150722', '莫力达瓦达斡尔族自治旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150723', '鄂伦春自治旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150724', '鄂温克族自治旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150725', '陈巴尔虎旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150726', '新巴尔虎左旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150727', '新巴尔虎右旗', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150781', '满洲里市', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150782', '牙克石市', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150783', '扎兰屯市', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150784', '额尔古纳市', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150785', '根河市', '3', '150700');
INSERT INTO `thinkox_district` VALUES ('150801', '市辖区', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150802', '临河区', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150821', '五原县', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150822', '磴口县', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150823', '乌拉特前旗', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150824', '乌拉特中旗', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150825', '乌拉特后旗', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150826', '杭锦后旗', '3', '150800');
INSERT INTO `thinkox_district` VALUES ('150901', '市辖区', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150902', '集宁区', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150921', '卓资县', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150922', '化德县', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150923', '商都县', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150924', '兴和县', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150925', '凉城县', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150926', '察哈尔右翼前旗', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150927', '察哈尔右翼中旗', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150928', '察哈尔右翼后旗', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150929', '四子王旗', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('150981', '丰镇市', '3', '150900');
INSERT INTO `thinkox_district` VALUES ('152201', '乌兰浩特市', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152202', '阿尔山市', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152221', '科尔沁右翼前旗', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152222', '科尔沁右翼中旗', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152223', '扎赉特旗', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152224', '突泉县', '3', '152200');
INSERT INTO `thinkox_district` VALUES ('152501', '二连浩特市', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152502', '锡林浩特市', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152522', '阿巴嘎旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152523', '苏尼特左旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152524', '苏尼特右旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152525', '东乌珠穆沁旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152526', '西乌珠穆沁旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152527', '太仆寺旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152528', '镶黄旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152529', '正镶白旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152530', '正蓝旗', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152531', '多伦县', '3', '152500');
INSERT INTO `thinkox_district` VALUES ('152921', '阿拉善左旗', '3', '152900');
INSERT INTO `thinkox_district` VALUES ('152922', '阿拉善右旗', '3', '152900');
INSERT INTO `thinkox_district` VALUES ('152923', '额济纳旗', '3', '152900');
INSERT INTO `thinkox_district` VALUES ('210101', '市辖区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210102', '和平区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210103', '沈河区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210104', '大东区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210105', '皇姑区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210106', '铁西区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210111', '苏家屯区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210112', '东陵区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210113', '新城子区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210114', '于洪区', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210122', '辽中县', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210123', '康平县', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210124', '法库县', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210181', '新民市', '3', '210100');
INSERT INTO `thinkox_district` VALUES ('210201', '市辖区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210202', '中山区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210203', '西岗区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210204', '沙河口区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210211', '甘井子区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210212', '旅顺口区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210213', '金州区', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210224', '长海县', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210281', '瓦房店市', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210282', '普兰店市', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210283', '庄河市', '3', '210200');
INSERT INTO `thinkox_district` VALUES ('210301', '市辖区', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210302', '铁东区', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210303', '铁西区', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210304', '立山区', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210311', '千山区', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210321', '台安县', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210323', '岫岩满族自治县', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210381', '海城市', '3', '210300');
INSERT INTO `thinkox_district` VALUES ('210401', '市辖区', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210402', '新抚区', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210403', '东洲区', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210404', '望花区', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210411', '顺城区', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210421', '抚顺县', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210422', '新宾满族自治县', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210423', '清原满族自治县', '3', '210400');
INSERT INTO `thinkox_district` VALUES ('210501', '市辖区', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210502', '平山区', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210503', '溪湖区', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210504', '明山区', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210505', '南芬区', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210521', '本溪满族自治县', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210522', '桓仁满族自治县', '3', '210500');
INSERT INTO `thinkox_district` VALUES ('210601', '市辖区', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210602', '元宝区', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210603', '振兴区', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210604', '振安区', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210624', '宽甸满族自治县', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210681', '东港市', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210682', '凤城市', '3', '210600');
INSERT INTO `thinkox_district` VALUES ('210701', '市辖区', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210702', '古塔区', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210703', '凌河区', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210711', '太和区', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210726', '黑山县', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210727', '义　县', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210781', '凌海市', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210782', '北宁市', '3', '210700');
INSERT INTO `thinkox_district` VALUES ('210801', '市辖区', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210802', '站前区', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210803', '西市区', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210804', '鲅鱼圈区', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210811', '老边区', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210881', '盖州市', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210882', '大石桥市', '3', '210800');
INSERT INTO `thinkox_district` VALUES ('210901', '市辖区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210902', '海州区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210903', '新邱区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210904', '太平区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210905', '清河门区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210911', '细河区', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210921', '阜新蒙古族自治县', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('210922', '彰武县', '3', '210900');
INSERT INTO `thinkox_district` VALUES ('211001', '市辖区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211002', '白塔区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211003', '文圣区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211004', '宏伟区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211005', '弓长岭区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211011', '太子河区', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211021', '辽阳县', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211081', '灯塔市', '3', '211000');
INSERT INTO `thinkox_district` VALUES ('211101', '市辖区', '3', '211100');
INSERT INTO `thinkox_district` VALUES ('211102', '双台子区', '3', '211100');
INSERT INTO `thinkox_district` VALUES ('211103', '兴隆台区', '3', '211100');
INSERT INTO `thinkox_district` VALUES ('211121', '大洼县', '3', '211100');
INSERT INTO `thinkox_district` VALUES ('211122', '盘山县', '3', '211100');
INSERT INTO `thinkox_district` VALUES ('211201', '市辖区', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211202', '银州区', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211204', '清河区', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211221', '铁岭县', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211223', '西丰县', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211224', '昌图县', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211281', '调兵山市', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211282', '开原市', '3', '211200');
INSERT INTO `thinkox_district` VALUES ('211301', '市辖区', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211302', '双塔区', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211303', '龙城区', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211321', '朝阳县', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211322', '建平县', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211324', '喀喇沁左翼蒙古族自治县', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211381', '北票市', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211382', '凌源市', '3', '211300');
INSERT INTO `thinkox_district` VALUES ('211401', '市辖区', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211402', '连山区', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211403', '龙港区', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211404', '南票区', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211421', '绥中县', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211422', '建昌县', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('211481', '兴城市', '3', '211400');
INSERT INTO `thinkox_district` VALUES ('220101', '市辖区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220102', '南关区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220103', '宽城区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220104', '朝阳区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220105', '二道区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220106', '绿园区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220112', '双阳区', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220122', '农安县', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220181', '九台市', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220182', '榆树市', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220183', '德惠市', '3', '220100');
INSERT INTO `thinkox_district` VALUES ('220201', '市辖区', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220202', '昌邑区', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220203', '龙潭区', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220204', '船营区', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220211', '丰满区', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220221', '永吉县', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220281', '蛟河市', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220282', '桦甸市', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220283', '舒兰市', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220284', '磐石市', '3', '220200');
INSERT INTO `thinkox_district` VALUES ('220301', '市辖区', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220302', '铁西区', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220303', '铁东区', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220322', '梨树县', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220323', '伊通满族自治县', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220381', '公主岭市', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220382', '双辽市', '3', '220300');
INSERT INTO `thinkox_district` VALUES ('220401', '市辖区', '3', '220400');
INSERT INTO `thinkox_district` VALUES ('220402', '龙山区', '3', '220400');
INSERT INTO `thinkox_district` VALUES ('220403', '西安区', '3', '220400');
INSERT INTO `thinkox_district` VALUES ('220421', '东丰县', '3', '220400');
INSERT INTO `thinkox_district` VALUES ('220422', '东辽县', '3', '220400');
INSERT INTO `thinkox_district` VALUES ('220501', '市辖区', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220502', '东昌区', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220503', '二道江区', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220521', '通化县', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220523', '辉南县', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220524', '柳河县', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220581', '梅河口市', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220582', '集安市', '3', '220500');
INSERT INTO `thinkox_district` VALUES ('220601', '市辖区', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220602', '八道江区', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220621', '抚松县', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220622', '靖宇县', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220623', '长白朝鲜族自治县', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220625', '江源县', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220681', '临江市', '3', '220600');
INSERT INTO `thinkox_district` VALUES ('220701', '市辖区', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220702', '宁江区', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220721', '前郭尔罗斯蒙古族自治县', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220722', '长岭县', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220723', '乾安县', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220724', '扶余县', '3', '220700');
INSERT INTO `thinkox_district` VALUES ('220801', '市辖区', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('220802', '洮北区', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('220821', '镇赉县', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('220822', '通榆县', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('220881', '洮南市', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('220882', '大安市', '3', '220800');
INSERT INTO `thinkox_district` VALUES ('222401', '延吉市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222402', '图们市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222403', '敦化市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222404', '珲春市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222405', '龙井市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222406', '和龙市', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222424', '汪清县', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('222426', '安图县', '3', '222400');
INSERT INTO `thinkox_district` VALUES ('230101', '市辖区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230102', '道里区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230103', '南岗区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230104', '道外区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230106', '香坊区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230107', '动力区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230108', '平房区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230109', '松北区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230111', '呼兰区', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230123', '依兰县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230124', '方正县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230125', '宾　县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230126', '巴彦县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230127', '木兰县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230128', '通河县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230129', '延寿县', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230181', '阿城市', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230182', '双城市', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230183', '尚志市', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230184', '五常市', '3', '230100');
INSERT INTO `thinkox_district` VALUES ('230201', '市辖区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230202', '龙沙区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230203', '建华区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230204', '铁锋区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230205', '昂昂溪区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230206', '富拉尔基区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230207', '碾子山区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230208', '梅里斯达斡尔族区', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230221', '龙江县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230223', '依安县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230224', '泰来县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230225', '甘南县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230227', '富裕县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230229', '克山县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230230', '克东县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230231', '拜泉县', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230281', '讷河市', '3', '230200');
INSERT INTO `thinkox_district` VALUES ('230301', '市辖区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230302', '鸡冠区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230303', '恒山区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230304', '滴道区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230305', '梨树区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230306', '城子河区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230307', '麻山区', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230321', '鸡东县', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230381', '虎林市', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230382', '密山市', '3', '230300');
INSERT INTO `thinkox_district` VALUES ('230401', '市辖区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230402', '向阳区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230403', '工农区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230404', '南山区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230405', '兴安区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230406', '东山区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230407', '兴山区', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230421', '萝北县', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230422', '绥滨县', '3', '230400');
INSERT INTO `thinkox_district` VALUES ('230501', '市辖区', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230502', '尖山区', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230503', '岭东区', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230505', '四方台区', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230506', '宝山区', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230521', '集贤县', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230522', '友谊县', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230523', '宝清县', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230524', '饶河县', '3', '230500');
INSERT INTO `thinkox_district` VALUES ('230601', '市辖区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230602', '萨尔图区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230603', '龙凤区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230604', '让胡路区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230605', '红岗区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230606', '大同区', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230621', '肇州县', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230622', '肇源县', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230623', '林甸县', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230624', '杜尔伯特蒙古族自治县', '3', '230600');
INSERT INTO `thinkox_district` VALUES ('230701', '市辖区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230702', '伊春区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230703', '南岔区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230704', '友好区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230705', '西林区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230706', '翠峦区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230707', '新青区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230708', '美溪区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230709', '金山屯区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230710', '五营区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230711', '乌马河区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230712', '汤旺河区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230713', '带岭区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230714', '乌伊岭区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230715', '红星区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230716', '上甘岭区', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230722', '嘉荫县', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230781', '铁力市', '3', '230700');
INSERT INTO `thinkox_district` VALUES ('230801', '市辖区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230802', '永红区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230803', '向阳区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230804', '前进区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230805', '东风区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230811', '郊　区', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230822', '桦南县', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230826', '桦川县', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230828', '汤原县', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230833', '抚远县', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230881', '同江市', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230882', '富锦市', '3', '230800');
INSERT INTO `thinkox_district` VALUES ('230901', '市辖区', '3', '230900');
INSERT INTO `thinkox_district` VALUES ('230902', '新兴区', '3', '230900');
INSERT INTO `thinkox_district` VALUES ('230903', '桃山区', '3', '230900');
INSERT INTO `thinkox_district` VALUES ('230904', '茄子河区', '3', '230900');
INSERT INTO `thinkox_district` VALUES ('230921', '勃利县', '3', '230900');
INSERT INTO `thinkox_district` VALUES ('231001', '市辖区', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231002', '东安区', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231003', '阳明区', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231004', '爱民区', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231005', '西安区', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231024', '东宁县', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231025', '林口县', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231081', '绥芬河市', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231083', '海林市', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231084', '宁安市', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231085', '穆棱市', '3', '231000');
INSERT INTO `thinkox_district` VALUES ('231101', '市辖区', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231102', '爱辉区', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231121', '嫩江县', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231123', '逊克县', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231124', '孙吴县', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231181', '北安市', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231182', '五大连池市', '3', '231100');
INSERT INTO `thinkox_district` VALUES ('231201', '市辖区', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231202', '北林区', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231221', '望奎县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231222', '兰西县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231223', '青冈县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231224', '庆安县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231225', '明水县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231226', '绥棱县', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231281', '安达市', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231282', '肇东市', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('231283', '海伦市', '3', '231200');
INSERT INTO `thinkox_district` VALUES ('232721', '呼玛县', '3', '232700');
INSERT INTO `thinkox_district` VALUES ('232722', '塔河县', '3', '232700');
INSERT INTO `thinkox_district` VALUES ('232723', '漠河县', '3', '232700');
INSERT INTO `thinkox_district` VALUES ('310101', '黄浦区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310103', '卢湾区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310104', '徐汇区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310105', '长宁区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310106', '静安区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310107', '普陀区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310108', '闸北区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310109', '虹口区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310110', '杨浦区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310112', '闵行区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310113', '宝山区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310114', '嘉定区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310115', '浦东新区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310116', '金山区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310117', '松江区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310118', '青浦区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310119', '南汇区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310120', '奉贤区', '3', '310100');
INSERT INTO `thinkox_district` VALUES ('310230', '崇明县', '3', '310200');
INSERT INTO `thinkox_district` VALUES ('320101', '市辖区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320102', '玄武区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320103', '白下区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320104', '秦淮区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320105', '建邺区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320106', '鼓楼区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320107', '下关区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320111', '浦口区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320113', '栖霞区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320114', '雨花台区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320115', '江宁区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320116', '六合区', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320124', '溧水县', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320125', '高淳县', '3', '320100');
INSERT INTO `thinkox_district` VALUES ('320201', '市辖区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320202', '崇安区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320203', '南长区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320204', '北塘区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320205', '锡山区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320206', '惠山区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320211', '滨湖区', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320281', '江阴市', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320282', '宜兴市', '3', '320200');
INSERT INTO `thinkox_district` VALUES ('320301', '市辖区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320302', '鼓楼区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320303', '云龙区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320304', '九里区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320305', '贾汪区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320311', '泉山区', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320321', '丰　县', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320322', '沛　县', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320323', '铜山县', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320324', '睢宁县', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320381', '新沂市', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320382', '邳州市', '3', '320300');
INSERT INTO `thinkox_district` VALUES ('320401', '市辖区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320402', '天宁区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320404', '钟楼区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320405', '戚墅堰区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320411', '新北区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320412', '武进区', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320481', '溧阳市', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320482', '金坛市', '3', '320400');
INSERT INTO `thinkox_district` VALUES ('320501', '市辖区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320502', '沧浪区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320503', '平江区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320504', '金阊区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320505', '虎丘区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320506', '吴中区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320507', '相城区', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320581', '常熟市', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320582', '张家港市', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320583', '昆山市', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320584', '吴江市', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320585', '太仓市', '3', '320500');
INSERT INTO `thinkox_district` VALUES ('320601', '市辖区', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320602', '崇川区', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320611', '港闸区', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320621', '海安县', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320623', '如东县', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320681', '启东市', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320682', '如皋市', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320683', '通州市', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320684', '海门市', '3', '320600');
INSERT INTO `thinkox_district` VALUES ('320701', '市辖区', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320703', '连云区', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320705', '新浦区', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320706', '海州区', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320721', '赣榆县', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320722', '东海县', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320723', '灌云县', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320724', '灌南县', '3', '320700');
INSERT INTO `thinkox_district` VALUES ('320801', '市辖区', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320802', '清河区', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320803', '楚州区', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320804', '淮阴区', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320811', '清浦区', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320826', '涟水县', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320829', '洪泽县', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320830', '盱眙县', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320831', '金湖县', '3', '320800');
INSERT INTO `thinkox_district` VALUES ('320901', '市辖区', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320902', '亭湖区', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320903', '盐都区', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320921', '响水县', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320922', '滨海县', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320923', '阜宁县', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320924', '射阳县', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320925', '建湖县', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320981', '东台市', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('320982', '大丰市', '3', '320900');
INSERT INTO `thinkox_district` VALUES ('321001', '市辖区', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321002', '广陵区', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321003', '邗江区', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321011', '郊　区', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321023', '宝应县', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321081', '仪征市', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321084', '高邮市', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321088', '江都市', '3', '321000');
INSERT INTO `thinkox_district` VALUES ('321101', '市辖区', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321102', '京口区', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321111', '润州区', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321112', '丹徒区', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321181', '丹阳市', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321182', '扬中市', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321183', '句容市', '3', '321100');
INSERT INTO `thinkox_district` VALUES ('321201', '市辖区', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321202', '海陵区', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321203', '高港区', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321281', '兴化市', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321282', '靖江市', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321283', '泰兴市', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321284', '姜堰市', '3', '321200');
INSERT INTO `thinkox_district` VALUES ('321301', '市辖区', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('321302', '宿城区', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('321311', '宿豫区', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('321322', '沭阳县', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('321323', '泗阳县', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('321324', '泗洪县', '3', '321300');
INSERT INTO `thinkox_district` VALUES ('330101', '市辖区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330102', '上城区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330103', '下城区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330104', '江干区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330105', '拱墅区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330106', '西湖区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330108', '滨江区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330109', '萧山区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330110', '余杭区', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330122', '桐庐县', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330127', '淳安县', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330182', '建德市', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330183', '富阳市', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330185', '临安市', '3', '330100');
INSERT INTO `thinkox_district` VALUES ('330201', '市辖区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330203', '海曙区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330204', '江东区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330205', '江北区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330206', '北仑区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330211', '镇海区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330212', '鄞州区', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330225', '象山县', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330226', '宁海县', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330281', '余姚市', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330282', '慈溪市', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330283', '奉化市', '3', '330200');
INSERT INTO `thinkox_district` VALUES ('330301', '市辖区', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330302', '鹿城区', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330303', '龙湾区', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330304', '瓯海区', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330322', '洞头县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330324', '永嘉县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330326', '平阳县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330327', '苍南县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330328', '文成县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330329', '泰顺县', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330381', '瑞安市', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330382', '乐清市', '3', '330300');
INSERT INTO `thinkox_district` VALUES ('330401', '市辖区', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330402', '秀城区', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330411', '秀洲区', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330421', '嘉善县', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330424', '海盐县', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330481', '海宁市', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330482', '平湖市', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330483', '桐乡市', '3', '330400');
INSERT INTO `thinkox_district` VALUES ('330501', '市辖区', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330502', '吴兴区', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330503', '南浔区', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330521', '德清县', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330522', '长兴县', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330523', '安吉县', '3', '330500');
INSERT INTO `thinkox_district` VALUES ('330601', '市辖区', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330602', '越城区', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330621', '绍兴县', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330624', '新昌县', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330681', '诸暨市', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330682', '上虞市', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330683', '嵊州市', '3', '330600');
INSERT INTO `thinkox_district` VALUES ('330701', '市辖区', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330702', '婺城区', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330703', '金东区', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330723', '武义县', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330726', '浦江县', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330727', '磐安县', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330781', '兰溪市', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330782', '义乌市', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330783', '东阳市', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330784', '永康市', '3', '330700');
INSERT INTO `thinkox_district` VALUES ('330801', '市辖区', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330802', '柯城区', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330803', '衢江区', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330822', '常山县', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330824', '开化县', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330825', '龙游县', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330881', '江山市', '3', '330800');
INSERT INTO `thinkox_district` VALUES ('330901', '市辖区', '3', '330900');
INSERT INTO `thinkox_district` VALUES ('330902', '定海区', '3', '330900');
INSERT INTO `thinkox_district` VALUES ('330903', '普陀区', '3', '330900');
INSERT INTO `thinkox_district` VALUES ('330921', '岱山县', '3', '330900');
INSERT INTO `thinkox_district` VALUES ('330922', '嵊泗县', '3', '330900');
INSERT INTO `thinkox_district` VALUES ('331001', '市辖区', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331002', '椒江区', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331003', '黄岩区', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331004', '路桥区', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331021', '玉环县', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331022', '三门县', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331023', '天台县', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331024', '仙居县', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331081', '温岭市', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331082', '临海市', '3', '331000');
INSERT INTO `thinkox_district` VALUES ('331101', '市辖区', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331102', '莲都区', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331121', '青田县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331122', '缙云县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331123', '遂昌县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331124', '松阳县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331125', '云和县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331126', '庆元县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331127', '景宁畲族自治县', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('331181', '龙泉市', '3', '331100');
INSERT INTO `thinkox_district` VALUES ('340101', '市辖区', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340102', '瑶海区', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340103', '庐阳区', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340104', '蜀山区', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340111', '包河区', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340121', '长丰县', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340122', '肥东县', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340123', '肥西县', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('340201', '市辖区', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340202', '镜湖区', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340203', '马塘区', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340204', '新芜区', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340207', '鸠江区', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340221', '芜湖县', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340222', '繁昌县', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340223', '南陵县', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('340301', '市辖区', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340302', '龙子湖区', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340303', '蚌山区', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340304', '禹会区', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340311', '淮上区', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340321', '怀远县', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340322', '五河县', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340323', '固镇县', '3', '340300');
INSERT INTO `thinkox_district` VALUES ('340401', '市辖区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340402', '大通区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340403', '田家庵区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340404', '谢家集区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340405', '八公山区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340406', '潘集区', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340421', '凤台县', '3', '340400');
INSERT INTO `thinkox_district` VALUES ('340501', '市辖区', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('340502', '金家庄区', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('340503', '花山区', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('340504', '雨山区', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('340521', '当涂县', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('340601', '市辖区', '3', '340600');
INSERT INTO `thinkox_district` VALUES ('340602', '杜集区', '3', '340600');
INSERT INTO `thinkox_district` VALUES ('340603', '相山区', '3', '340600');
INSERT INTO `thinkox_district` VALUES ('340604', '烈山区', '3', '340600');
INSERT INTO `thinkox_district` VALUES ('340621', '濉溪县', '3', '340600');
INSERT INTO `thinkox_district` VALUES ('340701', '市辖区', '3', '340700');
INSERT INTO `thinkox_district` VALUES ('340702', '铜官山区', '3', '340700');
INSERT INTO `thinkox_district` VALUES ('340703', '狮子山区', '3', '340700');
INSERT INTO `thinkox_district` VALUES ('340711', '郊　区', '3', '340700');
INSERT INTO `thinkox_district` VALUES ('340721', '铜陵县', '3', '340700');
INSERT INTO `thinkox_district` VALUES ('340801', '市辖区', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340802', '迎江区', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340803', '大观区', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340811', '郊　区', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340822', '怀宁县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340823', '枞阳县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340824', '潜山县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340825', '太湖县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340826', '宿松县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340827', '望江县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340828', '岳西县', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('340881', '桐城市', '3', '340800');
INSERT INTO `thinkox_district` VALUES ('341001', '市辖区', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341002', '屯溪区', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341003', '黄山区', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341004', '徽州区', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341021', '歙　县', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341022', '休宁县', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341023', '黟　县', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341024', '祁门县', '3', '341000');
INSERT INTO `thinkox_district` VALUES ('341101', '市辖区', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341102', '琅琊区', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341103', '南谯区', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341122', '来安县', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341124', '全椒县', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341125', '定远县', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341126', '凤阳县', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341181', '天长市', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341182', '明光市', '3', '341100');
INSERT INTO `thinkox_district` VALUES ('341201', '市辖区', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341202', '颍州区', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341203', '颍东区', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341204', '颍泉区', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341221', '临泉县', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341222', '太和县', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341225', '阜南县', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341226', '颍上县', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341282', '界首市', '3', '341200');
INSERT INTO `thinkox_district` VALUES ('341301', '市辖区', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341302', '墉桥区', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341321', '砀山县', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341322', '萧　县', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341323', '灵璧县', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341324', '泗　县', '3', '341300');
INSERT INTO `thinkox_district` VALUES ('341401', '庐江县', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('341402', '巢湖市', '3', '340100');
INSERT INTO `thinkox_district` VALUES ('341422', '无为县', '3', '340200');
INSERT INTO `thinkox_district` VALUES ('341423', '含山县', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('341424', '和　县', '3', '340500');
INSERT INTO `thinkox_district` VALUES ('341501', '市辖区', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341502', '金安区', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341503', '裕安区', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341521', '寿　县', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341522', '霍邱县', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341523', '舒城县', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341524', '金寨县', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341525', '霍山县', '3', '341500');
INSERT INTO `thinkox_district` VALUES ('341601', '市辖区', '3', '341600');
INSERT INTO `thinkox_district` VALUES ('341602', '谯城区', '3', '341600');
INSERT INTO `thinkox_district` VALUES ('341621', '涡阳县', '3', '341600');
INSERT INTO `thinkox_district` VALUES ('341622', '蒙城县', '3', '341600');
INSERT INTO `thinkox_district` VALUES ('341623', '利辛县', '3', '341600');
INSERT INTO `thinkox_district` VALUES ('341701', '市辖区', '3', '341700');
INSERT INTO `thinkox_district` VALUES ('341702', '贵池区', '3', '341700');
INSERT INTO `thinkox_district` VALUES ('341721', '东至县', '3', '341700');
INSERT INTO `thinkox_district` VALUES ('341722', '石台县', '3', '341700');
INSERT INTO `thinkox_district` VALUES ('341723', '青阳县', '3', '341700');
INSERT INTO `thinkox_district` VALUES ('341801', '市辖区', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341802', '宣州区', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341821', '郎溪县', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341822', '广德县', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341823', '泾　县', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341824', '绩溪县', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341825', '旌德县', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('341881', '宁国市', '3', '341800');
INSERT INTO `thinkox_district` VALUES ('350101', '市辖区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350102', '鼓楼区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350103', '台江区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350104', '仓山区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350105', '马尾区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350111', '晋安区', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350121', '闽侯县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350122', '连江县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350123', '罗源县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350124', '闽清县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350125', '永泰县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350128', '平潭县', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350181', '福清市', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350182', '长乐市', '3', '350100');
INSERT INTO `thinkox_district` VALUES ('350201', '市辖区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350203', '思明区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350205', '海沧区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350206', '湖里区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350211', '集美区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350212', '同安区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350213', '翔安区', '3', '350200');
INSERT INTO `thinkox_district` VALUES ('350301', '市辖区', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350302', '城厢区', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350303', '涵江区', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350304', '荔城区', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350305', '秀屿区', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350322', '仙游县', '3', '350300');
INSERT INTO `thinkox_district` VALUES ('350401', '市辖区', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350402', '梅列区', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350403', '三元区', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350421', '明溪县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350423', '清流县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350424', '宁化县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350425', '大田县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350426', '尤溪县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350427', '沙　县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350428', '将乐县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350429', '泰宁县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350430', '建宁县', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350481', '永安市', '3', '350400');
INSERT INTO `thinkox_district` VALUES ('350501', '市辖区', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350502', '鲤城区', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350503', '丰泽区', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350504', '洛江区', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350505', '泉港区', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350521', '惠安县', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350524', '安溪县', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350525', '永春县', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350526', '德化县', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350527', '金门县', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350581', '石狮市', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350582', '晋江市', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350583', '南安市', '3', '350500');
INSERT INTO `thinkox_district` VALUES ('350601', '市辖区', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350602', '芗城区', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350603', '龙文区', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350622', '云霄县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350623', '漳浦县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350624', '诏安县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350625', '长泰县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350626', '东山县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350627', '南靖县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350628', '平和县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350629', '华安县', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350681', '龙海市', '3', '350600');
INSERT INTO `thinkox_district` VALUES ('350701', '市辖区', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350702', '延平区', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350721', '顺昌县', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350722', '浦城县', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350723', '光泽县', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350724', '松溪县', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350725', '政和县', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350781', '邵武市', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350782', '武夷山市', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350783', '建瓯市', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350784', '建阳市', '3', '350700');
INSERT INTO `thinkox_district` VALUES ('350801', '市辖区', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350802', '新罗区', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350821', '长汀县', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350822', '永定县', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350823', '上杭县', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350824', '武平县', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350825', '连城县', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350881', '漳平市', '3', '350800');
INSERT INTO `thinkox_district` VALUES ('350901', '市辖区', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350902', '蕉城区', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350921', '霞浦县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350922', '古田县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350923', '屏南县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350924', '寿宁县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350925', '周宁县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350926', '柘荣县', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350981', '福安市', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('350982', '福鼎市', '3', '350900');
INSERT INTO `thinkox_district` VALUES ('360101', '市辖区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360102', '东湖区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360103', '西湖区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360104', '青云谱区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360105', '湾里区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360111', '青山湖区', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360121', '南昌县', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360122', '新建县', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360123', '安义县', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360124', '进贤县', '3', '360100');
INSERT INTO `thinkox_district` VALUES ('360201', '市辖区', '3', '360200');
INSERT INTO `thinkox_district` VALUES ('360202', '昌江区', '3', '360200');
INSERT INTO `thinkox_district` VALUES ('360203', '珠山区', '3', '360200');
INSERT INTO `thinkox_district` VALUES ('360222', '浮梁县', '3', '360200');
INSERT INTO `thinkox_district` VALUES ('360281', '乐平市', '3', '360200');
INSERT INTO `thinkox_district` VALUES ('360301', '市辖区', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360302', '安源区', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360313', '湘东区', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360321', '莲花县', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360322', '上栗县', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360323', '芦溪县', '3', '360300');
INSERT INTO `thinkox_district` VALUES ('360401', '市辖区', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360402', '庐山区', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360403', '浔阳区', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360421', '九江县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360423', '武宁县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360424', '修水县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360425', '永修县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360426', '德安县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360427', '星子县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360428', '都昌县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360429', '湖口县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360430', '彭泽县', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360481', '瑞昌市', '3', '360400');
INSERT INTO `thinkox_district` VALUES ('360501', '市辖区', '3', '360500');
INSERT INTO `thinkox_district` VALUES ('360502', '渝水区', '3', '360500');
INSERT INTO `thinkox_district` VALUES ('360521', '分宜县', '3', '360500');
INSERT INTO `thinkox_district` VALUES ('360601', '市辖区', '3', '360600');
INSERT INTO `thinkox_district` VALUES ('360602', '月湖区', '3', '360600');
INSERT INTO `thinkox_district` VALUES ('360622', '余江县', '3', '360600');
INSERT INTO `thinkox_district` VALUES ('360681', '贵溪市', '3', '360600');
INSERT INTO `thinkox_district` VALUES ('360701', '市辖区', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360702', '章贡区', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360721', '赣　县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360722', '信丰县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360723', '大余县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360724', '上犹县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360725', '崇义县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360726', '安远县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360727', '龙南县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360728', '定南县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360729', '全南县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360730', '宁都县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360731', '于都县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360732', '兴国县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360733', '会昌县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360734', '寻乌县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360735', '石城县', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360781', '瑞金市', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360782', '南康市', '3', '360700');
INSERT INTO `thinkox_district` VALUES ('360801', '市辖区', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360802', '吉州区', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360803', '青原区', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360821', '吉安县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360822', '吉水县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360823', '峡江县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360824', '新干县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360825', '永丰县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360826', '泰和县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360827', '遂川县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360828', '万安县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360829', '安福县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360830', '永新县', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360881', '井冈山市', '3', '360800');
INSERT INTO `thinkox_district` VALUES ('360901', '市辖区', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360902', '袁州区', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360921', '奉新县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360922', '万载县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360923', '上高县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360924', '宜丰县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360925', '靖安县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360926', '铜鼓县', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360981', '丰城市', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360982', '樟树市', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('360983', '高安市', '3', '360900');
INSERT INTO `thinkox_district` VALUES ('361001', '市辖区', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361002', '临川区', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361021', '南城县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361022', '黎川县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361023', '南丰县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361024', '崇仁县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361025', '乐安县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361026', '宜黄县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361027', '金溪县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361028', '资溪县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361029', '东乡县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361030', '广昌县', '3', '361000');
INSERT INTO `thinkox_district` VALUES ('361101', '市辖区', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361102', '信州区', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361121', '上饶县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361122', '广丰县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361123', '玉山县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361124', '铅山县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361125', '横峰县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361126', '弋阳县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361127', '余干县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361128', '鄱阳县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361129', '万年县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361130', '婺源县', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('361181', '德兴市', '3', '361100');
INSERT INTO `thinkox_district` VALUES ('370101', '市辖区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370102', '历下区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370103', '市中区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370104', '槐荫区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370105', '天桥区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370112', '历城区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370113', '长清区', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370124', '平阴县', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370125', '济阳县', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370126', '商河县', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370181', '章丘市', '3', '370100');
INSERT INTO `thinkox_district` VALUES ('370201', '市辖区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370202', '市南区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370203', '市北区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370205', '四方区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370211', '黄岛区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370212', '崂山区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370213', '李沧区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370214', '城阳区', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370281', '胶州市', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370282', '即墨市', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370283', '平度市', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370284', '胶南市', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370285', '莱西市', '3', '370200');
INSERT INTO `thinkox_district` VALUES ('370301', '市辖区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370302', '淄川区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370303', '张店区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370304', '博山区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370305', '临淄区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370306', '周村区', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370321', '桓台县', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370322', '高青县', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370323', '沂源县', '3', '370300');
INSERT INTO `thinkox_district` VALUES ('370401', '市辖区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370402', '市中区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370403', '薛城区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370404', '峄城区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370405', '台儿庄区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370406', '山亭区', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370481', '滕州市', '3', '370400');
INSERT INTO `thinkox_district` VALUES ('370501', '市辖区', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370502', '东营区', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370503', '河口区', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370521', '垦利县', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370522', '利津县', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370523', '广饶县', '3', '370500');
INSERT INTO `thinkox_district` VALUES ('370601', '市辖区', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370602', '芝罘区', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370611', '福山区', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370612', '牟平区', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370613', '莱山区', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370634', '长岛县', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370681', '龙口市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370682', '莱阳市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370683', '莱州市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370684', '蓬莱市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370685', '招远市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370686', '栖霞市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370687', '海阳市', '3', '370600');
INSERT INTO `thinkox_district` VALUES ('370701', '市辖区', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370702', '潍城区', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370703', '寒亭区', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370704', '坊子区', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370705', '奎文区', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370724', '临朐县', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370725', '昌乐县', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370781', '青州市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370782', '诸城市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370783', '寿光市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370784', '安丘市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370785', '高密市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370786', '昌邑市', '3', '370700');
INSERT INTO `thinkox_district` VALUES ('370801', '市辖区', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370802', '市中区', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370811', '任城区', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370826', '微山县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370827', '鱼台县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370828', '金乡县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370829', '嘉祥县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370830', '汶上县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370831', '泗水县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370832', '梁山县', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370881', '曲阜市', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370882', '兖州市', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370883', '邹城市', '3', '370800');
INSERT INTO `thinkox_district` VALUES ('370901', '市辖区', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370902', '泰山区', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370903', '岱岳区', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370921', '宁阳县', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370923', '东平县', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370982', '新泰市', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('370983', '肥城市', '3', '370900');
INSERT INTO `thinkox_district` VALUES ('371001', '市辖区', '3', '371000');
INSERT INTO `thinkox_district` VALUES ('371002', '环翠区', '3', '371000');
INSERT INTO `thinkox_district` VALUES ('371081', '文登市', '3', '371000');
INSERT INTO `thinkox_district` VALUES ('371082', '荣成市', '3', '371000');
INSERT INTO `thinkox_district` VALUES ('371083', '乳山市', '3', '371000');
INSERT INTO `thinkox_district` VALUES ('371101', '市辖区', '3', '371100');
INSERT INTO `thinkox_district` VALUES ('371102', '东港区', '3', '371100');
INSERT INTO `thinkox_district` VALUES ('371103', '岚山区', '3', '371100');
INSERT INTO `thinkox_district` VALUES ('371121', '五莲县', '3', '371100');
INSERT INTO `thinkox_district` VALUES ('371122', '莒　县', '3', '371100');
INSERT INTO `thinkox_district` VALUES ('371201', '市辖区', '3', '371200');
INSERT INTO `thinkox_district` VALUES ('371202', '莱城区', '3', '371200');
INSERT INTO `thinkox_district` VALUES ('371203', '钢城区', '3', '371200');
INSERT INTO `thinkox_district` VALUES ('371301', '市辖区', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371302', '兰山区', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371311', '罗庄区', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371312', '河东区', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371321', '沂南县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371322', '郯城县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371323', '沂水县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371324', '苍山县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371325', '费　县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371326', '平邑县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371327', '莒南县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371328', '蒙阴县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371329', '临沭县', '3', '371300');
INSERT INTO `thinkox_district` VALUES ('371401', '市辖区', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371402', '德城区', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371421', '陵　县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371422', '宁津县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371423', '庆云县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371424', '临邑县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371425', '齐河县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371426', '平原县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371427', '夏津县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371428', '武城县', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371481', '乐陵市', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371482', '禹城市', '3', '371400');
INSERT INTO `thinkox_district` VALUES ('371501', '市辖区', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371502', '东昌府区', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371521', '阳谷县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371522', '莘　县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371523', '茌平县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371524', '东阿县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371525', '冠　县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371526', '高唐县', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371581', '临清市', '3', '371500');
INSERT INTO `thinkox_district` VALUES ('371601', '市辖区', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371602', '滨城区', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371621', '惠民县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371622', '阳信县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371623', '无棣县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371624', '沾化县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371625', '博兴县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371626', '邹平县', '3', '371600');
INSERT INTO `thinkox_district` VALUES ('371701', '市辖区', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371702', '牡丹区', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371721', '曹　县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371722', '单　县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371723', '成武县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371724', '巨野县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371725', '郓城县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371726', '鄄城县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371727', '定陶县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('371728', '东明县', '3', '371700');
INSERT INTO `thinkox_district` VALUES ('410101', '市辖区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410102', '中原区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410103', '二七区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410104', '管城回族区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410105', '金水区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410106', '上街区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410108', '邙山区', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410122', '中牟县', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410181', '巩义市', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410182', '荥阳市', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410183', '新密市', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410184', '新郑市', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410185', '登封市', '3', '410100');
INSERT INTO `thinkox_district` VALUES ('410201', '市辖区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410202', '龙亭区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410203', '顺河回族区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410204', '鼓楼区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410205', '南关区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410211', '郊　区', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410221', '杞　县', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410222', '通许县', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410223', '尉氏县', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410224', '开封县', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410225', '兰考县', '3', '410200');
INSERT INTO `thinkox_district` VALUES ('410301', '市辖区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410302', '老城区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410303', '西工区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410304', '廛河回族区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410305', '涧西区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410306', '吉利区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410307', '洛龙区', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410322', '孟津县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410323', '新安县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410324', '栾川县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410325', '嵩　县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410326', '汝阳县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410327', '宜阳县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410328', '洛宁县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410329', '伊川县', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410381', '偃师市', '3', '410300');
INSERT INTO `thinkox_district` VALUES ('410401', '市辖区', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410402', '新华区', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410403', '卫东区', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410404', '石龙区', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410411', '湛河区', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410421', '宝丰县', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410422', '叶　县', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410423', '鲁山县', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410425', '郏　县', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410481', '舞钢市', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410482', '汝州市', '3', '410400');
INSERT INTO `thinkox_district` VALUES ('410501', '市辖区', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410502', '文峰区', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410503', '北关区', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410505', '殷都区', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410506', '龙安区', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410522', '安阳县', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410523', '汤阴县', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410526', '滑　县', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410527', '内黄县', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410581', '林州市', '3', '410500');
INSERT INTO `thinkox_district` VALUES ('410601', '市辖区', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410602', '鹤山区', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410603', '山城区', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410611', '淇滨区', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410621', '浚　县', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410622', '淇　县', '3', '410600');
INSERT INTO `thinkox_district` VALUES ('410701', '市辖区', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410702', '红旗区', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410703', '卫滨区', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410704', '凤泉区', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410711', '牧野区', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410721', '新乡县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410724', '获嘉县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410725', '原阳县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410726', '延津县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410727', '封丘县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410728', '长垣县', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410781', '卫辉市', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410782', '辉县市', '3', '410700');
INSERT INTO `thinkox_district` VALUES ('410801', '市辖区', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410802', '解放区', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410803', '中站区', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410804', '马村区', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410811', '山阳区', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410821', '修武县', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410822', '博爱县', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410823', '武陟县', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410825', '温　县', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410881', '济源市', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410882', '沁阳市', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410883', '孟州市', '3', '410800');
INSERT INTO `thinkox_district` VALUES ('410901', '市辖区', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410902', '华龙区', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410922', '清丰县', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410923', '南乐县', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410926', '范　县', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410927', '台前县', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('410928', '濮阳县', '3', '410900');
INSERT INTO `thinkox_district` VALUES ('411001', '市辖区', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411002', '魏都区', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411023', '许昌县', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411024', '鄢陵县', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411025', '襄城县', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411081', '禹州市', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411082', '长葛市', '3', '411000');
INSERT INTO `thinkox_district` VALUES ('411101', '市辖区', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411102', '源汇区', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411103', '郾城区', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411104', '召陵区', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411121', '舞阳县', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411122', '临颍县', '3', '411100');
INSERT INTO `thinkox_district` VALUES ('411201', '市辖区', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411202', '湖滨区', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411221', '渑池县', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411222', '陕　县', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411224', '卢氏县', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411281', '义马市', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411282', '灵宝市', '3', '411200');
INSERT INTO `thinkox_district` VALUES ('411301', '市辖区', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411302', '宛城区', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411303', '卧龙区', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411321', '南召县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411322', '方城县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411323', '西峡县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411324', '镇平县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411325', '内乡县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411326', '淅川县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411327', '社旗县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411328', '唐河县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411329', '新野县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411330', '桐柏县', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411381', '邓州市', '3', '411300');
INSERT INTO `thinkox_district` VALUES ('411401', '市辖区', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411402', '梁园区', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411403', '睢阳区', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411421', '民权县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411422', '睢　县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411423', '宁陵县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411424', '柘城县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411425', '虞城县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411426', '夏邑县', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411481', '永城市', '3', '411400');
INSERT INTO `thinkox_district` VALUES ('411501', '市辖区', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411502', '师河区', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411503', '平桥区', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411521', '罗山县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411522', '光山县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411523', '新　县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411524', '商城县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411525', '固始县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411526', '潢川县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411527', '淮滨县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411528', '息　县', '3', '411500');
INSERT INTO `thinkox_district` VALUES ('411601', '市辖区', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411602', '川汇区', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411621', '扶沟县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411622', '西华县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411623', '商水县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411624', '沈丘县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411625', '郸城县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411626', '淮阳县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411627', '太康县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411628', '鹿邑县', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411681', '项城市', '3', '411600');
INSERT INTO `thinkox_district` VALUES ('411701', '市辖区', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411702', '驿城区', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411721', '西平县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411722', '上蔡县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411723', '平舆县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411724', '正阳县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411725', '确山县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411726', '泌阳县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411727', '汝南县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411728', '遂平县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('411729', '新蔡县', '3', '411700');
INSERT INTO `thinkox_district` VALUES ('420101', '市辖区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420102', '江岸区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420103', '江汉区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420104', '乔口区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420105', '汉阳区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420106', '武昌区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420107', '青山区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420111', '洪山区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420112', '东西湖区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420113', '汉南区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420114', '蔡甸区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420115', '江夏区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420116', '黄陂区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420117', '新洲区', '3', '420100');
INSERT INTO `thinkox_district` VALUES ('420201', '市辖区', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420202', '黄石港区', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420203', '西塞山区', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420204', '下陆区', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420205', '铁山区', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420222', '阳新县', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420281', '大冶市', '3', '420200');
INSERT INTO `thinkox_district` VALUES ('420301', '市辖区', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420302', '茅箭区', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420303', '张湾区', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420321', '郧　县', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420322', '郧西县', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420323', '竹山县', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420324', '竹溪县', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420325', '房　县', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420381', '丹江口市', '3', '420300');
INSERT INTO `thinkox_district` VALUES ('420501', '市辖区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420502', '西陵区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420503', '伍家岗区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420504', '点军区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420505', '猇亭区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420506', '夷陵区', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420525', '远安县', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420526', '兴山县', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420527', '秭归县', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420528', '长阳土家族自治县', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420529', '五峰土家族自治县', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420581', '宜都市', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420582', '当阳市', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420583', '枝江市', '3', '420500');
INSERT INTO `thinkox_district` VALUES ('420601', '市辖区', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420602', '襄城区', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420606', '樊城区', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420607', '襄阳区', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420624', '南漳县', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420625', '谷城县', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420626', '保康县', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420682', '老河口市', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420683', '枣阳市', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420684', '宜城市', '3', '420600');
INSERT INTO `thinkox_district` VALUES ('420701', '市辖区', '3', '420700');
INSERT INTO `thinkox_district` VALUES ('420702', '梁子湖区', '3', '420700');
INSERT INTO `thinkox_district` VALUES ('420703', '华容区', '3', '420700');
INSERT INTO `thinkox_district` VALUES ('420704', '鄂城区', '3', '420700');
INSERT INTO `thinkox_district` VALUES ('420801', '市辖区', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420802', '东宝区', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420804', '掇刀区', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420821', '京山县', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420822', '沙洋县', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420881', '钟祥市', '3', '420800');
INSERT INTO `thinkox_district` VALUES ('420901', '市辖区', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420902', '孝南区', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420921', '孝昌县', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420922', '大悟县', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420923', '云梦县', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420981', '应城市', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420982', '安陆市', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('420984', '汉川市', '3', '420900');
INSERT INTO `thinkox_district` VALUES ('421001', '市辖区', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421002', '沙市区', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421003', '荆州区', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421022', '公安县', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421023', '监利县', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421024', '江陵县', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421081', '石首市', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421083', '洪湖市', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421087', '松滋市', '3', '421000');
INSERT INTO `thinkox_district` VALUES ('421101', '市辖区', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421102', '黄州区', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421121', '团风县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421122', '红安县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421123', '罗田县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421124', '英山县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421125', '浠水县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421126', '蕲春县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421127', '黄梅县', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421181', '麻城市', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421182', '武穴市', '3', '421100');
INSERT INTO `thinkox_district` VALUES ('421201', '市辖区', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421202', '咸安区', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421221', '嘉鱼县', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421222', '通城县', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421223', '崇阳县', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421224', '通山县', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421281', '赤壁市', '3', '421200');
INSERT INTO `thinkox_district` VALUES ('421301', '市辖区', '3', '421300');
INSERT INTO `thinkox_district` VALUES ('421302', '曾都区', '3', '421300');
INSERT INTO `thinkox_district` VALUES ('421381', '广水市', '3', '421300');
INSERT INTO `thinkox_district` VALUES ('422801', '恩施市', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422802', '利川市', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422822', '建始县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422823', '巴东县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422825', '宣恩县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422826', '咸丰县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422827', '来凤县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('422828', '鹤峰县', '3', '422800');
INSERT INTO `thinkox_district` VALUES ('429004', '仙桃市', '3', '429000');
INSERT INTO `thinkox_district` VALUES ('429005', '潜江市', '3', '429000');
INSERT INTO `thinkox_district` VALUES ('429006', '天门市', '3', '429000');
INSERT INTO `thinkox_district` VALUES ('429021', '神农架林区', '3', '429000');
INSERT INTO `thinkox_district` VALUES ('430101', '市辖区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430102', '芙蓉区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430103', '天心区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430104', '岳麓区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430105', '开福区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430111', '雨花区', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430121', '长沙县', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430122', '望城县', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430124', '宁乡县', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430181', '浏阳市', '3', '430100');
INSERT INTO `thinkox_district` VALUES ('430201', '市辖区', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430202', '荷塘区', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430203', '芦淞区', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430204', '石峰区', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430211', '天元区', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430221', '株洲县', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430223', '攸　县', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430224', '茶陵县', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430225', '炎陵县', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430281', '醴陵市', '3', '430200');
INSERT INTO `thinkox_district` VALUES ('430301', '市辖区', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430302', '雨湖区', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430304', '岳塘区', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430321', '湘潭县', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430381', '湘乡市', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430382', '韶山市', '3', '430300');
INSERT INTO `thinkox_district` VALUES ('430401', '市辖区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430405', '珠晖区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430406', '雁峰区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430407', '石鼓区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430408', '蒸湘区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430412', '南岳区', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430421', '衡阳县', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430422', '衡南县', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430423', '衡山县', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430424', '衡东县', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430426', '祁东县', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430481', '耒阳市', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430482', '常宁市', '3', '430400');
INSERT INTO `thinkox_district` VALUES ('430501', '市辖区', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430502', '双清区', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430503', '大祥区', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430511', '北塔区', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430521', '邵东县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430522', '新邵县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430523', '邵阳县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430524', '隆回县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430525', '洞口县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430527', '绥宁县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430528', '新宁县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430529', '城步苗族自治县', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430581', '武冈市', '3', '430500');
INSERT INTO `thinkox_district` VALUES ('430601', '市辖区', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430602', '岳阳楼区', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430603', '云溪区', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430611', '君山区', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430621', '岳阳县', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430623', '华容县', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430624', '湘阴县', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430626', '平江县', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430681', '汨罗市', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430682', '临湘市', '3', '430600');
INSERT INTO `thinkox_district` VALUES ('430701', '市辖区', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430702', '武陵区', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430703', '鼎城区', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430721', '安乡县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430722', '汉寿县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430723', '澧　县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430724', '临澧县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430725', '桃源县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430726', '石门县', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430781', '津市市', '3', '430700');
INSERT INTO `thinkox_district` VALUES ('430801', '市辖区', '3', '430800');
INSERT INTO `thinkox_district` VALUES ('430802', '永定区', '3', '430800');
INSERT INTO `thinkox_district` VALUES ('430811', '武陵源区', '3', '430800');
INSERT INTO `thinkox_district` VALUES ('430821', '慈利县', '3', '430800');
INSERT INTO `thinkox_district` VALUES ('430822', '桑植县', '3', '430800');
INSERT INTO `thinkox_district` VALUES ('430901', '市辖区', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430902', '资阳区', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430903', '赫山区', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430921', '南　县', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430922', '桃江县', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430923', '安化县', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('430981', '沅江市', '3', '430900');
INSERT INTO `thinkox_district` VALUES ('431001', '市辖区', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431002', '北湖区', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431003', '苏仙区', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431021', '桂阳县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431022', '宜章县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431023', '永兴县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431024', '嘉禾县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431025', '临武县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431026', '汝城县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431027', '桂东县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431028', '安仁县', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431081', '资兴市', '3', '431000');
INSERT INTO `thinkox_district` VALUES ('431101', '市辖区', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431102', '芝山区', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431103', '冷水滩区', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431121', '祁阳县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431122', '东安县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431123', '双牌县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431124', '道　县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431125', '江永县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431126', '宁远县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431127', '蓝山县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431128', '新田县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431129', '江华瑶族自治县', '3', '431100');
INSERT INTO `thinkox_district` VALUES ('431201', '市辖区', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431202', '鹤城区', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431221', '中方县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431222', '沅陵县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431223', '辰溪县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431224', '溆浦县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431225', '会同县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431226', '麻阳苗族自治县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431227', '新晃侗族自治县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431228', '芷江侗族自治县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431229', '靖州苗族侗族自治县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431230', '通道侗族自治县', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431281', '洪江市', '3', '431200');
INSERT INTO `thinkox_district` VALUES ('431301', '市辖区', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('431302', '娄星区', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('431321', '双峰县', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('431322', '新化县', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('431381', '冷水江市', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('431382', '涟源市', '3', '431300');
INSERT INTO `thinkox_district` VALUES ('433101', '吉首市', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433122', '泸溪县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433123', '凤凰县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433124', '花垣县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433125', '保靖县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433126', '古丈县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433127', '永顺县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('433130', '龙山县', '3', '433100');
INSERT INTO `thinkox_district` VALUES ('440101', '市辖区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440102', '东山区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440103', '荔湾区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440104', '越秀区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440105', '海珠区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440106', '天河区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440107', '芳村区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440111', '白云区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440112', '黄埔区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440113', '番禺区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440114', '花都区', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440183', '增城市', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440184', '从化市', '3', '440100');
INSERT INTO `thinkox_district` VALUES ('440201', '市辖区', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440203', '武江区', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440204', '浈江区', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440205', '曲江区', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440222', '始兴县', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440224', '仁化县', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440229', '翁源县', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440232', '乳源瑶族自治县', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440233', '新丰县', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440281', '乐昌市', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440282', '南雄市', '3', '440200');
INSERT INTO `thinkox_district` VALUES ('440301', '市辖区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440303', '罗湖区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440304', '福田区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440305', '南山区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440306', '宝安区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440307', '龙岗区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440308', '盐田区', '3', '440300');
INSERT INTO `thinkox_district` VALUES ('440401', '市辖区', '3', '440400');
INSERT INTO `thinkox_district` VALUES ('440402', '香洲区', '3', '440400');
INSERT INTO `thinkox_district` VALUES ('440403', '斗门区', '3', '440400');
INSERT INTO `thinkox_district` VALUES ('440404', '金湾区', '3', '440400');
INSERT INTO `thinkox_district` VALUES ('440501', '市辖区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440507', '龙湖区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440511', '金平区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440512', '濠江区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440513', '潮阳区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440514', '潮南区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440515', '澄海区', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440523', '南澳县', '3', '440500');
INSERT INTO `thinkox_district` VALUES ('440601', '市辖区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440604', '禅城区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440605', '南海区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440606', '顺德区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440607', '三水区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440608', '高明区', '3', '440600');
INSERT INTO `thinkox_district` VALUES ('440701', '市辖区', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440703', '蓬江区', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440704', '江海区', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440705', '新会区', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440781', '台山市', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440783', '开平市', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440784', '鹤山市', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440785', '恩平市', '3', '440700');
INSERT INTO `thinkox_district` VALUES ('440801', '市辖区', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440802', '赤坎区', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440803', '霞山区', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440804', '坡头区', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440811', '麻章区', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440823', '遂溪县', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440825', '徐闻县', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440881', '廉江市', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440882', '雷州市', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440883', '吴川市', '3', '440800');
INSERT INTO `thinkox_district` VALUES ('440901', '市辖区', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440902', '茂南区', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440903', '茂港区', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440923', '电白县', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440981', '高州市', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440982', '化州市', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('440983', '信宜市', '3', '440900');
INSERT INTO `thinkox_district` VALUES ('441201', '市辖区', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441202', '端州区', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441203', '鼎湖区', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441223', '广宁县', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441224', '怀集县', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441225', '封开县', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441226', '德庆县', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441283', '高要市', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441284', '四会市', '3', '441200');
INSERT INTO `thinkox_district` VALUES ('441301', '市辖区', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441302', '惠城区', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441303', '惠阳区', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441322', '博罗县', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441323', '惠东县', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441324', '龙门县', '3', '441300');
INSERT INTO `thinkox_district` VALUES ('441401', '市辖区', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441402', '梅江区', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441421', '梅　县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441422', '大埔县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441423', '丰顺县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441424', '五华县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441426', '平远县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441427', '蕉岭县', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441481', '兴宁市', '3', '441400');
INSERT INTO `thinkox_district` VALUES ('441501', '市辖区', '3', '441500');
INSERT INTO `thinkox_district` VALUES ('441502', '城　区', '3', '441500');
INSERT INTO `thinkox_district` VALUES ('441521', '海丰县', '3', '441500');
INSERT INTO `thinkox_district` VALUES ('441523', '陆河县', '3', '441500');
INSERT INTO `thinkox_district` VALUES ('441581', '陆丰市', '3', '441500');
INSERT INTO `thinkox_district` VALUES ('441601', '市辖区', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441602', '源城区', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441621', '紫金县', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441622', '龙川县', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441623', '连平县', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441624', '和平县', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441625', '东源县', '3', '441600');
INSERT INTO `thinkox_district` VALUES ('441701', '市辖区', '3', '441700');
INSERT INTO `thinkox_district` VALUES ('441702', '江城区', '3', '441700');
INSERT INTO `thinkox_district` VALUES ('441721', '阳西县', '3', '441700');
INSERT INTO `thinkox_district` VALUES ('441723', '阳东县', '3', '441700');
INSERT INTO `thinkox_district` VALUES ('441781', '阳春市', '3', '441700');
INSERT INTO `thinkox_district` VALUES ('441801', '市辖区', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441802', '清城区', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441821', '佛冈县', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441823', '阳山县', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441825', '连山壮族瑶族自治县', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441826', '连南瑶族自治县', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441827', '清新县', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441881', '英德市', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('441882', '连州市', '3', '441800');
INSERT INTO `thinkox_district` VALUES ('445101', '市辖区', '3', '445100');
INSERT INTO `thinkox_district` VALUES ('445102', '湘桥区', '3', '445100');
INSERT INTO `thinkox_district` VALUES ('445121', '潮安县', '3', '445100');
INSERT INTO `thinkox_district` VALUES ('445122', '饶平县', '3', '445100');
INSERT INTO `thinkox_district` VALUES ('445201', '市辖区', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445202', '榕城区', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445221', '揭东县', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445222', '揭西县', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445224', '惠来县', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445281', '普宁市', '3', '445200');
INSERT INTO `thinkox_district` VALUES ('445301', '市辖区', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('445302', '云城区', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('445321', '新兴县', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('445322', '郁南县', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('445323', '云安县', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('445381', '罗定市', '3', '445300');
INSERT INTO `thinkox_district` VALUES ('450101', '市辖区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450102', '兴宁区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450103', '青秀区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450105', '江南区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450107', '西乡塘区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450108', '良庆区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450109', '邕宁区', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450122', '武鸣县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450123', '隆安县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450124', '马山县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450125', '上林县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450126', '宾阳县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450127', '横　县', '3', '450100');
INSERT INTO `thinkox_district` VALUES ('450201', '市辖区', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450202', '城中区', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450203', '鱼峰区', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450204', '柳南区', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450205', '柳北区', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450221', '柳江县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450222', '柳城县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450223', '鹿寨县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450224', '融安县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450225', '融水苗族自治县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450226', '三江侗族自治县', '3', '450200');
INSERT INTO `thinkox_district` VALUES ('450301', '市辖区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450302', '秀峰区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450303', '叠彩区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450304', '象山区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450305', '七星区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450311', '雁山区', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450321', '阳朔县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450322', '临桂县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450323', '灵川县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450324', '全州县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450325', '兴安县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450326', '永福县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450327', '灌阳县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450328', '龙胜各族自治县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450329', '资源县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450330', '平乐县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450331', '荔蒲县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450332', '恭城瑶族自治县', '3', '450300');
INSERT INTO `thinkox_district` VALUES ('450401', '市辖区', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450403', '万秀区', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450404', '蝶山区', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450405', '长洲区', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450421', '苍梧县', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450422', '藤　县', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450423', '蒙山县', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450481', '岑溪市', '3', '450400');
INSERT INTO `thinkox_district` VALUES ('450501', '市辖区', '3', '450500');
INSERT INTO `thinkox_district` VALUES ('450502', '海城区', '3', '450500');
INSERT INTO `thinkox_district` VALUES ('450503', '银海区', '3', '450500');
INSERT INTO `thinkox_district` VALUES ('450512', '铁山港区', '3', '450500');
INSERT INTO `thinkox_district` VALUES ('450521', '合浦县', '3', '450500');
INSERT INTO `thinkox_district` VALUES ('450601', '市辖区', '3', '450600');
INSERT INTO `thinkox_district` VALUES ('450602', '港口区', '3', '450600');
INSERT INTO `thinkox_district` VALUES ('450603', '防城区', '3', '450600');
INSERT INTO `thinkox_district` VALUES ('450621', '上思县', '3', '450600');
INSERT INTO `thinkox_district` VALUES ('450681', '东兴市', '3', '450600');
INSERT INTO `thinkox_district` VALUES ('450701', '市辖区', '3', '450700');
INSERT INTO `thinkox_district` VALUES ('450702', '钦南区', '3', '450700');
INSERT INTO `thinkox_district` VALUES ('450703', '钦北区', '3', '450700');
INSERT INTO `thinkox_district` VALUES ('450721', '灵山县', '3', '450700');
INSERT INTO `thinkox_district` VALUES ('450722', '浦北县', '3', '450700');
INSERT INTO `thinkox_district` VALUES ('450801', '市辖区', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450802', '港北区', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450803', '港南区', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450804', '覃塘区', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450821', '平南县', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450881', '桂平市', '3', '450800');
INSERT INTO `thinkox_district` VALUES ('450901', '市辖区', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450902', '玉州区', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450921', '容　县', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450922', '陆川县', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450923', '博白县', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450924', '兴业县', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('450981', '北流市', '3', '450900');
INSERT INTO `thinkox_district` VALUES ('451001', '市辖区', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451002', '右江区', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451021', '田阳县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451022', '田东县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451023', '平果县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451024', '德保县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451025', '靖西县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451026', '那坡县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451027', '凌云县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451028', '乐业县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451029', '田林县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451030', '西林县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451031', '隆林各族自治县', '3', '451000');
INSERT INTO `thinkox_district` VALUES ('451101', '市辖区', '3', '451100');
INSERT INTO `thinkox_district` VALUES ('451102', '八步区', '3', '451100');
INSERT INTO `thinkox_district` VALUES ('451121', '昭平县', '3', '451100');
INSERT INTO `thinkox_district` VALUES ('451122', '钟山县', '3', '451100');
INSERT INTO `thinkox_district` VALUES ('451123', '富川瑶族自治县', '3', '451100');
INSERT INTO `thinkox_district` VALUES ('451201', '市辖区', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451202', '金城江区', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451221', '南丹县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451222', '天峨县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451223', '凤山县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451224', '东兰县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451225', '罗城仫佬族自治县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451226', '环江毛南族自治县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451227', '巴马瑶族自治县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451228', '都安瑶族自治县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451229', '大化瑶族自治县', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451281', '宜州市', '3', '451200');
INSERT INTO `thinkox_district` VALUES ('451301', '市辖区', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451302', '兴宾区', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451321', '忻城县', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451322', '象州县', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451323', '武宣县', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451324', '金秀瑶族自治县', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451381', '合山市', '3', '451300');
INSERT INTO `thinkox_district` VALUES ('451401', '市辖区', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451402', '江洲区', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451421', '扶绥县', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451422', '宁明县', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451423', '龙州县', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451424', '大新县', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451425', '天等县', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('451481', '凭祥市', '3', '451400');
INSERT INTO `thinkox_district` VALUES ('460101', '市辖区', '3', '460100');
INSERT INTO `thinkox_district` VALUES ('460105', '秀英区', '3', '460100');
INSERT INTO `thinkox_district` VALUES ('460106', '龙华区', '3', '460100');
INSERT INTO `thinkox_district` VALUES ('460107', '琼山区', '3', '460100');
INSERT INTO `thinkox_district` VALUES ('460108', '美兰区', '3', '460100');
INSERT INTO `thinkox_district` VALUES ('460201', '市辖区', '3', '460200');
INSERT INTO `thinkox_district` VALUES ('469001', '五指山市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469002', '琼海市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469003', '儋州市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469005', '文昌市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469006', '万宁市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469007', '东方市', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469025', '定安县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469026', '屯昌县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469027', '澄迈县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469028', '临高县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469030', '白沙黎族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469031', '昌江黎族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469033', '乐东黎族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469034', '陵水黎族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469035', '保亭黎族苗族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469036', '琼中黎族苗族自治县', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469037', '西沙群岛', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469038', '南沙群岛', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('469039', '中沙群岛的岛礁及其海域', '3', '469000');
INSERT INTO `thinkox_district` VALUES ('500101', '万州区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500102', '涪陵区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500103', '渝中区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500104', '大渡口区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500105', '江北区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500106', '沙坪坝区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500107', '九龙坡区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500108', '南岸区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500109', '北碚区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500110', '万盛区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500111', '双桥区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500112', '渝北区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500113', '巴南区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500114', '黔江区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500115', '长寿区', '3', '500100');
INSERT INTO `thinkox_district` VALUES ('500222', '綦江县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500223', '潼南县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500224', '铜梁县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500225', '大足县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500226', '荣昌县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500227', '璧山县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500228', '梁平县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500229', '城口县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500230', '丰都县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500231', '垫江县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500232', '武隆县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500233', '忠　县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500234', '开　县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500235', '云阳县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500236', '奉节县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500237', '巫山县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500238', '巫溪县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500240', '石柱土家族自治县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500241', '秀山土家族苗族自治县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500242', '酉阳土家族苗族自治县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500243', '彭水苗族土家族自治县', '3', '500200');
INSERT INTO `thinkox_district` VALUES ('500381', '江津市', '3', '500300');
INSERT INTO `thinkox_district` VALUES ('500382', '合川市', '3', '500300');
INSERT INTO `thinkox_district` VALUES ('500383', '永川市', '3', '500300');
INSERT INTO `thinkox_district` VALUES ('500384', '南川市', '3', '500300');
INSERT INTO `thinkox_district` VALUES ('510101', '市辖区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510104', '锦江区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510105', '青羊区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510106', '金牛区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510107', '武侯区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510108', '成华区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510112', '龙泉驿区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510113', '青白江区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510114', '新都区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510115', '温江区', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510121', '金堂县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510122', '双流县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510124', '郫　县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510129', '大邑县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510131', '蒲江县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510132', '新津县', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510181', '都江堰市', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510182', '彭州市', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510183', '邛崃市', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510184', '崇州市', '3', '510100');
INSERT INTO `thinkox_district` VALUES ('510301', '市辖区', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510302', '自流井区', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510303', '贡井区', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510304', '大安区', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510311', '沿滩区', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510321', '荣　县', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510322', '富顺县', '3', '510300');
INSERT INTO `thinkox_district` VALUES ('510401', '市辖区', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510402', '东　区', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510403', '西　区', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510411', '仁和区', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510421', '米易县', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510422', '盐边县', '3', '510400');
INSERT INTO `thinkox_district` VALUES ('510501', '市辖区', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510502', '江阳区', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510503', '纳溪区', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510504', '龙马潭区', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510521', '泸　县', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510522', '合江县', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510524', '叙永县', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510525', '古蔺县', '3', '510500');
INSERT INTO `thinkox_district` VALUES ('510601', '市辖区', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510603', '旌阳区', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510623', '中江县', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510626', '罗江县', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510681', '广汉市', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510682', '什邡市', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510683', '绵竹市', '3', '510600');
INSERT INTO `thinkox_district` VALUES ('510701', '市辖区', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510703', '涪城区', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510704', '游仙区', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510722', '三台县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510723', '盐亭县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510724', '安　县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510725', '梓潼县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510726', '北川羌族自治县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510727', '平武县', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510781', '江油市', '3', '510700');
INSERT INTO `thinkox_district` VALUES ('510801', '市辖区', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510802', '市中区', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510811', '元坝区', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510812', '朝天区', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510821', '旺苍县', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510822', '青川县', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510823', '剑阁县', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510824', '苍溪县', '3', '510800');
INSERT INTO `thinkox_district` VALUES ('510901', '市辖区', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('510903', '船山区', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('510904', '安居区', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('510921', '蓬溪县', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('510922', '射洪县', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('510923', '大英县', '3', '510900');
INSERT INTO `thinkox_district` VALUES ('511001', '市辖区', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511002', '市中区', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511011', '东兴区', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511024', '威远县', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511025', '资中县', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511028', '隆昌县', '3', '511000');
INSERT INTO `thinkox_district` VALUES ('511101', '市辖区', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511102', '市中区', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511111', '沙湾区', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511112', '五通桥区', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511113', '金口河区', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511123', '犍为县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511124', '井研县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511126', '夹江县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511129', '沐川县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511132', '峨边彝族自治县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511133', '马边彝族自治县', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511181', '峨眉山市', '3', '511100');
INSERT INTO `thinkox_district` VALUES ('511301', '市辖区', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511302', '顺庆区', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511303', '高坪区', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511304', '嘉陵区', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511321', '南部县', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511322', '营山县', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511323', '蓬安县', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511324', '仪陇县', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511325', '西充县', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511381', '阆中市', '3', '511300');
INSERT INTO `thinkox_district` VALUES ('511401', '市辖区', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511402', '东坡区', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511421', '仁寿县', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511422', '彭山县', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511423', '洪雅县', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511424', '丹棱县', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511425', '青神县', '3', '511400');
INSERT INTO `thinkox_district` VALUES ('511501', '市辖区', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511502', '翠屏区', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511521', '宜宾县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511522', '南溪县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511523', '江安县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511524', '长宁县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511525', '高　县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511526', '珙　县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511527', '筠连县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511528', '兴文县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511529', '屏山县', '3', '511500');
INSERT INTO `thinkox_district` VALUES ('511601', '市辖区', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511602', '广安区', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511621', '岳池县', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511622', '武胜县', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511623', '邻水县', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511681', '华莹市', '3', '511600');
INSERT INTO `thinkox_district` VALUES ('511701', '市辖区', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511702', '通川区', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511721', '达　县', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511722', '宣汉县', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511723', '开江县', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511724', '大竹县', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511725', '渠　县', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511781', '万源市', '3', '511700');
INSERT INTO `thinkox_district` VALUES ('511801', '市辖区', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511802', '雨城区', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511821', '名山县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511822', '荥经县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511823', '汉源县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511824', '石棉县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511825', '天全县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511826', '芦山县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511827', '宝兴县', '3', '511800');
INSERT INTO `thinkox_district` VALUES ('511901', '市辖区', '3', '511900');
INSERT INTO `thinkox_district` VALUES ('511902', '巴州区', '3', '511900');
INSERT INTO `thinkox_district` VALUES ('511921', '通江县', '3', '511900');
INSERT INTO `thinkox_district` VALUES ('511922', '南江县', '3', '511900');
INSERT INTO `thinkox_district` VALUES ('511923', '平昌县', '3', '511900');
INSERT INTO `thinkox_district` VALUES ('512001', '市辖区', '3', '512000');
INSERT INTO `thinkox_district` VALUES ('512002', '雁江区', '3', '512000');
INSERT INTO `thinkox_district` VALUES ('512021', '安岳县', '3', '512000');
INSERT INTO `thinkox_district` VALUES ('512022', '乐至县', '3', '512000');
INSERT INTO `thinkox_district` VALUES ('512081', '简阳市', '3', '512000');
INSERT INTO `thinkox_district` VALUES ('513221', '汶川县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513222', '理　县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513223', '茂　县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513224', '松潘县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513225', '九寨沟县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513226', '金川县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513227', '小金县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513228', '黑水县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513229', '马尔康县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513230', '壤塘县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513231', '阿坝县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513232', '若尔盖县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513233', '红原县', '3', '513200');
INSERT INTO `thinkox_district` VALUES ('513321', '康定县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513322', '泸定县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513323', '丹巴县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513324', '九龙县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513325', '雅江县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513326', '道孚县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513327', '炉霍县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513328', '甘孜县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513329', '新龙县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513330', '德格县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513331', '白玉县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513332', '石渠县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513333', '色达县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513334', '理塘县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513335', '巴塘县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513336', '乡城县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513337', '稻城县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513338', '得荣县', '3', '513300');
INSERT INTO `thinkox_district` VALUES ('513401', '西昌市', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513422', '木里藏族自治县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513423', '盐源县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513424', '德昌县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513425', '会理县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513426', '会东县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513427', '宁南县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513428', '普格县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513429', '布拖县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513430', '金阳县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513431', '昭觉县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513432', '喜德县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513433', '冕宁县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513434', '越西县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513435', '甘洛县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513436', '美姑县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('513437', '雷波县', '3', '513400');
INSERT INTO `thinkox_district` VALUES ('520101', '市辖区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520102', '南明区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520103', '云岩区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520111', '花溪区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520112', '乌当区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520113', '白云区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520114', '小河区', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520121', '开阳县', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520122', '息烽县', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520123', '修文县', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520181', '清镇市', '3', '520100');
INSERT INTO `thinkox_district` VALUES ('520201', '钟山区', '3', '520200');
INSERT INTO `thinkox_district` VALUES ('520203', '六枝特区', '3', '520200');
INSERT INTO `thinkox_district` VALUES ('520221', '水城县', '3', '520200');
INSERT INTO `thinkox_district` VALUES ('520222', '盘　县', '3', '520200');
INSERT INTO `thinkox_district` VALUES ('520301', '市辖区', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520302', '红花岗区', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520303', '汇川区', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520321', '遵义县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520322', '桐梓县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520323', '绥阳县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520324', '正安县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520325', '道真仡佬族苗族自治县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520326', '务川仡佬族苗族自治县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520327', '凤冈县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520328', '湄潭县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520329', '余庆县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520330', '习水县', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520381', '赤水市', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520382', '仁怀市', '3', '520300');
INSERT INTO `thinkox_district` VALUES ('520401', '市辖区', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520402', '西秀区', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520421', '平坝县', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520422', '普定县', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520423', '镇宁布依族苗族自治县', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520424', '关岭布依族苗族自治县', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('520425', '紫云苗族布依族自治县', '3', '520400');
INSERT INTO `thinkox_district` VALUES ('522201', '铜仁市', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522222', '江口县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522223', '玉屏侗族自治县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522224', '石阡县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522225', '思南县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522226', '印江土家族苗族自治县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522227', '德江县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522228', '沿河土家族自治县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522229', '松桃苗族自治县', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522230', '万山特区', '3', '522200');
INSERT INTO `thinkox_district` VALUES ('522301', '兴义市', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522322', '兴仁县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522323', '普安县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522324', '晴隆县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522325', '贞丰县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522326', '望谟县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522327', '册亨县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522328', '安龙县', '3', '522300');
INSERT INTO `thinkox_district` VALUES ('522401', '毕节市', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522422', '大方县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522423', '黔西县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522424', '金沙县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522425', '织金县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522426', '纳雍县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522427', '威宁彝族回族苗族自治县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522428', '赫章县', '3', '522400');
INSERT INTO `thinkox_district` VALUES ('522601', '凯里市', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522622', '黄平县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522623', '施秉县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522624', '三穗县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522625', '镇远县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522626', '岑巩县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522627', '天柱县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522628', '锦屏县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522629', '剑河县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522630', '台江县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522631', '黎平县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522632', '榕江县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522633', '从江县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522634', '雷山县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522635', '麻江县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522636', '丹寨县', '3', '522600');
INSERT INTO `thinkox_district` VALUES ('522701', '都匀市', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522702', '福泉市', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522722', '荔波县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522723', '贵定县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522725', '瓮安县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522726', '独山县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522727', '平塘县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522728', '罗甸县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522729', '长顺县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522730', '龙里县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522731', '惠水县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('522732', '三都水族自治县', '3', '522700');
INSERT INTO `thinkox_district` VALUES ('530101', '市辖区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530102', '五华区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530103', '盘龙区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530111', '官渡区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530112', '西山区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530113', '东川区', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530121', '呈贡县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530122', '晋宁县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530124', '富民县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530125', '宜良县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530126', '石林彝族自治县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530127', '嵩明县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530128', '禄劝彝族苗族自治县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530129', '寻甸回族彝族自治县', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530181', '安宁市', '3', '530100');
INSERT INTO `thinkox_district` VALUES ('530301', '市辖区', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530302', '麒麟区', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530321', '马龙县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530322', '陆良县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530323', '师宗县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530324', '罗平县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530325', '富源县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530326', '会泽县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530328', '沾益县', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530381', '宣威市', '3', '530300');
INSERT INTO `thinkox_district` VALUES ('530401', '市辖区', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530402', '红塔区', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530421', '江川县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530422', '澄江县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530423', '通海县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530424', '华宁县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530425', '易门县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530426', '峨山彝族自治县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530427', '新平彝族傣族自治县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530428', '元江哈尼族彝族傣族自治县', '3', '530400');
INSERT INTO `thinkox_district` VALUES ('530501', '市辖区', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530502', '隆阳区', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530521', '施甸县', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530522', '腾冲县', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530523', '龙陵县', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530524', '昌宁县', '3', '530500');
INSERT INTO `thinkox_district` VALUES ('530601', '市辖区', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530602', '昭阳区', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530621', '鲁甸县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530622', '巧家县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530623', '盐津县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530624', '大关县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530625', '永善县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530626', '绥江县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530627', '镇雄县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530628', '彝良县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530629', '威信县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530630', '水富县', '3', '530600');
INSERT INTO `thinkox_district` VALUES ('530701', '市辖区', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530702', '古城区', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530721', '玉龙纳西族自治县', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530722', '永胜县', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530723', '华坪县', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530724', '宁蒗彝族自治县', '3', '530700');
INSERT INTO `thinkox_district` VALUES ('530801', '市辖区', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530802', '翠云区', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530821', '普洱哈尼族彝族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530822', '墨江哈尼族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530823', '景东彝族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530824', '景谷傣族彝族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530825', '镇沅彝族哈尼族拉祜族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530826', '江城哈尼族彝族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530827', '孟连傣族拉祜族佤族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530828', '澜沧拉祜族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530829', '西盟佤族自治县', '3', '530800');
INSERT INTO `thinkox_district` VALUES ('530901', '市辖区', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530902', '临翔区', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530921', '凤庆县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530922', '云　县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530923', '永德县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530924', '镇康县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530925', '双江拉祜族佤族布朗族傣族自治县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530926', '耿马傣族佤族自治县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('530927', '沧源佤族自治县', '3', '530900');
INSERT INTO `thinkox_district` VALUES ('532301', '楚雄市', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532322', '双柏县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532323', '牟定县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532324', '南华县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532325', '姚安县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532326', '大姚县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532327', '永仁县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532328', '元谋县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532329', '武定县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532331', '禄丰县', '3', '532300');
INSERT INTO `thinkox_district` VALUES ('532501', '个旧市', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532502', '开远市', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532522', '蒙自县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532523', '屏边苗族自治县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532524', '建水县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532525', '石屏县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532526', '弥勒县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532527', '泸西县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532528', '元阳县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532529', '红河县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532530', '金平苗族瑶族傣族自治县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532531', '绿春县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532532', '河口瑶族自治县', '3', '532500');
INSERT INTO `thinkox_district` VALUES ('532621', '文山县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532622', '砚山县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532623', '西畴县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532624', '麻栗坡县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532625', '马关县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532626', '丘北县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532627', '广南县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532628', '富宁县', '3', '532600');
INSERT INTO `thinkox_district` VALUES ('532801', '景洪市', '3', '532800');
INSERT INTO `thinkox_district` VALUES ('532822', '勐海县', '3', '532800');
INSERT INTO `thinkox_district` VALUES ('532823', '勐腊县', '3', '532800');
INSERT INTO `thinkox_district` VALUES ('532901', '大理市', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532922', '漾濞彝族自治县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532923', '祥云县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532924', '宾川县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532925', '弥渡县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532926', '南涧彝族自治县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532927', '巍山彝族回族自治县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532928', '永平县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532929', '云龙县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532930', '洱源县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532931', '剑川县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('532932', '鹤庆县', '3', '532900');
INSERT INTO `thinkox_district` VALUES ('533102', '瑞丽市', '3', '533100');
INSERT INTO `thinkox_district` VALUES ('533103', '潞西市', '3', '533100');
INSERT INTO `thinkox_district` VALUES ('533122', '梁河县', '3', '533100');
INSERT INTO `thinkox_district` VALUES ('533123', '盈江县', '3', '533100');
INSERT INTO `thinkox_district` VALUES ('533124', '陇川县', '3', '533100');
INSERT INTO `thinkox_district` VALUES ('533321', '泸水县', '3', '533300');
INSERT INTO `thinkox_district` VALUES ('533323', '福贡县', '3', '533300');
INSERT INTO `thinkox_district` VALUES ('533324', '贡山独龙族怒族自治县', '3', '533300');
INSERT INTO `thinkox_district` VALUES ('533325', '兰坪白族普米族自治县', '3', '533300');
INSERT INTO `thinkox_district` VALUES ('533421', '香格里拉县', '3', '533400');
INSERT INTO `thinkox_district` VALUES ('533422', '德钦县', '3', '533400');
INSERT INTO `thinkox_district` VALUES ('533423', '维西傈僳族自治县', '3', '533400');
INSERT INTO `thinkox_district` VALUES ('540101', '市辖区', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540102', '城关区', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540121', '林周县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540122', '当雄县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540123', '尼木县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540124', '曲水县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540125', '堆龙德庆县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540126', '达孜县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('540127', '墨竹工卡县', '3', '540100');
INSERT INTO `thinkox_district` VALUES ('542121', '昌都县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542122', '江达县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542123', '贡觉县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542124', '类乌齐县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542125', '丁青县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542126', '察雅县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542127', '八宿县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542128', '左贡县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542129', '芒康县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542132', '洛隆县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542133', '边坝县', '3', '542100');
INSERT INTO `thinkox_district` VALUES ('542221', '乃东县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542222', '扎囊县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542223', '贡嘎县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542224', '桑日县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542225', '琼结县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542226', '曲松县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542227', '措美县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542228', '洛扎县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542229', '加查县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542231', '隆子县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542232', '错那县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542233', '浪卡子县', '3', '542200');
INSERT INTO `thinkox_district` VALUES ('542301', '日喀则市', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542322', '南木林县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542323', '江孜县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542324', '定日县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542325', '萨迦县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542326', '拉孜县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542327', '昂仁县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542328', '谢通门县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542329', '白朗县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542330', '仁布县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542331', '康马县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542332', '定结县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542333', '仲巴县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542334', '亚东县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542335', '吉隆县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542336', '聂拉木县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542337', '萨嘎县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542338', '岗巴县', '3', '542300');
INSERT INTO `thinkox_district` VALUES ('542421', '那曲县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542422', '嘉黎县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542423', '比如县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542424', '聂荣县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542425', '安多县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542426', '申扎县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542427', '索　县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542428', '班戈县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542429', '巴青县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542430', '尼玛县', '3', '542400');
INSERT INTO `thinkox_district` VALUES ('542521', '普兰县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542522', '札达县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542523', '噶尔县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542524', '日土县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542525', '革吉县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542526', '改则县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542527', '措勤县', '3', '542500');
INSERT INTO `thinkox_district` VALUES ('542621', '林芝县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542622', '工布江达县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542623', '米林县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542624', '墨脱县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542625', '波密县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542626', '察隅县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('542627', '朗　县', '3', '542600');
INSERT INTO `thinkox_district` VALUES ('610101', '市辖区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610102', '新城区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610103', '碑林区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610104', '莲湖区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610111', '灞桥区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610112', '未央区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610113', '雁塔区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610114', '阎良区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610115', '临潼区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610116', '长安区', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610122', '蓝田县', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610124', '周至县', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610125', '户　县', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610126', '高陵县', '3', '610100');
INSERT INTO `thinkox_district` VALUES ('610201', '市辖区', '3', '610200');
INSERT INTO `thinkox_district` VALUES ('610202', '王益区', '3', '610200');
INSERT INTO `thinkox_district` VALUES ('610203', '印台区', '3', '610200');
INSERT INTO `thinkox_district` VALUES ('610204', '耀州区', '3', '610200');
INSERT INTO `thinkox_district` VALUES ('610222', '宜君县', '3', '610200');
INSERT INTO `thinkox_district` VALUES ('610301', '市辖区', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610302', '渭滨区', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610303', '金台区', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610304', '陈仓区', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610322', '凤翔县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610323', '岐山县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610324', '扶风县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610326', '眉　县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610327', '陇　县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610328', '千阳县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610329', '麟游县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610330', '凤　县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610331', '太白县', '3', '610300');
INSERT INTO `thinkox_district` VALUES ('610401', '市辖区', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610402', '秦都区', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610403', '杨凌区', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610404', '渭城区', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610422', '三原县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610423', '泾阳县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610424', '乾　县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610425', '礼泉县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610426', '永寿县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610427', '彬　县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610428', '长武县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610429', '旬邑县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610430', '淳化县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610431', '武功县', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610481', '兴平市', '3', '610400');
INSERT INTO `thinkox_district` VALUES ('610501', '市辖区', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610502', '临渭区', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610521', '华　县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610522', '潼关县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610523', '大荔县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610524', '合阳县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610525', '澄城县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610526', '蒲城县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610527', '白水县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610528', '富平县', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610581', '韩城市', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610582', '华阴市', '3', '610500');
INSERT INTO `thinkox_district` VALUES ('610601', '市辖区', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610602', '宝塔区', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610621', '延长县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610622', '延川县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610623', '子长县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610624', '安塞县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610625', '志丹县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610626', '吴旗县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610627', '甘泉县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610628', '富　县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610629', '洛川县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610630', '宜川县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610631', '黄龙县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610632', '黄陵县', '3', '610600');
INSERT INTO `thinkox_district` VALUES ('610701', '市辖区', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610702', '汉台区', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610721', '南郑县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610722', '城固县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610723', '洋　县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610724', '西乡县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610725', '勉　县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610726', '宁强县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610727', '略阳县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610728', '镇巴县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610729', '留坝县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610730', '佛坪县', '3', '610700');
INSERT INTO `thinkox_district` VALUES ('610801', '市辖区', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610802', '榆阳区', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610821', '神木县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610822', '府谷县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610823', '横山县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610824', '靖边县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610825', '定边县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610826', '绥德县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610827', '米脂县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610828', '佳　县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610829', '吴堡县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610830', '清涧县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610831', '子洲县', '3', '610800');
INSERT INTO `thinkox_district` VALUES ('610901', '市辖区', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610902', '汉滨区', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610921', '汉阴县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610922', '石泉县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610923', '宁陕县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610924', '紫阳县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610925', '岚皋县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610926', '平利县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610927', '镇坪县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610928', '旬阳县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('610929', '白河县', '3', '610900');
INSERT INTO `thinkox_district` VALUES ('611001', '市辖区', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611002', '商州区', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611021', '洛南县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611022', '丹凤县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611023', '商南县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611024', '山阳县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611025', '镇安县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('611026', '柞水县', '3', '611000');
INSERT INTO `thinkox_district` VALUES ('620101', '市辖区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620102', '城关区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620103', '七里河区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620104', '西固区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620105', '安宁区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620111', '红古区', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620121', '永登县', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620122', '皋兰县', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620123', '榆中县', '3', '620100');
INSERT INTO `thinkox_district` VALUES ('620201', '市辖区', '3', '620200');
INSERT INTO `thinkox_district` VALUES ('620301', '市辖区', '3', '620300');
INSERT INTO `thinkox_district` VALUES ('620302', '金川区', '3', '620300');
INSERT INTO `thinkox_district` VALUES ('620321', '永昌县', '3', '620300');
INSERT INTO `thinkox_district` VALUES ('620401', '市辖区', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620402', '白银区', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620403', '平川区', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620421', '靖远县', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620422', '会宁县', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620423', '景泰县', '3', '620400');
INSERT INTO `thinkox_district` VALUES ('620501', '市辖区', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620502', '秦城区', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620503', '北道区', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620521', '清水县', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620522', '秦安县', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620523', '甘谷县', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620524', '武山县', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620525', '张家川回族自治县', '3', '620500');
INSERT INTO `thinkox_district` VALUES ('620601', '市辖区', '3', '620600');
INSERT INTO `thinkox_district` VALUES ('620602', '凉州区', '3', '620600');
INSERT INTO `thinkox_district` VALUES ('620621', '民勤县', '3', '620600');
INSERT INTO `thinkox_district` VALUES ('620622', '古浪县', '3', '620600');
INSERT INTO `thinkox_district` VALUES ('620623', '天祝藏族自治县', '3', '620600');
INSERT INTO `thinkox_district` VALUES ('620701', '市辖区', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620702', '甘州区', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620721', '肃南裕固族自治县', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620722', '民乐县', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620723', '临泽县', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620724', '高台县', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620725', '山丹县', '3', '620700');
INSERT INTO `thinkox_district` VALUES ('620801', '市辖区', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620802', '崆峒区', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620821', '泾川县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620822', '灵台县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620823', '崇信县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620824', '华亭县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620825', '庄浪县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620826', '静宁县', '3', '620800');
INSERT INTO `thinkox_district` VALUES ('620901', '市辖区', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620902', '肃州区', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620921', '金塔县', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620922', '安西县', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620923', '肃北蒙古族自治县', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620924', '阿克塞哈萨克族自治县', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620981', '玉门市', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('620982', '敦煌市', '3', '620900');
INSERT INTO `thinkox_district` VALUES ('621001', '市辖区', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621002', '西峰区', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621021', '庆城县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621022', '环　县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621023', '华池县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621024', '合水县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621025', '正宁县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621026', '宁　县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621027', '镇原县', '3', '621000');
INSERT INTO `thinkox_district` VALUES ('621101', '市辖区', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621102', '安定区', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621121', '通渭县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621122', '陇西县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621123', '渭源县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621124', '临洮县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621125', '漳　县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621126', '岷　县', '3', '621100');
INSERT INTO `thinkox_district` VALUES ('621201', '市辖区', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621202', '武都区', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621221', '成　县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621222', '文　县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621223', '宕昌县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621224', '康　县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621225', '西和县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621226', '礼　县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621227', '徽　县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('621228', '两当县', '3', '621200');
INSERT INTO `thinkox_district` VALUES ('622901', '临夏市', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622921', '临夏县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622922', '康乐县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622923', '永靖县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622924', '广河县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622925', '和政县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622926', '东乡族自治县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('622927', '积石山保安族东乡族撒拉族自治县', '3', '622900');
INSERT INTO `thinkox_district` VALUES ('623001', '合作市', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623021', '临潭县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623022', '卓尼县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623023', '舟曲县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623024', '迭部县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623025', '玛曲县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623026', '碌曲县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('623027', '夏河县', '3', '623000');
INSERT INTO `thinkox_district` VALUES ('630101', '市辖区', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630102', '城东区', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630103', '城中区', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630104', '城西区', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630105', '城北区', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630121', '大通回族土族自治县', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630122', '湟中县', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('630123', '湟源县', '3', '630100');
INSERT INTO `thinkox_district` VALUES ('632121', '平安县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632122', '民和回族土族自治县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632123', '乐都县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632126', '互助土族自治县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632127', '化隆回族自治县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632128', '循化撒拉族自治县', '3', '632100');
INSERT INTO `thinkox_district` VALUES ('632221', '门源回族自治县', '3', '632200');
INSERT INTO `thinkox_district` VALUES ('632222', '祁连县', '3', '632200');
INSERT INTO `thinkox_district` VALUES ('632223', '海晏县', '3', '632200');
INSERT INTO `thinkox_district` VALUES ('632224', '刚察县', '3', '632200');
INSERT INTO `thinkox_district` VALUES ('632321', '同仁县', '3', '632300');
INSERT INTO `thinkox_district` VALUES ('632322', '尖扎县', '3', '632300');
INSERT INTO `thinkox_district` VALUES ('632323', '泽库县', '3', '632300');
INSERT INTO `thinkox_district` VALUES ('632324', '河南蒙古族自治县', '3', '632300');
INSERT INTO `thinkox_district` VALUES ('632521', '共和县', '3', '632500');
INSERT INTO `thinkox_district` VALUES ('632522', '同德县', '3', '632500');
INSERT INTO `thinkox_district` VALUES ('632523', '贵德县', '3', '632500');
INSERT INTO `thinkox_district` VALUES ('632524', '兴海县', '3', '632500');
INSERT INTO `thinkox_district` VALUES ('632525', '贵南县', '3', '632500');
INSERT INTO `thinkox_district` VALUES ('632621', '玛沁县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632622', '班玛县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632623', '甘德县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632624', '达日县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632625', '久治县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632626', '玛多县', '3', '632600');
INSERT INTO `thinkox_district` VALUES ('632721', '玉树县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632722', '杂多县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632723', '称多县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632724', '治多县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632725', '囊谦县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632726', '曲麻莱县', '3', '632700');
INSERT INTO `thinkox_district` VALUES ('632801', '格尔木市', '3', '632800');
INSERT INTO `thinkox_district` VALUES ('632802', '德令哈市', '3', '632800');
INSERT INTO `thinkox_district` VALUES ('632821', '乌兰县', '3', '632800');
INSERT INTO `thinkox_district` VALUES ('632822', '都兰县', '3', '632800');
INSERT INTO `thinkox_district` VALUES ('632823', '天峻县', '3', '632800');
INSERT INTO `thinkox_district` VALUES ('640101', '市辖区', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640104', '兴庆区', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640105', '西夏区', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640106', '金凤区', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640121', '永宁县', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640122', '贺兰县', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640181', '灵武市', '3', '640100');
INSERT INTO `thinkox_district` VALUES ('640201', '市辖区', '3', '640200');
INSERT INTO `thinkox_district` VALUES ('640202', '大武口区', '3', '640200');
INSERT INTO `thinkox_district` VALUES ('640205', '惠农区', '3', '640200');
INSERT INTO `thinkox_district` VALUES ('640221', '平罗县', '3', '640200');
INSERT INTO `thinkox_district` VALUES ('640301', '市辖区', '3', '640300');
INSERT INTO `thinkox_district` VALUES ('640302', '利通区', '3', '640300');
INSERT INTO `thinkox_district` VALUES ('640323', '盐池县', '3', '640300');
INSERT INTO `thinkox_district` VALUES ('640324', '同心县', '3', '640300');
INSERT INTO `thinkox_district` VALUES ('640381', '青铜峡市', '3', '640300');
INSERT INTO `thinkox_district` VALUES ('640401', '市辖区', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640402', '原州区', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640422', '西吉县', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640423', '隆德县', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640424', '泾源县', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640425', '彭阳县', '3', '640400');
INSERT INTO `thinkox_district` VALUES ('640501', '市辖区', '3', '640500');
INSERT INTO `thinkox_district` VALUES ('640502', '沙坡头区', '3', '640500');
INSERT INTO `thinkox_district` VALUES ('640521', '中宁县', '3', '640500');
INSERT INTO `thinkox_district` VALUES ('640522', '海原县', '3', '640500');
INSERT INTO `thinkox_district` VALUES ('650101', '市辖区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650102', '天山区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650103', '沙依巴克区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650104', '新市区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650105', '水磨沟区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650106', '头屯河区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650107', '达坂城区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650108', '东山区', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650121', '乌鲁木齐县', '3', '650100');
INSERT INTO `thinkox_district` VALUES ('650201', '市辖区', '3', '650200');
INSERT INTO `thinkox_district` VALUES ('650202', '独山子区', '3', '650200');
INSERT INTO `thinkox_district` VALUES ('650203', '克拉玛依区', '3', '650200');
INSERT INTO `thinkox_district` VALUES ('650204', '白碱滩区', '3', '650200');
INSERT INTO `thinkox_district` VALUES ('650205', '乌尔禾区', '3', '650200');
INSERT INTO `thinkox_district` VALUES ('652101', '吐鲁番市', '3', '652100');
INSERT INTO `thinkox_district` VALUES ('652122', '鄯善县', '3', '652100');
INSERT INTO `thinkox_district` VALUES ('652123', '托克逊县', '3', '652100');
INSERT INTO `thinkox_district` VALUES ('652201', '哈密市', '3', '652200');
INSERT INTO `thinkox_district` VALUES ('652222', '巴里坤哈萨克自治县', '3', '652200');
INSERT INTO `thinkox_district` VALUES ('652223', '伊吾县', '3', '652200');
INSERT INTO `thinkox_district` VALUES ('652301', '昌吉市', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652302', '阜康市', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652303', '米泉市', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652323', '呼图壁县', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652324', '玛纳斯县', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652325', '奇台县', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652327', '吉木萨尔县', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652328', '木垒哈萨克自治县', '3', '652300');
INSERT INTO `thinkox_district` VALUES ('652701', '博乐市', '3', '652700');
INSERT INTO `thinkox_district` VALUES ('652722', '精河县', '3', '652700');
INSERT INTO `thinkox_district` VALUES ('652723', '温泉县', '3', '652700');
INSERT INTO `thinkox_district` VALUES ('652801', '库尔勒市', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652822', '轮台县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652823', '尉犁县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652824', '若羌县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652825', '且末县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652826', '焉耆回族自治县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652827', '和静县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652828', '和硕县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652829', '博湖县', '3', '652800');
INSERT INTO `thinkox_district` VALUES ('652901', '阿克苏市', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652922', '温宿县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652923', '库车县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652924', '沙雅县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652925', '新和县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652926', '拜城县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652927', '乌什县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652928', '阿瓦提县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('652929', '柯坪县', '3', '652900');
INSERT INTO `thinkox_district` VALUES ('653001', '阿图什市', '3', '653000');
INSERT INTO `thinkox_district` VALUES ('653022', '阿克陶县', '3', '653000');
INSERT INTO `thinkox_district` VALUES ('653023', '阿合奇县', '3', '653000');
INSERT INTO `thinkox_district` VALUES ('653024', '乌恰县', '3', '653000');
INSERT INTO `thinkox_district` VALUES ('653101', '喀什市', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653121', '疏附县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653122', '疏勒县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653123', '英吉沙县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653124', '泽普县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653125', '莎车县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653126', '叶城县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653127', '麦盖提县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653128', '岳普湖县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653129', '伽师县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653130', '巴楚县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653131', '塔什库尔干塔吉克自治县', '3', '653100');
INSERT INTO `thinkox_district` VALUES ('653201', '和田市', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653221', '和田县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653222', '墨玉县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653223', '皮山县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653224', '洛浦县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653225', '策勒县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653226', '于田县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('653227', '民丰县', '3', '653200');
INSERT INTO `thinkox_district` VALUES ('654002', '伊宁市', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654003', '奎屯市', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654021', '伊宁县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654022', '察布查尔锡伯自治县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654023', '霍城县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654024', '巩留县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654025', '新源县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654026', '昭苏县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654027', '特克斯县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654028', '尼勒克县', '3', '654000');
INSERT INTO `thinkox_district` VALUES ('654201', '塔城市', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654202', '乌苏市', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654221', '额敏县', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654223', '沙湾县', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654224', '托里县', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654225', '裕民县', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654226', '和布克赛尔蒙古自治县', '3', '654200');
INSERT INTO `thinkox_district` VALUES ('654301', '阿勒泰市', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654321', '布尔津县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654322', '富蕴县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654323', '福海县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654324', '哈巴河县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654325', '青河县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('654326', '吉木乃县', '3', '654300');
INSERT INTO `thinkox_district` VALUES ('659001', '石河子市', '3', '659000');
INSERT INTO `thinkox_district` VALUES ('659002', '阿拉尔市', '3', '659000');
INSERT INTO `thinkox_district` VALUES ('659003', '图木舒克市', '3', '659000');
INSERT INTO `thinkox_district` VALUES ('659004', '五家渠市', '3', '659000');
INSERT INTO `thinkox_district` VALUES ('810001', '香港', '2', '810000');
INSERT INTO `thinkox_district` VALUES ('810002', '中西区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810003', '九龙城区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810004', '南区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810005', '黄大仙区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810006', '油尖旺区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810007', '葵青区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810008', '西贡区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810009', '屯门区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810010', '荃湾区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810011', '东区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810012', '观塘区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810013', '深水步区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810014', '湾仔区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810015', '离岛区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810016', '北区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810017', '沙田区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810018', '大埔区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('810019', '元朗区', '3', '810001');
INSERT INTO `thinkox_district` VALUES ('820001', '澳门', '2', '820000');
INSERT INTO `thinkox_district` VALUES ('820002', '澳门', '3', '820001');
INSERT INTO `thinkox_district` VALUES ('710001', '台北市', '2', '710000');
INSERT INTO `thinkox_district` VALUES ('710002', '台北县', '3', '710001');
INSERT INTO `thinkox_district` VALUES ('710003', '基隆市', '2', '710000');
INSERT INTO `thinkox_district` VALUES ('910005', '中山市', '3', '442000');
INSERT INTO `thinkox_district` VALUES ('710004', '花莲县', '3', '710003');
INSERT INTO `thinkox_district` VALUES ('910006', '东莞市', '3', '441900');

-- ----------------------------
-- Table structure for thinkox_document
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_document`;
CREATE TABLE `thinkox_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of thinkox_document
-- ----------------------------
INSERT INTO `thinkox_document` VALUES ('15', '1', '', '3324235324', '40', '', '0', '0', '2', '2', '7', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1470195000', '1470195274', '1');

-- ----------------------------
-- Table structure for thinkox_document_article
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_document_article`;
CREATE TABLE `thinkox_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  `zx` int(10) unsigned NOT NULL COMMENT '附近',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of thinkox_document_article
-- ----------------------------
INSERT INTO `thinkox_document_article` VALUES ('15', '0', '32432432432dsfdsafasfdsafasfadsafafasfdasfasf', '', '0', '0');

-- ----------------------------
-- Table structure for thinkox_document_download
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_document_download`;
CREATE TABLE `thinkox_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of thinkox_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_event
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event`;
CREATE TABLE `thinkox_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发起人',
  `title` varchar(255) NOT NULL COMMENT '活动名称',
  `explain` text NOT NULL COMMENT '详细内容',
  `sTime` int(11) NOT NULL COMMENT '活动开始时间',
  `eTime` int(11) NOT NULL COMMENT '活动结束时间',
  `address` varchar(255) NOT NULL COMMENT '活动地点',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `limitCount` int(11) NOT NULL COMMENT '限制人数',
  `cover_id` int(11) NOT NULL COMMENT '封面ID',
  `attentionCount` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `event_type` varchar(20) NOT NULL COMMENT '类别',
  `signCount` int(11) NOT NULL,
  `is_recommend` tinyint(4) NOT NULL COMMENT '是否推荐',
  `people` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event
-- ----------------------------
INSERT INTO `thinkox_event` VALUES ('43', '1', '区政协活动', '181', '1473609600', '1473696000', '181', '1473670519', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '98');
INSERT INTO `thinkox_event` VALUES ('44', '1', '大会通知', '开会', '1473609600', '1473696000', '181', '1473677177', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '59');
INSERT INTO `thinkox_event` VALUES ('45', '1', '333', '66666', '1473609600', '1473696000', '666666', '1473686775', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '59,71,98,60,61,97');
INSERT INTO `thinkox_event` VALUES ('46', '1', '1', '66', '1473696000', '1473782400', '222', '1473737443', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '59');
INSERT INTO `thinkox_event` VALUES ('40', '1', '网源第一次员工大会', '本地活动主题：促进员工交流，为庄虎寻找一个女朋友！！所以，要求每个收到通知的员工，必须参加！！！', '1473512400', '1473762600', '181创业园6栋C号门309室', '1473670443', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '98');
INSERT INTO `thinkox_event` VALUES ('47', '1', '11', '3333', '1473696000', '1473782400', '333', '1473754782', '0', '0', '0', '0', '0', '0', '0', '区政协组织', '0', '0', '59,71,98,60,61,97');

-- ----------------------------
-- Table structure for thinkox_event_attend
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event_attend`;
CREATE TABLE `thinkox_event_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0为报名，1为参加',
  `whytext` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event_attend
-- ----------------------------
INSERT INTO `thinkox_event_attend` VALUES ('16', '58', '24', '委员11', '18108613153', '1473432161', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('15', '1', '21', '郝智理', '15871430887', '1473416626', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('17', '59', '35', '委员1', '13886199168', '1473437777', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('18', '59', '38', '委员1', '13886199168', '1473509846', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('19', '59', '40', '委员1', '13886199168', '1473517420', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('20', '59', '41', '委员1', '13886199168', '1473517593', '2', '有事，来不了');
INSERT INTO `thinkox_event_attend` VALUES ('21', '59', '42', '委员1', '13886199168', '1473519755', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('22', '59', '42', '委员1', '13886199168', '1473519763', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('23', '59', '44', '委员1', '13886199168', '1473677274', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('24', '59', '45', '委员1', '13886199168', '1473687085', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('25', '59', '46', '委员1', '13886199168', '1473737467', '1', null);
INSERT INTO `thinkox_event_attend` VALUES ('26', '59', '47', '委员1', '13886199168', '1473754830', '1', null);

-- ----------------------------
-- Table structure for thinkox_event_marknum
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event_marknum`;
CREATE TABLE `thinkox_event_marknum` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `truename` varchar(20) DEFAULT NULL,
  `event_id` int(10) NOT NULL,
  `mark_sort` tinyint(2) NOT NULL,
  `mark_time` int(11) NOT NULL,
  `mark_attr` varchar(20) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `company` varchar(30) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event_marknum
-- ----------------------------
INSERT INTO `thinkox_event_marknum` VALUES ('1', '1', '郝智理', '24', '2', '1473432461', '正常签到', null, null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('7', '1', '郝智理', '24', '1', '1473432461', '迟到了', null, null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('2', '1', '郝智理', '24', '3', '1473432461', '正常签到', null, null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('15', '59', '委员1', '31', '0', '0', '', '0', '总工会', '2147483647');
INSERT INTO `thinkox_event_marknum` VALUES ('16', '71', '委员1', '31', '1', '0', '', '0', '火凤凰', '2147483647');
INSERT INTO `thinkox_event_marknum` VALUES ('17', '60', '委员2', '31', '1', '0', '', '0', '发展科技有限公司', '2147483647');
INSERT INTO `thinkox_event_marknum` VALUES ('18', '61', '委员3', '31', '1', '0', '', '0', '科贸公司', '2147483647');
INSERT INTO `thinkox_event_marknum` VALUES ('19', '58', '委员11', '31', '1', '0', '', '0', '火凤凰', '2147483647');
INSERT INTO `thinkox_event_marknum` VALUES ('20', '59', '委员1', '34', '1', '0', '', '3', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('21', '71', '委员1', '34', '1', '0', '', '1', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('22', '60', '委员2', '34', '1', '0', '', '2', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('23', '61', '委员3', '34', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('24', '58', '委员11', '34', '1', '0', '', '4', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('31', '59', '委员1', '1', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('25', '59', '委员1', '35', '1', '0', '', '3', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('26', '71', '委员1', '35', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('27', '60', '委员2', '35', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('28', '61', '委员3', '35', '3', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('29', '58', '委员11', '35', '2', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('32', '71', '委员1', '1', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('33', '60', '委员2', '1', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('34', '61', '委员3', '1', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('35', '58', '委员11', '1', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('36', '59', '委员1', '36', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('37', '71', '委员1', '36', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('38', '60', '委员2', '36', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('39', '61', '委员3', '36', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('40', '58', '委员11', '36', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('41', '59', '委员1', '1', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('42', '71', '委员1', '1', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('43', '60', '委员2', '1', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('44', '61', '委员3', '1', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('45', '58', '委员11', '1', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('46', '59', '委员1', '37', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('47', '71', '委员1', '37', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('48', '60', '委员2', '37', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('49', '61', '委员3', '37', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('50', '59', '委员1', '36', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('51', '71', '委员1', '36', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('52', '60', '委员2', '36', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('53', '61', '委员3', '36', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('54', '58', '委员11', '36', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('55', '59', '委员1', '38', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('56', '71', '委员1', '38', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('57', '60', '委员2', '38', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('58', '61', '委员3', '38', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('59', '59', '委员1', '39', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('60', '71', '委员1', '39', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('61', '60', '委员2', '39', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('62', '61', '委员3', '39', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('81', '59', '委员1', '39', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('73', '1', '郝智理', '39', '1', '1473484712', '0', '1', '科贸公司', null);
INSERT INTO `thinkox_event_marknum` VALUES ('80', '1', '郝智理', '39', '2', '1473504545', '', '1', '国务院', '15871430887');
INSERT INTO `thinkox_event_marknum` VALUES ('82', '71', '委员1', '39', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('83', '60', '委员2', '39', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('84', '61', '委员3', '39', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('85', '96', null, '39', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('86', '79', null, '39', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('87', '81', null, '39', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('88', '86', null, '39', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('89', '95', null, '39', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('90', '59', '委员1', '40', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('91', '71', '委员1', '40', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('92', '60', '委员2', '40', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('93', '61', '委员3', '40', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('94', '96', null, '40', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('95', '79', null, '40', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('96', '81', null, '40', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('97', '86', null, '40', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('98', '95', null, '40', '1', '0', '', '0', null, null);
INSERT INTO `thinkox_event_marknum` VALUES ('99', '59', '委员1', '41', '1', '1473517664', '', '1', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('100', '71', '委员1', '41', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('101', '60', '委员2', '41', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('102', '61', '委员3', '41', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('103', '59', '委员1', '42', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('104', '71', '委员1', '42', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('105', '60', '委员2', '42', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('106', '61', '委员3', '42', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('107', '59', '委员1', '42', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('108', '71', '委员1', '42', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('109', '60', '委员2', '42', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('110', '61', '委员3', '42', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('111', '59', '委员1', '42', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('112', '71', '委员1', '42', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('113', '60', '委员2', '42', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('114', '61', '委员3', '42', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('115', '59', '委员1', '41', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('116', '71', '委员1', '41', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('117', '60', '委员2', '41', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('118', '61', '委员3', '41', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('119', '98', '陈三', '40', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_event_marknum` VALUES ('120', '98', '陈三', '43', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_event_marknum` VALUES ('121', '59', '委员1', '44', '1', '1473678856', '', '1', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('122', '59', '委员1', '45', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('123', '71', '委员dd', '45', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('124', '98', '陈三', '45', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_event_marknum` VALUES ('125', '60', '委员2', '45', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('126', '61', '委员3', '45', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('127', '97', '严三', '45', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_event_marknum` VALUES ('128', '59', '委员1', '46', '1', '1473737560', '', '1', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('129', '1', '郝智理', '46', '1', '1473753760', '', '1', '国务院', '15871430887');
INSERT INTO `thinkox_event_marknum` VALUES ('130', '59', '委员1', '47', '1', '1473754879', '', '1', '总工会', '13886199168');
INSERT INTO `thinkox_event_marknum` VALUES ('131', '71', '委员dd', '47', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('132', '98', '陈三', '47', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_event_marknum` VALUES ('133', '60', '委员2', '47', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_event_marknum` VALUES ('134', '61', '委员3', '47', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_event_marknum` VALUES ('135', '97', '严三', '47', '1', '0', '', '0', '总工会', '18696492998');

-- ----------------------------
-- Table structure for thinkox_event_markset
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event_markset`;
CREATE TABLE `thinkox_event_markset` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `event_id` int(10) NOT NULL,
  `mark_sort` tinyint(2) NOT NULL,
  `mark_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event_markset
-- ----------------------------
INSERT INTO `thinkox_event_markset` VALUES ('1', '12', '1', '2016');
INSERT INTO `thinkox_event_markset` VALUES ('2', '12', '2', '2016');
INSERT INTO `thinkox_event_markset` VALUES ('3', '12', '3', '2016');
INSERT INTO `thinkox_event_markset` VALUES ('4', '20', '1', '1473300000');
INSERT INTO `thinkox_event_markset` VALUES ('5', '20', '2', '1473696000');
INSERT INTO `thinkox_event_markset` VALUES ('6', '21', '1', '1472659200');
INSERT INTO `thinkox_event_markset` VALUES ('7', '21', '2', '1473868800');
INSERT INTO `thinkox_event_markset` VALUES ('8', '21', '3', '1475078400');
INSERT INTO `thinkox_event_markset` VALUES ('9', '22', '1', '1472745600');
INSERT INTO `thinkox_event_markset` VALUES ('10', '22', '2', '1473868800');
INSERT INTO `thinkox_event_markset` VALUES ('11', '23', '1', '1472745600');
INSERT INTO `thinkox_event_markset` VALUES ('12', '23', '2', '1474646400');
INSERT INTO `thinkox_event_markset` VALUES ('13', '24', '1', '1472745600');
INSERT INTO `thinkox_event_markset` VALUES ('14', '24', '2', '1473436800');
INSERT INTO `thinkox_event_markset` VALUES ('15', '24', '3', '1473782400');
INSERT INTO `thinkox_event_markset` VALUES ('16', '25', '1', '1472832000');
INSERT INTO `thinkox_event_markset` VALUES ('17', '1', '1', '1472832000');
INSERT INTO `thinkox_event_markset` VALUES ('18', '1', '1', '1473868800');
INSERT INTO `thinkox_event_markset` VALUES ('19', '1', '2', '1474819200');
INSERT INTO `thinkox_event_markset` VALUES ('20', '36', '1', '1472745600');
INSERT INTO `thinkox_event_markset` VALUES ('21', '36', '2', '1472832000');
INSERT INTO `thinkox_event_markset` VALUES ('22', '36', '3', '1473004800');
INSERT INTO `thinkox_event_markset` VALUES ('23', '36', '4', '1473782400');
INSERT INTO `thinkox_event_markset` VALUES ('24', '36', '5', '1474473600');
INSERT INTO `thinkox_event_markset` VALUES ('25', '38', '1', '1473782400');
INSERT INTO `thinkox_event_markset` VALUES ('26', '39', '1', '1473311912');
INSERT INTO `thinkox_event_markset` VALUES ('27', '39', '2', '1474473600');
INSERT INTO `thinkox_event_markset` VALUES ('28', '40', '1', '1473339600');
INSERT INTO `thinkox_event_markset` VALUES ('29', '41', '1', '1473523200');
INSERT INTO `thinkox_event_markset` VALUES ('30', '42', '1', '1473523200');
INSERT INTO `thinkox_event_markset` VALUES ('31', '43', '1', '1473609600');
INSERT INTO `thinkox_event_markset` VALUES ('32', '44', '1', '1473609600');
INSERT INTO `thinkox_event_markset` VALUES ('33', '45', '1', '1473609600');
INSERT INTO `thinkox_event_markset` VALUES ('34', '46', '1', '1473696000');
INSERT INTO `thinkox_event_markset` VALUES ('35', '47', '1', '1473696000');

-- ----------------------------
-- Table structure for thinkox_event_markuser
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event_markuser`;
CREATE TABLE `thinkox_event_markuser` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `event_id` int(10) NOT NULL,
  `marknum` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event_markuser
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_event_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_event_type`;
CREATE TABLE `thinkox_event_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_event_type
-- ----------------------------
INSERT INTO `thinkox_event_type` VALUES ('1', '区政协组织', '1403859500', '1469694478', '1', '0', '0', '0');
INSERT INTO `thinkox_event_type` VALUES ('2', '专委会组织', '1403859511', '1469694483', '1', '0', '0', '0');
INSERT INTO `thinkox_event_type` VALUES ('3', '慈善1', '1469600544', '1471661230', '-1', '0', '1', '0');
INSERT INTO `thinkox_event_type` VALUES ('4', '慈善2', '1469600556', '1471661236', '-1', '0', '1', '0');
INSERT INTO `thinkox_event_type` VALUES ('5', '其他活动', '1469694493', '1469694486', '1', '0', '0', '0');
INSERT INTO `thinkox_event_type` VALUES ('6', '街乡组织', '1469694501', '1470819782', '1', '0', '0', '0');
INSERT INTO `thinkox_event_type` VALUES ('7', '活动的', '1469695081', '1471661242', '-1', '0', '0', '0');
INSERT INTO `thinkox_event_type` VALUES ('8', 'aaaa', '1473477581', '1473477588', '-1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_field
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_field`;
CREATE TABLE `thinkox_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `field_data` varchar(1000) NOT NULL,
  `createTime` int(11) NOT NULL,
  `changeTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=495 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_field
-- ----------------------------
INSERT INTO `thinkox_field` VALUES ('46', '58', '36', '12345', '1469598856', '1473219660');
INSERT INTO `thinkox_field` VALUES ('47', '58', '37', '12', '1469598856', '1473219660');
INSERT INTO `thinkox_field` VALUES ('48', '58', '38', '委员11', '1469598856', '1473219660');
INSERT INTO `thinkox_field` VALUES ('49', '58', '39', '11', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('50', '58', '40', '男', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('51', '58', '41', '1471968000', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('52', '58', '42', '汉族', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('53', '58', '43', '湖北', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('54', '58', '44', '3', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('55', '58', '45', '中国共产党', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('56', '58', '46', '高中', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('57', '58', '47', '5', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('58', '58', '48', '2', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('59', '58', '49', '5', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('60', '58', '50', '火凤凰', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('61', '58', '51', '2', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('62', '58', '52', '江旺路6号', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('63', '58', '53', '6', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('64', '58', '54', '1471968000', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('65', '58', '55', '1471968000', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('66', '58', '56', '', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('67', '58', '57', '前进街联络委员会', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('68', '58', '58', '', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('69', '58', '59', '是', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('70', '58', '60', '是', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('71', '58', '61', '', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('72', '58', '62', '13407134819', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('73', '58', '63', '22', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('74', '58', '64', '333', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('75', '58', '65', '', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('76', '58', '66', '1', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('77', '58', '67', '4', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('78', '58', '68', '', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('79', '58', '69', '2', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('80', '58', '70', '3', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('81', '58', '71', '5', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('82', '58', '72', '正常', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('83', '58', '73', '1', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('84', '58', '74', '已婚', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('85', '58', '75', '无', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('86', '58', '76', '1471968000', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('87', '58', '77', '1471968000', '1469769657', '1473219660');
INSERT INTO `thinkox_field` VALUES ('104', '59', '79', '阿里巴巴323233333333', '1471584155', '1471584245');
INSERT INTO `thinkox_field` VALUES ('105', '59', '81', '马云222233333333333333', '1471584155', '1471584245');
INSERT INTO `thinkox_field` VALUES ('106', '59', '82', '马云1123456333333333333333333', '1471584155', '1471584245');
INSERT INTO `thinkox_field` VALUES ('107', '59', '83', '18888888888443333333333333333', '1471584155', '1471584245');
INSERT INTO `thinkox_field` VALUES ('112', '60', '79', '中国', '1471590286', '1471590286');
INSERT INTO `thinkox_field` VALUES ('113', '60', '81', '习老大', '1471590286', '1471590286');
INSERT INTO `thinkox_field` VALUES ('114', '60', '82', '齐老大', '1471590286', '1471590286');
INSERT INTO `thinkox_field` VALUES ('115', '60', '83', '16666666666', '1471590286', '1471590286');
INSERT INTO `thinkox_field` VALUES ('116', '61', '79', '美国', '1471590308', '1471590308');
INSERT INTO `thinkox_field` VALUES ('117', '61', '81', '普老大', '1471590308', '1471590308');
INSERT INTO `thinkox_field` VALUES ('118', '61', '82', '奥老大', '1471590308', '1471590308');
INSERT INTO `thinkox_field` VALUES ('119', '61', '83', '55555555', '1471590308', '1471590308');
INSERT INTO `thinkox_field` VALUES ('120', '62', '79', '啊哈啊', '1471590334', '1471590334');
INSERT INTO `thinkox_field` VALUES ('121', '62', '81', '呀呀', '1471590334', '1471590334');
INSERT INTO `thinkox_field` VALUES ('122', '62', '82', '哈哈', '1471590334', '1471590334');
INSERT INTO `thinkox_field` VALUES ('123', '62', '83', '66666666', '1471590334', '1471590334');
INSERT INTO `thinkox_field` VALUES ('124', '71', '36', '12345', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('125', '71', '37', '12', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('126', '71', '38', '委员dd', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('127', '71', '39', '11', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('128', '71', '40', '男', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('129', '71', '41', '1471968000', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('130', '71', '42', '汉族', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('131', '71', '43', '湖北', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('132', '71', '44', '3', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('133', '71', '45', '中国共产党', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('134', '71', '46', '高中', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('135', '71', '47', '5', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('136', '71', '48', '2', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('137', '71', '49', '5', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('138', '71', '50', '火凤凰', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('139', '71', '51', '2', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('140', '71', '52', '江旺路6号', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('141', '71', '53', '6', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('142', '71', '54', '1471968000', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('143', '71', '55', '1471968000', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('144', '71', '56', '提案委', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('145', '71', '57', '民族街联络委员会', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('146', '71', '58', '', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('147', '71', '59', '是', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('148', '71', '60', '是', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('149', '71', '61', '', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('150', '71', '62', '13407134819', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('151', '71', '63', '22', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('152', '71', '64', '333', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('153', '71', '66', '1', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('154', '71', '67', '4', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('155', '71', '69', '2', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('156', '71', '70', '3', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('157', '71', '71', '5', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('158', '71', '72', '正常', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('159', '71', '73', '1', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('160', '71', '74', '已婚', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('161', '71', '75', '无', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('162', '71', '76', '1471968000', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('163', '71', '77', '1471968000', '1472021179', '1473165654');
INSERT INTO `thinkox_field` VALUES ('164', '64', '36', '1', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('165', '64', '37', '1', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('166', '64', '38', '委员2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('167', '64', '39', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('168', '64', '40', '男', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('169', '64', '41', '1471968000', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('170', '64', '42', '汉族', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('171', '64', '43', '湖北', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('172', '64', '44', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('173', '64', '45', '中国共产党', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('174', '64', '46', '高中', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('175', '64', '47', '5', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('176', '64', '48', '45', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('177', '64', '49', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('178', '64', '50', '2333333', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('179', '64', '51', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('180', '64', '52', '1', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('181', '64', '53', '123456', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('182', '64', '54', '1471968000', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('183', '64', '55', '1471968000', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('184', '64', '56', '经科委', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('185', '64', '57', '民权街联络委员会', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('186', '64', '58', '', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('187', '64', '59', '否', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('188', '64', '60', '是', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('189', '64', '61', '', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('190', '64', '62', '13407134811', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('191', '64', '63', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('192', '64', '64', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('193', '64', '66', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('194', '64', '67', '55', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('195', '64', '69', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('196', '64', '70', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('197', '64', '71', '2', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('198', '64', '72', '正常', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('199', '64', '73', '3', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('200', '64', '74', '已婚', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('201', '64', '75', '3', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('202', '64', '76', '1471968000', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('203', '64', '77', '1471968000', '1472025665', '1473212080');
INSERT INTO `thinkox_field` VALUES ('204', '65', '36', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('205', '65', '37', '2', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('206', '65', '38', '委员3', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('207', '65', '39', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('208', '65', '40', '男', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('209', '65', '41', '1471968000', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('210', '65', '42', '汉族', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('211', '65', '43', '湖北', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('212', '65', '44', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('213', '65', '45', '中国共产党', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('214', '65', '46', '高中', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('215', '65', '47', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('216', '65', '48', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('217', '65', '49', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('218', '65', '50', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('219', '65', '51', '4', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('220', '65', '52', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('221', '65', '53', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('222', '65', '54', '1471968000', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('223', '65', '55', '1471968000', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('224', '65', '56', '社法委', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('225', '65', '57', '汉兴街联络委员会', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('226', '65', '58', '', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('227', '65', '59', '是', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('228', '65', '60', '是', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('229', '65', '61', '', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('230', '65', '62', '13407134829', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('231', '65', '63', '3', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('232', '65', '64', '3', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('233', '65', '66', '3', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('234', '65', '67', '1', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('235', '65', '69', '4', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('236', '65', '70', '5', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('237', '65', '71', '6', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('238', '65', '72', '正常', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('239', '65', '73', '6', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('240', '65', '74', '已婚', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('241', '65', '75', '3', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('242', '65', '76', '1471968000', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('243', '65', '77', '1471968000', '1472025840', '1473165685');
INSERT INTO `thinkox_field` VALUES ('244', '68', '79', '税务局', '1472033457', '1472033457');
INSERT INTO `thinkox_field` VALUES ('245', '68', '81', '1', '1472033457', '1472033457');
INSERT INTO `thinkox_field` VALUES ('246', '68', '82', '2', '1472033457', '1472033457');
INSERT INTO `thinkox_field` VALUES ('247', '68', '83', '3', '1472033457', '1472033457');
INSERT INTO `thinkox_field` VALUES ('248', '69', '79', '公安局', '1472033481', '1472033481');
INSERT INTO `thinkox_field` VALUES ('249', '69', '81', '1', '1472033481', '1472033481');
INSERT INTO `thinkox_field` VALUES ('250', '69', '82', '2', '1472033481', '1472033481');
INSERT INTO `thinkox_field` VALUES ('251', '69', '83', '3', '1472033481', '1472033481');
INSERT INTO `thinkox_field` VALUES ('252', '70', '79', '水务局', '1472033521', '1472033521');
INSERT INTO `thinkox_field` VALUES ('253', '70', '81', '22', '1472033521', '1472033521');
INSERT INTO `thinkox_field` VALUES ('254', '70', '82', '33', '1472033521', '1472033521');
INSERT INTO `thinkox_field` VALUES ('255', '70', '83', '55', '1472033521', '1472033521');
INSERT INTO `thinkox_field` VALUES ('256', '80', '36', '4444444444444444444', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('257', '80', '37', '559685466', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('258', '80', '38', '老大', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('259', '80', '39', '333333333333333', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('260', '80', '40', '男', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('261', '80', '41', '1473091200', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('262', '80', '42', '汉族', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('263', '80', '43', '湖北', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('264', '80', '44', '3333333333333333333', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('265', '80', '45', '中国共产党', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('266', '80', '46', '高中', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('267', '80', '47', '2132131231231231321312', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('268', '80', '48', '321321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('269', '80', '49', '31321321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('270', '80', '50', '22222222222222222', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('271', '80', '51', '2323232', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('272', '80', '52', '321321321321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('273', '80', '53', '3232131232132', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('274', '80', '54', '1473091200', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('275', '80', '55', '1473091200', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('276', '80', '56', '社法委', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('277', '80', '57', '前进街联络委员会', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('278', '80', '58', '中国民主建国会', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('279', '80', '59', '是', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('280', '80', '60', '是', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('281', '80', '61', '是', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('282', '80', '62', '13333333333', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('283', '80', '63', '13333333', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('284', '80', '64', '32323', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('285', '80', '66', '2323232', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('286', '80', '67', '321321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('287', '80', '69', '321321313', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('288', '80', '70', '1312321321321321321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('289', '80', '71', '32131211111111111111111111111111111', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('290', '80', '72', '正常', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('291', '80', '73', '321321312321', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('292', '80', '74', '已婚', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('293', '80', '75', '佛教', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('294', '80', '76', '1473091200', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('295', '80', '77', '1473091200', '1473164699', '1473165601');
INSERT INTO `thinkox_field` VALUES ('296', '71', '93', '提案委组', '1473165007', '1473165654');
INSERT INTO `thinkox_field` VALUES ('297', '80', '93', '社法委政法群团组', '1473165045', '1473165601');
INSERT INTO `thinkox_field` VALUES ('298', '64', '93', '经科委经济发展组', '1473165116', '1473212080');
INSERT INTO `thinkox_field` VALUES ('299', '65', '93', '社法委文教卫体组', '1473165145', '1473165685');
INSERT INTO `thinkox_field` VALUES ('300', '80', '94', '否', '1473165601', '1473165601');
INSERT INTO `thinkox_field` VALUES ('301', '80', '95', '否', '1473165601', '1473165601');
INSERT INTO `thinkox_field` VALUES ('302', '71', '94', '是', '1473165654', '1473165654');
INSERT INTO `thinkox_field` VALUES ('303', '71', '95', '否', '1473165654', '1473165654');
INSERT INTO `thinkox_field` VALUES ('304', '64', '94', '否', '1473165671', '1473212080');
INSERT INTO `thinkox_field` VALUES ('305', '64', '95', '是', '1473165671', '1473212080');
INSERT INTO `thinkox_field` VALUES ('306', '65', '94', '是', '1473165685', '1473165685');
INSERT INTO `thinkox_field` VALUES ('307', '65', '95', '是', '1473165685', '1473165685');
INSERT INTO `thinkox_field` VALUES ('308', '58', '93', '提案委组', '1473219341', '1473219660');
INSERT INTO `thinkox_field` VALUES ('309', '58', '94', '是', '1473219341', '1473219660');
INSERT INTO `thinkox_field` VALUES ('310', '58', '95', '是', '1473219341', '1473219660');
INSERT INTO `thinkox_field` VALUES ('311', '66', '79', '公安局', '1473327116', '1473327142');
INSERT INTO `thinkox_field` VALUES ('312', '66', '81', 'x1', '1473327116', '1473327142');
INSERT INTO `thinkox_field` VALUES ('313', '66', '82', 'x2', '1473327116', '1473327142');
INSERT INTO `thinkox_field` VALUES ('314', '66', '83', '13512345678', '1473327116', '1473327142');
INSERT INTO `thinkox_field` VALUES ('315', '67', '79', '水利局', '1473327183', '1473327183');
INSERT INTO `thinkox_field` VALUES ('316', '67', '81', 'x3', '1473327183', '1473327183');
INSERT INTO `thinkox_field` VALUES ('317', '67', '82', 'x5', '1473327183', '1473327183');
INSERT INTO `thinkox_field` VALUES ('318', '67', '83', '13587654321', '1473327183', '1473327183');
INSERT INTO `thinkox_field` VALUES ('319', '1', '38', '郝智理', '111', '1111');
INSERT INTO `thinkox_field` VALUES ('320', '59', '36', '123', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('321', '59', '38', '委员1', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('322', '59', '39', '委员1', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('323', '59', '40', '男', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('324', '59', '41', '1473350400', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('325', '59', '42', '汉族', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('326', '59', '43', '湖北武汉', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('327', '59', '44', '123456', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('328', '59', '46', '博士', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('329', '59', '47', '教授', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('330', '59', '48', '主任', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('331', '59', '49', '总经理', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('332', '59', '50', '总工会', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('333', '59', '51', '江汉区管委会', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('334', '59', '54', '1473350400', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('335', '59', '55', '1473350400', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('336', '59', '56', '提案委', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('337', '59', '57', '新华街联络委员会', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('338', '59', '58', '中国农工民主党', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('339', '59', '59', '是', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('340', '59', '60', '是', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('341', '59', '61', '是', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('342', '59', '62', '13886199168', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('343', '59', '72', '正常', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('344', '59', '73', '大陆人士', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('345', '59', '74', '已婚', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('346', '59', '75', '无', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('347', '59', '76', '1473350400', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('348', '59', '77', '1473350400', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('349', '59', '93', '提案委组', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('350', '59', '96', '十四届', '1473413689', '1473753382');
INSERT INTO `thinkox_field` VALUES ('351', '60', '36', '123', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('352', '60', '38', '委员2', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('353', '60', '39', '委员2', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('354', '60', '40', '男', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('355', '60', '41', '1473350400', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('356', '60', '42', '回族', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('357', '60', '43', '湖北宜昌', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('358', '60', '44', '123456', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('359', '60', '46', '博士', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('360', '60', '47', '工程师', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('361', '60', '48', '副主任', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('362', '60', '49', '董事长', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('363', '60', '50', '发展科技有限公司', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('364', '60', '51', '区政协', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('365', '60', '54', '1473350400', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('366', '60', '55', '1473868800', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('367', '60', '56', '经科委', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('368', '60', '57', '民族街联络委员会', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('369', '60', '58', '中国国民党革命委员会', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('370', '60', '59', '否', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('371', '60', '60', '是', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('372', '60', '61', '是', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('373', '60', '62', '18694076198', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('374', '60', '67', '二', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('375', '60', '72', '正常', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('376', '60', '73', '大陆人士', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('377', '60', '74', '未婚', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('378', '60', '75', '道教', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('379', '60', '76', '1473350400', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('380', '60', '77', '1473350400', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('381', '60', '93', '经科委科技发展组', '1473414489', '1473429578');
INSERT INTO `thinkox_field` VALUES ('382', '61', '36', '6789', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('383', '61', '38', '委员3', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('384', '61', '39', '委员3', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('385', '61', '40', '男', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('386', '61', '41', '1473350400', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('387', '61', '42', '汉族', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('388', '61', '43', '湖北武汉', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('389', '61', '44', '1234567', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('390', '61', '46', '博士', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('391', '61', '47', '工程师', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('392', '61', '48', '主任', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('393', '61', '49', '总经理', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('394', '61', '50', '科贸公司', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('395', '61', '51', '区政协', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('396', '61', '54', '1473350400', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('397', '61', '55', '1473350400', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('398', '61', '56', '文史委', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('399', '61', '57', '满春街联络委员会', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('400', '61', '58', '中国国民党革命委员会', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('401', '61', '59', '否', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('402', '61', '60', '是', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('403', '61', '61', '是', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('404', '61', '62', '13407134819', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('405', '61', '67', '一', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('406', '61', '72', '正常', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('407', '61', '73', '港澳台', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('408', '61', '74', '已婚', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('409', '61', '75', '佛教', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('410', '61', '76', '1473350400', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('411', '61', '77', '1473350400', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('412', '61', '93', '文史委组', '1473414599', '1473429554');
INSERT INTO `thinkox_field` VALUES ('413', '61', '53', '86181234', '1473415140', '1473429554');
INSERT INTO `thinkox_field` VALUES ('414', '59', '53', '66181234', '1473415162', '1473753382');
INSERT INTO `thinkox_field` VALUES ('415', '60', '53', '56181234', '1473415179', '1473429578');
INSERT INTO `thinkox_field` VALUES ('416', '1', '38', '郝智理', '1473415179', '1473415179');
INSERT INTO `thinkox_field` VALUES ('417', '1', '50', '国务院', '1473415179', '1473415179');
INSERT INTO `thinkox_field` VALUES ('418', '1', '62', '15871430887', '1473415179', '1473415179');
INSERT INTO `thinkox_field` VALUES ('419', '62', '100', '民族街联络委员会', '1473513523', '1473513523');
INSERT INTO `thinkox_field` VALUES ('420', '62', '101', '集体1', '1473513523', '1473513523');
INSERT INTO `thinkox_field` VALUES ('421', '62', '102', '13886199168', '1473513523', '1473513523');
INSERT INTO `thinkox_field` VALUES ('422', '63', '100', '满春街联络委员会', '1473513559', '1473513559');
INSERT INTO `thinkox_field` VALUES ('423', '63', '101', '集体2', '1473513559', '1473513559');
INSERT INTO `thinkox_field` VALUES ('424', '63', '102', '13407134819', '1473513559', '1473513559');
INSERT INTO `thinkox_field` VALUES ('425', '97', '36', '1', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('426', '97', '38', '严三', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('427', '97', '39', '严三', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('428', '97', '41', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('429', '97', '42', '汉', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('430', '97', '43', '湖北武汉', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('431', '97', '44', '123456', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('432', '97', '46', '博士', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('433', '97', '47', '教授', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('434', '97', '48', '副主任', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('435', '97', '49', '总经理', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('436', '97', '50', '总工会', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('437', '97', '51', '区政协', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('438', '97', '52', '江汉路', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('439', '97', '53', '12345678', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('440', '97', '54', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('441', '97', '55', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('442', '97', '56', '文史委', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('443', '97', '57', '民权街联络委员会', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('444', '97', '58', '中国国民党革命委员会', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('445', '97', '62', '18696492998', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('446', '97', '63', '12345678', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('447', '97', '64', '江汉鲁', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('448', '97', '65', '2@qq.com', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('449', '97', '67', '一', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('450', '97', '72', '正常', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('451', '97', '73', '大陆人士', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('452', '97', '75', '天主教', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('453', '97', '76', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('454', '97', '77', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('455', '97', '93', '文史委组', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('456', '97', '96', '十四届', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('457', '97', '97', '1473609600', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('458', '97', '98', '岗位变动', '1473665285', '1473665285');
INSERT INTO `thinkox_field` VALUES ('459', '98', '36', '123', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('460', '98', '38', '陈三', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('461', '98', '39', '陈三', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('462', '98', '41', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('463', '98', '42', '汉族', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('464', '98', '43', '湖北宜昌', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('465', '98', '44', '123456', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('466', '98', '46', '博士', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('467', '98', '47', '工程师', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('468', '98', '48', '主任', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('469', '98', '49', '董事长', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('470', '98', '50', '总工会', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('471', '98', '51', '江汉区管委会', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('472', '98', '52', '江汉路', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('473', '98', '53', '86181234', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('474', '98', '54', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('475', '98', '55', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('476', '98', '56', '提案委', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('477', '98', '57', '民族街联络委员会', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('478', '98', '58', '中国国民党革命委员会', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('479', '98', '62', '15629156212', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('480', '98', '63', '12345678', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('481', '98', '64', '江汉路', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('482', '98', '65', '2@qq.com', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('483', '98', '66', '12356', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('484', '98', '67', '二', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('485', '98', '69', '是', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('486', '98', '72', '正常', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('487', '98', '73', '大陆人士', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('488', '98', '75', '佛教', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('489', '98', '76', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('490', '98', '77', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('491', '98', '93', '提案委组', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('492', '98', '96', '十四届', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('493', '98', '97', '1473609600', '1473669283', '1473669283');
INSERT INTO `thinkox_field` VALUES ('494', '98', '98', '岗位变动', '1473669283', '1473669283');

-- ----------------------------
-- Table structure for thinkox_field_group
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_field_group`;
CREATE TABLE `thinkox_field_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_field_group
-- ----------------------------
INSERT INTO `thinkox_field_group` VALUES ('13', '委员信息', '1', '1403847366', '0', '1');
INSERT INTO `thinkox_field_group` VALUES ('14', '办理单位', '1', '1471406198', '0', '0');
INSERT INTO `thinkox_field_group` VALUES ('15', '集体', '1', '1472615279', '0', '0');

-- ----------------------------
-- Table structure for thinkox_field_setting
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_field_setting`;
CREATE TABLE `thinkox_field_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(25) NOT NULL,
  `profile_group_id` int(11) NOT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1',
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `sort` int(11) NOT NULL,
  `form_type` varchar(25) NOT NULL,
  `form_default_value` varchar(200) NOT NULL,
  `validation` varchar(25) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `createTime` int(11) NOT NULL,
  `child_form_type` varchar(25) NOT NULL,
  `input_tips` varchar(100) NOT NULL COMMENT '输入提示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_field_setting
-- ----------------------------
INSERT INTO `thinkox_field_setting` VALUES ('36', '身份证号', '13', '1', '1', '0', 'input', '', '', '1', '1409045825', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('37', '编号', '13', '1', '0', '0', 'input', '', '', '1', '1469598560', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('38', '名称', '13', '1', '1', '0', 'input', '', '', '1', '1469598625', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('39', '曾用名', '13', '1', '1', '0', 'input', '', '', '1', '1469602481', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('40', '性别', '13', '1', '1', '0', 'radio', '男|女', '', '1', '1469602503', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('41', '生日', '13', '1', '1', '0', 'time', '', '', '1', '1469602522', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('42', '民族', '13', '1', '1', '0', 'input', '', '', '1', '1469602574', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('43', '籍贯', '13', '1', '1', '0', 'input', '', '', '1', '1469602624', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('44', '邮政编码', '13', '1', '1', '0', 'input', '', '', '1', '1469602656', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('45', '政治面貌', '13', '1', '1', '0', 'select', '中共|群众|团员|中国国民党革命委员会|中国民主同盟|中国民主建国会|中国民主促进会|中国农工民主党|中国致公党|九三学社', '', '0', '1469602697', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('46', '文化程度', '13', '1', '1', '0', 'select', '博士|硕士|本科|大专|中专|技工|高中|初中|小学', '', '1', '1469602751', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('47', '职称', '13', '1', '0', '0', 'input', '', '', '1', '1469602773', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('48', '党派职务', '13', '1', '0', '0', 'input', '', '', '1', '1469602855', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('49', '现任职称', '13', '1', '1', '0', 'input', '', '', '1', '1469602875', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('50', '工作单位', '13', '1', '1', '0', 'input', '', '', '1', '1469602888', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('51', '推荐单位', '13', '1', '1', '0', 'input', '', '', '1', '1469602905', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('52', '单位地址', '13', '1', '0', '0', 'input', '', '', '1', '1469602930', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('53', '办公电话', '13', '1', '0', '0', 'input', '', '', '1', '1469602942', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('54', '入职时间', '13', '1', '0', '0', 'time', '', '', '1', '1469602958', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('55', '入党时间', '13', '1', '0', '0', 'time', '', '', '1', '1469602973', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('56', '专委会', '13', '1', '1', '0', 'select', '提案委|经科委|文史委|社法委|外事委|委工委', '', '1', '1469603004', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('57', '街道联络委', '13', '1', '1', '0', 'select', '民族街联络委员会|民权街联络委员会|满春街联络委员会|花楼水塔街联络委员会|前进街联络委员会|民意街联络委员会|新华街联络委员会|万松街联络委员会|北湖街联络委员会|唐家墩街联络委员会|常青街联络委员会|汉兴街联络委员会|江汉经济开发区联络委员会\r\n', '', '1', '1469603011', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('58', '界别', '13', '1', '1', '0', 'select', '中国国民党革命委员会|中国民主同盟|中国民主建国会|中国民主促进会|中国农工民主党|中国致公党|九三学社|工商联', '', '1', '1469603033', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('59', '是否常委', '13', '1', '0', '0', 'radio', '是|否', '', '1', '1469603044', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('60', '是否省委员', '13', '1', '0', '0', 'radio', '是|否', '', '1', '1469603071', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('61', '是否区委员', '13', '1', '0', '0', 'radio', '是|否', '', '1', '1469603104', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('62', '手机号', '13', '1', '1', '0', 'input', '', '', '1', '1469603124', 'phone', '');
INSERT INTO `thinkox_field_setting` VALUES ('63', '家庭电话', '13', '1', '0', '0', 'input', '', '', '1', '1469603147', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('64', '家庭地址', '13', '1', '0', '0', 'input', '', '', '1', '1469603588', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('65', 'email', '13', '1', '0', '0', 'input', '', '', '1', '1469603602', 'email', '');
INSERT INTO `thinkox_field_setting` VALUES ('66', 'qq', '13', '1', '0', '0', 'input', '', '', '1', '1469603609', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('67', '社会身份', '13', '1', '0', '0', 'input', '', '', '1', '1469603630', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('68', '简历', '13', '1', '0', '0', 'file', '', '', '1', '1469603652', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('69', '是否华侨', '13', '1', '0', '0', 'input', '', '', '1', '1469603666', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('70', '兴趣爱好', '13', '1', '0', '0', 'input', '', '', '1', '1469603673', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('71', '备注', '13', '1', '0', '0', 'input', '', '', '1', '1469603683', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('72', '委员状态', '13', '1', '0', '0', 'select', '正常|禁用', '', '1', '1469603722', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('73', '属地', '13', '1', '0', '0', 'select', '大陆人士|港澳台|华侨', '', '1', '1469603741', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('74', '婚否', '13', '1', '1', '0', 'radio', '已婚|未婚', '', '1', '1469603768', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('75', '宗教', '13', '1', '0', '0', 'select', '无|天主教|基督教|佛教|道教', '', '1', '1469603784', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('76', '加入政协日期', '13', '1', '1', '0', 'time', '', '', '1', '1469603800', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('77', '退出政协日期', '13', '1', '0', '0', 'time', '', '', '1', '1469603811', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('78', 'uid', '13', '0', '1', '0', 'input', '', '', '-1', '1469753720', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('79', '名称', '14', '1', '1', '0', 'input', '', '', '1', '1471411011', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('80', 'uid', '14', '0', '1', '0', 'input', '', '', '-1', '1471427647', 'number', '');
INSERT INTO `thinkox_field_setting` VALUES ('81', '单位领导', '14', '1', '1', '0', 'input', '', '', '1', '1471515077', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('82', '责任人', '14', '1', '1', '0', 'input', '', '', '1', '1471515087', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('83', '联系电话', '14', '1', '1', '0', 'input', '', '', '1', '1471515104', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('84', '专委会', '15', '1', '0', '0', 'select', '1|2|3', '', '1', '1472615317', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('85', '街道联络委', '15', '1', '0', '0', 'select', '1|2|3', '', '1', '1472615354', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('86', '民主党派', '15', '1', '0', '0', 'select', '1|2|3', '', '1', '1472615386', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('87', '工商联', '15', '1', '0', '0', 'select', '1|2|3', '', '1', '1472615407', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('88', '是否信息员', '15', '1', '0', '0', 'radio', '是|否', '', '1', '1472615437', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('89', '是否联络员', '15', '1', '0', '0', 'radio', '是|否', '', '1', '1472615463', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('90', '领导', '15', '1', '0', '0', 'input', '', '', '1', '1472615476', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('91', '界别', '15', '1', '0', '0', 'select', '123\r\n345\r\n4665', '', '1', '1472970091', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('92', '头像', '13', '1', '0', '0', 'picture', '', '', '-1', '1473045118', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('93', '专委会组', '13', '1', '1', '0', 'select', '提案委组|经科委科技发展组|经科委经济发展组|经科委城市发展组|文史委组|社法委政法群团组|社法委文教卫体组|社法委人口资源与环境组|外事委组', '', '1', '1473164581', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('94', '七党一联主委', '13', '1', '1', '0', 'radio', '是|否', '', '1', '1473165357', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('95', '主席会议成员', '13', '1', '0', '0', 'radio', '是|否', '', '1', '1473165374', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('96', '届别', '13', '1', '0', '0', 'select', '十四届|十五届', '', '1', '1473233556', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('97', '调整变动时间', '13', '1', '0', '0', 'time', '', '', '1', '1473233576', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('98', '调整变动原因', '13', '1', '0', '0', 'select', '岗位变动|退休|调出本市|暂停资格|违纪违法|其它\r\n', '', '1', '1473233624', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('99', '主任', '13', '1', '0', '0', 'select', '提案委|经科委|文史委|社法委|外事委|委工委|民族街联络委员会|民权街联络委员会|满春街联络委员会|花楼水塔街联络委员会|前进街联络委员会|民意街联络委员会|新华街联络委员会|万松街联络委员会|北湖街联络委员会|唐家墩街联络委员会|常青街联络委员会|汉兴街联络委员会|江汉经济开发区联络委员会', '', '1', '1473235502', '', '');
INSERT INTO `thinkox_field_setting` VALUES ('100', '名称', '15', '1', '1', '0', 'input', '', '', '1', '1473500005', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('101', '联络员', '15', '1', '1', '0', 'input', '', '', '1', '1473500013', 'string', '');
INSERT INTO `thinkox_field_setting` VALUES ('102', '联系方式', '15', '1', '1', '0', 'input', '', '', '1', '1473501220', 'string', '');

-- ----------------------------
-- Table structure for thinkox_file
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_file`;
CREATE TABLE `thinkox_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  `driver` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of thinkox_file
-- ----------------------------
INSERT INTO `thinkox_file` VALUES ('64', 'test0001', 'test0001', '2016-08-23/', '', 'application/zip', '1048576', '320d324ac6b4eca6f0f5be348c7b4404', 'f0ec282a0ecf3cdca4ab6d1b5b24feb8ab3dfc09', '0', '1471933545', '');
INSERT INTO `thinkox_file` VALUES ('65', '57bbed4a5636b.', '57bbed4a5636b.', '2016-08-23/', '', 'application/zip', '8536', '0e2421f0bcaf02cd5766d51e413db326', 'ab854c1ce36c1006e8beb98ca0a39dbf1355421f', '0', '1471933770', '');
INSERT INTO `thinkox_file` VALUES ('66', '57bbefc2118c6.', '57bbefc2118c6.', '2016-08-23/', '', 'application/zip', '3853849', '50f613f68f2aaa61c646aa50ebfe05dc', 'f182fe5ffcb7a1cb1f9f2039b5f8c2448038086b', '0', '1471934401', '');
INSERT INTO `thinkox_file` VALUES ('67', '57bbf078df520.', '57bbf078df520.', '2016-08-23/', '', 'application/zip', '625319', 'e9263af7f90e04ffb4d5dcc510ef6d6c', 'b83b9b1865f17b1822530fb921b929f4125a5c3e', '0', '1471934584', '');
INSERT INTO `thinkox_file` VALUES ('68', '57bbf2a16180a.', '57bbf2a16180a.', '2016-08-23/', '', 'application/zip', '2318340', '8208e973493b302862d62847d199fbed', 'ac4c670075e4534e9b2fdf5f848a75738ca51408', '0', '1471935137', '');
INSERT INTO `thinkox_file` VALUES ('60', '57bbe8c56f22f.', '57bbe8c56f22f.', '2016-08-23/', '', 'application/zip', '1048576', 'ee8b2d40a42cfd40f292321991697577', '1367d0a1f78c297d67a3e414cd46ddde9d2a64ab', '0', '1471932613', '');
INSERT INTO `thinkox_file` VALUES ('61', '57bbe8c597d1f.', '57bbe8c597d1f.', '2016-08-23/', '', 'application/octet-stream', '1048576', '99bc477e395c62e20bde630469e1ef4a', '8e2da49a2cb6e433724b63712d0cbf677728c5e4', '0', '1471932613', '');
INSERT INTO `thinkox_file` VALUES ('62', '57bbe8c5c23d0.', '57bbe8c5c23d0.', '2016-08-23/', '', 'application/octet-stream', '1048576', 'fd9f72b9dc50e601952469b38449876d', '3dfc4de30f3bf6458cc03aefb68dfbc997b26f7f', '0', '1471932613', '');
INSERT INTO `thinkox_file` VALUES ('63', '57bbe8c5ecf5f.', '57bbe8c5ecf5f.', '2016-08-23/', '', 'application/octet-stream', '708121', '7e7f7a5e943f4201de23daa5a6581de5', '388e2b87698f0da1cdc394596360bcaaed6fe43c', '0', '1471932613', '');

-- ----------------------------
-- Table structure for thinkox_fileu
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_fileu`;
CREATE TABLE `thinkox_fileu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `user_id` int(10) NOT NULL,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `savename` varchar(50) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` varchar(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` varchar(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `record_id` int(8) DEFAULT NULL COMMENT '来源Id',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  `location` tinyint(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sn` (`savename`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of thinkox_fileu
-- ----------------------------
INSERT INTO `thinkox_fileu` VALUES ('78', '58', 'Proposal', '53abcfc290c6e.zip', '53abcfc290c6e.zip', 'Uploads/2016-08-24/', 'zip', '77', '2617027', '1472007886', '0');
INSERT INTO `thinkox_fileu` VALUES ('79', '58', 'Proposal', '54d0c03ce3283.zip', '54d0c03ce3283.zip', 'Uploads/2016-08-24/', 'zip', '77', '7559221', '1472007894', '0');
INSERT INTO `thinkox_fileu` VALUES ('80', '58', 'Proposal', '53d73f40ecda7.zip', '53d73f40ecda7.zip', 'Uploads/2016-08-24/', 'zip', '77', '3522866', '1472014594', '0');
INSERT INTO `thinkox_fileu` VALUES ('82', '58', 'Proposal', '55fb7b5a44cc7 (2).zip', '55fb7b5a44cc7 (2).zip', 'Uploads/2016-08-24/', 'zip', '77', '1903929', '1472015213', '0');
INSERT INTO `thinkox_fileu` VALUES ('83', '58', 'Proposal', '536a4b7a3ddd8.zip', '536a4b7a3ddd8.zip', 'Uploads/2016-08-24/', 'zip', '77', '5508135', '1472015290', '0');
INSERT INTO `thinkox_fileu` VALUES ('85', '71', 'Proposal', '1_1113064991.doc', '1_1113064991.doc', 'Uploads/2016-08-24/', 'doc', '79', '39424', '1472024375', '0');
INSERT INTO `thinkox_fileu` VALUES ('86', '71', 'Proposal', '', '', 'Uploads/2016-08-26/', 'docx', '131', '1471161', '1472191713', '0');
INSERT INTO `thinkox_fileu` VALUES ('87', '58', 'Proposal', '53ca94f1dbc7e.zip', '53ca94f1dbc7e.zip', 'Uploads/2016-08-29/', 'zip', '97', '1168522', '1472438587', '0');
INSERT INTO `thinkox_fileu` VALUES ('88', '58', 'Proposal', '53d5f69da7445.zip', '53d5f69da7445.zip', 'Uploads/2016-08-29/', 'zip', '97', '2308277', '1472438587', '0');
INSERT INTO `thinkox_fileu` VALUES ('89', '58', 'Proposal', '53d5fe9c30376.zip', '53d5fe9c30376.zip', 'Uploads/2016-08-29/', 'zip', '97', '8536', '1472438588', '0');
INSERT INTO `thinkox_fileu` VALUES ('92', '58', 'Proposal', '800.jpg', '800.jpg', 'Uploads/2016-08-31/', 'jpg', '123', '434267', '1472621598', '0');
INSERT INTO `thinkox_fileu` VALUES ('93', '58', 'Proposal', 'ad1.png', 'ad1.png', 'Uploads/2016-08-31/', 'png', '123', '23485', '1472621598', '0');
INSERT INTO `thinkox_fileu` VALUES ('94', '64', 'Proposal', '120366479.png', '120366479.png', 'Uploads/2016-08-31/', 'png', '127', '18024', '1472623440', '0');
INSERT INTO `thinkox_fileu` VALUES ('95', '64', 'Proposal', 'banner0.jpg', 'banner0.jpg', 'Uploads/2016-08-31/', 'jpg', '127', '208677', '1472623486', '0');
INSERT INTO `thinkox_fileu` VALUES ('96', '64', 'Proposal', '500.jpg', '500.jpg', 'Uploads/2016-08-31/', 'jpg', '127', '203623', '1472623524', '0');
INSERT INTO `thinkox_fileu` VALUES ('112', '71', 'Proposal', 'JavaScript.pdf', 'JavaScript.pdf', 'Uploads/2016-08-31/', 'pdf', '133', '21962427', '1472645955', '0');
INSERT INTO `thinkox_fileu` VALUES ('109', '64', 'Proposal', '002 - ', '002 - ', 'Uploads/2016-08-31/', 'jpg', '129', '39252', '1472624106', '0');
INSERT INTO `thinkox_fileu` VALUES ('110', '64', 'Proposal', '001.jpg', '001.jpg', 'Uploads/2016-08-31/', 'jpg', '130', '45824', '1472624499', '0');
INSERT INTO `thinkox_fileu` VALUES ('111', '64', 'Proposal', '600.jpg', '600.jpg', 'Uploads/2016-08-31/', 'jpg', '132', '270622', '1472626739', '0');
INSERT INTO `thinkox_fileu` VALUES ('172', '58', '', '2.jpg', 'hpA461.jpg', 'Uploads/2016-09-05/58/', 'jpg', '0', '49193', '1473063275', '0');
INSERT INTO `thinkox_fileu` VALUES ('114', '71', 'Proposal', '1.doc', '1.doc', 'Uploads/2016-09-01/', 'doc', '134', '39424', '1472702229', '0');
INSERT INTO `thinkox_fileu` VALUES ('137', '69', 'Proposal', '8.doc', 'hp513A.doc', 'Uploads/2016-09-01/69/', 'doc', '7397', '39424', '1472711904', '0');
INSERT INTO `thinkox_fileu` VALUES ('116', '71', 'Proposal', '5.doc', '5.doc', 'Uploads/2016-09-01/', 'doc', '135', '39424', '1472708304', '0');
INSERT INTO `thinkox_fileu` VALUES ('135', '58', 'Proposal', '01.jpg', 'hp5A4C.jpg', 'Uploads/2016-09-01/58/', 'jpg', '121', '72150', '1472710727', '0');
INSERT INTO `thinkox_fileu` VALUES ('136', '58', 'Proposal', '001.jpg', 'hpBC0C.jpg', 'Uploads/2016-09-01/58/', 'jpg', '121', '45824', '1472710883', '0');
INSERT INTO `thinkox_fileu` VALUES ('122', '71', 'Proposal', 'hp5F2F.doc', 'hp5F2F.doc', 'Uploads/66/2016-09-01/', 'doc', '135', '39424', '1472710204', '0');
INSERT INTO `thinkox_fileu` VALUES ('138', '70', 'Proposal', '', 'hpC2A3.docx', 'Uploads/2016-09-01/70/', 'docx', '7398', '11956', '1472712064', '0');
INSERT INTO `thinkox_fileu` VALUES ('139', '71', 'Proposal', '8.doc', 'hp770A.doc', 'Uploads/2016-09-01/71/', 'doc', '139', '39424', '1472729544', '0');
INSERT INTO `thinkox_fileu` VALUES ('140', '71', 'Proposal', '', 'hpE3A3.docx', 'Uploads/2016-09-01/71/', 'docx', '141', '11956', '1472731013', '0');
INSERT INTO `thinkox_fileu` VALUES ('141', '69', 'Proposal', '', 'hp8169.docx', 'Uploads/2016-09-01/69/', 'docx', '7401', '11956', '1472733347', '0');
INSERT INTO `thinkox_fileu` VALUES ('142', '70', 'Proposal', '8.doc', 'hpBBFA.doc', 'Uploads/2016-09-01/70/', 'doc', '7403', '39424', '1472733493', '0');
INSERT INTO `thinkox_fileu` VALUES ('143', '58', 'Proposal', '001.jpg', 'hp8B6E.jpg', 'Uploads/2016-09-02/58/', 'jpg', '7327', '45824', '1472781043', '0');
INSERT INTO `thinkox_fileu` VALUES ('144', '58', 'Proposal', '01.jpg', 'hp9667.jpg', 'Uploads/2016-09-02/58/', 'jpg', '7327', '72150', '1472781046', '0');
INSERT INTO `thinkox_fileu` VALUES ('145', '58', 'Proposal', 'top4.png', 'hpA056.png', 'Uploads/2016-09-02/58/', 'png', '7328', '141145', '1472781114', '0');
INSERT INTO `thinkox_fileu` VALUES ('146', '71', 'Proposal', '8.doc', 'hp6E16.doc', 'Uploads/2016-09-02/71/', 'doc', '143', '39424', '1472795847', '0');
INSERT INTO `thinkox_fileu` VALUES ('147', '71', 'Proposal', '8.doc', 'hp108D.doc', 'Uploads/2016-09-02/71/', 'doc', '144', '39424', '1472796741', '0');
INSERT INTO `thinkox_fileu` VALUES ('148', '71', 'Proposal', '', 'hpAEDF.docx', 'Uploads/2016-09-02/66/', 'docx', '144', '11956', '1472797043', '0');
INSERT INTO `thinkox_fileu` VALUES ('149', '71', 'Proposal', '', 'hp3C40.docx', 'Uploads/2016-09-02/66/', 'docx', '144', '11956', '1472797079', '0');
INSERT INTO `thinkox_fileu` VALUES ('150', '71', 'Proposal', '8.doc', 'hp17B1.doc', 'Uploads/2016-09-02/71/', 'doc', '146', '39424', '1472797201', '0');
INSERT INTO `thinkox_fileu` VALUES ('151', '71', 'Proposal', '', 'hp2817.docx', 'Uploads/2016-09-02/71/', 'docx', '147', '11956', '1472797271', '0');
INSERT INTO `thinkox_fileu` VALUES ('152', '71', 'Proposal', '8.doc', 'hpB23D.doc', 'Uploads/2016-09-02/71/', 'doc', '148', '39424', '1472797306', '0');
INSERT INTO `thinkox_fileu` VALUES ('153', '71', 'Proposal', '', 'hp9D19.docx', 'Uploads/2016-09-02/66/', 'docx', '143', '11956', '1472797432', '0');
INSERT INTO `thinkox_fileu` VALUES ('154', '71', 'Proposal', '', 'hpC87D.docx', 'Uploads/2016-09-02/66/', 'docx', '143', '11956', '1472797509', '0');
INSERT INTO `thinkox_fileu` VALUES ('161', '68', 'Proposal', '登录通用接口1.docx', 'hp39EE.docx', 'Uploads/2016-09-02/68/', 'docx', '7404', '11956', '1472799438', '0');
INSERT INTO `thinkox_fileu` VALUES ('160', '71', 'Proposal', '登录通用接口1.docx', 'hp99A8.docx', 'Uploads/2016-09-02/66/', 'docx', '148', '11956', '1472798152', '0');
INSERT INTO `thinkox_fileu` VALUES ('164', '69', 'Proposal', '8.doc', 'hpC619.doc', 'Uploads/2016-09-02/69/', 'doc', '7405', '39424', '1472799540', '0');
INSERT INTO `thinkox_fileu` VALUES ('175', '59', '', 'bg_topr.png', 'hp1U1jCW.png', 'Uploads/2016-09-09/59/', 'png', '0', '23812', '1473409481', '0');
INSERT INTO `thinkox_fileu` VALUES ('173', '58', 'proposal', 'bg_topr.png', 'hp7tgpmh.png', 'Uploads/2016-09-08/58/', 'png', '150', '23812', '1473315432', '0');
INSERT INTO `thinkox_fileu` VALUES ('174', '59', 'proposal', '登录通用接口1.docx', 'hp7rqQyU.docx', 'Uploads/2016-09-08/59/', 'docx', '152', '11956', '1473328563', '0');
INSERT INTO `thinkox_fileu` VALUES ('167', '86', 'Proposal', '登录通用接口1.docx', 'hpF21D.docx', 'Uploads/2016-09-02/69/', 'docx', '7406', '11956', '1472800862', '0');
INSERT INTO `thinkox_fileu` VALUES ('168', '69', 'Proposal', '8.doc', 'hpA6E.doc', 'Uploads/2016-09-02/69/', 'doc', '7406', '39424', '1472800868', '0');
INSERT INTO `thinkox_fileu` VALUES ('169', '58', 'Proposal', '江协办[15]区政协委员履职量化综合评价实施细则.doc', 'hp74F4.doc', 'Uploads/2016-09-02/58/', 'doc', '7328', '66048', '1472801485', '0');
INSERT INTO `thinkox_fileu` VALUES ('170', '58', 'Proposal', '江协办[14]2015年度政协提案目标责任考评工作的通知.doc', 'hpDE13.doc', 'Uploads/2016-09-02/58/', 'doc', '7328', '54784', '1472801512', '0');
INSERT INTO `thinkox_fileu` VALUES ('171', '58', 'proposal_result', '江协办[15]区政协委员履职量化综合评价实施细则.doc', 'hp27B1.doc', 'Uploads/2016-09-02/58/', 'doc', '7328', '66048', '1472801662', '0');
INSERT INTO `thinkox_fileu` VALUES ('176', '59', '', 'bg_topr.png', 'hpIa2aP9.png', 'Uploads/2016-09-09/59/', 'png', '0', '23812', '1473409595', '0');
INSERT INTO `thinkox_fileu` VALUES ('178', '59', 'proposal', '登录通用接口1.docx', 'hpRJLf1f.docx', 'Uploads/2016-09-09/59/', 'docx', '155', '11956', '1473415553', '0');
INSERT INTO `thinkox_fileu` VALUES ('179', '59', 'proposal', '活动修改意见.docx', 'hpnUa28x.docx', 'Uploads/2016-09-09/59/', 'docx', '156', '99602', '1473415693', '0');
INSERT INTO `thinkox_fileu` VALUES ('180', '59', 'proposal', '流程描述.docx', 'hpKL1oHY.docx', 'Uploads/2016-09-09/59/', 'docx', '158', '15662', '1473415832', '0');
INSERT INTO `thinkox_fileu` VALUES ('181', '62', 'proposal', '活动修改意见.docx', 'hpDdY80J.docx', 'Uploads/2016-09-09/62/', 'docx', '159', '99602', '1473425922', '0');
INSERT INTO `thinkox_fileu` VALUES ('182', '67', 'proposal_result', '流程描述.docx', 'hpaDQFkE.docx', 'Uploads/2016-09-09/67/', 'docx', '7406', '15662', '1473435884', '0');
INSERT INTO `thinkox_fileu` VALUES ('183', '59', 'proposal', '活动修改意见.docx', 'hpbujAo0.docx', 'Uploads/2016-09-09/64/', 'docx', '158', '99602', '1473435980', '0');
INSERT INTO `thinkox_fileu` VALUES ('184', '67', 'proposal_result', '登录通用接口1.docx', 'hpFGCZQ8.docx', 'Uploads/2016-09-09/67/', 'docx', '7417', '11956', '1473436180', '0');
INSERT INTO `thinkox_fileu` VALUES ('185', '68', 'proposal_result', '活动修改意见.docx', 'hpxUI9AC.docx', 'Uploads/2016-09-09/68/', 'docx', '7415', '99602', '1473436431', '0');
INSERT INTO `thinkox_fileu` VALUES ('186', '59', 'proposal', '流程描述.docx', 'hpQs1plp.docx', 'Uploads/2016-09-10/59/', 'docx', '161', '15662', '1473489641', '0');
INSERT INTO `thinkox_fileu` VALUES ('187', '66', 'proposal_result', '流程描述.docx', 'hpU7LvHt.docx', 'Uploads/2016-09-10/66/', 'docx', '7411', '15662', '1473492599', '0');
INSERT INTO `thinkox_fileu` VALUES ('188', '67', 'proposal_result', '8.doc', 'hpcU8xIS.doc', 'Uploads/2016-09-10/67/', 'doc', '7413', '39424', '1473493418', '0');
INSERT INTO `thinkox_fileu` VALUES ('189', '68', 'proposal_result', '1_1505316101.doc', 'hp0RSVEX.doc', 'Uploads/2016-09-10/68/', 'doc', '7412', '1274880', '1473493465', '0');
INSERT INTO `thinkox_fileu` VALUES ('191', '59', 'P', '流程描述.docx', 'hpyFP3R9.docx', 'Uploads/2016-09-10/59/', 'docx', '0', '15662', '1473502644', '0');
INSERT INTO `thinkox_fileu` VALUES ('192', '64', 'P', '流程描述.docx', 'hpkF5wG8.docx', 'Uploads/2016-09-10/64/', 'docx', '166', '15662', '1473506235', '0');
INSERT INTO `thinkox_fileu` VALUES ('193', '66', 'P', '流程描述.docx', 'hp1GV5T2.docx', 'Uploads/2016-09-10/66/', 'docx', '7423', '15662', '1473507503', '0');
INSERT INTO `thinkox_fileu` VALUES ('194', '68', 'P', '流程描述.docx', 'hpI4RLDJ.docx', 'Uploads/2016-09-10/68/', 'docx', '7424', '15662', '1473507584', '0');
INSERT INTO `thinkox_fileu` VALUES ('195', '59', 'Proposal', '流程描述.docx', 'hpnModNX.docx', 'Uploads/2016-09-10/62/', 'docx', '166', '15662', '1473514180', '0');
INSERT INTO `thinkox_fileu` VALUES ('196', '62', 'Proposal', '登录通用接口1.docx', 'hpM8SZQV.docx', 'Uploads/2016-09-10/62/', 'docx', '169', '11956', '1473514837', '0');
INSERT INTO `thinkox_fileu` VALUES ('197', '62', 'Array', '流程描述.docx', 'hpiXPeyj.docx', 'Uploads/2016-09-10/62/', 'docx', '0', '15662', '1473516049', '0');
INSERT INTO `thinkox_fileu` VALUES ('198', '62', 'Array', '流程描述.docx', 'hp1tebtm.docx', 'Uploads/2016-09-10/62/', 'docx', '170', '15662', '1473516094', '0');
INSERT INTO `thinkox_fileu` VALUES ('199', '62', 'proposal', '流程描述.docx', 'hpFutNIi.docx', 'Uploads/2016-09-10/62/', 'docx', '170', '15662', '1473516378', '0');
INSERT INTO `thinkox_fileu` VALUES ('200', '62', 'proposal', '问题反馈.docx', 'hpBGrX0L.docx', 'Uploads/2016-09-10/64/', 'docx', '170', '1123171', '1473516432', '0');
INSERT INTO `thinkox_fileu` VALUES ('201', '67', 'proposal_result', '流程描述.docx', 'hpeqOCzp.docx', 'Uploads/2016-09-10/67/', 'docx', '7429', '15662', '1473518241', '0');
INSERT INTO `thinkox_fileu` VALUES ('202', '68', 'proposal_result', '流程描述.docx', 'hp18KJ7B.docx', 'Uploads/2016-09-10/68/', 'docx', '7426', '15662', '1473518297', '0');
INSERT INTO `thinkox_fileu` VALUES ('203', '68', 'proposal_result', 'logo.png', 'hpxDHz44.png', 'Uploads/2016-09-11/68/', 'png', '7424', '80956', '1473561288', '0');
INSERT INTO `thinkox_fileu` VALUES ('204', '66', 'proposal_result', '流程描述.docx', 'hpOlLQyz.docx', 'Uploads/2016-09-11/66/', 'docx', '7430', '15662', '1473579102', '0');
INSERT INTO `thinkox_fileu` VALUES ('205', '66', 'proposal_result', '登录通用接口1.docx', 'hpInqQRi.docx', 'Uploads/2016-09-11/66/', 'docx', '7432', '11956', '1473579184', '0');
INSERT INTO `thinkox_fileu` VALUES ('206', '59', 'message', '1.jpg', 'hpTDmFLx.jpg', 'Uploads/2016-09-11/59/', 'jpg', '328', '34452', '1473583766', '0');
INSERT INTO `thinkox_fileu` VALUES ('207', '59', 'message', '2.jpg', 'hpsdYjpF.jpg', 'Uploads/2016-09-11/59/', 'jpg', '329', '43798', '1473584579', '0');
INSERT INTO `thinkox_fileu` VALUES ('208', '59', 'message', '3.jpg', 'hpt5aQr3.jpg', 'Uploads/2016-09-11/59/', 'jpg', '330', '38560', '1473584873', '0');
INSERT INTO `thinkox_fileu` VALUES ('213', '59', 'survey', 'QQ截图20160503101459.png', 'hpbx5cGG.png', 'Uploads/2016-09-12/59/', 'png', '160', '3812', '1473661921', '0');
INSERT INTO `thinkox_fileu` VALUES ('212', '59', 'survey', 'show_img.png', 'hpbUySUO.png', 'Uploads/2016-09-12/59/', 'png', '131', '51057', '1473656339', '0');
INSERT INTO `thinkox_fileu` VALUES ('214', '59', 'historical', 'show_img.png', 'hp5oI2f5.png', 'Uploads/2016-09-12/59/', 'png', '1', '51057', '1473665915', '0');
INSERT INTO `thinkox_fileu` VALUES ('215', '59', 'historical', 'show_img.png', 'hpUKFGSl.png', 'Uploads/2016-09-12/59/', 'png', '160', '51057', '1473667017', '0');
INSERT INTO `thinkox_fileu` VALUES ('216', '59', 'historical', 'show_img.png', 'hpSVcJIR.png', 'Uploads/2016-09-12/59/', 'png', '163', '51057', '1473667399', '0');
INSERT INTO `thinkox_fileu` VALUES ('217', '59', 'historical', 'show_img.png', 'hpVtjVgI.png', 'Uploads/2016-09-12/59/', 'png', '164', '51057', '1473667474', '0');
INSERT INTO `thinkox_fileu` VALUES ('218', '59', 'historical', 'QQ截图20160503101459.png', 'hpFBOTyj.png', 'Uploads/2016-09-12/59/', 'png', '165', '3812', '1473667541', '0');
INSERT INTO `thinkox_fileu` VALUES ('219', '96', 'historical', 'smalllogo.png', 'hpV1wgRz.png', 'Uploads/2016-09-12/96/', 'png', '166', '27252', '1473668181', '0');
INSERT INTO `thinkox_fileu` VALUES ('220', '96', 'polls', 'smalllogo.png', 'hpVhrGJR.png', 'Uploads/2016-09-12/96/', 'png', '0', '27252', '1473668232', '0');
INSERT INTO `thinkox_fileu` VALUES ('221', '96', 'polls', 'smalllogo.png', 'hp1FL0O2.png', 'Uploads/2016-09-12/96/', 'png', '0', '27252', '1473668243', '0');
INSERT INTO `thinkox_fileu` VALUES ('225', '59', 'polls', 'logo.png', 'hpOFUiBH.png', 'Uploads/2016-09-12/59/', 'png', '99', '80956', '1473677294', '0');
INSERT INTO `thinkox_fileu` VALUES ('224', '59', 'message', '登录通用接口1.docx', 'hpC1jDo3.docx', 'Uploads/2016-09-12/59/', 'docx', '339', '11956', '1473676776', '0');
INSERT INTO `thinkox_fileu` VALUES ('233', '59', 'working', 'QQ截图20160913152550.png', 'hpDr7HAN.png', 'Uploads/2016-09-13/59/', 'png', '52', '13813', '1473751578', '0');
INSERT INTO `thinkox_fileu` VALUES ('228', '60', 'polls', '登录通用接口1.docx', 'hpQio5q0.docx', 'Uploads/2016-09-13/60/', 'docx', '101', '11956', '1473728873', '0');
INSERT INTO `thinkox_fileu` VALUES ('230', '69', 'polls', '登录通用接口1.docx', 'hpT8j8AZ.docx', 'Uploads/2016-09-13/60/', 'docx', '95', '11956', '1473729487', '0');
INSERT INTO `thinkox_fileu` VALUES ('231', '69', 'polls', 'show_img.png', 'hpBmUyNS.png', 'Uploads/2016-09-13/59/', 'png', '95', '51057', '1473731060', '0');
INSERT INTO `thinkox_fileu` VALUES ('234', '59', 'polls', 'show_img.png', 'hpffKIkw.png', 'Uploads/2016-09-13/59/', 'png', '104', '51057', '1473760747', '0');

-- ----------------------------
-- Table structure for thinkox_follow
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_follow`;
CREATE TABLE `thinkox_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `follow_who` int(11) NOT NULL COMMENT '关注谁',
  `who_follow` int(11) NOT NULL COMMENT '谁关注',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='关注表';

-- ----------------------------
-- Records of thinkox_follow
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_forum
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum`;
CREATE TABLE `thinkox_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `post_count` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `allow_user_group` text NOT NULL,
  `sort` int(11) NOT NULL,
  `logo` int(11) NOT NULL,
  `background` int(11) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `admin` varchar(100) NOT NULL,
  `type_id` int(11) NOT NULL,
  `last_reply_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_forum
-- ----------------------------
INSERT INTO `thinkox_forum` VALUES ('1', '委员对话', '1407114174', '11', '1', '1', '0', '0', '0', '', '', '1', '1470012619');

-- ----------------------------
-- Table structure for thinkox_forum_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum_bookmark`;
CREATE TABLE `thinkox_forum_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_forum_bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_forum_lzl_reply
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum_lzl_reply`;
CREATE TABLE `thinkox_forum_lzl_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `to_f_reply_id` int(11) NOT NULL,
  `to_reply_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `ctime` int(11) NOT NULL,
  `is_del` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_forum_lzl_reply
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_forum_post
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum_post`;
CREATE TABLE `thinkox_forum_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `last_reply_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `is_top` tinyint(4) NOT NULL COMMENT '是否置顶',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_forum_post
-- ----------------------------
INSERT INTO `thinkox_forum_post` VALUES ('1', '1', '1', '看我来发个贴贴吧', '0', '<p>哈哈，发贴贴</p>', '1469600893', '1469600893', '1', '1470012619', '6', '1', '0');

-- ----------------------------
-- Table structure for thinkox_forum_post_reply
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum_post_reply`;
CREATE TABLE `thinkox_forum_post_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_forum_post_reply
-- ----------------------------
INSERT INTO `thinkox_forum_post_reply` VALUES ('1', '58', '1', '0', '<p>我是来回帖的！</p>', '1470012618', '1470012618', '1');

-- ----------------------------
-- Table structure for thinkox_forum_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_forum_type`;
CREATE TABLE `thinkox_forum_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `sort` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='论坛分类表';

-- ----------------------------
-- Records of thinkox_forum_type
-- ----------------------------
INSERT INTO `thinkox_forum_type` VALUES ('1', '默认分类', '1', '0', '0');
INSERT INTO `thinkox_forum_type` VALUES ('2', '官方板块', '1', '1', '0');

-- ----------------------------
-- Table structure for thinkox_group
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group`;
CREATE TABLE `thinkox_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `post_count` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `allow_user_group` text NOT NULL,
  `sort` int(11) NOT NULL,
  `logo` int(11) NOT NULL,
  `background` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `detail` text NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '群组类型，0为公共的，1为私有的',
  `activity` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_bookmark
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_bookmark`;
CREATE TABLE `thinkox_group_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_bookmark
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_dynamic
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_dynamic`;
CREATE TABLE `thinkox_group_dynamic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `row_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_dynamic
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_lzl_reply
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_lzl_reply`;
CREATE TABLE `thinkox_group_lzl_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `to_f_reply_id` int(11) NOT NULL,
  `to_reply_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `uid` int(11) NOT NULL,
  `to_uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `is_del` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_lzl_reply
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_member
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_member`;
CREATE TABLE `thinkox_group_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `activity` int(11) NOT NULL,
  `last_view` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_member
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_notice
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_notice`;
CREATE TABLE `thinkox_group_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_notice
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_post
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_post`;
CREATE TABLE `thinkox_group_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `last_reply_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `is_top` tinyint(4) NOT NULL COMMENT '是否置顶',
  `cate_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_post
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_post_category
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_post_category`;
CREATE TABLE `thinkox_group_post_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL COMMENT '所属群组',
  `title` varchar(50) NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_post_category
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_post_reply
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_post_reply`;
CREATE TABLE `thinkox_group_post_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `parse` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_group_post_reply
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_group_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_group_type`;
CREATE TABLE `thinkox_group_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  `status` tinyint(11) NOT NULL,
  `sort` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='群组的分类表';

-- ----------------------------
-- Records of thinkox_group_type
-- ----------------------------
INSERT INTO `thinkox_group_type` VALUES ('1', '群组默认分类', '1', '0', '1409811696', '0');

-- ----------------------------
-- Table structure for thinkox_historical
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_historical`;
CREATE TABLE `thinkox_historical` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `people` varchar(30) NOT NULL COMMENT '作者',
  `type_id` int(10) NOT NULL COMMENT '类别',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '备注',
  `upload` varchar(50) NOT NULL COMMENT '上传文件',
  `time` int(11) NOT NULL COMMENT '发表时间',
  `adopt` varchar(9) NOT NULL COMMENT '采用情况',
  `uid` int(10) unsigned NOT NULL COMMENT '外键用户ID',
  `people_view` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_historical
-- ----------------------------
INSERT INTO `thinkox_historical` VALUES ('166', '60,71,97,61,59,96,79,81,86,95', '3', '324', '<p>234fdsaf sad fsa</p>', '', '1473668158', '1', '96', '(民族街联络委员会),,(民权街联络委员会),(满春街联络委员会),(新华街联络委员会),(提案委),,(经科委),(文史委),,(七党一联主委),,,,,,,,,,,');

-- ----------------------------
-- Table structure for thinkox_historical_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_historical_type`;
CREATE TABLE `thinkox_historical_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_historical_type
-- ----------------------------
INSERT INTO `thinkox_historical_type` VALUES ('1', '秦朝', '1403859500', '1473595942', '1', '0', '0', '0');
INSERT INTO `thinkox_historical_type` VALUES ('2', '唐朝', '1403859511', '1473595953', '1', '0', '0', '0');
INSERT INTO `thinkox_historical_type` VALUES ('3', '宋朝', '1473595963', '1473595960', '1', '0', '0', '0');
INSERT INTO `thinkox_historical_type` VALUES ('4', '汉朝', '1473595976', '1473595973', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_hooks
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_hooks`;
CREATE TABLE `thinkox_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_hooks
-- ----------------------------
INSERT INTO `thinkox_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', 'ImageSlider');
INSERT INTO `thinkox_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'SuperLinks');
INSERT INTO `thinkox_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `thinkox_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'SocialComment,Attachment,Avatar');
INSERT INTO `thinkox_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `thinkox_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `thinkox_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `thinkox_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1471657753', 'EditorForAdmin');
INSERT INTO `thinkox_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,SyncLogin,Advertising,DevTeam');
INSERT INTO `thinkox_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `thinkox_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', 'Iswaf');
INSERT INTO `thinkox_hooks` VALUES ('17', 'checkin', '签到', '1', '1395371353', 'Checkin');
INSERT INTO `thinkox_hooks` VALUES ('18', 'Rank', '签到排名钩子', '1', '1395387442', 'Rank_checkin');
INSERT INTO `thinkox_hooks` VALUES ('20', 'support', '赞', '1', '1398264759', 'Support');
INSERT INTO `thinkox_hooks` VALUES ('21', 'localComment', '本地评论插件', '1', '1399440321', 'LocalComment');
INSERT INTO `thinkox_hooks` VALUES ('22', 'weiboType', '微博类型', '1', '1409121894', 'InsertImage');
INSERT INTO `thinkox_hooks` VALUES ('23', 'repost', '转发钩子', '1', '1403668286', 'Repost');
INSERT INTO `thinkox_hooks` VALUES ('24', 'syncLogin', '第三方登陆位置', '1', '1403700579', 'SyncLogin');
INSERT INTO `thinkox_hooks` VALUES ('25', 'syncMeta', '第三方登陆meta接口', '1', '1403700633', 'SyncLogin');
INSERT INTO `thinkox_hooks` VALUES ('26', 'J_China_City', '每个系统都需要的一个中国省市区三级联动插件。', '1', '1403841931', 'ChinaCity');
INSERT INTO `thinkox_hooks` VALUES ('27', 'Advs', '广告位插件', '1', '1406687667', 'Advs');
INSERT INTO `thinkox_hooks` VALUES ('28', 'imageSlider', '图片轮播钩子', '1', '1407144022', 'ImageSlider');
INSERT INTO `thinkox_hooks` VALUES ('29', 'friendLink', '友情链接插件', '1', '1407156413', 'SuperLinks');
INSERT INTO `thinkox_hooks` VALUES ('30', 'beforeSendWeibo', '在发微博之前预处理微博', '2', '1408084504', 'InsertFile');
INSERT INTO `thinkox_hooks` VALUES ('31', 'beforeSendRepost', '转发微博前的预处理钩子', '2', '1408085689', '');
INSERT INTO `thinkox_hooks` VALUES ('32', 'parseWeiboContent', '解析微博内容钩子', '2', '1409121261', '');
INSERT INTO `thinkox_hooks` VALUES ('33', 'userConfig', '用户配置页面钩子', '1', '1417137557', 'SyncLogin');
INSERT INTO `thinkox_hooks` VALUES ('34', 'weiboSide', '微博侧边钩子', '1', '1417063425', 'Retopic');
INSERT INTO `thinkox_hooks` VALUES ('35', 'personalMenus', '顶部导航栏个人下拉菜单', '1', '1417146501', '');
INSERT INTO `thinkox_hooks` VALUES ('36', 'dealPicture', '上传图片处理', '2', '1417139975', '');
INSERT INTO `thinkox_hooks` VALUES ('37', 'ucenterSideMenu', '用户中心左侧菜单', '1', '1417161205', '');
INSERT INTO `thinkox_hooks` VALUES ('39', 'single', '单页面专门用的钩子', '1', '1470040188', 'JqQrcode');
INSERT INTO `thinkox_hooks` VALUES ('38', 'checkinModule', '会议与活动挂载的签到插件', '1', '1470040123', 'CheckinModule,JqQrcode');
INSERT INTO `thinkox_hooks` VALUES ('41', 'moduleUpload', '自建模型上传附件钩子', '1', '1471597166', 'UploadFiles');
INSERT INTO `thinkox_hooks` VALUES ('42', 'weiyuanAvatar', '委员头像', '1', '1473055278', 'Avatar');

-- ----------------------------
-- Table structure for thinkox_issue
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_issue`;
CREATE TABLE `thinkox_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_issue
-- ----------------------------
INSERT INTO `thinkox_issue` VALUES ('13', '默认一级', '1409712474', '1409712467', '1', '0', '0', '0');
INSERT INTO `thinkox_issue` VALUES ('14', '默认二级', '1409712480', '1409712475', '1', '0', '13', '0');

-- ----------------------------
-- Table structure for thinkox_issue_content
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_issue_content`;
CREATE TABLE `thinkox_issue_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `view_count` int(11) NOT NULL COMMENT '阅读数量',
  `cover_id` int(11) NOT NULL COMMENT '封面图片id',
  `issue_id` int(11) NOT NULL COMMENT '所在专辑',
  `uid` int(11) NOT NULL COMMENT '发布者id',
  `reply_count` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(11) NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='专辑内容表';

-- ----------------------------
-- Records of thinkox_issue_content
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_local_comment
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_local_comment`;
CREATE TABLE `thinkox_local_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `app` text NOT NULL,
  `mod` text NOT NULL,
  `row_id` int(11) NOT NULL,
  `parse` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `create_time` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_local_comment
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_meet
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet`;
CREATE TABLE `thinkox_meet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发起人',
  `title` varchar(255) NOT NULL COMMENT '活动名称',
  `explain` text NOT NULL COMMENT '详细内容',
  `sTime` int(11) NOT NULL COMMENT '活动开始时间',
  `eTime` int(11) NOT NULL COMMENT '活动结束时间',
  `address` varchar(255) NOT NULL COMMENT '活动地点',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `limitCount` int(11) NOT NULL COMMENT '限制人数',
  `cover_id` int(11) NOT NULL COMMENT '封面ID',
  `attentionCount` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `view_count` int(11) NOT NULL,
  `reply_count` int(11) NOT NULL,
  `meet_type` varchar(20) NOT NULL,
  `signCount` int(11) NOT NULL,
  `is_recommend` tinyint(4) NOT NULL,
  `people` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet
-- ----------------------------
INSERT INTO `thinkox_meet` VALUES ('17', '1', '会议', '18111111', '1473609600', '1473696000', '18111', '1473678929', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59');
INSERT INTO `thinkox_meet` VALUES ('18', '1', '会议', '2222', '1473609600', '1473696000', '222', '1473679655', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59,71,98,60,61,97');
INSERT INTO `thinkox_meet` VALUES ('20', '1', '会议', '1111', '1473696000', '1473782400', '火凤凰', '1473737384', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59');
INSERT INTO `thinkox_meet` VALUES ('21', '1', '22', '3333', '1473696000', '1473782400', '333', '1473737646', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59');
INSERT INTO `thinkox_meet` VALUES ('15', '1', '全体大会', '中秋前大会', '1473609600', '1473696000', '181', '1473670378', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '98');
INSERT INTO `thinkox_meet` VALUES ('13', '1', '国家会议', '湖北省武汉市湖北省武汉市湖北省武汉市湖北省武汉市湖北省武汉市湖北省武汉市湖北省武汉市', '1473436800', '1475251200', '湖北省武汉市', '1473577155', '0', '0', '0', '0', '0', '0', '0', '常委会', '0', '0', '59,71,60,61,96,79,81,86,95');
INSERT INTO `thinkox_meet` VALUES ('14', '1', '测试通知', '关于测试通知', '1473609600', '1473696000', '181', '1473665389', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59,71,60,61,97');
INSERT INTO `thinkox_meet` VALUES ('22', '1', '最新测试会议人员进不去', '最新测试会议人员进不去', '1473955200', '1474560000', '最新测试会议人员进不去', '1473750829', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59,71,98,60,61,97');
INSERT INTO `thinkox_meet` VALUES ('23', '1', 't2', '3333', '1473696000', '1473782400', '1111', '1473754595', '0', '0', '0', '0', '0', '0', '0', '全会', '0', '0', '59');

-- ----------------------------
-- Table structure for thinkox_meet_attend
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet_attend`;
CREATE TABLE `thinkox_meet_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `meet_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0为报名，1为参加',
  `whytext` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet_attend
-- ----------------------------
INSERT INTO `thinkox_meet_attend` VALUES ('1', '98', '15', '陈三', '', '1473670227', '2', '有事');
INSERT INTO `thinkox_meet_attend` VALUES ('6', '59', '23', '委员1', '13886199168', '1473754657', '1', null);
INSERT INTO `thinkox_meet_attend` VALUES ('5', '1', '22', '郝智理', '15871430887', '1473751059', '2', '又是去咯哈');

-- ----------------------------
-- Table structure for thinkox_meet_marknum
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet_marknum`;
CREATE TABLE `thinkox_meet_marknum` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `truename` varchar(20) DEFAULT NULL,
  `meet_id` int(20) unsigned NOT NULL,
  `mark_sort` tinyint(2) unsigned NOT NULL,
  `mark_time` int(11) unsigned NOT NULL,
  `mark_attr` varchar(20) NOT NULL,
  `status` tinyint(1) unsigned DEFAULT NULL,
  `company` varchar(20) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet_marknum
-- ----------------------------
INSERT INTO `thinkox_meet_marknum` VALUES ('1', '59', '委员1', '11', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('2', '71', '委员1', '11', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('3', '60', '委员2', '11', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('4', '61', '委员3', '11', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('5', '59', '委员1', '12', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('6', '71', '委员1', '12', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('7', '60', '委员2', '12', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('8', '61', '委员3', '12', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('9', '59', '委员1', '13', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('10', '71', '委员dd', '13', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('11', '60', '委员2', '13', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('12', '61', '委员3', '13', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('18', '59', '委员1', '14', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('19', '71', '委员dd', '14', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('20', '60', '委员2', '14', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('21', '61', '委员3', '14', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('22', '97', '严三', '14', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_meet_marknum` VALUES ('23', '98', '陈三', '15', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('24', '98', '陈三', '0', '27', '1473670147', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('25', '98', '陈三', '0', '27', '1473670152', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('26', '98', '陈三', '0', '27', '1473670154', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('27', '98', '陈三', '0', '27', '1473670157', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('28', '98', '陈三', '0', '27', '1473670258', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('29', '98', '陈三', '0', '27', '1473670296', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('30', '98', '陈三', '0', '27', '1473670329', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('31', '98', '陈三', '15', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('32', '98', '陈三', '0', '27', '1473670367', '', '1', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('33', '98', '陈三', '15', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('34', '59', '委员1', '16', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('35', '71', '委员dd', '16', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('36', '98', '陈三', '16', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('37', '60', '委员2', '16', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('38', '61', '委员3', '16', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('39', '97', '严三', '16', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_meet_marknum` VALUES ('45', '1', '郝智理', '16', '1', '1473676731', '', '1', '国务院', '15871430887');
INSERT INTO `thinkox_meet_marknum` VALUES ('46', '59', '委员1', '17', '1', '1473679468', '', '1', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('47', '59', '委员1', '18', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('48', '71', '委员dd', '18', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('49', '98', '陈三', '18', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('50', '60', '委员2', '18', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('51', '61', '委员3', '18', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('52', '97', '严三', '18', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_meet_marknum` VALUES ('53', '59', '委员1', '19', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('54', '71', '委员dd', '19', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('55', '98', '陈三', '19', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('56', '60', '委员2', '19', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('57', '61', '委员3', '19', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('58', '97', '严三', '19', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_meet_marknum` VALUES ('59', '59', '委员1', '20', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('60', '59', '委员1', '20', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('61', '59', '委员1', '21', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('62', '59', '委员1', '22', '1', '0', '', '0', '总工会', '13886199168');
INSERT INTO `thinkox_meet_marknum` VALUES ('63', '71', '委员dd', '22', '1', '0', '', '0', '火凤凰', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('64', '98', '陈三', '22', '1', '0', '', '0', '总工会', '15629156212');
INSERT INTO `thinkox_meet_marknum` VALUES ('65', '60', '委员2', '22', '1', '0', '', '0', '发展科技有限公司', '18694076198');
INSERT INTO `thinkox_meet_marknum` VALUES ('66', '61', '委员3', '22', '1', '0', '', '0', '科贸公司', '13407134819');
INSERT INTO `thinkox_meet_marknum` VALUES ('67', '97', '严三', '22', '1', '0', '', '0', '总工会', '18696492998');
INSERT INTO `thinkox_meet_marknum` VALUES ('68', '59', '委员1', '23', '1', '1473754735', '', '1', '总工会', '13886199168');

-- ----------------------------
-- Table structure for thinkox_meet_markset
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet_markset`;
CREATE TABLE `thinkox_meet_markset` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meet_id` int(10) unsigned NOT NULL,
  `mark_sort` tinyint(2) unsigned NOT NULL,
  `mark_time` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet_markset
-- ----------------------------
INSERT INTO `thinkox_meet_markset` VALUES ('1', '11', '1', '1473523200');
INSERT INTO `thinkox_meet_markset` VALUES ('2', '12', '1', '1473091200');
INSERT INTO `thinkox_meet_markset` VALUES ('3', '13', '1', '1473350400');
INSERT INTO `thinkox_meet_markset` VALUES ('4', '14', '1', '1473696000');
INSERT INTO `thinkox_meet_markset` VALUES ('5', '15', '1', '1473523200');
INSERT INTO `thinkox_meet_markset` VALUES ('6', '16', '1', '1473264000');
INSERT INTO `thinkox_meet_markset` VALUES ('7', '17', '1', '1473609600');
INSERT INTO `thinkox_meet_markset` VALUES ('8', '18', '1', '1473523200');
INSERT INTO `thinkox_meet_markset` VALUES ('9', '19', '1', '1473523200');
INSERT INTO `thinkox_meet_markset` VALUES ('10', '20', '1', '1473868800');
INSERT INTO `thinkox_meet_markset` VALUES ('11', '21', '1', '1473696000');
INSERT INTO `thinkox_meet_markset` VALUES ('12', '22', '1', '1473955200');
INSERT INTO `thinkox_meet_markset` VALUES ('13', '23', '1', '1473696000');

-- ----------------------------
-- Table structure for thinkox_meet_markuser
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet_markuser`;
CREATE TABLE `thinkox_meet_markuser` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `event_id` int(10) unsigned NOT NULL,
  `marknum` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet_markuser
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_meet_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_meet_type`;
CREATE TABLE `thinkox_meet_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_meet_type
-- ----------------------------
INSERT INTO `thinkox_meet_type` VALUES ('1', '全会', '1403859500', '1469694553', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('2', '常委会', '1403859511', '1469694568', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('3', '主席会', '1469695238', '1469695235', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('4', '临时会', '1469695246', '1469695239', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('5', '专题协商会', '1469695250', '1469695247', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('6', '对口协商会', '1469695255', '1469695252', '1', '0', '0', '0');
INSERT INTO `thinkox_meet_type` VALUES ('7', '部门协商会', '1469695259', '1469695256', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_member
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_member`;
CREATE TABLE `thinkox_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `signature` text NOT NULL,
  `tox_money` int(11) NOT NULL,
  `pos_province` int(11) NOT NULL,
  `pos_city` int(11) NOT NULL,
  `pos_district` int(11) NOT NULL,
  `pos_community` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `status` (`status`),
  KEY `name` (`nickname`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of thinkox_member
-- ----------------------------
INSERT INTO `thinkox_member` VALUES ('1', 'admin', '0', '0000-00-00', '', '10', '32', '0', '1473307054', '2002830702', '1473744067', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('74', 'dominator88', '0', '0000-00-00', '', '0', '0', '2002830702', '1473473641', '0', '0', '-1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('59', 'wyy1', '0', '0000-00-00', '', '238', '75', '2002945241', '1473320049', '2002830702', '1473760924', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('60', 'wyy2', '0', '0000-00-00', '', '48', '8', '2002945241', '1473320081', '1035423177', '1473752199', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('61', 'wyy3', '0', '0000-00-00', '', '18', '1', '2002945241', '1473320099', '2002830702', '1473489786', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('62', 'jt1', '0', '0000-00-00', '', '36', '6', '2002945241', '1473320126', '2002830702', '1473516136', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('63', 'jt2', '0', '0000-00-00', '', '0', '0', '2002945241', '1473320142', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('64', 'taw', '0', '0000-00-00', '', '20', '26', '2002945241', '1473320167', '3707332670', '1473734029', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('65', 'dcs', '0', '0000-00-00', '', '20', '24', '2002945241', '1473320189', '2002830702', '1473648546', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('66', 'bldw1', '0', '0000-00-00', '', '30', '22', '2002945241', '1473320226', '2002830702', '1473738396', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('67', 'bldw2', '0', '0000-00-00', '', '30', '16', '2002945241', '1473320247', '2002830702', '1473738382', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('68', 'bldw3', '0', '0000-00-00', '', '20', '12', '2002945241', '1473320266', '2002830702', '1473647947', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('69', 'zxbgs', '0', '0000-00-00', '', '20', '23', '2002945241', '1473338138', '2002830702', '1473745113', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('70', 'bgszr', '0', '0000-00-00', '', '120', '15', '2002945241', '1473338265', '2002830702', '1473745092', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('71', '12aaa', '0', '0000-00-00', '', '62', '0', '2002830702', '1473414695', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('76', 'dominator82', '0', '0000-00-00', '', '0', '0', '2002830702', '1473474867', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('77', 'dominator85', '0', '0000-00-00', '', '0', '0', '2002830702', '1473474908', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('78', 'feiliao221', '0', '0000-00-00', '', '0', '0', '2002830702', '1473474952', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('79', 'fdsafas', '0', '0000-00-00', '', '0', '0', '2002830702', '1473475098', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('80', '3432432aa', '0', '0000-00-00', '', '0', '0', '2002830702', '1473475196', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('81', 'feixia', '0', '0000-00-00', '', '0', '0', '2002830702', '1473475374', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('82', 'dadada', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477299', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('83', 'feiren', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477382', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('84', 'feiren111', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477404', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('85', 'rrrrrrr999', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477529', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('86', 'tttttt111', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477703', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('87', 'feewew332', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477742', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('88', 'feewew33233', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477764', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('89', 'feewew3333233', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477794', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('90', '32432234sss', '0', '0000-00-00', '', '0', '0', '2002830702', '1473477842', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('91', 'fdsaf33', '0', '0000-00-00', '', '0', '0', '2002830702', '1473478030', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('92', 'fdsaf33', '0', '0000-00-00', '', '0', '0', '2002830702', '1473478030', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('93', 'fdsaf33333', '0', '0000-00-00', '', '0', '0', '2002830702', '1473478205', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('94', 'fdsaf3333322', '0', '0000-00-00', '', '0', '0', '2002830702', '1473478937', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('95', '23423aaa', '0', '0000-00-00', '', '0', '0', '2002830702', '1473479229', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('96', 'dominator', '0', '0000-00-00', '', '10', '13', '2002830702', '1473479297', '2002830702', '1473736440', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('97', '18696492998', '0', '0000-00-00', '', '0', '0', '2002830702', '1473665128', '0', '0', '1', '', '0', '0', '0', '0', '0');
INSERT INTO `thinkox_member` VALUES ('98', '15629156212', '0', '0000-00-00', '', '0', '0', '2002830702', '1473669019', '0', '0', '1', '', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_menu
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_menu`;
CREATE TABLE `thinkox_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=2459 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_menu
-- ----------------------------
INSERT INTO `thinkox_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2', '资讯', '0', '1111', 'Article/mydocument', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `thinkox_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `thinkox_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('16', '用户', '0', '3', 'User/index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('17', '用户信息', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `thinkox_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `thinkox_menu` VALUES ('19', '用户行为', '68', '0', 'User/action', '0', '', '行为管理', '0');
INSERT INTO `thinkox_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `thinkox_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `thinkox_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `thinkox_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `thinkox_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `thinkox_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `thinkox_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `thinkox_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `thinkox_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `thinkox_menu` VALUES ('43', '扩展', '0', '998', 'Addons/index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `thinkox_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `thinkox_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `thinkox_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `thinkox_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `thinkox_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `thinkox_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `thinkox_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `thinkox_menu` VALUES ('58', '模型管理', '2', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `thinkox_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('68', '系统', '0', '9999', 'Config/group', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `thinkox_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `thinkox_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `thinkox_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `thinkox_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('80', '分类管理', '2', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `thinkox_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `thinkox_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `thinkox_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `thinkox_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `thinkox_menu` VALUES ('86', '备份数据库', '68', '20', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `thinkox_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `thinkox_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `thinkox_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `thinkox_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `thinkox_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `thinkox_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `thinkox_menu` VALUES ('93', '其他', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `thinkox_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('106', '行为日志', '68', '0', 'Action/actionlog', '0', '', '行为管理', '0');
INSERT INTO `thinkox_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2388', '微博设置', '2381', '0', 'Weibo/config', '0', '微博的基本配置', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('2457', '设置分类状态', '2444', '0', 'Forum/setTypeStatus', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2456', '新增/编辑分类', '2444', '0', 'Forum/addType', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2455', '论坛设置', '2444', '10', 'Forum/config', '0', '', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('130', '新增、编辑', '132', '0', 'SEO/editRule', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('131', '排序', '132', '0', 'SEO/sortRule', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('132', '规则管理', '68', '0', 'SEO/index', '1', '', 'SEO规则', '0');
INSERT INTO `thinkox_menu` VALUES ('133', '回复管理', '122', '5', '/Admin/Forum/reply', '0', '', '回复', '0');
INSERT INTO `thinkox_menu` VALUES ('2454', '回复管理', '2444', '6', 'Forum/reply', '0', '', '回复', '0');
INSERT INTO `thinkox_menu` VALUES ('2453', '回复回收站', '2444', '6', 'Forum/replyTrash', '0', '', '回复', '0');
INSERT INTO `thinkox_menu` VALUES ('2452', '帖子回收站', '2444', '4', 'Forum/postTrash', '0', '', '帖子', '0');
INSERT INTO `thinkox_menu` VALUES ('2451', '板块回收站', '2444', '2', 'Forum/forumTrash', '0', '', '板块', '0');
INSERT INTO `thinkox_menu` VALUES ('2450', '新增/编辑回复', '2444', '0', 'Forum/editReply', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2386', '微博回收站', '2381', '2', 'Weibo/weiboTrash', '0', '', '微博', '0');
INSERT INTO `thinkox_menu` VALUES ('146', '规则回收站', '68', '0', 'SEO/ruleTrash', '1', '', 'SEO规则', '0');
INSERT INTO `thinkox_menu` VALUES ('147', '头衔列表', '16', '10', 'Rank/index', '0', '', '头衔管理', '0');
INSERT INTO `thinkox_menu` VALUES ('149', '添加头衔', '16', '2', 'Rank/editRank', '0', '', '头衔管理', '0');
INSERT INTO `thinkox_menu` VALUES ('150', '查看用户', '16', '0', 'Rank/userList', '0', '', '头衔管理', '0');
INSERT INTO `thinkox_menu` VALUES ('151', '用户头衔列表', '150', '0', 'Rank/userRankList', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('152', '关联新头衔', '150', '0', 'Rank/userAddRank', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('153', '编辑头衔关联', '150', '0', 'Rank/userChangeRank', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2353', '内容管理', '2351', '1', 'Proposal/proposal', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2352', '提案交办分类管理', '2351', '0', 'ProposalType/index', '0', '', '提案交办分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2351', '提案交办', '0', '23', 'ProposalType/Index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2350', '内容回收站', '2345', '1', 'Survey/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('162', '扩展资料', '16', '0', 'Admin/User/profile', '0', '', '用户管理', '0');
INSERT INTO `thinkox_menu` VALUES ('163', '添加、编辑分组', '162', '0', 'Admin/User/editProfile', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('164', '分组排序', '162', '0', 'Admin/User/sortProfile', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('165', '字段列表', '162', '0', 'Admin/User/field', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('166', '添加、编辑字段', '165', '0', 'Admin/User/editFieldSetting', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('167', '字段排序', '165', '0', 'Admin/User/sortField', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('168', '全部补丁', '68', '0', 'Admin/Update/quick', '1', '', '升级补丁', '0');
INSERT INTO `thinkox_menu` VALUES ('169', '新增补丁', '68', '0', 'Admin/Update/addpack', '1', '', '升级补丁', '0');
INSERT INTO `thinkox_menu` VALUES ('170', '委员列表', '16', '0', 'Admin/User/expandinfo_select', '0', '', '用户管理', '0');
INSERT INTO `thinkox_menu` VALUES ('171', '扩展资料详情', '170', '0', 'User/expandinfo_details', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('188', '活动', '0', '21', 'EventType/index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('189', '活动分类管理', '188', '0', 'EventType/index', '0', '', '活动分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('190', '内容管理', '188', '0', 'Event/event', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('191', '活动分类回收站', '188', '0', 'EventType/eventTypeTrash', '0', '', '活动分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('192', '内容审核', '188', '0', 'Event/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('193', '内容回收站', '188', '0', 'Event/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('216', '待审核用户头衔', '16', '0', 'Rank/rankVerify', '0', '', '头衔管理', '0');
INSERT INTO `thinkox_menu` VALUES ('217', '被驳回的头衔申请', '16', '0', 'Rank/rankVerifyFailure', '0', '', '头衔管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2387', '回复回收站', '2381', '4', 'Weibo/commentTrash', '0', '', '回复', '0');
INSERT INTO `thinkox_menu` VALUES ('2449', '排序', '2444', '0', 'Forum/sortForum', '0', '', '板块', '0');
INSERT INTO `thinkox_menu` VALUES ('221', '活动设置', '188', '0', 'Event/config', '0', '', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('222', '基础设置', '16', '0', 'User/config', '0', '', '用户管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2385', '编辑回复', '2381', '0', 'Weibo/editComment', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2383', '回复管理', '2381', '3', 'Weibo/comment', '0', '', '回复', '0');
INSERT INTO `thinkox_menu` VALUES ('2384', '编辑微博', '2381', '0', 'Weibo/editWeibo', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2382', '微博管理', '2381', '1', 'Weibo/weibo', '0', '', '微博', '0');
INSERT INTO `thinkox_menu` VALUES ('2381', '微博', '0', '999', 'Weibo/weibo', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2276', '会议设置', '2269', '0', 'Meet/config', '0', '', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('2275', '内容回收站', '2269', '1', 'Meet/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2274', '内容审核', '2269', '1', 'Meet/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2273', '会议分类回收站', '2269', '0', 'MeetType/meetTypeTrash', '0', '', '活动分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2272', '内容管理', '2269', '1', 'Meet/meet', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2271', '会议分类管理', '2269', '0', 'MeetType/index', '0', '', '活动分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2269', '会议管理', '0', '23', 'MeetType/Index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2235', '模块管理', '43', '0', 'module/lists', '0', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2236', '卸载模块', '43', '0', 'module/uninstall', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2237', '模块安装', '43', '0', 'module/install', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2238', '新增权限节点', '27', '0', 'AuthManager/addNode', '1', '', '', '1');
INSERT INTO `thinkox_menu` VALUES ('2239', '前台权限管理', '27', '0', 'AuthManager/accessUser', '1', '', '权限管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2240', '转移用户组', '16', '0', 'User/changeGroup', '1', '批量转移用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2241', '删除权限节点', '27', '0', 'AuthManager/deleteNode', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2443', '新增表情包', '68', '0', 'adimn/expression/add', '1', '', '表情配置', '0');
INSERT INTO `thinkox_menu` VALUES ('2442', '表情列表', '68', '0', 'admin/expression/expressionList', '1', '', '表情配置', '0');
INSERT INTO `thinkox_menu` VALUES ('2441', '表情管理', '68', '30', 'admin/expression/index', '0', '', '表情配置', '0');
INSERT INTO `thinkox_menu` VALUES ('2448', '编辑帖子', '2444', '0', 'Forum/editPost', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2447', '编辑／创建板块', '2444', '0', 'Forum/editForum', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2446', '帖子管理', '2444', '3', 'Forum/post', '0', '', '帖子', '0');
INSERT INTO `thinkox_menu` VALUES ('2445', '板块管理', '2444', '1', 'Forum/forum', '0', '', '板块', '0');
INSERT INTO `thinkox_menu` VALUES ('2444', '论坛', '0', '22', 'Forum/index', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2354', '提案交办分类回收站', '2351', '0', 'ProposalType/proposalTypeTrash', '0', '', '提案交办分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2349', '内容审核', '2345', '1', 'Survey/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2348', '调研报告分类回收站', '2345', '0', 'SurveyType/surveyTypeTrash', '0', '', '调研报告分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2347', '内容管理', '2345', '1', 'Survey/survey', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2346', '调研报告分类管理', '2345', '0', 'SurveyType/index', '0', '', '调研报告分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2345', '调研报告', '0', '23', 'SurveyType/Index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2339', '内容回收站', '2334', '1', 'Polls/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2338', '内容审核', '2334', '1', 'Polls/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2337', '社情民意分类回收站', '2334', '0', 'PollsType/pollsTypeTrash', '0', '', '社情民意分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2336', '内容管理', '2334', '1', 'Polls/polls', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2335', '社情民意分类管理', '2334', '0', 'PollsType/index', '0', '', '社情民意分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2334', '社情民意', '0', '23', 'PollsType/Index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2333', '社情民意设置', '2234', '2', 'Polls/config', '0', '', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('2329', '公示公告', '0', '2', 'Announce/lists', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2330', '内容管理', '2329', '0', 'Announce/lists', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2332', '公告回收站', '2329', '0', 'Announce/trash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2355', '内容审核', '2351', '1', 'Proposal/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2356', '内容回收站', '2351', '1', 'Proposal/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2357', '文史资料', '0', '23', 'HistoricalType/Index', '0', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2358', '文史资料设置', '2357', '2', 'Historical/config', '0', '', '设置', '0');
INSERT INTO `thinkox_menu` VALUES ('2359', '文史资料分类管理', '2357', '0', 'HistoricalType/index', '0', '', '文史资料分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2360', '内容管理', '2357', '1', 'Historical/historical', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2361', '文史资料分类回收站', '2357', '0', 'HistoricalType/historicalTypeTrash', '0', '', '文史资料分类管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2362', '内容审核', '2357', '1', 'Historical/verify', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2363', '内容回收站', '2357', '1', 'Historical/contentTrash', '0', '', '内容管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2415', '删除权限节点', '27', '0', 'AuthManager/deleteNode', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2414', '转移用户组', '16', '0', 'User/changeGroup', '1', '批量转移用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2413', '前台权限管理', '27', '0', 'AuthManager/accessUser', '1', '', '权限管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2412', '新增权限节点', '27', '0', 'AuthManager/addNode', '1', '', '', '1');
INSERT INTO `thinkox_menu` VALUES ('2411', '模块安装', '43', '0', 'module/install', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2410', '卸载模块', '43', '0', 'module/uninstall', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2435', '卸载模块', '43', '0', 'module/uninstall', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2436', '模块安装', '43', '0', 'module/install', '1', '', '云平台', '0');
INSERT INTO `thinkox_menu` VALUES ('2437', '新增权限节点', '27', '0', 'AuthManager/addNode', '1', '', '', '1');
INSERT INTO `thinkox_menu` VALUES ('2438', '前台权限管理', '27', '0', 'AuthManager/accessUser', '1', '', '权限管理', '0');
INSERT INTO `thinkox_menu` VALUES ('2439', '转移用户组', '16', '0', 'User/changeGroup', '1', '批量转移用户组', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2440', '删除权限节点', '27', '0', 'AuthManager/deleteNode', '1', '', '', '0');
INSERT INTO `thinkox_menu` VALUES ('2458', '分类管理', '2444', '0', 'Forum/type', '0', '分类管理', '分类管理', '0');

-- ----------------------------
-- Table structure for thinkox_message
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_message`;
CREATE TABLE `thinkox_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `stime` int(11) NOT NULL,
  `type` varchar(10) NOT NULL COMMENT '公告类型',
  `people` longtext NOT NULL,
  `file` varchar(50) NOT NULL COMMENT '附件',
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=341 DEFAULT CHARSET=utf8 COMMENT='thinkox新增消息表';

-- ----------------------------
-- Records of thinkox_message
-- ----------------------------
INSERT INTO `thinkox_message` VALUES ('338', '59', '关于中秋节放假通知', '中秋节放假3天', '1473609600', '通知', '59,71,60,61,97', '', '0');
INSERT INTO `thinkox_message` VALUES ('329', '59', '关于十一放假的通知', '十一放假十天', '1472659200', '通知', '59,71,60,61', '', '0');
INSERT INTO `thinkox_message` VALUES ('337', '59', '关于组织政协委员认真开展“委员访民”活动的通知', '各位政协委员：\r\n\r\n根据开展庆祝区政协成立60周年系列活动的统一安排，区政协定于5月以“贴近群众，社区采风”为主题，以“问难”为重点内容，以政协委员各街道（开发区）联络委为单位，组织全体委员走进街道社区、走近居民群众，了解民忧民困，收集民情民意，掌握民生需求。\r\n\r\n参与“委员访民”活动情况将计入委员履职档案，请各位委员高度重视，积极参加。\r\n\r\n \r\n\r\n \r\n\r\n　　　　　　　　　　　　　　   江汉区政协办公室\r\n\r\n　　　　　　　　　　　　　　 二〇一五年五月六日\r\n', '1473609600', '通知', '59,71,60,61,97', '', '0');

-- ----------------------------
-- Table structure for thinkox_model
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_model`;
CREATE TABLE `thinkox_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of thinkox_model
-- ----------------------------
INSERT INTO `thinkox_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"33\",\"3\",\"24\",\"2\",\"5\",\"12\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1473044592', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('4', 'proposal', '提案交办', '0', '', '1', '{\"1\":[\"34\",\"35\",\"36\",\"37\",\"38\",\"39\",\"40\",\"41\",\"42\",\"43\",\"44\",\"45\",\"46\"]}', '1:基础', '', '', '', '', 'id:序号\r\ntitle:提案名称', '10', '', '', '1470387576', '1470387649', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('5', 'event', '活动', '0', '', '1', '{\"1\":[\"54\",\"55\",\"56\",\"57\",\"58\",\"59\",\"60\",\"61\",\"62\",\"63\",\"64\",\"65\",\"66\",\"67\",\"68\",\"69\",\"70\",\"71\"]}', '1:基础', '', '', '', '', 'id:序号\r\ntitle:标题', '10', '', '', '1470707529', '1470707569', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('6', 'proposal_result', '办理结果', '0', '', '1', '{\"1\":[\"86\",\"87\",\"88\",\"89\",\"90\",\"91\",\"92\",\"93\",\"94\",\"95\",\"96\",\"97\",\"98\",\"99\",\"100\"]}', '1:基础', '', '', '', '', 'id:序号\r\nuser_id:办理人Id', '10', '', '', '1471312124', '1471312209', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('7', 'polls', '社情民意', '0', '', '1', '{\"1\":[\"110\",\"112\",\"113\",\"114\",\"115\",\"116\",\"117\",\"118\",\"119\"]}', '1:基础', '', '', '', '', 'id:序号', '10', '', '', '1472813216', '1473320020', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('8', 'working', 'working', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1473320074', '1473320074', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('9', 'survey', 'survey', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1473320087', '1473320087', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('10', 'historical', '文史资料', '0', '', '1', '{\"1\":[\"136\",\"137\",\"138\",\"139\",\"140\",\"141\",\"142\"]}', '1:基础', '', '', '', '', 'id:序号', '10', '', '', '1473320161', '1473664673', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('11', 'proposal_joint', 'proposal_joint', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1473498443', '1473498443', '1', 'MyISAM');
INSERT INTO `thinkox_model` VALUES ('12', 'message', 'message', '0', '', '1', '', '1:基础', '', '', '', '', '', '10', '', '', '1473583597', '1473583597', '1', 'MyISAM');

-- ----------------------------
-- Table structure for thinkox_module
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_module`;
CREATE TABLE `thinkox_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '模块名',
  `alias` varchar(30) NOT NULL COMMENT '中文名',
  `version` varchar(20) NOT NULL COMMENT '版本号',
  `is_com` tinyint(4) NOT NULL COMMENT '是否商业版',
  `show_nav` tinyint(4) NOT NULL COMMENT '是否显示在导航栏中',
  `summary` varchar(200) NOT NULL COMMENT '简介',
  `developer` varchar(50) NOT NULL COMMENT '开发者',
  `website` varchar(200) NOT NULL COMMENT '网址',
  `entry` varchar(50) NOT NULL COMMENT '前台入口',
  `is_setup` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否已安装',
  `sort` int(11) NOT NULL COMMENT '模块排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `name_2` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='模块管理表';

-- ----------------------------
-- Records of thinkox_module
-- ----------------------------
INSERT INTO `thinkox_module` VALUES ('21', 'Blog', '资讯', '1.0.0', '0', '1', '原OneThink的内容模块，ThinkOX实现了前台界面，传统的CMS模块', '上海顶想信息科技有限公司', 'http://www.topthink.net/', 'Blog/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('22', 'Event', '活动', '1.0.0', '0', '1', '活动模块，用户可以发起活动', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Event/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('23', 'Forum', '论坛', '1.0.0', '0', '1', '论坛模块，比较简单的论坛模块', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Forum/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('24', 'Group', '群组', '1.0.0', '0', '1', '群组模块，允许用户建立自己的圈子', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Group/index/index', '0', '0');
INSERT INTO `thinkox_module` VALUES ('25', 'Home', '网站主页模块', '1.0.0', '0', '1', '首页模块，主要用于展示网站内容', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Home/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('26', 'Issue', '专辑', '1.0.0', '0', '1', '专辑模块，适用于精品内容展示', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Issue/index/index', '0', '0');
INSERT INTO `thinkox_module` VALUES ('27', 'People', '会员展示', '1.0.0', '0', '1', '会员展示模块，可以用于会员的查找', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'People/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('28', 'Shop', '积分商城', '1.0.0', '0', '1', '积分商城模块，用户可以使用积分兑换商品', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Shop/index/index', '0', '0');
INSERT INTO `thinkox_module` VALUES ('29', 'Weibo', '微博', '1.0.0', '0', '1', '微博模块，用户可以发布微博', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Weibo/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('30', 'Meet', '会议管理', '1.0.0', '0', '1', '只是会议模块', 'MR.Z', '', 'Meet/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('31', 'Announce', '公告', '1.0.0', '0', '1', '只是公告模块', 'MR.Z', '', 'Announce/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('32', 'Polls', '社情民意', '1.0.0', '0', '1', '只是社情民意模块', 'MR.Z', '', 'Polls/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('33', 'Survey', '调研报告', '1.0.0', '0', '1', '只是调研报告模块', 'MR.Z', '', 'Survey/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('34', 'Proposal', '提案交办', '1.0.0', '0', '1', '只是提案模块', 'MR.Z', '', 'Proposal/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('35', 'Historical', '文史资料', '1.0.0', '0', '1', '只是文史资料模块', 'MR.Z', '', 'Historical/index/index', '1', '0');
INSERT INTO `thinkox_module` VALUES ('36', 'Message', '消息', '1.0.0', '0', '1', '活动模块，用户可以发起活动', '嘉兴想天信息科技有限公司', 'http://www.ourstu.com', 'Event/index/index', '1', '0');

-- ----------------------------
-- Table structure for thinkox_picture
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_picture`;
CREATE TABLE `thinkox_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `type` varchar(50) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_picture
-- ----------------------------
INSERT INTO `thinkox_picture` VALUES ('110', 'local', '/Uploads/Picture/2016-08-01/579ea2da4a735.jpg', '', '4ce52b71a770a32c90d1ea6757325b64', 'd47dec8aab5bbcd1ddb9712d1c0e2f7a98f90558', '1', '1470014170');
INSERT INTO `thinkox_picture` VALUES ('111', 'local', '/Uploads/Picture/2016-08-01/579ea3d50e179.jpg', '', 'f2db6407cac7f12df2eee73ff12f4615', '2329be97c0956b48afde8a3226816463e444db0c', '1', '1470014420');
INSERT INTO `thinkox_picture` VALUES ('112', 'local', '/Uploads/Picture/2016-09-05/57ccdd55edc70.jpg', '', '9775b31ee180296c30c159896a67fc23', '5b7b19a163b5771887eb8b2a57e8fd7e7bece414', '1', '1473043797');

-- ----------------------------
-- Table structure for thinkox_polls
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_polls`;
CREATE TABLE `thinkox_polls` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `uid` int(5) NOT NULL,
  `people` varchar(30) NOT NULL COMMENT '作者ids',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `upload` varchar(50) NOT NULL COMMENT '文件',
  `adopt` varchar(50) NOT NULL COMMENT '采用情况',
  `make` varchar(80) NOT NULL COMMENT '批示情况',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `time` int(11) NOT NULL COMMENT '时间',
  `comments` text NOT NULL COMMENT '退回意见',
  `type_id` varchar(255) NOT NULL COMMENT '类型',
  `people_view` text NOT NULL COMMENT '参与人员展示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_polls
-- ----------------------------
INSERT INTO `thinkox_polls` VALUES ('85', '0', '234234', '324234', '324234', '', '3', '2,3,4', '4', '2147483647', '地奇巧霜期霜期fda', '', '');
INSERT INTO `thinkox_polls` VALUES ('84', '0', '孙赞', '中午出去吃饭', '1233123', '', '', '', '4', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('83', '0', '孙赞', '中午出去吃饭', ' 登录人甲    作者甲     ？？？ ', 'C:\\fakepath\\cc.php', '', '', '3', '0', '234234', '', '');
INSERT INTO `thinkox_polls` VALUES ('82', '0', '234234', '234', '234234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('81', '0', '324234', '23423', '234234', '', '', '', '0', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('80', '0', '324234', '234234', '242343', '', '', '', '3', '0', '342423', '', '');
INSERT INTO `thinkox_polls` VALUES ('78', '0', '234', '324', '423', '', '', '', '0', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('77', '0', '2213', '324234', '234234324', '', '', '', '0', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('86', '0', '234234', '146546549877987987979749456456445', '324234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('87', '0', '234234', '2', '324234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('88', '0', '234234', '3', '324234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('89', '0', '234234', '4', '324234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('90', '0', '234234', '5', '324234', '', '', '', '1', '2147483647', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('91', '0', '', '政协委员呼吁叫停西北湖地下人防商城项目建设的建议 ', '     近期，江汉区政协部分委员了解到西北湖地下将建设人防商城工程，对此深感诧异和不解，一致认为该项目性质定位与武汉城市总体规划及江汉区建设武汉现代服务业中心区的发展战略不符，区政协委员呼吁，不要在西北湖地下修建该工程。\n\n　　其依据理由如下：\n\n　　第一，西北湖地下商城将对西北湖水生态环境造成严重破坏。地下商城的形成将阻隔湖泊地表水与地下水的交流，湖泊底质将会改变，水体一些生物的生境、生存和发展的条件会受到破坏，原有生态系统的结构和\n\n　　功能将会发生很大改变。由于湖泊原有生物的组成和结构发生变化，湖泊自然形成的食物链网受到破坏，将会削弱有机质、营养盐等迁移、转化和输出的途径和量，削弱湖泊的自净能力，加剧一些污染质在湖中积聚的生态阻滞，加速与加重湖水的污染。同时对于湖泊底泥回填的厚度与回填的土壤质地、土壤污染状况、后期需要恢复的水生生物种类之间的关系，因为缺乏类似工程实例而无法确定，湖泊生态重建方面的相关研究目前开展不足。\n\n　　第二，西北湖地下商城与西北湖的区域定位不相符。西北湖地区是湖北及武汉的金融中心、商务中心、信息中心、资源配置中心和立体交通枢纽，是武汉现代服务业中心区的核心构架，是武汉乃至整个湖北的“金十字”地区。武汉200米以上的超高建筑大多集中在该区域；湖北5家外资银行及武汉地区大部分市级以上银行总部、5家全国性金融总部及省内最大的证券、信托、期货公司总部均设在该区域。西北湖地区下一步将依托于整个江汉地区及王家墩商务区，基本形成面向武汉城市圈、服务中部地区的区域性服务业中心，服务业的集聚辐射能力和综合服务功能整体提升，初步构建武汉城市圈及中部地区金融、现代物流、企业总部、会展服务、都市时尚、中介服务中心框架，成为支撑武汉城市圈“两型”社会综改区建设的重要载体，成为引领中部地区产业结构优化升级和经济发展方式加快转变的样板区域，成为全国服务业发展的典范。而西北湖地下商城与该区域的整体定位严重不相符，建成后的成本回收以及经营收益预计将不够理想。比较于江汉区内与其定位相似的友谊南路“地一大道”商城，其目前的商业信用不良，生意十分萧条，且后期管理严重缺乏，目前已处于无经营的状况，因此建议西北湖地区不可重蹈友谊南路“地一大道”商城的覆辙。\n\n　　第三，西北湖地下商城的建设将对该地区的景观环境造成严重破坏。目前该地段已经形成了西北湖公园，整体绿化与景观已经实施到位，成为了该地区市民健身、休闲、娱乐的绝佳场所，深受广大市民的喜爱。作为武汉中心城区“寸土寸金”的商务核心地带，能够有如此宽阔的亲水景观绿地实属不易。西北湖地下商城的建成必将对该公园的景观环境产生严重破坏，数十个地下出入口及排气孔将有损自然风光的整体性，也将对市民们健身、休闲、娱乐带来极大不便。\n\n　　第四，西北湖地下商城的建设会增加西北湖区域的交通压力。西北湖所在的汉口建设大道与新华路交汇处是武汉传统的交通拥堵区域之一，包括其周边的常青路至发展大道段、姑嫂树路至发展大道段、唐家墩路口、建设大道香港路口至新华路口等区域交通拥堵情况同样十分严重。西北湖地下商城的建设必然会增加该地区的车流量和人流量，导致车辆向周边其他拥堵区域严重淤积，形成连环性堵塞效应，不仅严重干扰该地块的正常通行，也会对整个区域的交通秩序造成不利影响。目前武汉正处于地铁全面开建，主干道大量维修，城市建设此起彼伏，私家车拥有量呈几何增长的城市交通“阵痛期”，应尽量避免对交通环境所产生的进一步不利影响。\n\n　　第五，西北湖地下商城的建设不适应两型社会的需要。西北湖地下商城属于高碳、高能耗项目，不利于节能减排，同时其产生的环境噪音以及消防隐患也将对周边居民的生活带来不利影响。\n\n　　为此，区政协委员呼吁和建议：1、由规划部门对该区域给予详规的论证，禁止对西北湖地下人防商城的建设。2、加大对西北湖现有水体的修复及周边环境亮化等整体综合性改造。3、为了解决建设银行、锦江饭店及周边停车难的问题，在不破坏西北湖现有湖面的前提下，可在西北湖以东的南北角利用已拆除的原人防办公大楼空地及绿化用地的地下空间修建2～3层地下停车泊位约500～600个，为发展“金十字”金融商贸集聚核心区和建设现代服务业综合配套改革试点区提供良好环境。\n', '', '', '', '4', '0', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('92', '0', '', '222', '66666', '', '', '', '4', '0', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('93', '0', '委员1', '435', '3454', '', '', '', '0', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('94', '0', '委员1', '45', '345345', '', '', '', '2', '0', '', '2', '');
INSERT INTO `thinkox_polls` VALUES ('95', '0', '59,71,98,60,61,97,96,79,81,86,', 'hhh333333444444', '<p>jkkkkk</p>', '', '2,3,4', '2,4', '6', '0', '', '2', '(提案委)委员1,委员dd,陈三,(经科委)委员2,(文史委)委员3,严三,(常委会成员),委员1,委员2,,委员3,委员dd,,,,,陈三,严三,');
INSERT INTO `thinkox_polls` VALUES ('96', '0', '', 'qqqq', '<p>errtrrtr</p>', '', '2,3', '2,4', '4', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('97', '0', '', ' dfsa fdsa dfsaf as', '<p>3d dfsaf dsa f sad fdsaf&nbsp;</p>', '', '2', '3', '3', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('98', '0', '', 'test001', '<p>dsaf sdaf sdaf dsaf sa&nbsp;</p>', '', '2', '2', '5', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('99', '0', '', 'test008588', '<p>fsa dsaf sa dfsaf sadf sda faf das&nbsp;</p>', '', '3,4', '2,4', '6', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('100', '0', '', 'fd safa ff dsa fsda sda fdsa', '<p>&nbsp;fdsakj fdklsa jfdskla jdklsa fjkldasj klsfajkl jdafsl</p>', '', '3', '3', '5', '0', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('101', '0', '', 'test2', '<p>2222</p>', '', '', '', '1', '1473728839', '', '1', '');
INSERT INTO `thinkox_polls` VALUES ('102', '0', '', 'test3', '<p>22222</p>', '', '1,3,4', '1,2,4', '6', '1473729416', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('103', '0', '', 'test5', '<p>333</p>', '', '1,3', '2,4', '5', '1473729467', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('104', '59', '', 'TEST6', '<p>22222</p>', '', '', '', '4', '1473729796', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('105', '0', '', '这是我的第一个测试', '<p>test0000000000000001</p>', '', '', '', '1', '1473731025', '', '2', '');
INSERT INTO `thinkox_polls` VALUES ('106', '0', '59,71,98,60,61,97', '1111111111111111111111111111111111111', '<p>4324234324324</p>', '', '', '', '1', '1473731207', '', '2', '');
INSERT INTO `thinkox_polls` VALUES ('107', '0', '59,71,98,60,61,97', '22222222222222222222', '<p>22222222222222222222222222222</p>', '', '', '', '1', '1473731280', '', '2', '(提案委)委员1,委员dd,陈三,(经科委)委员2,(文史委)委员3,严三,');
INSERT INTO `thinkox_polls` VALUES ('108', '59', '59,71,98,60,61,97', '这是test000007', '<p>这是test000007这是test000007这是test000007这是test000007这是test000007</p>', '', '', '', '1', '1473732362', '', '2', '(提案委)委员1,委员dd,陈三,(经科委)委员2,(文史委)委员3,严三,');
INSERT INTO `thinkox_polls` VALUES ('109', '0', '', '这是test000007', '<p>这是test000007这是test000007这是test000007这是test000007这是test000007</p>', '', '', '', '2', '1473732362', '', '', '');
INSERT INTO `thinkox_polls` VALUES ('110', '59', '59,71,98,60,61,97', 'TEST63333', '<p>22222</p>', '', '', '', '1', '1473729796', '', '2', '(提案委)委员1,委员dd,陈三,(经科委)委员2,(文史委)委员3,严三,');

-- ----------------------------
-- Table structure for thinkox_polls_attend
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_polls_attend`;
CREATE TABLE `thinkox_polls_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0为报名，1为参加',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_polls_attend
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_polls_process
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_polls_process`;
CREATE TABLE `thinkox_polls_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `polls_id` int(11) NOT NULL,
  `suggest` varchar(255) DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0为报名，1为参加',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_polls_process
-- ----------------------------
INSERT INTO `thinkox_polls_process` VALUES ('1', '0', '0', '我要退回啦', '0', '0');
INSERT INTO `thinkox_polls_process` VALUES ('2', '0', '91', '再退回一个', '0', '0');
INSERT INTO `thinkox_polls_process` VALUES ('3', '69', '85', 'TTT', '0', '1');
INSERT INTO `thinkox_polls_process` VALUES ('4', '69', '84', '最后测试这个', '1473683162', '1');
INSERT INTO `thinkox_polls_process` VALUES ('5', '69', '98', 'v退回001', '0', '1');
INSERT INTO `thinkox_polls_process` VALUES ('6', '69', '97', null, '1473686391', '3');
INSERT INTO `thinkox_polls_process` VALUES ('7', '69', '97', null, '1473686439', '3');
INSERT INTO `thinkox_polls_process` VALUES ('8', '69', '97', null, '1473686537', '3');
INSERT INTO `thinkox_polls_process` VALUES ('9', '69', '96', '这是退回000001', '1473686583', '4');
INSERT INTO `thinkox_polls_process` VALUES ('10', '70', '100', '二评价会看v', '1473686708', '5');
INSERT INTO `thinkox_polls_process` VALUES ('11', '70', '99', null, '1473686765', '6');
INSERT INTO `thinkox_polls_process` VALUES ('12', '69', '103', null, '1473730237', '3');
INSERT INTO `thinkox_polls_process` VALUES ('13', '69', '104', '6666', '1473730247', '4');
INSERT INTO `thinkox_polls_process` VALUES ('14', '70', '103', '8888', '1473730429', '5');
INSERT INTO `thinkox_polls_process` VALUES ('15', '69', '102', null, '1473730489', '3');
INSERT INTO `thinkox_polls_process` VALUES ('16', '70', '102', null, '1473730501', '6');
INSERT INTO `thinkox_polls_process` VALUES ('17', '69', '104', 'fdsa dfsa fsad fsda ', '1473735796', '3');
INSERT INTO `thinkox_polls_process` VALUES ('18', '70', '95', null, '1473735859', '6');
INSERT INTO `thinkox_polls_process` VALUES ('19', '70', '98', '', '1473742418', '5');

-- ----------------------------
-- Table structure for thinkox_polls_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_polls_type`;
CREATE TABLE `thinkox_polls_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_polls_type
-- ----------------------------
INSERT INTO `thinkox_polls_type` VALUES ('1', '经济发展类', '1403859500', '1473410216', '1', '0', '0', '0');
INSERT INTO `thinkox_polls_type` VALUES ('2', '社会事业类', '1403859511', '1473677235', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_proposal
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal`;
CREATE TABLE `thinkox_proposal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '发起人',
  `ycode` varchar(20) NOT NULL COMMENT '预案号',
  `code` varchar(20) DEFAULT NULL COMMENT '案号',
  `title` varchar(255) NOT NULL COMMENT '提案名称',
  `content` text NOT NULL COMMENT '详细内容',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  `type_id` int(11) NOT NULL COMMENT '类别',
  `meet_type` varchar(30) NOT NULL COMMENT '提出期间',
  `is_public` tinyint(2) NOT NULL COMMENT '是否公开',
  `is_first` tinyint(2) DEFAULT NULL COMMENT '是否第一提案人',
  `is_joint` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否联名',
  `jiebie` varchar(30) NOT NULL COMMENT '界别组',
  `renshu` int(5) unsigned NOT NULL DEFAULT '1' COMMENT '人数',
  `author` varchar(30) NOT NULL COMMENT '提案人',
  `contact` varchar(30) NOT NULL COMMENT '联系人',
  `merge_id` int(11) DEFAULT NULL COMMENT '并案id',
  `status` int(11) NOT NULL COMMENT '状态',
  `fujian` int(10) unsigned NOT NULL COMMENT '附件',
  `telephone` varchar(30) NOT NULL COMMENT '联系方式',
  `is_merge` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否并案',
  `meet` char(50) NOT NULL COMMENT '会议次数',
  `recommend` varchar(10) NOT NULL COMMENT '推荐',
  `adopt` varchar(100) NOT NULL COMMENT '采用',
  `write` varchar(100) NOT NULL COMMENT '批示',
  `joint_content` text NOT NULL COMMENT '联名理由',
  `contact_unit` varchar(50) NOT NULL COMMENT '联系人单位',
  `suggest` text NOT NULL COMMENT '提案委建议',
  `handsuggest` text NOT NULL COMMENT '交办意见',
  `leibie` varchar(20) NOT NULL COMMENT '类别',
  `jdllw` varchar(50) NOT NULL COMMENT '街道联络委',
  `zwh` varchar(50) NOT NULL COMMENT '专委会',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_proposal
-- ----------------------------
INSERT INTO `thinkox_proposal` VALUES ('9', '0', '', '1', '333', '', '0', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '1', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('10', '0', '43242432', null, '334324324', '32432432432423', '1470649210', '0', '1', '0', '0', null, '0', '0', '0', '434343', '', null, '11', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('11', '0', '2132131', null, '21321321321313213', '321312312321', '1470649265', '0', '1', '0', '0', null, '0', '0', '0', '3213', '', '0', '11', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('12', '0', '朝秦暮楚栽植', null, 'asfasfas', '栽植asfassafsafas', '1470649376', '0', '1', '0', '0', null, '0', '0', '0', '魂牵梦萦fsa', '', null, '3', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('13', '58', '432424', null, '32432', '4324234234', '1470650372', '0', '1', '0', '0', null, '0', '15', '5', '4324', '', null, '3', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('14', '58', '', null, '333', '魂牵梦萦栽植械大规模的a', '1470732629', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '3', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('15', '58', '', null, '333', '魂牵梦萦栽植械大规模的a土寺', '1470732650', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '3', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('16', '58', '', null, '333', '魂牵梦萦栽植械大规模的a土寺42342343242', '1470732745', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '3', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('17', '58', '', null, '333', '魂牵梦萦栽植械大规模的a土寺42342343242aaaaaaaaaaaaaaaaaaaaaaaaaa', '2016', '0', '1', '0', '0', null, '0', '0', '1', '324343', '3213', null, '1', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('18', '58', '', null, '333', '魂牵梦萦栽植械大规模的a土寺42342343242', '1470732857', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '9', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('19', '58', '', null, '333', '魂牵梦萦栽植械大规模的a土寺42342343242ffdsfsafsa2321321fdfsafasfdsaf32fdsafsafsafasfas', '1470732873', '0', '1', '0', '0', null, '0', '0', '1', '324343', '', null, '10', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('20', '0', '43424', null, 'fsafsa', 'fsafasf', '0', '0', '23', '0', '1', null, '1', '0', '3', '434343', '', '0', '9', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('21', '58', '4324234324', null, '432', '32432432', '33', '343', '434', '0', '1', null, '0', '14', '33', '3', '', '0', '9', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('22', '58', '434', null, '家33213123', '23213 21324第三方的萨芬夺sd', '23232', '2323', '1', '1', '1', null, '1', '15', '33', '333', '', null, '19', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('23', '58', '321321', null, '321321', '321312321', '321312', '21321321', '321321312', '0', '1', null, '1', '0', '3213213', '213213213', '32132131321', null, '19', '0', '3213213', '0', '1', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('24', '58', '', null, '', '', '1471248623', '1471248623', '1', '', '0', null, '1', '', '1', '', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('25', '58', '', null, 'test002', 'fsdafdjsak fjkdlsaj fklsa', '2016', '1471248623', '1', '0', '0', null, '1', '中华全国妇女联合会', '1', 'fdsafsa', '3213', '25', '3', '0', '13213', '2', '第一次', '', '', '', '', 'fdsafasfdsafasfsafas', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('26', '58', '', null, '', '', '1471248695', '1471248695', '1', '', '0', null, '1', '', '1', '', '', null, '19', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('27', '58', '', null, '我是一只大毛驴', '我是一只大毛驴我是一只大毛驴我是一只大毛驴我是一只大毛驴我是一只大毛驴我是一只大毛驴我是一只大毛驴', '1970', '1471248720', '1', '0', '1', null, '2', '中华全国妇女联合会', '1', '小毛驴', '3213', null, '3', '0', '13213', '0', '第二次', '', '', '', '我写了一个联名的理由，你看到了吗！', '湖北传媒', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('28', '58', '', null, '', '', '1471248738', '1471248737', '1', '', '0', null, '1', '', '1', '', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('29', '58', '', null, '', '', '1471248895', '1471248895', '1', '', '0', null, '1', '', '1', '', '', '0', '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('30', '58', '', null, '324234234', '2342423432432', '1471248947', '0', '1', '0', '0', null, '1', '--请选择--', '0', '', '', null, '1', '0', '', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('31', '58', '', null, '4324', '323333333333333333333333333333333333333333333333', '1471248970', '0', '1', '0', '0', null, '1', '--请选择--', '0', '', '', null, '1', '0', '', '0', '第十三届二次会议', '', '', '', '魂牵梦萦 魂牵梦萦 霜期械', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('32', '58', '', null, '4324', '323333333333333333333333333333333333333333333333', '1471250372', '0', '1', '0', '0', null, '1', '--请选择--', '0', '', '', '0', '5', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('33', '58', '22', null, '111', '2222', '1471250424', '0', '1', '0', '0', null, '1', '--请选择--', '0', '1', '', null, '18', '0', '13213', '0', '第十三届二次会议', '', '', '', '', '', '', '234324324324324234', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('34', '58', '', null, '111', '22224444444444444444444444', '2016', '0', '1', '0', '0', null, '1', '--请选择--', '0', '1', '3213', null, '1', '0', '13213', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('35', '58', '', null, '111', '2222', '1471250487', '0', '1', '0', '0', null, '1', '--请选择--', '0', '1', '', '35', '4', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('36', '58', '', null, '111', '2222', '1471250601', '0', '1', '0', '0', null, '1', '--请选择--', '0', '1', '', null, '19', '0', '13213', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('37', '0', '', null, '111', '2222', '1471250424', '0', '1', '0', '0', null, '1', '--请选择--', '0', '1', '', null, '13', '0', '13213', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('38', '58', '', null, '555', '555', '1471251480', '0', '1', '0', '0', null, '1', '--请选择--', '3', '111', '', null, '10', '0', '13213', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('39', '58', '', null, 'test002', '1111111', '1970', '0', '1', '0', '0', null, '1', '中华全国妇女联合会', '2', 'anren', '3213', null, '19', '0', '13213', '0', '第三次', '', '', '', '', 'djflksajfkla fdklsj fklsa', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('40', '58', '44458899885', null, '第一个提案', '第一个提案第一个提案第一个提案第一个提案第一个提案第一个提案第一个提案', '1471329659', '0', '1', '0', '0', null, '1', '--请选择--', '23', '飞侠', '', '40', '19', '0', '13213', '1', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('41', '58', '', null, 'test11111', '53253253255432532532532', '1471340110', '0', '1', '0', '0', null, '1', '--请选择--', '1', '324343', '3213', null, '9', '0', '13213', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('42', '58', '4459688796246546', null, '一个提案', '魂牵梦萦飞洒飞洒霜期柑柑a', '2016', '0', '1', '0', '0', null, '2', '中华全国总工会', '0', 'NO1', '3213', null, '9', '0', '13213', '0', '--请选择--', '', '', '', '这是NO1 联名', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('43', '58', '', null, '2222', 'tyyyy67', '1471496067', '0', '1', '0', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('44', '58', '', null, '123', '5555', '2016', '0', '1', '0', '0', null, '0', '', '0', '', '3213', '44', '13', '0', '13213', '2', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('45', '58', '', null, '556', '6666', '1970', '0', '1', '0', '0', null, '1', '', '0', '', '3213', null, '13', '0', '13213', '0', '第十三届二次会议', '', '', '', '33333', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('46', '58', '', null, '1', '555555', '2016', '0', '1', '0', '0', null, '0', '', '0', '', '3213', null, '19', '0', '13213', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('47', '58', '闭2016001号', null, '55', '5555', '2016', '0', '1', '0', '0', null, '0', '', '0', '', '3213', '0', '3', '0', '13213', '2', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('48', '58', '', null, 'asfasfasfasf', '栽植asasfasfas', '1471504187', '0', '1', '0', '0', null, '0', '', '0', '', '', null, '3', '0', '', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('49', '58', '', null, '4333333333333333333', '333333333333333333333333333333333', '1471504221', '0', '1', '0', '0', null, '0', '', '0', '', '', null, '3', '0', '', '0', '第十三届二次会议', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('50', '58', '4324234', null, '324324324', '3243242343244234234234', '1970', '0', '1', '0', '0', null, '0', '', '0', '23432', '3213', '94', '2', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('51', '58', '', null, 's鞋柜栽植asf', 'as魂牵梦萦栽植asfasfafafasf', '2016', '0', '1', '0', '0', null, '0', '', '0', '', '3213', null, '3', '0', '13213', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('52', '58', '4468579998255468547', null, '121212121212121', '内容啊，<span>内容啊，</span><span>内容啊，</span><span>内容啊，</span><span>内容啊，</span><span>内容啊，</span>', '1471572498', '0', '1', '0', '0', null, '0', '中国民主建国会', '2', '达达达', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('53', '58', '4468579998255468547', null, '121212121212121', '内容啊，<span>内容啊，</span><span>内容啊，</span><span>内容啊，</span><span>内容啊，</span><span>内容啊，</span>', '1471572535', '0', '1', '0', '0', null, '0', '中国民主建国会', '2', '达达达', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('54', '58', '', null, '3213213', '3123123123123123213', '1471576830', '0', '1', '1', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('55', '58', '', null, '423', '234324324324', '1471576892', '0', '1', '会议期间', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('56', '58', '4324', null, '324234', '432423424234', '1471576999', '0', '1', '', '0', null, '0', '', '3', '3242423', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('57', '58', '', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577036', '0', '1', '会议期间', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('58', '58', '第一次001号', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577148', '0', '1', '会议期间', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('59', '58', '', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577405', '0', '1', '闭会期间', '0', null, '0', '', '0', '', '', null, '1', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('60', '58', '闭2016001号', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577483', '0', '1', '闭会期间', '0', null, '0', '', '0', '', '', null, '3', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('61', '58', '闭2016001号', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577495', '0', '1', '闭会期间', '0', null, '0', '', '0', '', '', null, '3', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('62', '58', '闭2016002号', null, 'asfsafsa', '栽植safdsafasfasfasdfasf', '1471577739', '0', '1', '闭会期间', '0', null, '0', '', '0', '', '', null, '3', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('63', '58', '', null, '案由啊', '无可奈何花落去械霸花样百出f', '2016', '0', '1', '', '0', null, '0', '中国民主建国会', '3', '32432', '3213', null, '1', '0', '13213', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('64', '58', '33333', null, '434343', '43242342', '1970', '0', '1', '', '0', null, '0', '中国民主促进会', '434343', '43333', '3213', null, '1', '0', '13213', '0', '第三次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('65', '58', '', null, 'fsdaf dsaf asf das', '34324234324', '1471852599', '0', '1', '', '0', null, '0', '中国国民党革命委员会', '33', '444', '', '72', '2', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('66', '58', '43242342', null, '4324', '4234324', '1471852680', '0', '1', '', '0', null, '0', '中国民主建国会', '3', '', '', '92', '2', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('67', '58', '324324', null, '432', '4324234324', '1471852728', '0', '1', '', '0', null, '0', '', '3', '324', '', '71', '2', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('68', '58', '第三次001号', null, 'dsa fsa', 'f', '1471852825', '0', '1', '会议期间', '0', null, '0', '中国民主建国会', '3', 'f dsa fsa fsa', '', '83', '2', '0', '', '1', '第三次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('69', '58', '第三次002号', null, 'dsa fsa', 'f', '1471852856', '0', '1', '会议期间', '0', null, '0', '中国民主建国会', '3', 'f dsa fsa fsa', '', '71', '3', '0', '', '1', '第三次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('70', '58', '第三次003号', null, 'dsa fsa', 'f', '1471852874', '0', '1', '会议期间', '0', null, '0', '中国民主建国会', '3', 'f dsa fsa fsa', '', '83', '5', '0', '', '2', '第三次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('71', '58', '第二次001号', null, 'ewqrwqr', 'eee', '1471852923', '0', '1', '会议期间', '0', null, '0', '中国农工民主党', '3', 'ree', '', '71', '4', '0', '', '2', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('72', '58', '第二次002号', null, 'ewqrwqr', 'eee', '1471852944', '0', '1', '会议期间', '0', null, '0', '中国农工民主党', '3', 'ree', '', '83', '19', '0', '', '2', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('73', '58', '闭2016003号', null, '324324', '32432', '1471852985', '0', '1', '闭会期间', '0', null, '0', '中国民主同盟', '0', '432', '', '83', '19', '0', '', '1', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('74', '58', '闭2016004号', '闭2016002号', '324324', '32432', '1471853015', '0', '1', '闭会期间', '0', null, '0', '中国民主同盟', '0', '432', '', '83', '17', '0', '', '1', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('75', '58', '', null, '哈哈哈', '鞋柜栽植dsaf', '1472015193', '0', '1', '', '0', null, '0', '', '3', '', '', null, '1', '0', '', '0', '第三次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('76', '58', '', null, '432432', '432423432432', '1472015224', '0', '1', '', '0', null, '0', '', '3', '', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('77', '58', '', null, 'DADADFA', '魂牵梦萦fsafsafsa', '1472015293', '0', '1', '', '0', null, '0', '', '0', '', '', null, '13', '19', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('78', '58', '', null, 'heheh', 'fdsafsa', '2016', '0', '1', '', '0', null, '0', '', '0', '', '3213', '83', '2', '0', '13213', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('79', '71', '第一次008号', null, 'cs1', 'fdsafdsa', '1970', '0', '1', '会议期间', '0', null, '2', '九三学社', '1', 'wyy1', '委员1', null, '9', '0', '6', '0', '第一次', '', '', '', '我想联名', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('80', '71', '第二次003号', null, 'cs2', '222', '1472031269', '0', '1', '会议期间', '0', null, '0', '中国致公党', '1', '11', '', null, '7', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('81', '71', '', null, 'cs3', '3333', '1472031318', '0', '1', '', '0', null, '0', '中华全国台湾同胞联谊会', '3', '3333', '', null, '4', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('82', '71', '', null, 'cs4', '555', '1472032027', '0', '1', '', '0', null, '0', '', '0', '333', '', '82', '17', '0', '', '2', '', '4', '1,3', '2,4', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('83', '71', '', null, 'cs5', '5555', '1472032045', '0', '1', '', '0', null, '0', '', '5', 'cddd', '', '82', '9', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('84', '71', '', null, 'test1', '6666', '1472181921', '0', '1', '', '0', null, '0', '', '0', '委员1', '', null, '0', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('85', '71', '第一次009号', null, 'test1', '1111', '1472182001', '0', '1', '会议期间', '0', null, '0', '', '1', '委员1', '', null, '0', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('86', '71', '001号', null, 'test2', '2222', '1472182051', '0', '1', '会议期间', '0', null, '0', '', '111', '委员1', '', null, '0', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('87', '71', '001号', null, 'test2', '5555', '1472182083', '0', '1', '会议期间', '0', null, '2', '', '1', '委员1', '', null, '1', '0', '', '0', '', '', '', '', '3333', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('88', '71', '', null, '432423432', '3332', '1472182486', '0', '1', '', '0', null, '0', '中华全国总工会', '3', '委员1', '', null, '1', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('89', '71', '', null, 'ts1', '222', '1472182543', '0', '1', '', '0', null, '0', '', '0', '委员1', '委员1', null, '1', '0', '6', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('90', '64', '第一次012号', null, 'ta1', '2222', '1472199582', '0', '1', '会议期间', '0', null, '2', '中国民主同盟', '1', '委员2', '委员2', null, '9', '0', '123456', '0', '第一次', '', '', '', '3333', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('91', '64', '第一次019号', null, 'ta2', '222', '1472544715', '0', '1', '会议期间', '0', null, '2', '中华全国总工会', '22', '委员2', '委员2', '128', '2', '0', '123456', '1', '第一次', '', '', '', '6666', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('92', '65', '', null, 'ta2', '2222', '1472199761', '0', '1', '', '0', null, '0', '中华全国妇女联合会', '0', '委员3', '', null, '13', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('93', '64', '第一次012号', null, 'ta3', '333', '1472202775', '0', '2', '会议期间', '0', null, '0', '中国科学技术协会', '2', '委员2', '', '93', '19', '0', '', '2', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('94', '64', '第一次019号', null, 'ta5111111111111111111111111111', '3331113333333333333333333333333', '1472538294', '0', '1', '会议期间', '0', null, '0', '中华全国归国华侨联合会', '2', '委员2', '3213', '93', '3', '0', '13213', '1', '第一次', '0', '', '', '', '', '111111111111111111', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('95', '64', '', null, '1111', '2222', '1472538159', '0', '1', '', '0', null, '0', '', '0', '委员2', '3213', null, '1', '0', '13213', '0', '', '0', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('96', '64', '第一次014号', null, '222', '3333', '1472471292', '0', '1', '会议期间', '0', null, '0', '中国科学技术协会', '1', '委员2', '', '96', '7', '0', '', '2', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('97', '58', '', null, '我要一个提案', '魂牵梦萦房萨芬萨芬柑', '1472471336', '0', '1', '', '0', null, '0', '', '0', '3213', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('98', '64', '第一次016号', null, 'test1', '111', '1472474151', '0', '1', '会议期间', '0', null, '0', '中华全国青年联合会', '1', '委员2', '委员2', null, '13', '0', '123456', '0', '第一次', '', '', '', '', '', '', '我要提几点444', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('99', '58', '第一次018号', null, 'eee', 'eee', '1472535873', '0', '1', '会议期间', '0', null, '0', '', '0', '3213', '3213', null, '1', '0', '13213', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('100', '58', '闭2016005号', null, 'rererere', 'dtetrere', '1472535935', '0', '2', '闭会期间', '0', null, '0', '', '3', '3213', '', null, '1', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('101', '64', '001号', null, '2', '333', '1472544057', '0', '1', '会议期间', '0', null, '0', '', '0', '委员2', '', null, '1', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('102', '64', '', null, '22', '3333', '1472544215', '0', '1', '', '0', null, '0', '', '0', '委员2', '', '128', '2', '0', '', '1', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('103', '58', '闭2016006号', null, '11111111111111111111111111111', '111111111111111', '1472544422', '0', '2', '闭会期间', '0', null, '0', '', '1', '3213', '', '137', '2', '0', '', '1', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('104', '58', '闭2016007号', null, '222222222222222', '222222222222222222', '1472544495', '0', '2', '闭会期间', '0', null, '0', '', '34324', '3213', '', null, '7', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('105', '58', '', null, '立', '晶', '1472545870', '0', '1', '', '0', null, '1', '', '0', '3213', '3213', null, '6', '0', '13213', '0', '', '', '', '', '立', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('106', '64', '', null, 'taa1', '555', '1472549124', '0', '1', '', '0', null, '0', '', '0', '委员2', '', null, '5', '0', '', '0', '', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('107', '64', '第一次019号', null, 'taa2', '22', '1472549172', '0', '1', '会议期间', '0', null, '0', '中华全国青年联合会', '1', '委员2', '', null, '1', '0', '22', '0', '第一次', '', '', '', '', '333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('108', '64', '第一次020号', null, '555', '5555', '1472549698', '0', '1', '会议期间', '0', null, '0', '', '0', '委员2', '', null, '1', '0', '', '0', '第一次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('109', '64', '第一次021号', null, 'taa3', '3333', '1472549771', '0', '1', '会议期间', '0', null, '2', '中国民主促进会', '222', '委员2', '', null, '1', '0', '11', '0', '第一次', '', '', '', '5555', '222', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('110', '65', '第一次023号', null, '666', '66666', '1472550789', '0', '1', '会议期间', '0', null, '2', '', '55', '委员3', '委员3', null, '4', '0', '333', '0', '第一次', '', '', '', '888', '22', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('111', '65', '第一次024号', null, '555', '55555', '1472550850', '0', '1', '会议期间', '0', null, '2', '', '333', '委员3', '', null, '1', '0', '', '0', '第一次', '', '', '', '6666', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('112', '64', '第一次029号', null, 't1', '2223', '1472552616', '0', '1', '会议期间', '0', null, '0', '中国民主同盟', '1', '委员2', '', '112', '19', '0', '333', '2', '第一次', '0', '', '', '', '333', '666', '555', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('113', '64', '第一次029号', null, 't2', '3333', '1472552473', '0', '1', '会议期间', '0', null, '0', '中华全国青年联合会', '3', '委员2', '委员2', '128', '2', '0', '333', '1', '第一次', '', '', '', '', '333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('114', '64', '第一次027号', null, 't3', '333', '1472551940', '0', '1', '会议期间', '0', null, '0', '中华全国归国华侨联合会', '2', '委员2', '', '128', '2', '0', '333', '1', '第一次', '', '', '', '', '33', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('115', '64', '第一次028号', null, 't5', '3333', '1472552216', '0', '1', '会议期间', '0', null, '0', '', '3', '委员2', '', null, '1', '0', '22', '0', '第一次', '', '', '', '', '3333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('116', '58', '闭2016008号', null, '321312321', 'dfdsfasf', '1472555796', '0', '1', '闭会期间', '0', null, '0', '', '2', '3213', '', null, '1', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('117', '58', '闭2016009号', null, '我是一个提案', '魂牵梦萦塔顶栽奇巧载f', '1472555965', '0', '2', '闭会期间', '0', null, '0', '', '3', '3213', '', null, '1', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('118', '58', '闭2016010号', null, '我是一个提案', '魂牵梦萦塔顶栽奇巧载f', '1472556001', '0', '2', '闭会期间', '0', null, '0', '', '3', '3213', '', null, '1', '0', '', '0', '第二次', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('119', '58', '闭2016011号', null, '13213213213213213', '323232323', '1472563325', '0', '1', '闭会期间', '0', null, '2', '', '2', '3213', '', null, '1', '0', '13213', '0', '第二次', '', '', '', '', '123212222222222222222', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('120', '64', '第一次031号', null, '555', '5555', '1472564619', '0', '1', '会议期间', '0', null, '1', '中华全国青年联合会', '1', '委员2', '委员2', '151', '2', '0', '123456', '1', '第一次', '', '', '', '5555', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('121', '58', '闭2016012号', null, '我的一个提案', '椟槥鞋柜栽霜期fsaas', '1472563542', '0', '2', '闭会期间', '0', null, '2', '', '23', '3213', '', null, '1', '0', '13213', '0', '第二次', '', '', '', '', '123212222222222222222', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('122', '64', '第一次035号', null, 'tt1', '222', '1472623322', '0', '1', '会议期间', '0', null, '2', '中华全国妇女联合会', '2', '委员2', '委员2', '137', '2', '0', '123456', '1', '第一次', '', '', '', '3335555', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('123', '58', '第二次005号', null, '提案test', 'test001', '1472621656', '0', '1', '会议期间', '0', null, '0', '', '3', '3213', '3213', null, '13', '0', '13213', '0', '第二次', '', '', '', '', '123212222222222222222', '', '这里更新交办意见', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('124', '64', '第一次034号', null, '333', '333', '1472623289', '0', '1', '会议期间', '0', null, '0', '', '33', '委员2', '', null, '1', '0', '123456', '0', '第一次', '', '', '', '', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('125', '64', '第一次035号', null, '55', '333', '1472623342', '0', '1', '会议期间', '0', null, '0', '', '0', '委员2', '', '151', '2', '0', '123456', '1', '第一次', '', '', '', '', '2333333', '', '', '集体', '花楼水塔街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('126', '64', '第一次036号', null, '331', '333', '1472623362', '0', '1', '会议期间', '0', null, '0', '', '0', '委员2', '', null, '1', '0', '123456', '0', '第一次', '', '', '', '', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('127', '64', '闭2016017号', null, '再澧', 'dfdsfsafsa', '1472623542', '0', '1', '闭会期间', '0', null, '0', '', '3', '委员2', '委员2', null, '1', '0', '123456', '0', '第二次', '', '', '', '', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('128', '64', '第一次039号', '十五届一次会议010号', '12351', '33351', '1472623722', '0', '1', '会议期间', '1', null, '0', '中华全国台湾同胞联谊会', '31', '委员2', '2221', '128', '17', '0', '123456', '2', '第一次', '', '', '', '', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('129', '64', '第一次041号', '十五届一次会议008号', 'a1', '333', '1472624494', '0', '1', '会议期间', '0', null, '2', '中华全国台湾同胞联谊会', '1', '委员2', '委员2', '129', '17', '0', '123456', '2', '第一次', '', '', '', '333', '2333333', '', '', '委员', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('130', '64', '第一次042号', '十五届一次会议011号', 'a2', 'sss', '1472624548', '0', '1', '会议期间', '0', null, '0', '中国科学技术协会', '2', '委员2', '', '129', '17', '0', '123456', '1', '第一次', '', '', '', '', '2333333', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('131', '71', '第一次043号', null, 'a5', '555', '1472627591', '0', '1', '会议期间', '0', null, '0', '中华全国青年联合会', '2', '委员1', '', null, '18', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '集体', '民意街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('132', '64', '第一次044号', '十五届一次会议001号', 'aaa', 'ddd', '1472629092', '0', '1', '会议期间', '0', null, '2', '', '2', '委员2', '', null, '17', '0', '123456', '0', '第一次', '', '', '', '333', '2333333', '', '', '集体', '花楼水塔街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('133', '71', '第一次045号', '十五届一次会议003号', 'a6', '66668888', '1472646136', '0', '1', '会议期间', '1', null, '2', '群众', '5', '委员1', '委员1', null, '17', '0', '6', '0', '第一次', '1', '', '', '9999', '火凤凰', 'tttt', '55655555', '集体', '民意街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('134', '71', '第一次046号', '十五届一次会议002号', 'a6', '222', '1472702285', '0', '1', '会议期间', '1', null, '2', '中国科学技术协会', '111', '委员1', '委员1', null, '17', '0', '6', '0', '第一次', '', '', '', '333', '火凤凰', '', '', '集体', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('135', '71', '第一次047号', '闭2016001号', 'a7_1', 'aaaaaaaa', '1472710169', '0', '1', '闭会期间', '2', null, '2', '无党派人员', '3', '委员1', '委员1', '135', '17', '0', '6', '2', '第二次', '2', '', '', '6666', '火凤凰', '666666', '88888', '集体', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('136', '71', '第一次048号', '十五届一次会议012号', 'a8', '222', '1472709562', '0', '1', '会议期间', '1', null, '2', '九三学社', '111', '委员1', '委员1', null, '17', '0', '6', '0', '第一次', '', '', '', '666', '火凤凰', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('137', '58', '第二次006号', '十五届一次会议004号', '323333', '33333333333333333333333333333333', '1472717312', '0', '1', '会议期间', '0', null, '1', '中国国民党革命委员会', '2', '3213', '3213', '137', '17', '0', '13213', '2', '第二次', '', '', '', '', '123212222222222222222', '', '', '集体', '民意街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('138', '58', '第二次007号', '十五届一次会议013号', '3333333333333333', '322222222222222222222222222222', '1472717759', '0', '1', '会议期间', '0', null, '2', '中国民主促进会', '3', '3213', '1', '1', '17', '1', '13213', '0', '第二次', '', '', '', '', '123212222222222222222', '', '', '', '', '');
INSERT INTO `thinkox_proposal` VALUES ('139', '71', '第一次049号', '十五届一次会议009号', 'a9', 'aaa', '1472730581', '0', '1', '会议期间', '1', null, '2', '', '2', '委员1', '委员1', '139', '9', '0', '6', '2', '第一次', '', '', '', '88888', '火凤凰', '', '', '委员', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('140', '71', '第一次050号', '十五届一次会议006号', 'a10', 'aaa', '1472730828', '0', '1', '会议期间', '1', null, '0', '中华全国台湾同胞联谊会', '1', '委员1', '委员1', '139', '17', '0', '6', '1', '第一次', '', '', '', '6666', '火凤凰', '', '', '委员', '花楼水塔街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('141', '71', '第一次051号', '十五届一次会议007号', 'a11', '33', '1472731021', '0', '1', '会议期间', '0', null, '0', '中国科学技术协会', '2', '委员1', '', '139', '17', '0', '6', '1', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '花楼水塔街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('142', '58', '闭2016018号', '闭2016002号', 'test005', '34324324234', '1472785433', '0', '2', '闭会期间', '0', null, '0', '', '3', '委员1', '', null, '9', '0', '6', '0', '第三次', '', '', '', '', '火凤凰', '', '', '委员', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('143', '71', '第一次052号', null, 'B1', '266666', '1472798072', '0', '1', '会议期间', '1', null, '0', '中华全国青年联合会', '1', '委员1', '委员1', '143', '9', '0', '6', '2', '第一次', '1', '1', '2', '555', '火凤凰', '77777', '3333', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('144', '71', '第一次053号', null, 'B2', '222333', '1472797093', '0', '1', '会议期间', '1', null, '0', '中华全国妇女联合会', '2', '委员1', '', '143', '2', '0', '6', '1', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('145', '71', '第一次054号', null, 'B3', '333', '1472797137', '0', '1', '会议期间', '1', null, '0', '中华全国青年联合会', '2', '委员1', '委员1', null, '13', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('146', '71', '第一次055号', '第一次009号', 'B5', '3333', '1472797207', '0', '1', '会议期间', '1', null, '0', '中国科学技术协会', '8', '委员1', '', null, '9', '0', '6', '0', '第一次', '', '3,4', '4', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('147', '71', '第一次056号', null, 'B7', 'AAA', '1472797280', '0', '1', '会议期间', '1', null, '0', '中华全国妇女联合会', '2', '委员1', '', null, '1', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('148', '71', '第一次057号', null, 'B8', 'AAA', '1472798157', '0', '1', '会议期间', '1', null, '0', '中国科学技术协会', '1', '委员1', '', null, '4', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('149', '71', '第一次058号', null, '22', '5555', '1473214321', '0', '1', '会议期间', '0', null, '0', '中国科学技术协会', '1', '委员1', '委员1', null, '1', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('150', '58', '第一次059号', null, '3333', '555555', '1473315439', '0', '1', '会议期间', '1', null, '0', '群众', '0', '委员11', '委员11', null, '1', '0', '6', '0', '第一次', '', '', '', '', '火凤凰', '', '', '委员', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('151', '58', '闭2016019号', null, '312313', '2313', '1473323749', '0', '1', '闭会期间', '1', null, '0', '', '2', '委员11', '委员11', '151', '18', '0', '6', '2', '第二次', '', '', '', '', '火凤凰', '', '342342342', '委员', '前进街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('152', '59', '第一次060号', null, '111', '2222', '1473328575', '0', '1', '会议期间', '0', null, '2', '', '1', '', '', null, '1', '0', '', '0', '第一次', '', '', '', '666', '', '', '', '委员', '', '');
INSERT INTO `thinkox_proposal` VALUES ('153', '59', '第二次008号', null, 't1', '22222', '1473334563', '0', '1', '会议期间', '0', null, '2', '', '0', '', '', null, '4', '0', '', '0', '第二次', '', '', '', 'sss', '', '', '', '委员', '', '');
INSERT INTO `thinkox_proposal` VALUES ('154', '59', '十五届一次会议001号', '第一次010号', 'C1', '111122222222222', '1473434696', '0', '1', '会议期间', '1', null, '0', '中共', '1', '委员1', '委员1', '154', '9', '0', '13412345678', '2', '十五届一次会议', '', '1', '2', '222', '总工会', '', '55555', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('155', '59', '十五届一次会议002号', null, 'C2', 'DDDD', '1473416329', '0', '1', '会议期间', '1', null, '2', '中华全国青年联合会', '2', '委员1', '委员1', '154', '2', '0', '66181234', '1', '十五届一次会议', '', '', '', '333', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('156', '59', '十五届一次会议003号', null, 'C3', 'DDDD3333', '1473506440', '0', '1', '会议期间', '0', null, '0', '群众', '2', '委员1', '委员1', null, '8', '0', '66181234', '0', '十五届一次会议', '', '', '', '5555', '总工会', '33333', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('157', '59', '闭2016020号', null, 'C5', '2222', '1473415757', '0', '3', '闭会期间', '0', null, '0', '团员', '11', '委员1', '委员1', null, '4', '0', '66181234', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('158', '59', '闭2016021号', '闭2016003号', 'C6', '333', '1473435949', '0', '1', '闭会期间', '0', null, '0', '中国国民党革命委员会', '5', '委员1', '委员1', null, '9', '0', '66181234', '0', '十五届一次会议', '', '3', '1,3', '', '总工会', '', '6666', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('159', '62', '十五届一次会议004号', null, 'J1', '111', '1473425965', '0', '1', '会议期间', '1', null, '0', '中华全国妇女联合会', '1', '民族街联络委员会', '集体1', null, '1', '0', '333', '0', '十五届一次会议', '', '', '', '', '', '', '', '集体', '', '');
INSERT INTO `thinkox_proposal` VALUES ('160', '96', '闭2016022号', null, 's鞋柜栽植asf', '人扣篮大赛就分开了世界弗兰克撒旦教弗兰克撒旦教疯狂拉萨', '1473479606', '0', '4', '闭会期间', '0', null, '0', '', '323', '333', '222', null, '1', '0', '12121', '0', '十五届一次会议', '', '', '', '', '213213', '', '', '委员', '', '');
INSERT INTO `thinkox_proposal` VALUES ('161', '59', '十五届一次会议005号', null, '关于推动健康产业升级,加快“环同济健康城”建设的建议案', '   近年来，健康产业升级,加快“环同济健康城”建设', '1473562879', '0', '1', '会议期间', '2', null, '2', '教育界', '1', '委员1', '委员1', '161', '13', '0', '66181234', '2', '十五届一次会议', '', '', '', '关于推动健康产业升级,加快“环同济健康城”建设的建议案，可否一起联名提交提案', '总工会', '非常很好', '66666', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('162', '59', '十五届一次会议006号', null, '关于发展我区众创空间的建议', '关于发展我区众创空间的建议', '1473502995', '0', '1', '会议期间', '0', null, '0', '九三学社', '1', '委员1', '委员1', null, '4', '0', '66181234', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('163', '59', '闭2016023号', null, '关于支持我区台企转型升级的建议', '关于支持我区台企转型升级的建议', '1473498403', '0', '3', '闭会期间', '0', null, '0', '九三学社', '1', '委员1', '委员1', '161', '2', '0', '66181234', '1', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('164', '59', '十五届一次会议007号', null, 'D1', 'DDDD', '1473743668', '0', '6', '会议期间', '1', null, '0', '中国国民党革命委员会', '0', '委员1', '委员1', null, '2', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('165', '59', '十五届一次会议008号', null, '333', '33366666', '1473506488', '0', '2', '会议期间', '0', null, '0', '中国国民党革命委员会', '22', '委员1', '委员1', '166', '2', '0', '13886199168', '1', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('166', '59', '闭2016024号', null, 'D2', '333333', '1473506520', '0', '3', '闭会期间', '0', null, '0', '中国国民党革命委员会', '0', '委员1', '委员1', null, '13', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '总工会', '', '666', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('167', '59', '十五届一次会议009号', null, 'D3', '3333', '1473509140', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '1', '委员1', '委员1', null, '1', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('168', '62', '十五届一次会议010号', null, '关于加强公开承诺工程项目建设的建议', '关于加强公开承诺工程项目建设的建议\r\n', '1473514447', '0', '1', '会议期间', '0', null, '0', '', '0', '民族街联络委员会', '集体1', null, '8', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '', '', '', '集体', '', '');
INSERT INTO `thinkox_proposal` VALUES ('169', '62', '十五届一次会议011号', '十五届一次会议005号', '关于改善道路洒水清洁方式，提高环境卫生水平的建议', '关于改善道路洒水清洁方式，提高环境卫生水平的建议1\r\n', '1473515337', '0', '1', '会议期间', '1', null, '0', '', '1', '民族街联络委员会', '集体1', null, '17', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '11111', '建议', '6666', '集体', '', '');
INSERT INTO `thinkox_proposal` VALUES ('170', '62', '十五届一次会议012号', null, '关于多渠道建设公共停车场的建议', '关于多渠道建设公共停车场的建议6', '1473516442', '0', '1', '会议期间', '0', null, '0', '', '1', '民族街联络委员会', '集体1', null, '18', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '', '66666', '666', '集体', '', '');
INSERT INTO `thinkox_proposal` VALUES ('171', '59', '闭2016025号', null, '我要测试啦', '321312321', '1473574236', '0', '2', '闭会期间', '0', null, '0', '中国国民党革命委员会', '3', '委员1', '委员1', null, '1', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('172', '59', '十五届一次会议013号', null, 'CS1', '111', '1473578983', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '0', '委员1', '委员1', null, '9', '0', '13886199168', '0', '十五届一次会议', '2', '2', '3', '', '总工会', '3333', '333', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('173', '59', '十五届一次会议014号', null, 'C2', '2222', '1473580361', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '12', '委员1', '委员1', null, '8', '0', '13886199168', '0', '十五届一次会议', '', '', '', '', '总工会', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('174', '60', '十五届一次会议015号', null, 'C1', '2222', '1473596100', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '1', '委员2', '委员2', null, '2', '0', '18694076198', '0', '十五届一次会议', '', '', '', '', '发展科技有限公司', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('175', '60', '十五届一次会议016号', null, 'cc2', 'ssss', '1473596115', '0', '2', '会议期间', '0', null, '0', '中国国民党革命委员会', '0', '委员2', '委员2', null, '1', '0', '18694076198', '0', '十五届一次会议', '', '', '', '', '发展科技有限公司', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('176', '60', '十五届一次会议017号', null, 'CC3', '3333', '1473596133', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '0', '委员2', '委员2', null, '2', '0', '18694076198', '0', '十五届一次会议', '', '', '', '', '发展科技有限公司', '', '', '委员', '民族街联络委员会', '');
INSERT INTO `thinkox_proposal` VALUES ('177', '60', '十五届一次会议018号', null, '22', '3333', '1473596605', '0', '1', '会议期间', '0', null, '0', '中国国民党革命委员会', '0', '委员2', '委员2', null, '2', '0', '18694076198', '0', '十五届一次会议', '', '', '', '', '发展科技有限公司', '', '', '委员', '民族街联络委员会', '经科委');

-- ----------------------------
-- Table structure for thinkox_proposal_joint
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal_joint`;
CREATE TABLE `thinkox_proposal_joint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `proposal_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `is_agree` tinyint(2) NOT NULL COMMENT '是否同意联名',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建的时间',
  `suggest` varchar(250) DEFAULT NULL COMMENT '意见反馈',
  PRIMARY KEY (`id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7390 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of thinkox_proposal_joint
-- ----------------------------
INSERT INTO `thinkox_proposal_joint` VALUES ('7302', '58', '27', '1', '1471398405', 'fdsafsafasfasdfasfas33323232432423432432423333333333333333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7295', '58', '31', '2', '1471346524', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7299', '58', '31', '0', '1471347662', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7301', '1', '27', '0', '1471398404', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7311', '58', '27', '1', '1471398929', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7312', '1', '42', '0', '1471411033', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7313', '58', '42', '0', '1471411035', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7314', '58', '45', '1', '1471496607', '333333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7315', '64', '79', '2', '1472025868', '22222');
INSERT INTO `thinkox_proposal_joint` VALUES ('7316', '65', '79', '1', '1472025874', '333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7317', '64', '87', '0', '1472190646', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7318', '65', '87', '0', '1472190647', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7320', '71', '90', '0', '1472198787', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7321', '65', '90', '1', '1472198789', '333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7323', '64', '100', '0', '1472536604', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7324', '65', '91', '0', '1472544282', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7325', '58', '85', '0', '1472544289', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7326', '64', '85', '0', '1472544558', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7327', '65', '105', '0', '1472544561', '2323232');
INSERT INTO `thinkox_proposal_joint` VALUES ('7328', '65', '109', '1', '1472549792', '6666');
INSERT INTO `thinkox_proposal_joint` VALUES ('7329', '64', '110', '1', '1472550242', '6666');
INSERT INTO `thinkox_proposal_joint` VALUES ('7330', '58', '110', '0', '1472550243', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7331', '64', '111', '0', '1472550866', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7332', '58', '111', '1', '1472550867', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7333', '64', '118', '0', '1472562843', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7334', '65', '118', '0', '1472562892', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7339', '65', '117', '0', '1472563628', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7340', '65', '117', '0', '1472563631', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7337', '58', '120', '0', '1472563379', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7338', '65', '120', '1', '1472563381', '666');
INSERT INTO `thinkox_proposal_joint` VALUES ('7341', '65', '117', '0', '1472563689', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7342', '65', '122', '1', '1472615845', '3333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7344', '71', '122', '0', '1472615907', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7345', '71', '129', '0', '1472624479', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7346', '71', '132', '0', '1472629100', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7347', '65', '132', '1', '1472629101', '3333');
INSERT INTO `thinkox_proposal_joint` VALUES ('7348', '65', '133', '0', '1472646000', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7349', '64', '133', '0', '1472646002', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7350', '65', '134', '0', '1472702294', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7352', '64', '134', '0', '1472702404', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7353', '64', '135', '1', '1472708189', '8888');
INSERT INTO `thinkox_proposal_joint` VALUES ('7354', '65', '135', '0', '1472708190', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7356', '65', '136', '0', '1472709206', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7357', '64', '136', '0', '1472709207', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7358', '64', '137', '2', '1472717078', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7359', '65', '137', '2', '1472717080', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7368', '65', '143', '0', '1472796334', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7361', '71', '138', '0', '1472717379', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7362', '64', '138', '0', '1472718162', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7364', '65', '139', '2', '1472729860', '6666');
INSERT INTO `thinkox_proposal_joint` VALUES ('7365', '64', '139', '1', '1472729861', '88889');
INSERT INTO `thinkox_proposal_joint` VALUES ('7366', '64', '140', '0', '1472730688', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7367', '65', '140', '0', '1472730689', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7369', '64', '143', '2', '1472796335', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7370', '71', '121', '0', '1472798395', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7371', '71', '119', '0', '1472982822', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7372', '64', '119', '0', '1472982823', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7373', '58', '149', '0', '1473214374', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7374', '64', '149', '0', '1473214375', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7375', '58', '152', '0', '1473328598', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7376', '58', '153', '1', '1473334030', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7379', '60', '155', '1', '1473415572', '666');
INSERT INTO `thinkox_proposal_joint` VALUES ('7378', '61', '154', '0', '1473415425', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7380', '60', '156', '0', '1473415710', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7381', '61', '156', '0', '1473415711', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7382', '59', '160', '2', '1473479613', '');
INSERT INTO `thinkox_proposal_joint` VALUES ('7387', '61', '167', '0', '1473509150', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7386', '61', '161', '1', '1473489666', '同意联名');
INSERT INTO `thinkox_proposal_joint` VALUES ('7388', '59', '168', '0', '1473514434', null);
INSERT INTO `thinkox_proposal_joint` VALUES ('7389', '60', '171', '0', '1473733957', null);

-- ----------------------------
-- Table structure for thinkox_proposal_process
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal_process`;
CREATE TABLE `thinkox_proposal_process` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `group` varchar(30) NOT NULL COMMENT '操作对象',
  `proposal_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  `to_status` tinyint(2) NOT NULL COMMENT '操作状态',
  `suggest` varchar(250) DEFAULT NULL,
  `result_id` int(10) DEFAULT NULL COMMENT '办理单位ID 可选',
  PRIMARY KEY (`id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7605 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of thinkox_proposal_process
-- ----------------------------
INSERT INTO `thinkox_proposal_process` VALUES ('7350', '58', '委员', '78', '提案人【3213】向提案委提交了预案号【】，案由【heheh】的提案', '1472018225', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7351', '71', '委员', '79', '提案人【委员1】向提案委提交了预案号【第一次006号】，案由【cs1】的提案', '1472028705', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7352', '66', '提案委', '79', '提案委【taw1】对提案人【委员1】，预案号【第一次007号】,案由【cs1】的提案执行了退回操作', '1472031051', '3', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7353', '71', '委员', '79', '提案人【委员1】向提案委提交了预案号【第一次007号】，案由【cs1】的提案', '1472031204', '3', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7348', '58', '委员', '72', '提案人【3213】向提案委提交了预案号【第二次002号】，案由【ewqrwqr】的提案', '1471852944', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7349', '58', '委员', '74', '提案人【3213】向提案委提交了预案号【闭2016004号】，案由【324324】的提案', '1471853015', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7354', '71', '委员', '80', '提案人【委员1】向提案委提交了预案号【第二次003号】，案由【cs2】的提案', '1472031269', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7355', '71', '委员', '81', '提案人【委员1】向提案委提交了预案号【】，案由【cs3】的提案', '1472031318', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7356', '66', '提案委', '81', '提案委【taw1】对提案人【委员1】，预案号【】,案由【cs3】的提案执行了未立案操作', '1472031845', '4', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7357', '66', '提案委', '80', '提案委【taw1】对提案人【委员1】，预案号【第二次003号】,案由【cs2】的提案执行了委员来信操作', '1472031888', '7', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7358', '66', '提案委', '79', '提案委【taw1】对提案人【委员1】，预案号【第一次008号】,案由【cs1】的提案执行了已立案操作', '1472031999', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7359', '71', '委员', '82', '提案人【委员1】向提案委提交了预案号【】，案由【cs4】的提案', '1472032027', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7360', '71', '委员', '83', '提案人【委员1】向提案委提交了预案号【】，案由【cs5】的提案', '1472032045', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7361', '66', '提案委', '82', '提案委【taw1】对提案人【委员1】，预案号【】,案由【cs4】的提案执行了已立案操作', '1472032623', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7362', '66', '提案委', '0', '', '1472033011', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7363', '67', '政府办公室', '0', '', '1472111274', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7364', '58', '提案委', '83', '提案委【dominator】对提案人【委员1】，预案号【】,案由【cs5】的提案执行了已立案操作', '1472113016', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7365', '58', '提案委', '74', '提案委【dominator】对提案人【3213】，预案号【闭2016004号】,案由【324324】的提案执行了已立案操作', '1472115027', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7366', '58', '提案委', '72', '提案委【dominator】对提案人【3213】，预案号【第二次002号】,案由【ewqrwqr】的提案执行了已立案操作', '1472115033', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7367', '58', '提案委', '73', '提案委【dominator】对提案人【3213】，预案号【闭2016003号】,案由【324324】的提案执行了已立案操作', '1472115038', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7368', '58', '提案委', '0', '', '1472115045', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7369', '58', '提案委', '83', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs5】的提案执行了已结案操作', '1472180830', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7370', '71', '委员', '89', '提案人【委员1】向提案委提交了预案号【】，案由【ts1】的提案', '1472182543', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7371', '58', '提案委', '89', '提案委【dominator】对提案人【委员1】，预案号【】,案由【ts1】的提案执行了未立案操作', '1472190672', '4', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7372', '58', '提案委', '71', '提案委【dominator】对提案人【3213】，预案号【第二次001号】,案由【ewqrwqr】的提案执行了未立案操作', '1472190723', '4', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7373', '58', '提案委', '70', '提案委【dominator】对提案人【3213】，预案号【第三次003号】,案由【dsa fsa】的提案执行了撤案操作', '1472191045', '5', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7374', '58', '办理单位', '7321', '办理单位【】对提案人【】，预案号【】,案由【111】的提案执行了移交办理操作', '1472197766', '19', '我要移交', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7375', '58', '办理单位', '36', '办理单位【】对提案人【】，预案号【】,案由【111】的提案执行了移交办理操作', '1472197861', '19', '我要移交了', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7376', '58', '提案委', '69', '提案委【dominator】对提案人【3213】，预案号【第三次002号】,案由【dsa fsa】的提案执行了退回操作', '1472198334', '3', '退回了', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7377', '64', '委员', '90', '提案人【委员2】向提案委提交了预案号【第一次010号】，案由【ta1】的提案', '1472199147', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7378', '66', '提案委', '90', '提案委【taw1】对提案人【委员2】，预案号【第一次012号】,案由【ta1】的提案执行了退回操作', '1472199463', '3', '55555', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7379', '64', '委员', '90', '提案人【委员2】向提案委提交了预案号【第一次012号】，案由【ta1】的提案', '1472199487', '3', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7380', '66', '提案委', '90', '提案委【taw1】对提案人【委员2】，预案号【第一次012号】,案由【ta1】的提案执行了退回操作', '1472199508', '3', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7381', '64', '委员', '90', '提案人【委员2】向提案委提交了预案号【第一次012号】，案由【ta1】的提案', '1472199582', '3', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7382', '65', '委员', '92', '提案人【委员3】向提案委提交了预案号【】，案由【ta2】的提案', '1472199761', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7383', '66', '提案委', '90', '提案委【taw1】对提案人【委员2】，预案号【第一次012号】,案由【ta1】的提案执行了已立案操作', '1472199904', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7384', '66', '提案委', '0', '', '1472199930', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7385', '67', '政府办公室', '0', '', '1472202239', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7386', '66', '提案委', '90', '政府督查室【taw1】对办理单位【】，提案人【委员2】，预案号【第一次012号】,案由【ta1】的提案执行了已结案操作', '1472202388', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7387', '64', '委员', '93', '提案人【委员2】向提案委提交了预案号【第一次012号】，案由【ta3】的提案', '1472202775', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7388', '64', '委员', '94', '提案人【委员2】向提案委提交了预案号【第一次013号】，案由【ta5】的提案', '1472202820', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7389', '66', '提案委', '93', '提案委【taw1】对提案人【委员2】，预案号【第一次012号】,案由【ta3】的提案执行了已立案操作', '1472203235', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7390', '66', '提案委', '0', '', '1472203244', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7391', '68', '办理单位', '93', '办理单位【税务局】对提案人【】，预案号【第一次012号】,案由【ta3】的提案执行了移交办理操作', '1472203327', '19', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7392', '66', '提案委', '92', '提案委【taw1】对提案人【委员3】，预案号【】,案由【ta2】的提案执行了已立案操作', '1472204378', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7393', '66', '提案委', '0', '', '1472204386', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7340', '58', '提案委', '51', '提案委【】对提案人【3213】，预案号【】,案由【s鞋柜栽植asf】的提案执行了退回操作', '1471832793', '13', '地奇巧霜期回复洒落空间风口上拉分开了撒娇发生卡拉时框', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7341', '58', '提案委', '62', '提案委【】对提案人【3213】，预案号【闭2016002号】,案由【asfsafsa】的提案执行了退回操作', '1471832906', '3', '埼大法师载栽载茜dsa', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7342', '58', '提案委', '60', '提案委【dominator】对提案人【3213】，预案号【闭2016001号】,案由【asfsafsa】的提案执行了退回操作', '1471833014', '3', '4324234324324324', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7394', '58', '政府办公室', '74', '', '1472206414', '13', '哈哈 哈', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7395', '58', '政府办公室', '0', '', '1472442833', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7396', '58', '办理单位', '37', '办理单位【】对提案人【】，预案号【】,案由【111】的提案执行了移交办理操作', '1472451376', '13', '我不要办理了，交给别人吧', '7337');
INSERT INTO `thinkox_proposal_process` VALUES ('7397', '64', '委员', '95', '提案人【委员2】向提案委提交了预案号【】，案由【1111】的提案', '1472470912', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7398', '64', '委员', '96', '提案人【委员2】向提案委提交了预案号【第一次014号】，案由【222】的提案', '1472471291', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7399', '64', '委员', '98', '提案人【委员2】向提案委提交了预案号【第一次015号】，案由【test1】的提案', '1472474151', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7400', '66', '提案委', '98', '提案委【taw1】对提案人【委员2】，预案号【第一次016号】,案由【test1】的提案执行了已立案操作', '1472474844', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7401', '58', '提案委', '96', '提案委【dominator】对提案人【委员2】，预案号【第一次014号】,案由【222】的提案执行了委员来信操作', '1472520072', '7', '委员来信了', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7402', '64', '委员', '94', '提案人【委员2】向提案委提交了预案号【第一次013号】，案由【ta5】的提案', '1472538294', '2', '111111111111111111', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7403', '58', '提案委', '94', '提案委【dominator】对提案人【委员2】，预案号【第一次019号】,案由【ta5111111111111111111111111111】的提案执行了退回操作', '1472538365', '3', '我要退回啦', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7404', '64', '委员', '102', '提案人【委员2】向提案委提交了预案号【】，案由【22】的提案', '1472544215', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7405', '58', '委员', '103', '提案人【3213】向提案委提交了预案号【闭2016006号】，案由【11111111111111111111111111111】的提案', '1472544422', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7406', '58', '委员', '104', '提案人【3213】向提案委提交了预案号【闭2016007号】，案由【222222222222222】的提案', '1472544495', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7407', '64', '委员', '91', '提案人【委员2】向提案委提交了预案号【第一次011号】，案由【ta2】的提案', '1472544715', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7408', '64', '委员', '91', '提案人【委员2】向提案委提交了预案号【第一次019号】，案由【ta2】的提案', '1472544715', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7409', '58', '委员', '105', '提案人【3213】向提案委提交了预案号【】，案由【立】的提案', '1472545870', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7410', '58', '委员', '105', '提案人【3213】向提案委提交了预案号【】，案由【立】的提案', '1472545870', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7411', '64', '委员', '106', '提案人【委员2】向提案委提交了预案号【】，案由【taa1】的提案', '1472549124', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7412', '65', '委员', '110', '提案人【委员3】向提案委提交了预案号【第一次022号】，案由【666】的提案', '1472550789', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7413', '65', '委员', '110', '提案人【委员3】向提案委提交了预案号【第一次023号】，案由【666】的提案', '1472550789', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7414', '64', '委员', '112', '提案人【委员2】向提案委提交了预案号【第一次025号】，案由【t1】的提案', '1472551886', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7415', '64', '委员', '113', '提案人【委员2】向提案委提交了预案号【第一次026号】，案由【t2】的提案', '1472551920', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7416', '64', '委员', '114', '提案人【委员2】向提案委提交了预案号【第一次027号】，案由【t3】的提案', '1472551940', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7417', '66', '提案委', '113', '提案委【taw1】对提案人【委员2】，预案号【第一次026号】,案由【t2】的提案执行了退回操作', '1472552396', '3', '66666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7418', '64', '委员', '113', '提案人【委员2】向提案委提交了预案号【第一次026号】，案由【t2】的提案', '1472552473', '3', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7419', '64', '委员', '113', '提案人【委员2】向提案委提交了预案号【第一次029号】，案由【t2】的提案', '1472552473', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7420', '66', '提案委', '110', '提案委【taw1】对提案人【委员3】，预案号【第一次023号】,案由【666】的提案执行了未立案操作', '1472552523', '4', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7421', '66', '提案委', '106', '提案委【taw1】对提案人【委员2】，预案号【】,案由【taa1】的提案执行了撤案操作', '1472552536', '5', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7422', '66', '提案委', '105', '提案委【taw1】对提案人【3213】，预案号【】,案由【立】的提案执行了不在管辖区操作', '1472552546', '6', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7423', '66', '提案委', '104', '提案委【taw1】对提案人【3213】，预案号【闭2016007号】,案由【222222222222222】的提案执行了委员来信操作', '1472552558', '7', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7424', '64', '委员', '112', '提案人【委员2】向提案委提交了预案号【第一次025号】，案由【t1】的提案', '1472552616', '2', '666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7425', '64', '委员', '112', '提案人【委员2】向提案委提交了预案号【第一次029号】，案由【t1】的提案', '1472552616', '2', '666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7426', '66', '提案委', '112', '提案委【taw1】对提案人【委员2】，预案号【第一次029号】,案由【t1】的提案执行了已立案操作', '1472553376', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7427', '66', '提案委', '0', '', '1472553409', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7428', '69', '办理单位', '112', '办理单位【公安局】对提案人【】，预案号【第一次029号】,案由【t1】的提案执行了移交办理操作', '1472556644', '19', 'rrrr', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7429', '64', '委员', '120', '提案人【委员2】向提案委提交了预案号【第一次030号】，案由【555】的提案', '1472564619', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7430', '64', '委员', '120', '提案人【委员2】向提案委提交了预案号【第一次031号】，案由【555】的提案', '1472564619', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7431', '58', '办理单位', '26', '办理单位【】对提案人【】，预案号【】,案由【】的提案执行了移交办理操作', '1472612701', '19', '我要移走了！', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7432', '58', '委员', '123', '提案人【3213】向提案委提交了预案号【第二次004号】，案由【提案test】的提案', '1472621656', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7433', '58', '委员', '123', '提案人【3213】向提案委提交了预案号【第二次005号】，案由【提案test】的提案', '1472621656', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7434', '58', '提案委', '123', '提案委【dominator】对提案人【3213】，预案号【第二次005号】,案由【提案test】的提案执行了已立案操作', '1472621917', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7435', '58', '提案委', '0', '', '1472621975', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7436', '64', '委员', '122', '提案人【委员2】向提案委提交了预案号【第一次032号】，案由【tt1】的提案', '1472622663', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7437', '64', '委员', '122', '提案人【委员2】向提案委提交了预案号【第一次033号】，案由【tt1】的提案', '1472622663', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7438', '66', '提案委', '122', '提案委【taw1】对提案人【委员2】，预案号【第一次033号】,案由【tt1】的提案执行了退回操作', '1472623244', '3', 'dddd', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7439', '64', '委员', '122', '提案人【委员2】向提案委提交了预案号【第一次033号】，案由【tt1】的提案', '1472623322', '3', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7440', '64', '委员', '122', '提案人【委员2】向提案委提交了预案号【第一次035号】，案由【tt1】的提案', '1472623322', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7441', '64', '委员', '125', '提案人【委员2】向提案委提交了预案号【第一次035号】，案由【55】的提案', '1472623342', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7442', '64', '委员', '128', '提案人【委员2】向提案委提交了预案号【第一次037号】，案由【123】的提案', '1472623555', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7443', '64', '委员', '128', '提案人【委员2】向提案委提交了预案号【第一次037号】，案由【123】的提案', '1472623698', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7444', '64', '委员', '128', '提案人【委员2】向提案委提交了预案号【第一次038号】，案由【1235】的提案', '1472623698', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7445', '64', '委员', '128', '提案人【委员2】向提案委提交了预案号【第一次038号】，案由【1235】的提案', '1472623722', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7446', '64', '委员', '128', '提案人【委员2】向提案委提交了预案号【第一次039号】，案由【12351】的提案', '1472623722', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7447', '64', '委员', '129', '提案人【委员2】向提案委提交了预案号【第一次040号】，案由【a1】的提案', '1472624494', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7448', '64', '委员', '129', '提案人【委员2】向提案委提交了预案号【第一次041号】，案由【a1】的提案', '1472624494', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7449', '64', '委员', '130', '提案人【委员2】向提案委提交了预案号【第一次042号】，案由【a2】的提案', '1472624548', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7450', '66', '提案委', '129', '提案委【taw1】对提案人【委员2】，预案号【第一次041号】,案由【a1】的提案执行了已立案操作', '1472624582', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7451', '66', '提案委', '0', '', '1472624653', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7452', '69', '办理单位', '129', '', '1472626759', '13', '555', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7453', '67', '政府督查室', '0', '', '1472626902', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7454', '66', '提案委', '129', '政府督查室【taw1】对办理单位【】，提案人【委员2】，预案号【第一次041号】,案由【a1】的提案执行了已结案操作', '1472627234', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7455', '71', '委员', '131', '提案人【委员1】向提案委提交了预案号【第一次043号】，案由【a5】的提案', '1472627591', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7456', '66', '提案委', '131', '提案委【taw1】对提案人【委员1】，预案号【第一次043号】,案由【a5】的提案执行了已立案操作', '1472627621', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7457', '66', '提案委', '0', '', '1472627636', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7458', '68', '办理单位', '131', '办理单位【税务局】对提案人【】，预案号【第一次043号】,案由【a5】的提案执行了移交办理操作', '1472627680', '19', '555', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7459', '58', '提案委', '0', '', '1472633072', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7460', '71', '委员', '133', '提案人【委员1】向提案委提交了预案号【第一次045号】，案由【a6】的提案', '1472646039', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7461', '71', '委员', '133', '提案人【委员1】向提案委提交了预案号【第一次045号】，案由【a6】的提案', '1472646039', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7462', '71', '委员', '133', '提案人【委员1】向提案委提交了预案号【第一次045号】，案由【a6】的提案', '1472646136', '2', 'tttt', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7463', '71', '委员', '133', '提案人【委员1】向提案委提交了预案号【第一次045号】，案由【a6】的提案', '1472646136', '2', 'tttt', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7464', '66', '提案委', '133', '提案委【taw1】对提案人【委员1】，预案号【第一次045号】,案由【a6】的提案执行了已立案操作', '1472646158', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7465', '66', '提案委', '0', '', '1472646167', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7466', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7】的提案', '1472708812', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7467', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7】的提案', '1472708812', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7468', '71', '委员', '136', '提案人【委员1】向提案委提交了预案号【第一次048号】，案由【a8】的提案', '1472709562', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7469', '71', '委员', '136', '提案人【委员1】向提案委提交了预案号【第一次048号】，案由【a8】的提案', '1472709562', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7470', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7】的提案', '1472709708', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7471', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7_1】的提案', '1472709708', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7472', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7_1】的提案', '1472709746', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7473', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7_1】的提案', '1472709746', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7474', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7_1】的提案', '1472710169', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7475', '71', '委员', '135', '提案人【委员1】向提案委提交了预案号【第一次047号】，案由【a7_1】的提案', '1472710169', '2', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7476', '66', '提案委', '135', '提案委【taw1】对提案人【委员1】，预案号【第一次047号】,案由【a7_1】的提案执行了已立案操作', '1472710211', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7477', '66', '提案委', '0', '', '1472710301', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7478', '58', '办理单位', '77', '办理单位【】对提案人【】，预案号【】,案由【DADADFA】的提案执行了移交办理操作', '1472711432', '19', '幅度达沙发上发生载', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7479', '68', '办理单位', '135', '办理单位【税务局】对提案人【】，预案号【第一次047号】,案由【a7_1】的提案执行了移交办理操作', '1472711731', '19', '555', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7480', '70', '办理单位', '135', '', '1472712265', '13', '8888', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7481', '67', '政府督查室', '0', '', '1472712701', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7482', '66', '提案委', '135', '政府督查室【taw1】对办理单位【】，提案人【委员1】，预案号【第一次047号】,案由【a7_1】的提案执行了已结案操作', '1472713198', '9', '666666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7483', '58', '委员', '137', '提案人【3213】向提案委提交了预案号【第二次006号】，案由【323333】的提案', '1472717312', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7484', '58', '委员', '137', '提案人【3213】向提案委提交了预案号【第二次006号】，案由【323333】的提案', '1472717312', '2', '', '7333');
INSERT INTO `thinkox_proposal_process` VALUES ('7485', '58', '政府督查室', '44', '', '1472723493', '13', '你给我重办吧', '7330');
INSERT INTO `thinkox_proposal_process` VALUES ('7486', '58', '政府督查室', '44', '', '1472723537', '13', '这个必须要重办', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7487', '71', '委员', '139', '提案人【委员1】向提案委提交了预案号【第一次049号】，案由【a9】的提案', '1472730581', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7488', '71', '委员', '139', '提案人【委员1】向提案委提交了预案号【第一次049号】，案由【a9】的提案', '1472730581', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7489', '71', '委员', '140', '提案人【委员1】向提案委提交了预案号【第一次050号】，案由【a10】的提案', '1472730827', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7490', '71', '委员', '140', '提案人【委员1】向提案委提交了预案号【第一次050号】，案由【a10】的提案', '1472730827', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7491', '71', '委员', '141', '提案人【委员1】向提案委提交了预案号【第一次051号】，案由【a11】的提案', '1472731021', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7492', '66', '提案委', '139', '提案委【taw1】对提案人【委员1】，预案号【第一次049号】,案由【a9】的提案执行了已立案操作', '1472732136', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7493', '66', '提案委', '0', '', '1472732233', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7494', '68', '办理单位', '139', '办理单位【税务局】对提案人【】，预案号【第一次049号】,案由【a9】的提案执行了移交办理操作', '1472732585', '19', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7495', '70', '办理单位', '139', '', '1472734034', '13', '66666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7496', '67', '政府督查室', '0', '', '1472734103', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7497', '66', '提案委', '139', '政府督查室【taw1】对办理单位【】，提案人【委员1】，预案号【第一次049号】,案由【a9】的提案执行了已结案操作', '1472734276', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7498', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472778861', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7499', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472779299', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7500', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472779394', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7501', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472779812', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7502', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472779853', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7503', '58', '提案委', '82', '政府督查室【dominator】对办理单位【】，提案人【委员1】，预案号【】,案由【cs4】的提案执行了已结案操作', '1472779901', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7504', '58', '政府督查室', '77', '', '1472782084', '13', '我退回来了', '7336');
INSERT INTO `thinkox_proposal_process` VALUES ('7505', '71', '委员', '143', '提案人【委员1】向提案委提交了预案号【第一次052号】，案由【B1】的提案', '1472796718', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7506', '71', '委员', '144', '提案人【委员1】向提案委提交了预案号【第一次053号】，案由【B2】的提案', '1472796749', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7507', '71', '委员', '144', '提案人【委员1】向提案委提交了预案号【第一次053号】，案由【B2】的提案', '1472797093', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7508', '71', '委员', '145', '提案人【委员1】向提案委提交了预案号【第一次054号】，案由【B3】的提案', '1472797137', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7509', '71', '委员', '146', '提案人【委员1】向提案委提交了预案号【第一次055号】，案由【B5】的提案', '1472797206', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7510', '71', '委员', '148', '提案人【委员1】向提案委提交了预案号【第一次057号】，案由【B8】的提案', '1472797315', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7511', '71', '委员', '143', '提案人【委员1】向提案委提交了预案号【第一次052号】，案由【B1】的提案', '1472797440', '2', '77777', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7512', '66', '提案委', '143', '提案委【taw1】对提案人【委员1】，预案号【第一次052号】,案由【B1】的提案执行了退回操作', '1472797686', '3', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7513', '71', '委员', '143', '提案人【委员1】向提案委提交了预案号【第一次052号】，案由【B1】的提案', '1472798072', '2', '77777', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7514', '71', '委员', '148', '提案人【委员1】向提案委提交了预案号【第一次057号】，案由【B8】的提案', '1472798157', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7515', '66', '提案委', '148', '提案委【taw1】对提案人【委员1】，预案号【第一次057号】,案由【B8】的提案执行了未立案操作', '1472798262', '4', '777', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7516', '66', '提案委', '143', '提案委【taw1】对提案人【委员1】，预案号【第一次052号】,案由【B1】的提案执行了已立案操作', '1472798426', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7517', '66', '提案委', '0', '', '1472798878', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7518', '66', '提案委', '146', '提案委【taw1】对提案人【委员1】，预案号【第一次055号】,案由【B5】的提案执行了已立案操作', '1472798980', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7519', '66', '提案委', '145', '提案委【taw1】对提案人【委员1】，预案号【第一次054号】,案由【B3】的提案执行了已立案操作', '1472799014', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7520', '69', '办理单位', '143', '政府督查室【bldw2】对办理单位【公安局】，预案号【第一次052号】,案由【B1】的提案执行了办理反馈操作', '1472799614', '13', '222', '7405');
INSERT INTO `thinkox_proposal_process` VALUES ('7521', '67', '政府督查室', '0', '', '1472799810', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7522', '66', '提案委', '143', '政府督查室【taw1】对办理单位【】，提案人【委员1】，预案号【第一次052号】,案由【B1】的提案执行了已结案操作', '1472799874', '9', '77777', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7523', '66', '提案委', '0', '', '1472800779', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7524', '58', '委员', '151', '提案人【】向提案委提交了预案号【闭2016019号】，案由【312313】的提案', '1473323749', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7525', '64', '提案委', '0', '', '1473325943', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7526', '65', '政府督查室', '0', '', '1473332436', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7527', '59', '委员', '153', '提案人【】向提案委提交了预案号【第二次008号】，案由【t1】的提案', '1473334563', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7528', '59', '委员', '157', '提案人【】向提案委提交了预案号【闭2016020号】，案由【C5】的提案', '1473415757', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7529', '59', '委员', '155', '提案人【】向提案委提交了预案号【十五届一次会议002号】，案由【C2】的提案', '1473416329', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7530', '59', '委员', '154', '提案人【】向提案委提交了预案号【十五届一次会议001号】，案由【C1】的提案', '1473416354', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7531', '64', '提案委', '154', '提案人【】向提案委提交了预案号【十五届一次会议001号】，案由【C1】的提案', '1473434625', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7532', '64', '提案委', '154', '提案委【】对提案人【委员1】，预案号【十五届一次会议001号】,案由【C1】的提案执行了退回操作', '1473434650', '3', '333333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7533', '59', '委员', '154', '提案人【】向提案委提交了预案号【十五届一次会议001号】，案由【C1】的提案', '1473434696', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7534', '64', '提案委', '154', '提案委【】对提案人【委员1】，预案号【十五届一次会议001号】,案由【C1】的提案执行了已立案操作', '1473435043', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7535', '64', '提案委', '0', '', '1473435220', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7536', '64', '提案委', '153', '提案委【】对提案人【委员1】，预案号【第二次008号】,案由【t1】的提案执行了未立案操作', '1473435240', '4', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7537', '64', '提案委', '157', '提案委【】对提案人【委员1】，预案号【闭2016020号】,案由【C5】的提案执行了未立案操作', '1473435257', '4', '5555', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7538', '59', '委员', '158', '提案人【】向提案委提交了预案号【闭2016021号】，案由【C6】的提案', '1473435949', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7539', '64', '提案委', '158', '提案委【】对提案人【委员1】，预案号【闭2016021号】,案由【C6】的提案执行了已立案操作', '1473435985', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7540', '64', '提案委', '0', '', '1473436006', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7541', '65', '政府督查室', '0', '', '1473436721', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7542', '64', '提案委', '154', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议001号】,案由【C1】的提案执行了已结案操作', '1473436997', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7543', '64', '提案委', '146', '政府督查室【】对办理单位【】，提案人【】，预案号【第一次055号】,案由【B5】的提案执行了已结案操作', '1473437032', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7544', '59', '委员', '161', '提案人【】向提案委提交了预案号【十五届一次会议005号】，案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案', '1473496096', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7545', '59', '委员', '162', '提案人【】向提案委提交了预案号【十五届一次会议006号】，案由【关于发展我区众创空间的建议】的提案', '1473498360', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7546', '59', '委员', '163', '提案人【】向提案委提交了预案号【闭2016023号】，案由【关于支持我区台企转型升级的建议】的提案', '1473498403', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7547', '64', '提案委', '151', '提案委【】对提案人【】，预案号【闭2016019号】,案由【312313】的提案执行了已立案操作', '1473498982', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7548', '64', '提案委', '0', '', '1473498989', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7549', '64', '提案委', '162', '提案委【】对提案人【】，预案号【十五届一次会议006号】,案由【关于发展我区众创空间的建议】的提案执行了退回操作', '1473502156', '3', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7550', '59', '委员', '162', '提案人【】向提案委提交了预案号【十五届一次会议006号】，案由【关于发展我区众创空间的建议】的提案', '1473502995', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7551', '64', '提案委', '162', '提案委【】对提案人【】，预案号【十五届一次会议006号】,案由【关于发展我区众创空间的建议】的提案执行了未立案操作', '1473503050', '4', '不立案', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7552', '59', '委员', '164', '提案人【】向提案委提交了预案号【十五届一次会议007号】，案由【D1】的提案', '1473506206', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7553', '64', '提案委', '164', '提案委【】对提案人【委员1】，预案号【十五届一次会议007号】,案由【D1】的提案执行了退回操作', '1473506262', '3', '66666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7554', '59', '委员', '156', '提案人【】向提案委提交了预案号【十五届一次会议003号】，案由【C3】的提案', '1473506380', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7555', '64', '提案委', '156', '提案人【】向提案委提交了预案号【十五届一次会议003号】，案由【C3】的提案', '1473506409', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7556', '64', '提案委', '156', '提案人【】向提案委提交了预案号【十五届一次会议003号】，案由【C3】的提案', '1473506440', '2', '33333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7557', '64', '提案委', '156', '提案委【】对提案人【委员1】，预案号【十五届一次会议003号】,案由【C3】的提案执行了已立案操作', '1473506447', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7558', '59', '委员', '165', '提案人【】向提案委提交了预案号【十五届一次会议008号】，案由【333】的提案', '1473506488', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7559', '59', '委员', '166', '提案人【】向提案委提交了预案号【闭2016024号】，案由【D2】的提案', '1473506520', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7560', '64', '提案委', '166', '提案委【】对提案人【委员1】，预案号【闭2016024号】,案由【D2】的提案执行了已立案操作', '1473506608', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7561', '64', '提案委', '0', '', '1473506619', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7562', '66', '办理单位', '166', '政府督查室【】对办理单位【】，预案号【闭2016024号】,案由【D2】的提案执行了办理反馈操作', '1473508776', '13', '3333', '7423');
INSERT INTO `thinkox_proposal_process` VALUES ('7563', '67', '办理单位', '158', '政府督查室【】对办理单位【】，预案号【闭2016021号】,案由【C6】的提案执行了办理反馈操作', '1473509214', '13', '8888', '7417');
INSERT INTO `thinkox_proposal_process` VALUES ('7564', '65', '政府督查室', '0', '', '1473512782', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7565', '64', '提案委', '158', '政府督查室【】对办理单位【】，提案人【】，预案号【闭2016021号】,案由【C6】的提案执行了已结案操作', '1473513301', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7566', '62', '集体', '168', '提案人【】向提案委提交了预案号【十五届一次会议010号】，案由【关于加强公开承诺工程项目建设的建议】的提案', '1473514447', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7567', '64', '提案委', '168', '提案委【】对提案人【民族街联络委员会】，预案号【十五届一次会议010号】,案由【关于加强公开承诺工程项目建设的建议】的提案执行了已立案操作', '1473514531', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7568', '62', '集体', '169', '提案人【】向提案委提交了预案号【十五届一次会议011号】，案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案', '1473514845', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7569', '64', '提案委', '169', '提案人【】向提案委提交了预案号【十五届一次会议011号】，案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案', '1473515328', '2', '建议', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7570', '64', '提案委', '169', '提案人【】向提案委提交了预案号【十五届一次会议011号】，案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案', '1473515337', '2', '建议', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7571', '64', '提案委', '169', '提案委【】对提案人【民族街联络委员会】，预案号【十五届一次会议011号】,案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案执行了已立案操作', '1473515355', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7572', '64', '提案委', '0', '', '1473515369', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7573', '62', '集体', '170', '提案人【】向提案委提交了预案号【十五届一次会议012号】，案由【关于多渠道建设公共停车场的建议】的提案', '1473516387', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7574', '64', '提案委', '170', '提案人【】向提案委提交了预案号【十五届一次会议012号】，案由【关于多渠道建设公共停车场的建议】的提案', '1473516442', '2', '66666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7575', '64', '提案委', '170', '提案委【】对提案人【民族街联络委员会】，预案号【十五届一次会议012号】,案由【关于多渠道建设公共停车场的建议】的提案执行了已立案操作', '1473516449', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7576', '64', '提案委', '0', '', '1473518106', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7577', '66', '办理单位', '169', '办理单位【】对提案人【民族街联络委员会】，预案号【十五届一次会议011号】,案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案执行了移交办理操作', '1473518169', '19', '6666', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7578', '67', '办理单位', '169', '政府督查室【】对办理单位【】，预案号【十五届一次会议011号】,案由【关于改善道路洒水清洁方式，提高环境卫生水平的建议】的提案执行了办理反馈操作', '1473518365', '13', '888', '7429');
INSERT INTO `thinkox_proposal_process` VALUES ('7579', '65', '政府督查室', '0', '', '1473518451', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7580', '64', '提案委', '142', '政府督查室【】对办理单位【】，提案人【】，预案号【闭2016018号】,案由【test005】的提案执行了已结案操作', '1473519371', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7581', '68', '办理单位', '166', '政府督查室【】对办理单位【】，预案号【闭2016024号】,案由【D2】的提案执行了办理反馈操作', '1473561245', '13', '重办吧', '7424');
INSERT INTO `thinkox_proposal_process` VALUES ('7582', '64', '提案委', '161', '提案人【】向提案委提交了预案号【十五届一次会议005号】，案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案', '1473562849', '2', 'aaaaaa', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7583', '64', '提案委', '161', '提案人【】向提案委提交了预案号【十五届一次会议005号】，案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案', '1473562866', '2', '建议很好', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7584', '64', '提案委', '161', '提案人【】向提案委提交了预案号【十五届一次会议005号】，案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案', '1473562879', '2', '非常很好', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7585', '64', '提案委', '161', '提案委【】对提案人【委员1】，预案号【十五届一次会议005号】,案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案执行了已立案操作', '1473562888', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7586', '64', '提案委', '0', '', '1473563629', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7587', '64', '提案委', '139', '政府督查室【】对办理单位【】，提案人【】，预案号【第一次049号】,案由【a9】的提案执行了已结案操作', '1473578735', '9', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7588', '59', '委员', '172', '提案人【】向提案委提交了预案号【十五届一次会议013号】，案由【CS1】的提案', '1473578933', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7589', '64', '提案委', '172', '提案人【】向提案委提交了预案号【十五届一次会议013号】，案由【CS1】的提案', '1473578983', '2', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7590', '64', '提案委', '172', '提案委【】对提案人【委员1】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已立案操作', '1473579001', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7591', '64', '提案委', '0', '', '1473579027', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7592', '65', '政府督查室', '0', '', '1473579213', '1', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7593', '64', '提案委', '172', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已结案操作', '1473579370', '9', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7594', '64', '提案委', '172', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已结案操作', '1473579595', '9', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7595', '64', '提案委', '172', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已结案操作', '1473579735', '9', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7596', '64', '提案委', '172', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已结案操作', '1473580224', '9', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7597', '64', '提案委', '172', '政府督查室【】对办理单位【】，提案人【】，预案号【十五届一次会议013号】,案由【CS1】的提案执行了已结案操作', '1473580284', '9', '3333', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7598', '59', '委员', '173', '提案人【】向提案委提交了预案号【十五届一次会议014号】，案由【C2】的提案', '1473580361', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7599', '64', '提案委', '173', '提案委【】对提案人【委员1】，预案号【十五届一次会议014号】,案由【C2】的提案执行了已立案操作', '1473580403', '8', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7600', '66', '办理单位', '161', '政府督查室【】对办理单位【】，预案号【十五届一次会议005号】,案由【关于推动健康产业升级,加快“环同济健康城”建设的建议案】的提案执行了办理反馈操作', '1473595604', '13', '不符合要求', '7430');
INSERT INTO `thinkox_proposal_process` VALUES ('7601', '60', '委员', '174', '提案人【】向提案委提交了预案号【十五届一次会议015号】，案由【C1】的提案', '1473596100', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7602', '60', '委员', '176', '提案人【】向提案委提交了预案号【十五届一次会议017号】，案由【CC3】的提案', '1473596133', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7603', '60', '委员', '177', '提案人【】向提案委提交了预案号【十五届一次会议018号】，案由【22】的提案', '1473596605', '2', '', null);
INSERT INTO `thinkox_proposal_process` VALUES ('7604', '59', '委员', '164', '提案人【】向提案委提交了预案号【十五届一次会议007号】，案由【D1】的提案', '1473743668', '2', '', null);

-- ----------------------------
-- Table structure for thinkox_proposal_result
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal_result`;
CREATE TABLE `thinkox_proposal_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `group_id` int(10) NOT NULL,
  `proposal_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `rate` varchar(255) NOT NULL COMMENT '自己评价',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '办理单位信息状态',
  `to_status` tinyint(2) NOT NULL,
  `suggest` varchar(250) DEFAULT NULL COMMENT '内容',
  `leader` varchar(20) DEFAULT NULL COMMENT '分管领导',
  `leaderphone` varchar(20) DEFAULT NULL COMMENT '领导电话',
  `contact` varchar(20) DEFAULT NULL COMMENT '联系人',
  `telephone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `link_type` varchar(30) DEFAULT NULL COMMENT '沟通方式',
  `link_time` int(10) DEFAULT NULL COMMENT '沟通时间',
  `fujian` varchar(200) DEFAULT NULL COMMENT '附件',
  `wenhao` varchar(20) NOT NULL COMMENT '文号',
  `unit` varchar(50) NOT NULL COMMENT '单位',
  `comment` char(10) NOT NULL COMMENT '评价',
  PRIMARY KEY (`id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7433 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of thinkox_proposal_result
-- ----------------------------
INSERT INTO `thinkox_proposal_result` VALUES ('7303', '0', '0', '0', '', '1470906090', '1', '0', null, '323232', null, '3222222', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7304', '58', '0', '26', '', '2016', '2', '0', '', '3232', '', '3232', '', '0', '0', null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7305', '58', '9', '26', 'C', '1970', '0', '0', '4324324234', '78', '', '98', '', '0', '1971', null, '323232', '43434', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7306', '58', '9', '26', '', '1470907289', '3', '0', null, '7899', null, '98998', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7307', '58', '9', '22', '', '1470907687', '3', '0', null, '123456', null, '45454', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7308', '58', '9', '22', '', '1470907721', '3', '0', null, '123456', null, '45454', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7309', '58', '9', '22', '', '1470907805', '3', '0', null, '3232', null, '333333333333', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7327', '58', '9', '40', '', '0', '2', '0', 'fdsafasfasf', '323232', 'safasfasfasfasf', '3222222', 'as', '坐谈', '1920', 'sfasfasf', '', '', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7328', '58', '9', '40', '', '0', '1', '0', 'fdsafsafasfasfasfasfasfasfasfsa', '323232', '', '3222222', '', '走访', '1920', '4332432423432', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7325', '4', '9', '36', '', '1471253534', '1', '0', null, '22', null, '333', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7326', '4', '9', '40', '', '1471331483', '2', '0', null, '齐生', null, '飞鸟儿', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7321', '58', '9', '36', '', '1970', '3', '0', 'asfsafasfasfasf', '323232', 'fsadfsa342343', '3222222', 'fasfasfasf2432432432', '127', '33333', 'fsdafdsafsaf', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7330', '58', '9', '44', '', '0', '5', '0', 'fdsafasfdsafasfasfsaf', 'test\\1111', '', '434343111', '', '0', '0', 'asfasfasfasfasfasfasfasfasf', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7346', '69', '9', '82', '', '1472033568', '2', '0', '3333', '22', '3', '33', '3', '127', '333', '333', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7333', '58', '7', '44', '', '0', '5', '0', 'FDSAFSAF SF ASDF SA FAWE RW W F F', '小红', '11385552464', '小红1', '416468579', '3', '4685469', 'DSFSDAFAS FDSAF ', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7334', '58', '7', '42', '', '1471411703', '2', '0', ' 械霜期寺工', '小红12', '13333333333', '小红133', '16666666666', '2', '2147483647', '短发是否打算fsa44478768768343243242魂牵梦萦霜期sad54353454353432432432425555555555555555555555', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7335', '58', '7', '45', '', '1471411735', '5', '0', '放得开沙发空间覉国d', '小方', '14445856685', '大方', '77899685546', '22', '3243242', '魂牵梦萦地顶戴的萨芬械霜期333', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7336', '58', '9', '77', '', '0', '5', '0', '', '11', '', '222', '', '0', '1472659200', '', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7337', '58', '9', '77', '', '1471498256', '3', '0', '666666', '112', '6666', '3333', '66666', '6', '6666', '', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7338', '61', '9', '14', '', '1471590448', '1', '0', null, '222', null, '112', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7340', '59', '9', '14', '', '1471590506', '1', '0', null, '333', null, '3443', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7341', '61', '9', '14', '', '1471590532', '1', '0', null, '44', null, '5454', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7342', '62', '9', '14', '', '1471591210', '1', '0', null, '3323', null, '3343', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7350', '68', '9', '79', '', '1472034418', '3', '0', '444', '1', '', '2', '', '127', '666', '222', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7351', '70', '9', '79', '', '1472034422', '3', '0', '4444', '11', '', '22', '', '127', '444', '444', '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7352', '0', '8', '79', '', '1472109546', '1', '0', null, '', null, '', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7353', '70', '9', '39', '', '1472109718', '1', '0', null, '1', null, '2', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7354', '69', '9', '39', '', '1472109729', '1', '0', null, '11', null, '22', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7355', '70', '9', '39', '', '1472109953', '1', '0', null, 'fdsf', null, 'fdfd', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7356', '70', '9', '39', '', '1472109964', '3', '0', null, '33', null, '444', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7357', '70', '9', '82', '', '1472113462', '1', '0', null, '343', null, '333', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7358', '58', '8', '74', '', '1472115746', '5', '0', null, '2231', null, '212', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7364', '58', '8', '74', '', '2016', '2', '0', '', '11', '', '222', '', '0', '0', null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7360', '68', '8', '72', '', '2016', '0', '0', '', '22', '', '3', '', '0', '0', null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7361', '69', '8', '72', '', '1472194193', '1', '0', null, '33', null, '33', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7362', '69', '8', '73', '', '1472194419', '1', '0', null, 'ww', null, 'eer', null, null, null, null, '', '', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7363', '62', '8', '73', '', '1472195805', '1', '0', null, '122', null, '3232', null, null, null, null, '', '啊哈啊', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7365', '68', '8', '90', '', '2016', '2', '0', '3333', '1', '3', '2', '3', '127', '33', null, '33', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7366', '69', '8', '90', '', '1970', '2', '0', '3', '1', '1', '2', '2', '111', '222', null, '3333', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7377', '69', '8', '112', '', '1472555762', '3', '0', null, '11', null, '22', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7371', '68', '8', '93', '', '1472460395', '3', '0', null, 'qwe', null, 'qweq', null, null, null, null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7369', '69', '8', '92', '', '2016', '5', '0', '', '1', '', '2', '', '0', '0', null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7370', '61', '8', '93', '', '1472459629', '2', '0', null, '阿大', null, '阿二', null, null, null, null, '', '美国', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7375', '68', '8', '112', '', '2016', '0', '0', '', '1', '', '2', '', '0', '0', null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7378', '70', '8', '112', '', '1970', '0', '0', '3333', '111', '22', '222', '333', '127', '333', null, '3333', '水务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7379', '68', '8', '33', '', '1472611435', '1', '0', null, '34324', null, '343434', null, null, null, null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7380', '70', '8', '33', '', '1472611571', '1', '0', null, '33', null, '22', null, null, null, null, '', '水务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7381', '68', '8', '123', 'A', '2016', '1', '0', '5555', '001', '33', '002', '44', '电话', '2015', null, '1111', '税务局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7382', '69', '8', '123', '', '1472622013', '1', '0', null, '大哥', null, '小弟', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7386', '68', '8', '129', 'A', '1970', '2', '0', '111', '11', '11', '22', '11', '0', '1970', null, '1111', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7385', '69', '8', '129', 'C', '2016', '5', '0', '', '1', '1', '2', '2', '0', '0', null, '111', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7387', '69', '8', '131', '', '2016', '2', '0', '', '1', '', '2', '', null, '0', null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7388', '68', '8', '131', '', '1472627653', '3', '0', null, '12', null, '22', null, null, null, null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7389', '70', '8', '131', '', '2016', '2', '0', '', '1', '', '2', '', null, '0', null, '', '水务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7390', '62', '8', '131', '', '1472633421', '1', '0', null, '333', null, '4343', null, null, null, null, '', '啊哈啊', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7391', '61', '8', '131', '', '1472634799', '1', '0', null, '32223', null, '2323', null, null, null, null, '', '美国', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7394', '68', '8', '133', '', '1970', '1', '1', '', '1', '', '2', '', null, '1970', null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7395', '68', '8', '133', '', '2016', '1', '1', '', '11', '', '22', '', null, '0', null, '', '水务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7396', '68', '8', '135', '', '1472710947', '3', '0', null, '1', null, '2', null, null, null, null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7397', '69', '8', '135', 'A', '1970', '2', '0', '5555', '11', '2', '22', '4', '电话', '1970', null, '11', '公安局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7398', '70', '8', '135', 'A', '1970', '2', '0', '3', '55', '2', '66', '54', '电话', '1970', null, '3', '水务局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7402', '68', '8', '139', '', '1472732406', '3', '0', null, '11', null, '22', null, null, null, null, '', '税务局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7401', '69', '8', '139', 'A', '1970', '2', '0', '333', '1', '2', '2', '3', '电话', '1970', null, '222', '公安局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7403', '70', '8', '139', 'A', '1970', '2', '0', '3', '55', '2', '666', '3', '电话', '1970', null, '2', '水务局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7404', '68', '8', '143', 'A', '1472745600', '2', '0', '3333', '12', '33', '2', '3', '电话', '1472745600', null, '1', '税务局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7405', '69', '8', '143', 'A', '1472745600', '2', '0', '333', '11', '2', '22', '3', '电话', '1472832000', null, '222', '公安局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7406', '69', '8', '145', '', '1472745600', '2', '0', '333', 'sss', '2', '333', '3', '走访', '1472832000', null, '222', '公安局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7408', '66', '8', '146', '', '1473327219', '3', '0', null, '1', null, '2', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7409', '67', '8', '146', '', '1473264000', '2', '0', '', '2', '', '3', '', '电话', '0', null, '', '水利局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7410', '68', '8', '146', 'B', '1473264000', '2', '0', '', '112', '', '22', '', '电话', '0', null, '6676', '税务局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7411', '66', '8', '98', 'A 已经解决或采纳的', '1473264000', '5', '0', '333', '1', '2', '2', '3', '电话', '1472832000', null, '1', '公安局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7412', '68', '8', '98', 'B 列入计划拟解决的', '1473264000', '2', '0', '333', '1', '2', '3', '5', '走访', '1472745600', null, '666', '税务局', '3');
INSERT INTO `thinkox_proposal_result` VALUES ('7413', '67', '8', '98', 'C 留做参考', '1473264000', '2', '0', '5', '1', '2', '4', '3', '坐谈', '0', null, '3333', '水利局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7414', '66', '8', '154', '', '1473435391', '3', '0', null, '1', null, '2', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7415', '68', '8', '154', 'B 列入计划拟解决的', '1473350400', '2', '0', '333', '11', '22', '222', '3', '走访', '0', null, '1333', '税务局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7416', '67', '8', '154', 'A 已经解决或采纳的', '1473350400', '2', '0', '22', '111', '1', '2222', '2', '电话', '1472745600', null, '11', '水利局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7417', '67', '8', '158', 'A 已经解决或采纳的', '1473350400', '2', '0', '65555', '1', '2', '2', '3', '电话', '1472832000', null, '2', '水利局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7419', '66', '8', '151', '', '1473499299', '1', '0', null, '222', null, '111', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7424', '68', '8', '166', 'A 已经解决或采纳的', '1473436800', '1', '0', '333', '11', '1', '22', '2', '走访', '1473436800', null, '111', '税务局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7425', '66', '8', '169', '', '1473515449', '3', '0', null, '1', null, '2', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7423', '66', '8', '166', 'B 列入计划拟解决的', '1473436800', '5', '0', '2222', '1', '2', '2', '3', '电话', '1473436800', null, '222', '公安局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7426', '68', '8', '169', 'A 已经解决或采纳的', '1473436800', '2', '0', '3333', '11', '1', '22', '2', '电话', '1473436800', null, '333', '税务局', '2');
INSERT INTO `thinkox_proposal_result` VALUES ('7427', '66', '8', '170', '', '1473518141', '1', '0', null, '1', null, '2', null, null, null, null, '', '公安局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7428', '67', '8', '170', '', '1473518146', '1', '0', null, '11', null, '22', null, null, null, null, '', '水利局', '');
INSERT INTO `thinkox_proposal_result` VALUES ('7429', '67', '8', '169', 'A 已经解决或采纳的', '1473436800', '2', '0', '2222', '111', '1', '222', '2', '走访', '1473523200', null, '1', '水利局', '3');
INSERT INTO `thinkox_proposal_result` VALUES ('7430', '66', '8', '161', 'A 已经解决或采纳的', '1473523200', '5', '0', '3333', '王局长', '22', '张三', '33', '电话', '1472659200', null, '2222', '公安局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7431', '68', '8', '161', 'A 已经解决或采纳的', '1473523200', '2', '0', '', '刘局长', '', '李四', '', '电话', '1474560000', null, '222', '税务局', '1');
INSERT INTO `thinkox_proposal_result` VALUES ('7432', '66', '8', '172', 'B 列入计划拟解决的', '1473523200', '2', '0', '555', '1', '2', '2', '3', '走访', '1473696000', null, '22', '公安局', '2');

-- ----------------------------
-- Table structure for thinkox_proposal_suggest
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal_suggest`;
CREATE TABLE `thinkox_proposal_suggest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '回复人',
  `proposal_id` int(11) NOT NULL COMMENT '提案ID',
  `content` text NOT NULL COMMENT '建议内容',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` int(11) NOT NULL COMMENT '反馈状态',
  `to_status` int(11) NOT NULL COMMENT '针对状态提出的反馈',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_proposal_suggest
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_proposal_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_proposal_type`;
CREATE TABLE `thinkox_proposal_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_proposal_type
-- ----------------------------
INSERT INTO `thinkox_proposal_type` VALUES ('6', '经济发展类', '1473734815', '1473734813', '1', '0', '0', '0');
INSERT INTO `thinkox_proposal_type` VALUES ('7', '社会事业类', '1473734834', '1473734823', '1', '0', '0', '0');
INSERT INTO `thinkox_proposal_type` VALUES ('8', '城市建设与管理类', '1473734845', '1473734836', '1', '0', '0', '0');
INSERT INTO `thinkox_proposal_type` VALUES ('9', '科教文卫体', '1473734851', '1473734847', '1', '0', '0', '0');
INSERT INTO `thinkox_proposal_type` VALUES ('10', '其他', '1473734857', '1473734853', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_rank
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_rank`;
CREATE TABLE `thinkox_rank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '上传者id',
  `title` varchar(50) NOT NULL,
  `logo` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `types` tinyint(2) NOT NULL DEFAULT '1' COMMENT '前台是否可申请',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_rank
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_rank_user
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_rank_user`;
CREATE TABLE `thinkox_rank_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `is_show` tinyint(4) NOT NULL COMMENT '是否显示在昵称右侧（必须有图片才可）',
  `create_time` int(11) NOT NULL,
  `status` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_rank_user
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_seo_rule
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_seo_rule`;
CREATE TABLE `thinkox_seo_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `app` varchar(40) NOT NULL,
  `controller` varchar(40) NOT NULL,
  `action` varchar(40) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `seo_keywords` text NOT NULL,
  `seo_description` text NOT NULL,
  `seo_title` text NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_seo_rule
-- ----------------------------
INSERT INTO `thinkox_seo_rule` VALUES ('4', '整站标题', '', '', '', '1', '', '', 'ThinkOX', '7');
INSERT INTO `thinkox_seo_rule` VALUES ('6', '论坛版块页', 'forum', 'index', 'forum', '1', '{$forum.title} ', '{$forum.title} ', '{$forum.title} —— ThinkOX论坛', '2');
INSERT INTO `thinkox_seo_rule` VALUES ('7', '微博首页', 'Weibo', 'Index', 'index', '1', '微博', '微博首页', 'ThinkOX轻量化社交框架', '5');
INSERT INTO `thinkox_seo_rule` VALUES ('8', '微博详情页', 'Weibo', 'Index', 'weiboDetail', '1', '{$weibo.title|op_t},Thinkox,ox,微博', '{$weibo.content|op_t}\r\n', '{$weibo.content|op_t}——ThinkOX微博', '6');
INSERT INTO `thinkox_seo_rule` VALUES ('9', '用户中心', 'usercenter', 'index', 'index', '1', '{$user_info.nickname|op_t},Thinkox', '{$user_info.username|op_t}的个人主页', '{$user_info.nickname|op_t}的个人主页', '3');
INSERT INTO `thinkox_seo_rule` VALUES ('10', '会员页面', 'people', 'index', 'index', '1', '会员', '会员', '会员', '4');
INSERT INTO `thinkox_seo_rule` VALUES ('11', '论坛帖子详情页', 'forum', 'index', 'detail', '1', '{$post.title|op_t},论坛,thinkox', '{$post.title|op_t}', '{$post.title|op_t} —— ThinkOX论坛', '1');
INSERT INTO `thinkox_seo_rule` VALUES ('12', '商城首页', 'shop', 'index', 'index', '1', '商城,积分', '积分商城', '商城首页——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('13', '商城商品详情页', 'shop', 'index', 'goodsdetail', '1', '{$content.goods_name|op_t},商城', '{$content.goods_name|op_t}', '{$content.goods_name|op_t}——ThinkOX商城', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('14', '资讯首页', 'blog', 'index', 'index', '1', '资讯首页', '资讯首页\r\n', '资讯——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('15', '资讯列表页', 'blog', 'article', 'lists', '1', '{$category.title|op_t}', '{$category.title|op_t}', '{$category.title|op_t}', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('16', '资讯文章页', 'blog', 'article', 'detail', '1', '{$info.title|op_t}', '{$info.title|op_t}', '{$info.title|op_t}——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('17', '活动首页', 'event', 'index', 'index', '1', '活动', '活动首页', '活动首页——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('18', '活动详情页', 'event', 'index', 'detail', '1', '{$content.title|op_t}', '{$content.title|op_t}', '{$content.title|op_t}——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('19', '专辑首页', 'issue', 'index', 'index', '1', '专辑', '专辑首页', '专辑首页——ThinkOX', '0');
INSERT INTO `thinkox_seo_rule` VALUES ('20', '专辑详情页', 'issue', 'index', 'issuecontentdetail', '1', '{$content.title|op_t}', '{$content.title|op_t}', '{$content.title|op_t}——ThinkOX', '0');

-- ----------------------------
-- Table structure for thinkox_shop
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop`;
CREATE TABLE `thinkox_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(25) NOT NULL COMMENT '商品名称',
  `goods_ico` int(11) NOT NULL COMMENT '商品图标',
  `goods_introduct` varchar(100) NOT NULL COMMENT '商品简介',
  `goods_detail` text NOT NULL COMMENT '商品详情',
  `tox_money_need` int(11) NOT NULL COMMENT '需要金币数',
  `goods_num` int(11) NOT NULL COMMENT '商品余量',
  `changetime` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态，-1：删除；0：禁用；1：启用',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `category_id` int(11) NOT NULL,
  `is_new` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否为新品',
  `sell_num` int(11) NOT NULL DEFAULT '0' COMMENT '已出售量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='商品信息';

-- ----------------------------
-- Records of thinkox_shop
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_shop_address
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_address`;
CREATE TABLE `thinkox_shop_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `zipcode` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `change_time` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `phone` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of thinkox_shop_address
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_shop_buy
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_buy`;
CREATE TABLE `thinkox_shop_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `goods_num` int(11) NOT NULL COMMENT '购买数量',
  `status` tinyint(4) NOT NULL COMMENT '状态，-1：未领取；0：申请领取；1：已领取',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `createtime` int(11) NOT NULL COMMENT '购买时间',
  `gettime` int(11) NOT NULL COMMENT '交易结束时间',
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='购买商品信息表';

-- ----------------------------
-- Records of thinkox_shop_buy
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_shop_category
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_category`;
CREATE TABLE `thinkox_shop_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(25) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_shop_category
-- ----------------------------
INSERT INTO `thinkox_shop_category` VALUES ('1', '奖品', '1403507725', '1403507717', '1', '0', '0');

-- ----------------------------
-- Table structure for thinkox_shop_config
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_config`;
CREATE TABLE `thinkox_shop_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ename` varchar(25) NOT NULL COMMENT '标识',
  `cname` varchar(25) NOT NULL COMMENT '中文名称',
  `changetime` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商店配置';

-- ----------------------------
-- Records of thinkox_shop_config
-- ----------------------------
INSERT INTO `thinkox_shop_config` VALUES ('1', 'tox_money', '金币', '1403507688');
INSERT INTO `thinkox_shop_config` VALUES ('2', 'min_sell_num', '10', '1403489181');

-- ----------------------------
-- Table structure for thinkox_shop_log
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_log`;
CREATE TABLE `thinkox_shop_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_shop_log
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_shop_see
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_shop_see`;
CREATE TABLE `thinkox_shop_see` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_shop_see
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_super_links
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_super_links`;
CREATE TABLE `thinkox_super_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '类别（1：图片，2：普通）',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '站点名称',
  `cover_id` int(10) NOT NULL COMMENT '图片ID',
  `link` char(140) NOT NULL DEFAULT '' COMMENT '链接地址',
  `level` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='友情连接表';

-- ----------------------------
-- Records of thinkox_super_links
-- ----------------------------
INSERT INTO `thinkox_super_links` VALUES ('5', '2', '想天科技', '0', 'http://www.ourstu.com', '0', '1', '1407156786');
INSERT INTO `thinkox_super_links` VALUES ('6', '2', 'Onethink', '0', 'http://www.onethink.cn', '0', '1', '1407156813');
INSERT INTO `thinkox_super_links` VALUES ('7', '1', 'ThinkOX', '92', 'http://tox.ourstu.com', '0', '1', '1407156830');

-- ----------------------------
-- Table structure for thinkox_support
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_support`;
CREATE TABLE `thinkox_support` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appname` varchar(20) NOT NULL COMMENT '应用名',
  `row` int(11) NOT NULL COMMENT '应用标识',
  `uid` int(11) NOT NULL COMMENT '用户',
  `create_time` int(11) NOT NULL COMMENT '发布时间',
  `table` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='支持的表';

-- ----------------------------
-- Records of thinkox_support
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_survey
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_survey`;
CREATE TABLE `thinkox_survey` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '序号',
  `uid` int(11) NOT NULL,
  `time` int(11) NOT NULL COMMENT '时间',
  `author` varchar(20) NOT NULL COMMENT '作者',
  `type_id` varchar(50) NOT NULL COMMENT '类别',
  `title` varchar(150) NOT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '备注',
  `upload` varchar(10) NOT NULL COMMENT '文件上传',
  `phone` varchar(20) NOT NULL COMMENT '电话',
  `people` varchar(50) NOT NULL COMMENT '参与人员',
  `people_view` text NOT NULL COMMENT '展示参与人员',
  `speak` varchar(200) NOT NULL COMMENT '发言情况',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_survey
-- ----------------------------
INSERT INTO `thinkox_survey` VALUES ('125', '0', '0', '212121', '2', '332', '2332', '', '0', '233', '', '');
INSERT INTO `thinkox_survey` VALUES ('126', '0', '1473651471', 'wyy1', '', '报告111', '这是内容content', '', '', '59,71,60,61', '', '');
INSERT INTO `thinkox_survey` VALUES ('127', '59', '1473651612', 'wyy1', '', '我是test1', 'kafjdsakljfsakl', '', '', '59,71,60,61', '', '');
INSERT INTO `thinkox_survey` VALUES ('128', '59', '1473651654', 'wyy1', '', 'test01', 'abc', '', '', '59,71,60,61', '', '');
INSERT INTO `thinkox_survey` VALUES ('129', '59', '1473651808', 'wyy1', '4', 'test002', '这次一定要成功', '', '', '59,71,60,61', '', '');
INSERT INTO `thinkox_survey` VALUES ('130', '59', '1473652329', 'wyy1', '3', 'test003', 'testoo3 tent', '', '', '59,71,60,61', 'dfsafasfdasdf', '');
INSERT INTO `thinkox_survey` VALUES ('131', '59', '1473656332', 'wyy1', '3', '32432', '324324', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('132', '59', '1473660345', 'wyy1', '2', '参与人员test001', '这是我的内容啊', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('133', '59', '1473660678', 'wyy1', '3', '再试一下', '看有没有', '', '', '', '', '');
INSERT INTO `thinkox_survey` VALUES ('134', '59', '1473660794', 'wyy1', '2', 'test009', '123212312312', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('135', '59', '1473660794', 'wyy1', '2', 'test009', '123212312312', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('136', '59', '1473660794', 'wyy1', '2', 'test009', '123212312312', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('137', '59', '1473660794', 'wyy1', '2', 'test009', '123212312312', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('138', '59', '1473660794', 'wyy1', '2', 'test009', '123212312312', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('139', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('140', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('141', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('142', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('143', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('144', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('145', '59', '1473661086', 'wyy1', '2', 'test004', '2342342342', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('146', '59', '1473661299', 'wyy1', '1', 'test008', '123213', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('147', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('148', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('149', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('150', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('151', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('152', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('153', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('154', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('155', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('156', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('157', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('158', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('159', '59', '1473661381', 'wyy1', '3', '432432432432', '34324234', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('160', '59', '1473661889', 'wyy1', '2', 'test007', '这是一个测试的调研报告 ', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '');
INSERT INTO `thinkox_survey` VALUES ('161', '59', '1473662204', '委员1', '2', 'test017', '123456', '', '', '59,71,60,61', '(提案委),,(经科委),(文史委),', '1,2,3');

-- ----------------------------
-- Table structure for thinkox_survey_attend
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_survey_attend`;
CREATE TABLE `thinkox_survey_attend` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `creat_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '0为报名，1为参加',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_survey_attend
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_survey_type
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_survey_type`;
CREATE TABLE `thinkox_survey_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `allow_post` tinyint(4) NOT NULL,
  `pid` int(11) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_survey_type
-- ----------------------------
INSERT INTO `thinkox_survey_type` VALUES ('1', '经济发展类', '1403859500', '1473410813', '1', '0', '0', '0');
INSERT INTO `thinkox_survey_type` VALUES ('2', '社会事业类', '1403859511', '1473410827', '1', '0', '0', '0');
INSERT INTO `thinkox_survey_type` VALUES ('3', '城市建设与管理类', '1473410683', '1473410842', '1', '0', '0', '0');
INSERT INTO `thinkox_survey_type` VALUES ('4', '科教文卫体', '1473410862', '1473410850', '1', '0', '0', '0');
INSERT INTO `thinkox_survey_type` VALUES ('5', '其他', '1473410872', '1473410866', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for thinkox_sync_login
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_sync_login`;
CREATE TABLE `thinkox_sync_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `type_uid` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `oauth_token` varchar(255) NOT NULL,
  `oauth_token_secret` varchar(255) NOT NULL,
  `is_sync` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_sync_login
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_talk
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_talk`;
CREATE TABLE `thinkox_talk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `uids` varchar(100) NOT NULL,
  `appname` varchar(30) NOT NULL,
  `apptype` varchar(30) NOT NULL,
  `source_id` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `source_title` varchar(100) NOT NULL,
  `source_content` text NOT NULL,
  `source_url` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `message_id` int(11) NOT NULL,
  `other_uid` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=164 DEFAULT CHARSET=utf8 COMMENT='会话表';

-- ----------------------------
-- Records of thinkox_talk
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_talk_message
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_talk_message`;
CREATE TABLE `thinkox_talk_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(500) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=278 DEFAULT CHARSET=utf8 COMMENT='聊天消息表';

-- ----------------------------
-- Records of thinkox_talk_message
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_talk_message_push
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_talk_message_push`;
CREATE TABLE `thinkox_talk_message_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `source_id` int(11) NOT NULL COMMENT '来源消息id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `status` tinyint(4) NOT NULL,
  `talk_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=gbk COMMENT='状态，0为未提示，1为未点击，-1为已点击';

-- ----------------------------
-- Records of thinkox_talk_message_push
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_talk_push
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_talk_push`;
CREATE TABLE `thinkox_talk_push` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '接收推送的用户id',
  `source_id` int(11) NOT NULL COMMENT '来源id',
  `create_time` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态，0为未提示，1为未点击，-1为已点击',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COMMENT='对话推送表';

-- ----------------------------
-- Records of thinkox_talk_push
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_ucenter_admin`;
CREATE TABLE `thinkox_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of thinkox_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_ucenter_member`;
CREATE TABLE `thinkox_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(16) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  `openid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of thinkox_ucenter_member
-- ----------------------------
INSERT INTO `thinkox_ucenter_member` VALUES ('1', 'admin', '10a88cd5168bbe7138be197a94432f02', 'admin@admin.com', '15871430887', '1473307054', '2002945241', '1473744067', '2002830702', '1473307054', '1', 'ohz2CwSbVrSDH17rLS5Std7QvW8Q');
INSERT INTO `thinkox_ucenter_member` VALUES ('59', 'wyy1', '15fd393b9afb34bc38d323657f811c61', '2@qq.com', '13886199168', '1473320049', '2002945241', '1473760924', '2002830702', '1473320049', '1', 'ohz2Cwa3zHI5gcI03qfeqlzJEzds');
INSERT INTO `thinkox_ucenter_member` VALUES ('60', 'wyy2', '15fd393b9afb34bc38d323657f811c61', '3@qq.com', '', '1473320081', '2002945241', '1473752199', '1035423177', '1473320081', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('61', 'wyy3', '15fd393b9afb34bc38d323657f811c61', '5@qq.com', '', '1473320099', '2002945241', '1473489786', '2002830702', '1473320099', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('62', 'jt1', '15fd393b9afb34bc38d323657f811c61', '6@qq.com', '15871430887', '1473320126', '2002945241', '1473516136', '2002830702', '1473320126', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('63', 'jt2', '15fd393b9afb34bc38d323657f811c61', '8@qq.com', '', '1473320142', '2002945241', '0', '0', '1473320142', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('64', 'taw', '15fd393b9afb34bc38d323657f811c61', '1@qq.com', '', '1473320167', '2002945241', '1473734029', '3707332670', '1473320167', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('65', 'dcs', '15fd393b9afb34bc38d323657f811c61', '9@qq.com', '', '1473320189', '2002945241', '1473648546', '2002830702', '1473320189', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('66', 'bldw1', '15fd393b9afb34bc38d323657f811c61', '12@qq.com', '', '1473320226', '2002945241', '1473738396', '2002830702', '1473320226', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('67', 'bldw2', '15fd393b9afb34bc38d323657f811c61', '13@qq.com', '', '1473320247', '2002945241', '1473738382', '2002830702', '1473320247', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('68', 'bldw3', '15fd393b9afb34bc38d323657f811c61', '15@qq.com', '', '1473320266', '2002945241', '1473647947', '2002830702', '1473320266', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('69', 'zxbgs', '15fd393b9afb34bc38d323657f811c61', '115@qq.com', '', '1473338138', '2002945241', '1473745113', '2002830702', '1473338138', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('70', 'bgszr', '15fd393b9afb34bc38d323657f811c61', '66@qq.com', '', '1473338265', '2002945241', '1473745092', '2002830702', '1473338265', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('71', '12', '15fd393b9afb34bc38d323657f811c61', '23@qq.com', '', '1473414695', '2002830702', '0', '0', '1473414695', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('75', 'domintor', '10a88cd5168bbe7138be197a94432f02', 'fdafas@qq.com', 'f32313', '0', '0', '0', '0', '0', '0', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('76', 'cccct', '10a88cd5168bbe7138be197a94432f02', '332223', '11', '0', '0', '0', '0', '0', '0', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('81', 'feixia', '1111', 'dfsafsa@qq.com', '23232', '1473475374', '2002830702', '0', '0', '1473475374', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('95', '23423aaa', '367945e9876e5039868e89dd57b26f7e', 'dfsdfas@qq.com', '', '1473479229', '2002830702', '0', '0', '1473479229', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('96', 'dominator', '15fd393b9afb34bc38d323657f811c61', '545646@qq.com', '', '1473479297', '2002830702', '1473736440', '2002830702', '1473479297', '1', null);
INSERT INTO `thinkox_ucenter_member` VALUES ('97', '18696492998', '15fd393b9afb34bc38d323657f811c61', '231@qq.com', '18696492998', '1473665128', '2002830702', '0', '0', '1473665128', '1', 'ohz2CwZcqid9mnaknjX3belrJVbo');
INSERT INTO `thinkox_ucenter_member` VALUES ('98', '15629156212', '15fd393b9afb34bc38d323657f811c61', '88@qq.com', '', '1473669019', '2002830702', '0', '0', '1473669019', '1', 'ohz2CwdQWQ3HhfP9yBjaYA_TuAQA');

-- ----------------------------
-- Table structure for thinkox_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_ucenter_setting`;
CREATE TABLE `thinkox_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of thinkox_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_url
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_url`;
CREATE TABLE `thinkox_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of thinkox_url
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_user_token
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_user_token`;
CREATE TABLE `thinkox_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_user_token
-- ----------------------------
INSERT INTO `thinkox_user_token` VALUES ('14', '1', '5MjRgA3NVZCKrvc1Ehn8ybt26xe0DlYIpBQ9SHXU', '1470712563');

-- ----------------------------
-- Table structure for thinkox_weibo
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_weibo`;
CREATE TABLE `thinkox_weibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `is_top` tinyint(4) NOT NULL,
  `type` varchar(255) NOT NULL,
  `data` text NOT NULL,
  `repost_count` int(11) NOT NULL,
  `from` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=574 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_weibo
-- ----------------------------
INSERT INTO `thinkox_weibo` VALUES ('405', '1', '我发表了一个新的帖子【看我来发个贴贴吧】：http://www.thinkox.com/index.php?s=/forum/index/detail/id/1.html', '1469600893', '0', '1', '0', 'feed', 'a:0:{}', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('406', '58', '我发布了一个新的会议【顶戴dsafsa】：http://www.thinkox.com/index.php?s=/meet/index/detail/id/10.html', '1470014422', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('407', '1', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/9.html', '1470634143', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('408', '1', '我发布了一个新的活动【334324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/10.html', '1470649209', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('409', '1', '我发布了一个新的活动【21321321321313213】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/11.html', '1470649265', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('410', '1', '我发布了一个新的活动【asfasfas】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/12.html', '1470649376', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('411', '1', '我发布了一个新的活动【32432】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/13.html', '1470650372', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('412', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/14.html', '1470732629', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('413', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/15.html', '1470732650', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('414', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/16.html', '1470732745', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('415', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/17.html', '1470732828', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('416', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/18.html', '1470732857', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('417', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470732872', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('418', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470732929', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('419', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470732934', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('420', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470807561', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('421', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470807566', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('422', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470816396', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('423', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470816401', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('424', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470816411', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('425', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470820649', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('426', '58', '我修改了活动【家33213123】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/22.html', '1470822199', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('427', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/19.html', '1470879744', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('428', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/18.html', '1470879751', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('429', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/17.html', '1470879757', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('430', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/16.html', '1470879778', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('431', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/15.html', '1470879787', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('432', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/14.html', '1470879813', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('433', '58', '我发布了一个新的活动【11】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248266', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('434', '58', '我发布了一个新的活动【eeee】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248287', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('435', '58', '我发布了一个新的活动【555】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248365', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('436', '58', '我发布了一个新的活动【324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248475', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('437', '58', '我发布了一个新的活动【fasfasfsaf】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248528', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('438', '58', '我发布了一个新的活动【safsafas】：http://www.thinkox.com/index.php?s=/proposal/index/detail.html', '1471248534', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('439', '58', '我发布了一个新的活动【222】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/26.html', '1471248695', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('440', '58', '我发布了一个新的活动【5555】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471248720', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('441', '58', '我发布了一个新的活动【3】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/28.html', '1471248737', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('442', '58', '我发布了一个新的活动【432432】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/29.html', '1471248895', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('443', '58', '我发布了一个新的活动【324234234】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/30.html', '1471248947', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('444', '58', '我发布了一个新的活动【4324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/31.html', '1471248970', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('445', '58', '我发布了一个新的活动【4324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/32.html', '1471250371', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('446', '58', '我发布了一个新的活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250424', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('447', '58', '我发布了一个新的活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/34.html', '1471250454', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('448', '58', '我发布了一个新的活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/35.html', '1471250486', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('449', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250784', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('450', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250816', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('451', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250891', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('452', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250904', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('453', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250951', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('454', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250955', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('455', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471250981', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('456', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251018', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('457', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251038', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('458', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251087', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('459', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251134', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('460', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251165', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('461', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251375', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('462', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/33.html', '1471251411', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('463', '58', '我发布了一个新的活动【555】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/38.html', '1471251480', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('464', '58', '我发布了一个新的活动【888】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471251509', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('465', '58', '我修改了活动【555】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/38.html', '1471251579', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('466', '58', '我修改了活动【888】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471251624', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('467', '58', '我修改了活动【888】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471251635', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('468', '58', '我修改了活动【888】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471251661', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('469', '58', '我发布了一个新的活动【第一个提案】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/40.html', '1471329659', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('470', '58', '我修改了活动【第一个提案】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/40.html', '1471329891', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('471', '58', '我发布了一个新的活动【test11111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/41.html', '1471340110', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('472', '58', '我修改了活动【test11111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/41.html', '1471340117', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('473', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471397807', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('474', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471397822', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('475', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471397856', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('476', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471397985', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('477', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471398017', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('478', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471398024', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('479', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471398110', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('480', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471398120', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('481', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471398382', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('482', '58', '我修改了活动【test002】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471401096', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('483', '58', '我修改了活动【test002】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471401117', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('484', '58', '我修改了活动【test002】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/39.html', '1471401143', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('485', '58', '我修改了活动【我是一只大毛驴】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/27.html', '1471401196', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('486', '58', '我修改了活动【test002】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/25.html', '1471402337', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('487', '58', '我发布了一个新的活动【一个提案】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/42.html', '1471410912', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('488', '58', '我修改了活动【一个提案】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/42.html', '1471411149', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('489', '58', '我发布了一个新的活动【2222】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/43.html', '1471496067', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('490', '58', '我发布了一个新的活动【123】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/44.html', '1471496086', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('491', '58', '我修改了活动【123】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/44.html', '1471496255', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('492', '58', '我发布了一个新的活动【556】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/45.html', '1471496573', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('493', '58', '我修改了活动【556】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/45.html', '1471496878', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('494', '58', '我修改了活动【556】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/45.html', '1471496978', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('495', '58', '我修改了活动【556】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/45.html', '1471497038', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('496', '58', '我发布了一个新的活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/46.html', '1471497378', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('497', '58', '我修改了活动【1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/46.html', '1471497539', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('498', '58', '我发布了一个新的活动【55】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/47.html', '1471497653', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('499', '58', '我修改了活动【55】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/47.html', '1471497743', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('500', '58', '我修改了活动【111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/34.html', '1471499700', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('501', '58', '我修改了活动【333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/17.html', '1471499985', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('502', '58', '我发布了一个新的活动【asfasfasfasf】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/48.html', '1471504186', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('503', '58', '我发布了一个新的活动【4333333333333333333】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/49.html', '1471504221', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('504', '58', '我发布了一个新的活动【324324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/50.html', '1471504797', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('505', '58', '我修改了活动【324324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/50.html', '1471504812', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('506', '58', '我修改了活动【324324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/50.html', '1471504816', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('507', '58', '我发布了一个新的活动【s鞋柜栽植asf】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/51.html', '1471504877', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('508', '58', '我修改了活动【s鞋柜栽植asf】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/51.html', '1471572444', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('509', '58', '我发布了一个新的活动【121212121212121】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/52.html', '1471572498', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('510', '58', '我发布了一个新的活动【121212121212121】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/53.html', '1471572535', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('511', '58', '我发布了一个新的活动【3213213】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/54.html', '1471576829', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('512', '58', '我发布了一个新的活动【423】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/55.html', '1471576892', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('513', '58', '我发布了一个新的活动【324234】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/56.html', '1471576999', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('514', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/57.html', '1471577035', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('515', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/58.html', '1471577148', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('516', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/59.html', '1471577405', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('517', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/60.html', '1471577483', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('518', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/61.html', '1471577495', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('519', '58', '我发布了一个新的活动【asfsafsa】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/62.html', '1471577739', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('520', '58', '我发布了一个新的活动【案由啊】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/63.html', '1471850038', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('521', '58', '我修改了活动【案由啊】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/63.html', '1471850153', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('522', '58', '我发布了一个新的活动【434343】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/64.html', '1471850176', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('523', '58', '我修改了活动【434343】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/64.html', '1471850184', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('524', '58', '我修改了活动【434343】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/64.html', '1471850292', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('525', '58', '我修改了活动【434343】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/64.html', '1471850307', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('526', '58', '我发布了一个新的活动【fsdaf dsaf asf das】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/65.html', '1471852598', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('527', '58', '我发布了一个新的活动【4324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/66.html', '1471852680', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('528', '58', '我发布了一个新的活动【432】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/67.html', '1471852728', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('529', '58', '我发布了一个新的活动【ewqrwqr】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/72.html', '1471852944', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('530', '58', '我发布了一个新的活动【324324】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/74.html', '1471853015', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('531', '58', '我发布了一个新的活动【哈哈哈】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/75.html', '1472015193', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('532', '58', '我发布了一个新的活动【432432】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/76.html', '1472015224', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('533', '58', '我发布了一个新的活动【DADADFA】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/77.html', '1472015293', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('534', '58', '我发布了一个新的活动【heheh】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/78.html', '1472015350', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('535', '58', '我修改了活动【heheh】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/78.html', '1472018225', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('536', '71', '我发布了一个新的活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472024168', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('537', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472024379', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('538', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472024936', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('539', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472024956', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('540', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472024992', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('541', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472028705', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('542', '71', '我修改了活动【cs1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/79.html', '1472031204', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('543', '71', '我发布了一个新的活动【cs2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/80.html', '1472031269', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('544', '71', '我发布了一个新的活动【cs3】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/81.html', '1472031318', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('545', '71', '我发布了一个新的活动【cs4】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/82.html', '1472032027', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('546', '71', '我发布了一个新的活动【cs5】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/83.html', '1472032045', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('547', '71', '我发布了一个新的活动【test1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/84.html', '1472181921', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('548', '71', '我发布了一个新的活动【test1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/85.html', '1472182001', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('549', '71', '我发布了一个新的活动【test2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/86.html', '1472182051', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('550', '71', '我发布了一个新的活动【test2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/87.html', '1472182083', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('551', '71', '我发布了一个新的活动【432423432】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/88.html', '1472182486', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('552', '71', '我发布了一个新的活动【ts1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/89.html', '1472182534', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('553', '71', '我修改了活动【ts1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/89.html', '1472182543', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('554', '64', '我发布了一个新的活动【ta1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/90.html', '1472193865', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('555', '64', '我发布了一个新的活动【ta1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/91.html', '1472198607', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('556', '64', '我修改了活动【ta2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/91.html', '1472198633', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('557', '64', '我修改了活动【ta1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/90.html', '1472199147', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('558', '64', '我修改了活动【ta1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/90.html', '1472199487', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('559', '64', '我修改了活动【ta1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/90.html', '1472199582', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('560', '65', '我发布了一个新的活动【ta2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/92.html', '1472199761', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('561', '64', '我发布了一个新的活动【ta3】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/93.html', '1472202775', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('562', '64', '我发布了一个新的活动【ta5】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/94.html', '1472202820', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('563', '64', '我发布了一个新的活动【1111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/95.html', '1472470912', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('564', '64', '我发布了一个新的活动【222】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/96.html', '1472471291', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('565', '58', '我发布了一个新的活动【我要一个提案】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/97.html', '1472471336', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('566', '64', '我发布了一个新的活动【test1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/98.html', '1472474095', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('567', '64', '我修改了活动【test1】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/98.html', '1472474151', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('568', '58', '我发布了一个新的活动【eee】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/99.html', '1472535818', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('569', '58', '我修改了活动【eee】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/99.html', '1472535872', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('570', '58', '我发布了一个新的活动【rererere】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/100.html', '1472535935', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('571', '58', '我修改了活动【1111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/95.html', '1472538159', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('572', '58', '我修改了活动【ta5111111111111111111111111111】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/94.html', '1472538294', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');
INSERT INTO `thinkox_weibo` VALUES ('573', '64', '我发布了一个新的活动【2】：http://www.thinkox.com/index.php?s=/proposal/index/detail/id/101.html', '1472544057', '0', '1', '0', 'feed', 's:0:\"\";', '0', '');

-- ----------------------------
-- Table structure for thinkox_weibo_comment
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_weibo_comment`;
CREATE TABLE `thinkox_weibo_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `weibo_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `to_comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_weibo_comment
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_weibo_top
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_weibo_top`;
CREATE TABLE `thinkox_weibo_top` (
  `weibo_id` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`weibo_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='置顶微博表';

-- ----------------------------
-- Records of thinkox_weibo_top
-- ----------------------------

-- ----------------------------
-- Table structure for thinkox_weiyuan1
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_weiyuan1`;
CREATE TABLE `thinkox_weiyuan1` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `uid` int(5) NOT NULL,
  `cardid` varchar(20) NOT NULL COMMENT '身份证号',
  `code` varchar(20) NOT NULL COMMENT '编号',
  `realname` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `oldname` varchar(20) DEFAULT NULL COMMENT '曾用名',
  `sex` tinyint(2) NOT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `nation` tinyint(3) NOT NULL COMMENT '民族',
  `native` tinyint(3) NOT NULL COMMENT '籍贯',
  `yzbm` varchar(8) DEFAULT NULL,
  `politics` tinyint(3) NOT NULL COMMENT '政治面貌',
  `education` tinyint(3) NOT NULL COMMENT '文化程度',
  `job` varchar(20) DEFAULT NULL COMMENT '职称',
  `partyjob` varchar(20) DEFAULT NULL,
  `nowjob` varchar(20) DEFAULT NULL COMMENT '现任职称',
  `workunit` varchar(50) DEFAULT NULL COMMENT '工作单位',
  `recommendunit` varchar(50) DEFAULT NULL COMMENT '推荐单位',
  `workaddress` varchar(50) DEFAULT NULL COMMENT '单位地址',
  `workphone` varchar(15) DEFAULT NULL COMMENT '办公电话',
  `jobdate` datetime DEFAULT NULL COMMENT '入职时间',
  `partydate` datetime DEFAULT NULL COMMENT '入党时间',
  `party` tinyint(3) DEFAULT NULL COMMENT '党派',
  `zwh` tinyint(4) DEFAULT NULL COMMENT '专委会',
  `jdllw` tinyint(4) DEFAULT NULL COMMENT '街道联络委',
  `jiebie` tinyint(4) DEFAULT NULL,
  `iscw` tinyint(2) DEFAULT NULL COMMENT '是否常委',
  `isswy` tinyint(2) DEFAULT NULL COMMENT '是否省委员',
  `isqwy` tinyint(2) DEFAULT NULL COMMENT '是否区委员',
  `mobile` varchar(15) DEFAULT NULL COMMENT '手机号',
  `homephone` varchar(15) DEFAULT NULL COMMENT '家庭电话',
  `homeaddress` varchar(100) DEFAULT NULL COMMENT '家庭地址',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(15) DEFAULT NULL COMMENT 'QQ',
  `identity` tinyint(4) DEFAULT NULL COMMENT '社会身份',
  `avtar` varchar(50) DEFAULT NULL COMMENT '头像',
  `resume` varchar(100) DEFAULT NULL COMMENT '简历',
  `ishq` tinyint(2) DEFAULT NULL COMMENT '是否华侨',
  `interests` varchar(50) DEFAULT NULL COMMENT '兴趣爱好',
  `note` varchar(100) DEFAULT NULL COMMENT '备注',
  `wystatus` tinyint(4) DEFAULT NULL COMMENT '委员状态',
  `form` varchar(50) DEFAULT NULL COMMENT '属地',
  `marry` tinyint(2) DEFAULT NULL COMMENT '婚烟',
  `religion` tinyint(4) DEFAULT NULL COMMENT '宗教',
  `joinzxdate` datetime DEFAULT NULL COMMENT '加入政协日期',
  `quitzxdate` datetime DEFAULT NULL COMMENT '退出政协日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_weiyuan1
-- ----------------------------
INSERT INTO `thinkox_weiyuan1` VALUES ('1', '0', '', '', '432', '432', '0', '0000-00-00', '0', '0', '434', '0', '0', '', '', '', '23', '', '', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', null, '0', '0', '0', '0', '0', '0', '', '24', '', '', '24', '0', null, '', '0', '', '', null, '', null, '0', null, '0000-00-00 00:00:00');
INSERT INTO `thinkox_weiyuan1` VALUES ('2', '0', '', '23432', '432423', '423', '0', '0000-00-00', '0', '127', '', '0', '0', '', '32', '424', '2', '', '', '2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', null, '0', '0', '127', '0', '0', '0', '424', '', '', '24242423423', '424242', '0', null, '', '0', '', '', null, '', null, '0', null, '0000-00-00 00:00:00');
INSERT INTO `thinkox_weiyuan1` VALUES ('3', '0', '', '23432', '432423', '423', '0', '0000-00-00', '0', '127', '', '0', '0', '', '32', '424', '2', '', '', '2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', null, '0', '0', '127', '0', '0', '0', '424', '', '', '24242423423', '424242', '0', null, '', '0', '', '', null, '', null, '0', null, '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for thinkox_working
-- ----------------------------
DROP TABLE IF EXISTS `thinkox_working`;
CREATE TABLE `thinkox_working` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(40) NOT NULL COMMENT '发布人',
  `time` int(11) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` longtext NOT NULL COMMENT '内容',
  `upload` varchar(50) NOT NULL COMMENT '文件上传',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `bstatus` tinyint(1) unsigned zerofill DEFAULT NULL,
  `back` text NOT NULL COMMENT '退回意见',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thinkox_working
-- ----------------------------
INSERT INTO `thinkox_working` VALUES ('19', 'wyy1', '1475295132', '工作进度表', '工作进度表工作进度表工作进度表', '', '3', '3', '0');
INSERT INTO `thinkox_working` VALUES ('34', 'wyy1', '1475295132', '范德萨范德萨发', '发的萨芬萨芬多少', '', '3', '3', '');
INSERT INTO `thinkox_working` VALUES ('20', 'wyy1', '1475295132', '的萨芬的撒发生地方', '发的撒发生大幅度', '', '3', '3', '0');
INSERT INTO `thinkox_working` VALUES ('33', 'wyy1', '1475295132', '范德萨范德萨发', '反对撒反对撒', '', '2', '1', '');
INSERT INTO `thinkox_working` VALUES ('22', 'wyy1', '1475295132', 'fdsfadsafdsxxx', 'fdsafsdafdsxxx', 'xxxxx', '3', '3', '');
INSERT INTO `thinkox_working` VALUES ('23', 'wyy1', '1475295132', 'cccccccc', 'cccccccccccccc', 'cccccccccc', '3', '3', '');
INSERT INTO `thinkox_working` VALUES ('24', 'wyy1', '1475295132', 'ddfsfa', 'dsafdaf', 'fdsafsdfaf', '2', '3', '');
INSERT INTO `thinkox_working` VALUES ('32', 'wyy1', '1475295132', '反对撒反对撒', '放大舒服的萨芬', '', '2', '2', '');
INSERT INTO `thinkox_working` VALUES ('37', 'wyy1', '1475295132', '反对撒发生答复', '反对萨芬的萨芬的', '', '2', '2', '');
INSERT INTO `thinkox_working` VALUES ('38', 'wyy1', '1475295132', '范德萨范德萨发', '范德萨范德萨发', '', '3', '1', '');
INSERT INTO `thinkox_working` VALUES ('39', 'wyy1', '1475295132', '放到沙发上发呆撒', '反对撒反对撒', '', '2', '1', '');
INSERT INTO `thinkox_working` VALUES ('40', 'wyy1', '1475295132', '发的撒撒', '反对撒反对撒', '', '3', '2', '');
INSERT INTO `thinkox_working` VALUES ('43', 'wyy1', '1475295132', '最后一次测试', '<p>最后一次测试最后一次测试最后一次测试最后一次测试</p>', '', '2', '1', '');
INSERT INTO `thinkox_working` VALUES ('36', 'wyy1', '1475295132', '反对撒发生答复', '反对撒发生答复', '', '2', '2', '发的撒发生大幅度撒');
INSERT INTO `thinkox_working` VALUES ('35', 'wyy1', '1475295132', '终审测试终审测试终审测试终审测试', '<p>终审测试终审测试</p>', '', '3', '1', '');
INSERT INTO `thinkox_working` VALUES ('31', 'wyy1', '1475295132', '终审测试终审测试终审测试', '<p>终审测试终审测试</p>', '', '3', '1', '');
INSERT INTO `thinkox_working` VALUES ('44', 'wyy1', '1475295132', '四十四寺十四侍', '<p>反对萨芬双打</p>', '', '2', '1', '');
INSERT INTO `thinkox_working` VALUES ('45', 'wyy2', '1475295132', 't1', '<p>22222</p>', '', '2', '1', '');
INSERT INTO `thinkox_working` VALUES ('46', 'wyy2', '1475295132', 't28888', '<p>222228888</p>', '', '3', '3', '');
INSERT INTO `thinkox_working` VALUES ('52', 'wyy1', '2016', 'sssssssssssss', '<p>反对撒反对撒</p>', '', '1', '0', '');
