/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : dbaudioweb

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-08-24 11:11:57
*/
CREATE DATABASE IF NOT EXISTS DBAUDIOWEB DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

USE DBAUDIOWEB;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for baseattribs
-- ----------------------------
DROP TABLE IF EXISTS `baseattribs`;
CREATE TABLE `baseattribs` (
  `valueid` varchar(50) NOT NULL DEFAULT '',
  `valuename` varchar(50) NOT NULL DEFAULT '',
  `issingleselection` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`valueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of baseattribs
-- ----------------------------
INSERT INTO `baseattribs` VALUES ('寻呼话筒优先级', '3', '');
INSERT INTO `baseattribs` VALUES ('文件广播目录', 'E:\\test', '');
INSERT INTO `baseattribs` VALUES ('系统名称', '数字校园广播系统', '');
INSERT INTO `baseattribs` VALUES ('系统所有者', '索普电子', '');
INSERT INTO `baseattribs` VALUES ('终端点播优先级', '4', '');
INSERT INTO `baseattribs` VALUES ('终端点播目录', 'E:\\test', '');
INSERT INTO `baseattribs` VALUES ('终端采播优先级', '3', '');

-- ----------------------------
-- Table structure for domains
-- ----------------------------
DROP TABLE IF EXISTS `domains`;
CREATE TABLE `domains` (
  `ParentDomainId` int(50) NOT NULL,
  `DomainId` int(50) NOT NULL COMMENT '区域ID号',
  `DomainName` varchar(50) NOT NULL COMMENT '区域的名字',
  `isuse` bit(1) NOT NULL,
  PRIMARY KEY (`DomainId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of domains
-- ----------------------------
INSERT INTO `domains` VALUES ('0', '1', '未分区', '');

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `lid` int(100) NOT NULL AUTO_INCREMENT,
  `userid` varchar(100) NOT NULL,
  `logtype` varchar(20) DEFAULT NULL,
  `function` varchar(20) DEFAULT NULL,
  `logcontent` varchar(50) DEFAULT NULL,
  `logtime` varchar(20) NOT NULL,
  `IP` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`lid`),
  KEY `userid` (`userid`) USING BTREE,
  KEY `logtime` (`logtime`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `mid` int(11) NOT NULL,
  `parentmid` int(11) DEFAULT NULL,
  `mlevel` int(11) NOT NULL,
  `mname` varchar(10) NOT NULL,
  `mintroduce` varchar(50) DEFAULT NULL,
  `murl` varchar(50) NOT NULL,
  `micon` varchar(50) NOT NULL,
  `isopen` bit(1) DEFAULT b'0',
  `isenabled` bit(1) NOT NULL DEFAULT b'1',
  `note` varchar(100) DEFAULT NULL,
  `refresh` bit(1) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '广播控制', null, '#', 'menu-icon fa   fa-cog blue', '', '', null, '\0');
INSERT INTO `menu` VALUES ('2', '0', '1', '定时广播', null, '#', 'menu-icon fa  fa-bell-o orange', '', '', null, '\0');
INSERT INTO `menu` VALUES ('3', '0', '1', '文件广播', null, '#', 'menu-icon fa  fa-folder green', '', '', null, '\0');
INSERT INTO `menu` VALUES ('4', '0', '1', '采播管理', null, '#', 'menu-icon fa  fa-bolt black', '', '', null, '\0');
INSERT INTO `menu` VALUES ('5', '0', '1', '系统管理', null, '#', 'menu-icon fa  fa-desktop ', '', '', null, '\0');
INSERT INTO `menu` VALUES ('6', '1', '2', '运行状态', null, 'termstatus/listTermStatus.do', 'menu-icon fa fa-bar-chart-o pink', '\0', '', null, '');
INSERT INTO `menu` VALUES ('7', '1', '2', '任务管理', null, 'taskmanage/listTask', 'menu-icon fa  fa-cogs blue', '\0', '', null, '');
INSERT INTO `menu` VALUES ('8', '3', '2', '文件列表管理', null, 'filecast/toFileManage', 'menu-icon fa  fa-folder-open red', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('9', '2', '2', '方案管理', null, 'timedcast/listSchedules', 'menu-icon fa  fa-adjust green', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('11', '0', '1', '权限管理', '', '#', 'menu-icon fa  fa-key blue ', '', '', null, '\0');
INSERT INTO `menu` VALUES ('12', '11', '2', '角色管理', null, 'users/listRole.do', 'menu-icon fa  fa-lock orange', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('13', '11', '2', '用户管理', null, 'users/listAllUsers.do', 'menu-icon fa  fa-users', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('14', '4', '2', '实时采播', null, 'realtimecast/toCast', 'menu-icon fa  fa-bullhorn blue', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('17', '2', '2', '定时任务管理', '', 'timedcast/listScheTasks.do', 'menu-icon fa  fa-calendar blue', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('18', '5', '2', '基本设置', null, 'system/toBaseset', 'menu-icon fa  fa-asterisk pink', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('19', '5', '2', '分区管理', null, 'domain/listAllDomains.do', 'menu-icon fa  fa-folder-o blue', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('20', '5', '2', '终端管理', null, 'terminal/listAllTerm.do', 'menu-icon fa  fa-folder-open-o green', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('23', '4', '2', '终端采播', null, 'termcast/listTermTasks', 'menu-icon fa  fa-download green', '\0', '', null, '\0');
INSERT INTO `menu` VALUES ('24', '3', '2', '文件广播', null, 'filecast/toCast', 'menu-icon fa fa-headphones pick', '\0', '', null, '\0');

-- ----------------------------
-- Table structure for playlist
-- ----------------------------
DROP TABLE IF EXISTS `playlist`;
CREATE TABLE `playlist` (
  `playid` int(11) NOT NULL,
  `playname` varchar(255) NOT NULL,
  `palymusic` text,
  `palypath` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`playid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playlist
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(80) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(80) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(80) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  `cron_expression` varchar(120) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(80) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  `instance_name` varchar(80) NOT NULL,
  `fired_time` bigint(20) NOT NULL,
  `sched_time` bigint(20) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(80) DEFAULT NULL,
  `job_group` varchar(80) DEFAULT NULL,
  `is_nonconcurrent` int(11) DEFAULT NULL,
  `requests_recovery` int(11) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
INSERT INTO `qrtz_fired_triggers` VALUES ('quartzScheduler', 'SF15666153522121566615352164', 'RefreshJob', 'RefreshJob', 'SF1566615352212', '1566615688228', '1566615700669', '5', 'ACQUIRED', null, null, '0', '0');

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(80) NOT NULL,
  `job_group` varchar(80) NOT NULL,
  `description` varchar(120) DEFAULT NULL,
  `job_class_name` varchar(128) NOT NULL,
  `is_durable` int(11) NOT NULL,
  `is_nonconcurrent` int(11) NOT NULL,
  `is_update_data` int(11) NOT NULL,
  `requests_recovery` int(11) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', 'RefreshJob', 'RefreshJob', null, 'com.audioweb.quartzjob.RefreshJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787000737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000010770800000010000000007800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('dufy_test', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('scheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(80) NOT NULL,
  `last_checkin_time` bigint(20) NOT NULL,
  `checkin_interval` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('quartzScheduler', 'SF1566615352212', '1566615682418', '60000');

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(80) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  `repeat_count` bigint(20) NOT NULL,
  `repeat_interval` bigint(20) NOT NULL,
  `times_triggered` bigint(20) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
INSERT INTO `qrtz_simple_triggers` VALUES ('quartzScheduler', 'RefreshJob', 'RefreshJob', '-1', '65000', '8');

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(80) NOT NULL,
  `trigger_group` varchar(80) NOT NULL,
  `job_name` varchar(80) NOT NULL,
  `job_group` varchar(80) NOT NULL,
  `description` varchar(120) DEFAULT NULL,
  `next_fire_time` bigint(20) DEFAULT NULL,
  `prev_fire_time` bigint(20) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL COMMENT 'WAITING:等待   PAUSED:暂停  ACQUIRED:正常执行  BLOCKED：阻塞  ERROR：错误',
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(20) NOT NULL,
  `end_time` bigint(20) DEFAULT NULL,
  `calendar_name` varchar(80) DEFAULT NULL,
  `misfire_instr` smallint(6) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'RefreshJob', 'RefreshJob', 'RefreshJob', 'RefreshJob', null, '1566615700669', '1566615635669', '5', 'ACQUIRED', 'SIMPLE', '1566615180669', '0', null, '4', '');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `RoleId` int(20) NOT NULL,
  `RoleName` varchar(50) NOT NULL,
  `MenuRights` varchar(50) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `isuse` bit(1) NOT NULL DEFAULT b'1',
  `RoleLevel` varchar(2) NOT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', '总管理员', '27163646', null, '', '0');
INSERT INTO `roles` VALUES ('101', '校管理员', '27163646', null, '', '1');
INSERT INTO `roles` VALUES ('102', '教务主任', '27149310', null, '', '2');
INSERT INTO `roles` VALUES ('103', '班主任', '25182682', null, '', '2');
INSERT INTO `roles` VALUES ('104', '学生用户', '16909262', null, '', '3');

-- ----------------------------
-- Table structure for schedules
-- ----------------------------
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `ScheId` int(4) NOT NULL COMMENT '广播方案',
  `ScheName` varchar(50) NOT NULL COMMENT '方案名字',
  `Priority` int(1) NOT NULL DEFAULT '5',
  `IsExecSchd` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否使能(1为使能)',
  `isuse` bit(1) NOT NULL DEFAULT b'1',
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ScheId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of schedules
-- ----------------------------
INSERT INTO `schedules` VALUES ('1', '默认方案', '4', '', '', ' ');

-- ----------------------------
-- Table structure for schetask
-- ----------------------------
DROP TABLE IF EXISTS `schetask`;
CREATE TABLE `schetask` (
  `TaskId` int(8) NOT NULL AUTO_INCREMENT COMMENT '广播事件ID号',
  `ScheId` int(4) NOT NULL COMMENT '广播事件的所在方案ID号',
  `TaskName` varchar(50) NOT NULL COMMENT '广播事件的名字',
  `StartDateTime` datetime NOT NULL COMMENT '事件生效开始时间',
  `EndDateTime` datetime DEFAULT NULL COMMENT '事件结束生效时间',
  `LastingSeconds` int(5) DEFAULT NULL COMMENT '事件广播持续时间',
  `FilesInfo` varchar(4095) NOT NULL COMMENT '事件音频文件信息',
  `Weeks` varchar(8) NOT NULL DEFAULT '10000000' COMMENT '每周执行事件的使能（第一位为0默认使能。后面7位代表星期一到星期日的使能，1为使能位）',
  `Vols` int(2) NOT NULL DEFAULT '30' COMMENT '事件播放音量大小',
  `DomainsId` varchar(511) NOT NULL DEFAULT '',
  `ExecTime` time NOT NULL COMMENT '事件在当天播放的具体时间',
  `isuse` bit(1) NOT NULL DEFAULT b'1',
  `tasktype` int(1) NOT NULL,
  `UpDateTime` datetime NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `Status` bit(1) NOT NULL DEFAULT b'1',
  `nextFireTime` datetime DEFAULT NULL,
  `jobStatus` varchar(20) DEFAULT NULL,
  `SingleDate` date DEFAULT NULL,
  PRIMARY KEY (`TaskId`),
  KEY `ScheId` (`ScheId`),
  KEY `isuse` (`isuse`) USING BTREE,
  CONSTRAINT `schetask_ibfk_1` FOREIGN KEY (`ScheId`) REFERENCES `schedules` (`ScheId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of schetask
-- ----------------------------

-- ----------------------------
-- Table structure for terminals
-- ----------------------------
DROP TABLE IF EXISTS `terminals`;
CREATE TABLE `terminals` (
  `TName` varchar(50) NOT NULL COMMENT '终端ID号',
  `TIP` varchar(50) NOT NULL COMMENT '终端IP地址号',
  `TGateway` varchar(50) DEFAULT NULL COMMENT '网关IP号',
  `ISCMIC` bit(1) DEFAULT b'0' COMMENT '寻呼话筒的使能与控制分区',
  `ISAutoCast` bit(1) DEFAULT b'0' COMMENT '终端自动采播使能',
  `DomainId` int(50) NOT NULL,
  `isuse` bit(1) NOT NULL,
  `TIDString` varchar(4) NOT NULL,
  `FinalOfflineDate` datetime DEFAULT NULL,
  `isOnline` bit(1) NOT NULL DEFAULT b'0',
  `Precinct` varchar(511) DEFAULT NULL COMMENT '管理分区',
  PRIMARY KEY (`TIDString`),
  KEY `DomainId` (`DomainId`) USING BTREE,
  CONSTRAINT `terminal_ibfk_1` FOREIGN KEY (`DomainId`) REFERENCES `domains` (`DomainId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of terminals
-- ----------------------------

-- ----------------------------
-- Table structure for termtask
-- ----------------------------
DROP TABLE IF EXISTS `termtask`;
CREATE TABLE `termtask` (
  `TaskId` int(8) NOT NULL,
  `TaskName` varchar(255) NOT NULL,
  `isuse` bit(1) NOT NULL DEFAULT b'1',
  `upDateTime` datetime NOT NULL,
  `Status` bit(1) NOT NULL DEFAULT b'0',
  `nextFireTime` datetime DEFAULT NULL,
  `jobStatus` varchar(20) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `ExecTime` time DEFAULT NULL,
  `DomainsId` varchar(511) NOT NULL,
  `TIDString` varchar(4) NOT NULL,
  `Weeks` varchar(8) DEFAULT NULL,
  `Vols` int(2) NOT NULL,
  `CastLevel` int(2) NOT NULL,
  `LastingSeconds` int(5) DEFAULT NULL,
  `type` int(1) NOT NULL,
  PRIMARY KEY (`TaskId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of termtask
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '',
  `loginid` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `isuse` bit(1) NOT NULL DEFAULT b'1',
  `note` varchar(255) DEFAULT '',
  `Email` varchar(63) DEFAULT NULL,
  `CreatDate` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `LastLoginDate` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `LastPasswordChangeDate` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `oldpassword` varchar(50) DEFAULT NULL,
  `RoleId` int(11) NOT NULL,
  `DomainId` int(50) unsigned DEFAULT NULL,
  `type` bit(1) NOT NULL DEFAULT b'1',
  `realcasttype` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`userid`),
  KEY `RoleId` (`RoleId`) USING BTREE,
  KEY `password` (`password`) USING BTREE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', '总管理员', 'admin', '223ce7b851123353479d85757fbbf4e320d1e251', '', '', null, '2019-08-11 18:04:47', '2019-08-11 18:04:47', '2019-08-11 18:04:47', '80ebe23b3cb4dbd8a709ff779bc9a17b037d4d9e', '1', null, '', '0');
