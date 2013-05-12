-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2013 at 03:07 AM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tera`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Password` varchar(512) NOT NULL,
  `AccessLevel` int(1) NOT NULL DEFAULT '0',
  `Membership` int(1) NOT NULL DEFAULT '0',
  `LastOnlineUtc` bigint(100) NOT NULL DEFAULT '0',
  `Cash` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `AccountName` varchar(50) NOT NULL DEFAULT '',
  `PlayerId` int(11) NOT NULL DEFAULT '0',
  `ItemId` int(11) NOT NULL DEFAULT '0',
  `Amount` int(11) NOT NULL DEFAULT '0',
  `Color` int(11) NOT NULL DEFAULT '0',
  `Slot` int(11) NOT NULL DEFAULT '0',
  `StorageType` enum('Inventory','CharacterWarehouse','AccountWarehouse','GuildWarehouse','Trade') NOT NULL DEFAULT 'Inventory',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE IF NOT EXISTS `players` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `player_datas`
--

CREATE TABLE IF NOT EXISTS `player_datas` (
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

-- --------------------------------------------------------

--
-- Table structure for table `questdata`
--

CREATE TABLE IF NOT EXISTS `questdata` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `PlayerId` int(11) NOT NULL DEFAULT '0',
  `QuestId` int(11) NOT NULL DEFAULT '0',
  `Status` enum('None','Start','Reward','Complete','Locked') DEFAULT NULL,
  `Step` int(11) NOT NULL DEFAULT '0',
  `Counters` varchar(256) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE IF NOT EXISTS `servers` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `small_text` text NOT NULL,
  `img` longtext NOT NULL,
  `ip` varchar(22) NOT NULL,
  `port` int(5) NOT NULL,
  `category` varchar(3) NOT NULL,
  `name` varchar(25) NOT NULL,
  `crowdness` text NOT NULL,
  `open` int(11) NOT NULL,
  `permission_mask` varchar(15) NOT NULL DEFAULT '0x00000000',
  `server_stat` varchar(15) NOT NULL DEFAULT '0x00000001',
  `language` varchar(2) NOT NULL DEFAULT 'en',
  `l_visible` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
