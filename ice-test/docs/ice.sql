-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.1.0 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 ice 的数据库结构
CREATE DATABASE IF NOT EXISTS `ice` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ice`;

-- 导出  表 ice.ice_app 结构
CREATE TABLE IF NOT EXISTS `ice_app` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'application name',
  `info` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 正在导出表  ice.ice_app 的数据：~2 rows (大约)
INSERT INTO `ice_app` (`id`, `name`, `info`, `status`, `create_at`, `update_at`) VALUES
	(1, 'test1', '测试1', 1, '2025-01-03 16:58:09', '2025-01-03 16:58:10'),
	(2, 'big-market', '大营销平台', 1, '2025-01-19 14:06:21', '2025-01-19 14:06:21');

-- 导出  表 ice.ice_base 结构
CREATE TABLE IF NOT EXISTS `ice_base` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `app` int NOT NULL COMMENT 'remote application id',
  `scenes` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'scenes(mutli scene split with ,)',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 online 0 offline',
  `conf_id` bigint DEFAULT NULL,
  `time_type` tinyint DEFAULT '1' COMMENT 'see TimeTypeEnum',
  `start` datetime(3) DEFAULT NULL,
  `end` datetime(3) DEFAULT NULL,
  `debug` tinyint NOT NULL DEFAULT '1',
  `priority` bigint DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_index` (`update_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 正在导出表  ice.ice_base 的数据：~3 rows (大约)
INSERT INTO `ice_base` (`id`, `name`, `app`, `scenes`, `status`, `conf_id`, `time_type`, `start`, `end`, `debug`, `priority`, `create_at`, `update_at`) VALUES
	(1, '充值活动', 1, 'recharge-1', 1, 1, 1, NULL, NULL, 7, 1, '2025-01-03 17:00:04', '2025-01-03 17:01:13.193'),
	(2, '测试活动', 1, 'recharge', 1, 11, 1, NULL, NULL, 7, 1, '2025-01-08 19:53:34', '2025-01-19 13:36:02.936'),
	(3, '测试活动', 2, 'raffle-1', 1, 13, 1, NULL, NULL, 7, 1, '2025-01-19 14:07:45', '2025-01-19 14:07:45.782');

-- 导出  表 ice.ice_conf 结构
CREATE TABLE IF NOT EXISTS `ice_conf` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `app` int NOT NULL COMMENT 'remote application id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `son_ids` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '6' COMMENT 'see NodeTypeEnum',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 online 0 offline',
  `inverse` tinyint NOT NULL DEFAULT '0' COMMENT 'make true->false false->true',
  `conf_name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT 'leaf node class name',
  `conf_field` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT 'leaf node json config',
  `forward_id` bigint DEFAULT NULL,
  `time_type` tinyint NOT NULL DEFAULT '1' COMMENT 'see TimeTypeEnum',
  `start` datetime(3) DEFAULT NULL,
  `end` datetime(3) DEFAULT NULL,
  `debug` tinyint NOT NULL DEFAULT '1',
  `error_state` tinyint DEFAULT NULL COMMENT 'NULL/3-SHUTDOWN, 0-CONTINUE_FALSE, 1-CONTINUE_TRUE, 2-CONTINUE_NONE',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_index` (`update_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='记录每个规则结点的配置信息';

-- 正在导出表  ice.ice_conf 的数据：~21 rows (大约)
INSERT INTO `ice_conf` (`id`, `app`, `name`, `son_ids`, `type`, `status`, `inverse`, `conf_name`, `conf_field`, `forward_id`, `time_type`, `start`, `end`, `debug`, `error_state`, `create_at`, `update_at`) VALUES
	(1, 1, NULL, '4', 3, 1, 0, '', '', NULL, 1, NULL, NULL, 1, NULL, '2025-01-03 17:00:04', '2025-01-06 19:29:52.457'),
	(2, 1, '与节点', NULL, 1, 0, 0, '', '', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 15:33:35', '2025-01-06 15:33:35.598'),
	(3, 1, '10.1-10.7', NULL, 4, 0, 0, '', '', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 15:48:06', '2025-01-06 15:48:06.707'),
	(4, 1, '1.1-1.7', '5,6', 3, 1, 0, NULL, NULL, NULL, 7, '2025-01-01 00:00:00.000', '2025-02-01 19:48:47.000', 1, NULL, '2025-01-06 15:50:11', '2025-01-19 13:37:17.191'),
	(5, 1, '100元送5余额', '7,8', 1, 1, 0, NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 15:50:47', '2025-01-15 13:23:03.688'),
	(6, 1, '50元送10积分', '9,10', 1, 1, 0, NULL, NULL, NULL, 5, '2025-01-06 16:32:01.000', NULL, 1, NULL, '2025-01-06 15:50:52', '2025-01-06 19:29:52.475'),
	(7, 1, '充值满100元', NULL, 5, 1, 0, 'com.ice.test.flow.ScoreFlow', '{"score":100,"key":"cost"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 16:08:37', '2025-01-06 19:29:52.480'),
	(8, 1, '', NULL, 6, 1, 0, 'com.ice.test.result.AmountResult', '{"value":5,"key":"uid"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 16:10:39', '2025-01-06 19:29:52.485'),
	(9, 1, '充值满50元', NULL, 5, 1, 0, 'com.ice.test.flow.ScoreFlow', '{"score":50,"key":"cost"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 16:11:54', '2025-01-06 19:29:52.491'),
	(10, 1, '', NULL, 6, 1, 0, 'com.ice.test.result.PointResult', '{"value":10,"key":"uid"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-06 16:13:11', '2025-01-06 19:29:52.496'),
	(11, 1, NULL, '12', 0, 1, 0, NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-08 19:53:34', '2025-01-08 20:22:48.696'),
	(12, 1, '发放20余额', NULL, 6, 1, 0, 'com.ice.test.result.AmountResult', '{"value":20,"key":"uid"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-08 20:22:43', '2025-01-08 20:22:48.699'),
	(13, 2, 'raffle责任链规则根', '14,21', 1, 1, 0, NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 14:07:45', '2025-01-19 16:04:56.561'),
	(14, 2, '', '15,16', 4, 1, 1, NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 14:09:35', '2025-01-19 16:04:56.564'),
	(15, 2, 'Raffle责任链-黑名单规则', '18', 1, 1, 0, '', '', 17, 1, NULL, NULL, 1, NULL, '2025-01-19 14:10:03', '2025-01-19 15:42:38.512'),
	(16, 2, 'Raffle责任链-权重规则', '19,20', 1, 1, 0, '', '', NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 14:36:02', '2025-01-19 15:41:25.381'),
	(17, 2, '', NULL, 5, 1, 0, 'com.ice.test.flow.BlacklistFlow', '{"defaultValue":0.1,"blacklist":"1","key":"uid"}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 15:39:48', '2025-01-19 15:53:37.110'),
	(18, 2, '', NULL, 6, 1, 0, 'com.ice.test.result.BlacklistResult', NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 15:40:27', '2025-01-19 15:41:25.395'),
	(19, 2, '', NULL, 5, 1, 0, 'com.ice.test.flow.RuleWeightFlow', '{"weightRule":"4000:102,103,104,105 5000:102,103,104,105,106,107 6000:102,103,104,105,106,107,108","credit":4500}', NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 15:41:13', '2025-01-19 15:41:25.399'),
	(20, 2, '', NULL, 6, 1, 0, 'com.ice.test.result.RuleWeightResult', NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 15:41:22', '2025-01-19 15:41:25.403'),
	(21, 2, 'Raffle责任链-兜底抽奖规则', NULL, 6, 1, 0, 'com.ice.test.result.LuckyAwardResult', NULL, NULL, 1, NULL, NULL, 1, NULL, '2025-01-19 15:42:22', '2025-01-19 15:42:38.502');

-- 导出  表 ice.ice_conf_update 结构
CREATE TABLE IF NOT EXISTS `ice_conf_update` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `app` int NOT NULL COMMENT 'remote application id',
  `ice_id` bigint NOT NULL,
  `conf_id` bigint NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `son_ids` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '6' COMMENT 'see NodeTypeEnum',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 online 0 offline',
  `inverse` tinyint NOT NULL DEFAULT '0' COMMENT 'make true->false false->true',
  `conf_name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT 'leaf node class name',
  `conf_field` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT 'leaf node json config',
  `forward_id` bigint DEFAULT NULL,
  `time_type` tinyint NOT NULL DEFAULT '1' COMMENT 'see TimeTypeEnum',
  `start` datetime(3) DEFAULT NULL,
  `end` datetime(3) DEFAULT NULL,
  `debug` tinyint NOT NULL DEFAULT '1',
  `error_state` tinyint DEFAULT NULL COMMENT 'NULL/3-SHUTDOWN, 0-CONTINUE_FALSE, 1-CONTINUE_TRUE, 2-CONTINUE_NONE',
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `update_index` (`update_at`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='记录结点的配置信息、结点间的联系';

-- 正在导出表  ice.ice_conf_update 的数据：~0 rows (大约)

-- 导出  表 ice.ice_push_history 结构
CREATE TABLE IF NOT EXISTS `ice_push_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `app` int NOT NULL,
  `ice_id` bigint DEFAULT NULL,
  `reason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `operator` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 正在导出表  ice.ice_push_history 的数据：~1 rows (大约)
INSERT INTO `ice_push_history` (`id`, `app`, `ice_id`, `reason`, `push_data`, `operator`, `create_at`) VALUES
	(1, 1, 1, '11', '{"app":1,"base":{"id":1,"scenes":"recharge-1","confId":1,"debug":7,"name":"充值活动"},"confs":[{"id":4,"sonIds":"5,6","type":3,"timeType":7,"start":1735660800000,"end":1736423327000,"name":"1.1-1.7"},{"id":8,"type":6,"confName":"com.ice.test.result.AmountResult","confField":"{\\"value\\":5,\\"key\\":\\"uid\\"}"},{"id":9,"type":5,"confName":"com.ice.test.flow.ScoreFlow","confField":"{\\"score\\":50,\\"key\\":\\"cost\\"}","name":"充值满50元"},{"id":7,"type":5,"confName":"com.ice.test.flow.ScoreFlow","confField":"{\\"score\\":100,\\"key\\":\\"cost\\"}","name":"充值满100元"},{"id":6,"sonIds":"9,10","type":1,"timeType":5,"start":1736152321000,"name":"50元送10积分"},{"id":1,"sonIds":"4","type":3},{"id":5,"sonIds":"7,8","type":1,"timeType":7,"start":1735660800000,"end":1736438399000,"name":"100元送5余额"},{"id":10,"type":6,"confName":"com.ice.test.result.PointResult","confField":"{\\"value\\":10,\\"key\\":\\"uid\\"}"}]}', 'waitmoon', '2025-01-14 16:57:01');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
