/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : tera

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2013-05-07 17:34:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `accounts`
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Password` varchar(512) NOT NULL,
  `AccessLevel` int(1) NOT NULL DEFAULT '0',
  `Membership` int(1) NOT NULL DEFAULT '0',
  `LastOnlineUtc` bigint(100) NOT NULL DEFAULT '0',
  `Cash` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES ('1', 'admin', 'test', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `inventory`
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountName` varchar(50) NOT NULL DEFAULT '',
  `PlayerId` int(11) NOT NULL DEFAULT '0',
  `ItemId` int(11) NOT NULL DEFAULT '0',
  `Amount` int(11) NOT NULL DEFAULT '0',
  `Color` int(11) NOT NULL DEFAULT '0',
  `Slot` int(11) NOT NULL DEFAULT '0',
  `StorageType` enum('Inventory','CharacterWarehouse','AccountWarehouse','GuildWarehouse','Trade') NOT NULL DEFAULT 'Inventory',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES ('1', 'admin', '1', '125', '5', '0', '20', 'Inventory');
INSERT INTO `inventory` VALUES ('2', 'admin', '1', '8007', '3', '0', '21', 'Inventory');
INSERT INTO `inventory` VALUES ('3', 'admin', '1', '10001', '1', '0', '1', 'Inventory');
INSERT INTO `inventory` VALUES ('4', 'admin', '1', '15004', '1', '0', '3', 'Inventory');
INSERT INTO `inventory` VALUES ('5', 'admin', '1', '15005', '1', '0', '4', 'Inventory');
INSERT INTO `inventory` VALUES ('6', 'admin', '1', '15006', '1', '0', '5', 'Inventory');

-- ----------------------------
-- Table structure for `players`
-- ----------------------------
DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `AccountName` varchar(50) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT '1',
  `Exp` bigint(20) NOT NULL DEFAULT '0',
  `ExpRecoverable` bigint(20) NOT NULL DEFAULT '0',
  `Mount` int(11) NOT NULL DEFAULT '0',
  `UiSettings` text,
  `GuildAccepted` bit(1) NOT NULL DEFAULT b'0',
  `PraiseGiven` bit(1) NOT NULL DEFAULT b'0',
  `LastPraise` int(11) NOT NULL DEFAULT '-1',
  `CurrentBankSection` int(11) NOT NULL DEFAULT '0',
  `CreationDate` int(11) NOT NULL DEFAULT '0',
  `LastOnline` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of players
-- ----------------------------
INSERT INTO `players` VALUES ('1', 'admin', '9', '55600', '0', '0', '', '', '', '-1', '0', '1367770204', '0');

-- ----------------------------
-- Table structure for `player_datas`
-- ----------------------------
DROP TABLE IF EXISTS `player_datas`;
CREATE TABLE `player_datas` (
  `PlayerId` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Gender` enum('Male','Female') NOT NULL DEFAULT 'Male',
  `Race` enum('Human','HighElf','Aman','Castanic','Popori','Elin','Baraka') NOT NULL DEFAULT 'Human',
  `PlayerClass` enum('Warrior','Lancer','Slayer','Berserker','Sorcerer','Archer','Priest','Mystic','Elementalist') NOT NULL DEFAULT 'Warrior',
  `Data` text,
  `Details` text,
  `MapId` int(11) NOT NULL DEFAULT '0',
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `H` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PlayerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_datas
-- ----------------------------
INSERT INTO `player_datas` VALUES ('1', 'Admin', 'Male', 'Human', 'Warrior', '65180D00080B0400', '0C0B10021710090F13101000100C100008100C0C10150C101010100C12100F10', '13', '86292.1', '-85301.2', '-4617.87', '-30364');

-- ----------------------------
-- Table structure for `questdata`
-- ----------------------------
DROP TABLE IF EXISTS `questdata`;
CREATE TABLE `questdata` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PlayerId` int(11) NOT NULL DEFAULT '0',
  `QuestId` int(11) NOT NULL DEFAULT '0',
  `Status` enum('None','Start','Reward','Complete','Locked') DEFAULT NULL,
  `Step` int(11) NOT NULL DEFAULT '0',
  `Counters` varchar(256) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of questdata
-- ----------------------------
INSERT INTO `questdata` VALUES ('1', '1', '1301', 'Complete', '1', '0');
INSERT INTO `questdata` VALUES ('2', '1', '1305', 'Start', '0', '0');
INSERT INTO `questdata` VALUES ('3', '1', '1304', 'Start', '1', '0');
INSERT INTO `questdata` VALUES ('4', '1', '1302', 'Complete', '1', '0');
INSERT INTO `questdata` VALUES ('5', '1', '1311', 'Start', '0', '0');
INSERT INTO `questdata` VALUES ('6', '1', '1321', 'Complete', '1', '0');
INSERT INTO `questdata` VALUES ('7', '1', '1322', 'Start', '0', '0');
INSERT INTO `questdata` VALUES ('8', '1', '1323', 'Start', '0', '0');
INSERT INTO `questdata` VALUES ('9', '1', '1318', 'Start', '0', '0');
