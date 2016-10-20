-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 11 月 18 日 13:45
-- 服务器版本: 5.5.38
-- PHP 版本: 5.3.28

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 数据库: `110`
--

-- --------------------------------------------------------

--
-- 表的结构 `thinkox_wap`
--

CREATE TABLE IF NOT EXISTS `thinkox_wap` (
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=405 ;

--
-- 转存表中的数据 `thinkox_wap`
--

-- --------------------------------------------------------

--
-- 表的结构 `thinkox_wap_comment`
--

CREATE TABLE IF NOT EXISTS `thinkox_wap_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `wap_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `create_time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `to_comment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- 转存表中的数据 `thinkox_wap_comment`
--


-- --------------------------------------------------------

--
-- 表的结构 `thinkox_wap_top`
--

CREATE TABLE IF NOT EXISTS `thinkox_wap_top` (
  `wap_id` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`wap_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='置顶微博表';


--
-- 转存表中的数据 `thinkox_issue_content`
--
INSERT INTO `thinkox_menu` (`title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
( '微博', 0, 8, 'wap/wap', 0, '', '', 0);

set @tmp_id=0;
select @tmp_id:= id from thinkox_menu where title = '微博';

INSERT INTO `thinkox_menu` ( `title`, `pid`, `sort`, `url`, `hide`, `tip`, `group`, `is_dev`) VALUES
( '微博管理', @tmp_id, 1, 'wap/wap', 0, '', '微博', 0),
( '回复管理', @tmp_id, 3, 'wap/comment', 0, '', '回复', 0),
( '编辑微博', @tmp_id, 0, 'wap/editwap', 1, '', '', 0),
( '编辑回复', @tmp_id, 0, 'wap/editComment', 1, '', '', 0),
( '微博回收站', @tmp_id, 2, 'wap/wapTrash', 0, '', '微博', 0),
( '回复回收站', @tmp_id, 4, 'wap/commentTrash', 0, '', '回复', 0),
( '微博设置', @tmp_id, 0, 'wap/config', 0, '微博的基本配置', '设置', 0);


INSERT INTO `thinkox_auth_rule` ( `module`, `type`, `name`, `title`, `status`, `condition`) VALUES
( 'wap', 1, 'sendwap', '发微博', 1, ''),
( 'wap', 1, 'deletewap', '删除微博', 1, ''),
( 'wap', 1, 'setwapTop', '微博置顶', 1, ''),
( 'wap', 1, 'beTopicAdmin', '抢先成为话题主持人', 1, ''),
( 'wap', 1, 'manageTopic', '管理话题', 1, '');
