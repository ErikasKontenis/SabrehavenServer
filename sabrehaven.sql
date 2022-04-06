-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2019 at 01:39 AM
-- Server version: 10.1.35-MariaDB
-- PHP Version: 7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sabrehaven`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `password` char(40) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `premdays` int(11) NOT NULL DEFAULT '0',
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `frag_limit` int(11) NOT NULL DEFAULT '0',
  `declaration_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bounty` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `beds` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(1, 0, 0, 0, 'Spiritkeep', 36220, 1, 0, 0, 0, 0, 378, 23),
(2, 0, 0, 0, 'Snake Tower', 57440, 1, 0, 0, 0, 0, 616, 21),
(3, 0, 0, 0, 'Halls of the Adventurers', 29060, 1, 0, 0, 0, 0, 304, 18),
(4, 0, 0, 0, 'Dark Mansion', 34090, 1, 0, 0, 0, 0, 361, 17),
(5, 0, 0, 0, 'Bloodhall', 29040, 1, 0, 0, 0, 0, 306, 16),
(6, 0, 0, 0, 'Sunset Homes, Flat 01', 1040, 1, 0, 0, 0, 0, 13, 1),
(7, 0, 0, 0, 'Sunset Homes, Flat 02', 1040, 1, 0, 0, 0, 0, 13, 1),
(8, 0, 0, 0, 'Sunset Homes, Flat 03', 1040, 1, 0, 0, 0, 0, 13, 1),
(9, 0, 0, 0, 'Sunset Homes, Flat 11', 1040, 1, 0, 0, 0, 0, 13, 1),
(10, 0, 0, 0, 'Sunset Homes, Flat 12', 1040, 1, 0, 0, 0, 0, 13, 1),
(11, 0, 0, 0, 'Sunset Homes, Flat 13', 1620, 1, 0, 0, 0, 0, 19, 2),
(12, 0, 0, 0, 'Sunset Homes, Flat 14', 1040, 1, 0, 0, 0, 0, 13, 1),
(13, 0, 0, 0, 'Sunset Homes, Flat 21', 1040, 1, 0, 0, 0, 0, 13, 1),
(14, 0, 0, 0, 'Sunset Homes, Flat 22', 1040, 1, 0, 0, 0, 0, 13, 1),
(15, 0, 0, 0, 'Sunset Homes, Flat 23', 1620, 1, 0, 0, 0, 0, 19, 2),
(16, 0, 0, 0, 'Sunset Homes, Flat 24', 1040, 1, 0, 0, 0, 0, 13, 1),
(17, 0, 0, 0, 'Beach Home Apartments, Flat 01', 1430, 1, 0, 0, 0, 0, 13, 1),
(18, 0, 0, 0, 'Beach Home Apartments, Flat 02', 1430, 1, 0, 0, 0, 0, 13, 1),
(19, 0, 0, 0, 'Beach Home Apartments, Flat 03', 1430, 1, 0, 0, 0, 0, 13, 1),
(20, 0, 0, 0, 'Beach Home Apartments, Flat 04', 1430, 1, 0, 0, 0, 0, 13, 1),
(21, 0, 0, 0, 'Beach Home Apartments, Flat 05', 1430, 1, 0, 0, 0, 0, 13, 1),
(22, 0, 0, 0, 'Beach Home Apartments, Flat 06', 2190, 1, 0, 0, 0, 0, 19, 2),
(23, 0, 0, 0, 'Beach Home Apartments, Flat 11', 1430, 1, 0, 0, 0, 0, 13, 1),
(24, 0, 0, 0, 'Beach Home Apartments, Flat 12', 1760, 1, 0, 0, 0, 0, 16, 1),
(25, 0, 0, 0, 'Beach Home Apartments, Flat 13', 1760, 1, 0, 0, 0, 0, 16, 1),
(26, 0, 0, 0, 'Beach Home Apartments, Flat 14', 770, 1, 0, 0, 0, 0, 7, 1),
(27, 0, 0, 0, 'Beach Home Apartments, Flat 15', 770, 1, 0, 0, 0, 0, 7, 1),
(28, 0, 0, 0, 'Beach Home Apartments, Flat 16', 2190, 1, 0, 0, 0, 0, 19, 2),
(29, 0, 0, 0, 'Alai Flats, Flat 01', 1530, 1, 0, 0, 0, 0, 17, 1),
(30, 0, 0, 0, 'Alai Flats, Flat 02', 1530, 1, 0, 0, 0, 0, 17, 1),
(31, 0, 0, 0, 'Alai Flats, Flat 03', 1530, 1, 0, 0, 0, 0, 17, 1),
(32, 0, 0, 0, 'Alai Flats, Flat 04', 1530, 1, 0, 0, 0, 0, 17, 1),
(33, 0, 0, 0, 'Alai Flats, Flat 05', 2350, 1, 0, 0, 0, 0, 25, 2),
(34, 0, 0, 0, 'Alai Flats, Flat 06', 2350, 1, 0, 0, 0, 0, 25, 2),
(35, 0, 0, 0, 'Alai Flats, Flat 07', 1530, 1, 0, 0, 0, 0, 17, 1),
(36, 0, 0, 0, 'Alai Flats, Flat 08', 1530, 1, 0, 0, 0, 0, 17, 1),
(37, 0, 0, 0, 'Alai Flats, Flat 11', 1530, 1, 0, 0, 0, 0, 17, 1),
(38, 0, 0, 0, 'Alai Flats, Flat 12', 1530, 1, 0, 0, 0, 0, 17, 1),
(39, 0, 0, 0, 'Alai Flats, Flat 13', 1530, 1, 0, 0, 0, 0, 17, 1),
(40, 0, 0, 0, 'Alai Flats, Flat 14', 1800, 1, 0, 0, 0, 0, 20, 1),
(41, 0, 0, 0, 'Alai Flats, Flat 15', 2800, 1, 0, 0, 0, 0, 30, 2),
(42, 0, 0, 0, 'Alai Flats, Flat 16', 2800, 1, 0, 0, 0, 0, 30, 2),
(43, 0, 0, 0, 'Alai Flats, Flat 17', 1800, 1, 0, 0, 0, 0, 20, 1),
(44, 0, 0, 0, 'Alai Flats, Flat 18', 1800, 1, 0, 0, 0, 0, 20, 1),
(45, 0, 0, 0, 'Alai Flats, Flat 22', 1530, 1, 0, 0, 0, 0, 17, 1),
(46, 0, 0, 0, 'Alai Flats, Flat 21', 1530, 1, 0, 0, 0, 0, 17, 1),
(47, 0, 0, 0, 'Alai Flats, Flat 23', 1530, 1, 0, 0, 0, 0, 17, 1),
(48, 0, 0, 0, 'Alai Flats, Flat 24', 1800, 1, 0, 0, 0, 0, 20, 1),
(49, 0, 0, 0, 'Alai Flats, Flat 25', 2800, 1, 0, 0, 0, 0, 30, 2),
(50, 0, 0, 0, 'Alai Flats, Flat 26', 2800, 1, 0, 0, 0, 0, 30, 2),
(51, 0, 0, 0, 'Alai Flats, Flat 27', 1800, 1, 0, 0, 0, 0, 20, 1),
(52, 0, 0, 0, 'Alai Flats, Flat 28', 1800, 1, 0, 0, 0, 0, 20, 1),
(53, 0, 0, 0, 'Upper Swamp Lane 2', 9180, 1, 0, 0, 0, 0, 74, 4),
(54, 0, 0, 0, 'Upper Swamp Lane 4', 9180, 1, 0, 0, 0, 0, 74, 4),
(55, 0, 0, 0, 'Lower Swamp Lane 1', 9180, 1, 0, 0, 0, 0, 74, 4),
(56, 0, 0, 0, 'Lower Swamp Lane 3', 9180, 1, 0, 0, 0, 0, 74, 4),
(57, 0, 0, 0, 'Upper Swamp Lane 8', 16040, 1, 0, 0, 0, 0, 132, 3),
(58, 0, 0, 0, 'Southern Thais Guildhall', 43020, 1, 0, 0, 0, 0, 346, 16),
(59, 0, 0, 0, 'Upper Swamp Lane 10', 3920, 1, 0, 0, 0, 0, 31, 3),
(60, 0, 0, 0, 'Upper Swamp Lane 12', 7400, 1, 0, 0, 0, 0, 60, 3),
(61, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 2410, 1, 0, 0, 0, 0, 21, 2),
(62, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 1970, 1, 0, 0, 0, 0, 17, 2),
(63, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 2410, 1, 0, 0, 0, 0, 21, 2),
(64, 0, 0, 0, 'Sorcerer\'s Avenue 5', 5390, 1, 0, 0, 0, 0, 49, 1),
(65, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 1430, 1, 0, 0, 0, 0, 13, 1),
(66, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 1430, 1, 0, 0, 0, 0, 13, 1),
(67, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 1430, 1, 0, 0, 0, 0, 13, 1),
(68, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 1430, 1, 0, 0, 0, 0, 13, 1),
(69, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 1430, 1, 0, 0, 0, 0, 13, 1),
(70, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 1430, 1, 0, 0, 0, 0, 13, 1),
(71, 0, 0, 0, 'Thais Clanhall', 15940, 1, 0, 0, 0, 0, 188, 10),
(72, 0, 0, 0, 'Harbour Street 4', 1870, 1, 0, 0, 0, 0, 17, 1),
(73, 0, 0, 0, 'Thais Hostel', 11660, 1, 0, 0, 0, 0, 117, 24),
(74, 0, 0, 0, 'Farm Lane, Basement (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0),
(75, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0),
(76, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 1890, 1, 0, 0, 0, 0, 21, 0),
(77, 0, 0, 0, 'Warriors Guildhall', 28450, 1, 0, 0, 0, 0, 305, 11),
(78, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 2880, 1, 0, 0, 0, 0, 32, 0),
(79, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 1530, 1, 0, 0, 0, 0, 17, 0),
(80, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 2520, 1, 0, 0, 0, 0, 28, 0),
(81, 0, 0, 0, 'Mill Avenue 1 (Shop)', 2600, 1, 0, 0, 0, 0, 26, 1),
(82, 0, 0, 0, 'Mill Avenue 2 (Shop)', 4600, 1, 0, 0, 0, 0, 45, 2),
(83, 0, 0, 0, 'Mill Avenue 3', 2700, 1, 0, 0, 0, 0, 26, 2),
(84, 0, 0, 0, 'Mill Avenue 4', 2700, 1, 0, 0, 0, 0, 26, 2),
(85, 0, 0, 0, 'Mill Avenue 5', 6200, 1, 0, 0, 0, 0, 59, 4),
(86, 0, 0, 0, 'The City Wall 5a', 1170, 1, 0, 0, 0, 0, 13, 1),
(87, 0, 0, 0, 'The City Wall 5b', 1170, 1, 0, 0, 0, 0, 13, 1),
(88, 0, 0, 0, 'The City Wall 5c', 1170, 1, 0, 0, 0, 0, 13, 1),
(89, 0, 0, 0, 'The City Wall 5d', 1170, 1, 0, 0, 0, 0, 13, 1),
(90, 0, 0, 0, 'The City Wall 5e', 1170, 1, 0, 0, 0, 0, 13, 1),
(91, 0, 0, 0, 'The City Wall 5f', 1170, 1, 0, 0, 0, 0, 13, 1),
(92, 0, 0, 0, 'The City Wall 7a', 1170, 1, 0, 0, 0, 0, 13, 1),
(93, 0, 0, 0, 'The City Wall 7b', 1170, 1, 0, 0, 0, 0, 13, 1),
(94, 0, 0, 0, 'The City Wall 7c', 1630, 1, 0, 0, 0, 0, 17, 2),
(95, 0, 0, 0, 'The City Wall 7d', 1630, 1, 0, 0, 0, 0, 17, 2),
(96, 0, 0, 0, 'The City Wall 7e', 1630, 1, 0, 0, 0, 0, 17, 2),
(97, 0, 0, 0, 'The City Wall 7f', 1630, 1, 0, 0, 0, 0, 17, 2),
(98, 0, 0, 0, 'The City Wall 7g', 1170, 1, 0, 0, 0, 0, 13, 1),
(99, 0, 0, 0, 'The City Wall 7h', 1170, 1, 0, 0, 0, 0, 13, 1),
(100, 0, 0, 0, 'The City Wall 9', 1810, 1, 0, 0, 0, 0, 19, 2),
(101, 0, 0, 0, 'The City Wall 3a', 1990, 1, 0, 0, 0, 0, 21, 2),
(102, 0, 0, 0, 'The City Wall 3b', 1990, 1, 0, 0, 0, 0, 21, 2),
(103, 0, 0, 0, 'The City Wall 3c', 1990, 1, 0, 0, 0, 0, 21, 2),
(104, 0, 0, 0, 'The City Wall 3d', 1990, 1, 0, 0, 0, 0, 21, 2),
(105, 0, 0, 0, 'The City Wall 3e', 1990, 1, 0, 0, 0, 0, 21, 2),
(106, 0, 0, 0, 'The City Wall 3f', 1990, 1, 0, 0, 0, 0, 21, 2),
(107, 0, 0, 0, 'The City Wall 1a', 2440, 1, 0, 0, 0, 0, 26, 2),
(108, 0, 0, 0, 'The City Wall 1b', 2440, 1, 0, 0, 0, 0, 26, 2),
(109, 0, 0, 0, 'Harbour Place 2 (Shop)', 2600, 1, 0, 0, 0, 0, 26, 1),
(110, 0, 0, 0, 'Harbour Place 1 (Shop)', 2200, 1, 0, 0, 0, 0, 22, 0),
(111, 0, 0, 0, 'Mercenary Tower', 81410, 1, 0, 0, 0, 0, 607, 26),
(112, 0, 0, 0, 'Guildhall of the Red Rose', 54050, 1, 0, 0, 0, 0, 405, 15),
(113, 0, 0, 0, 'Fibula Village 1', 1690, 1, 0, 0, 0, 0, 13, 1),
(114, 0, 0, 0, 'Fibula Village 2', 1690, 1, 0, 0, 0, 0, 13, 1),
(115, 0, 0, 0, 'Fibula Village 3', 7320, 1, 0, 0, 0, 0, 54, 4),
(116, 0, 0, 0, 'Fibula Village 4', 3480, 1, 0, 0, 0, 0, 26, 2),
(117, 0, 0, 0, 'Fibula Village 5', 3480, 1, 0, 0, 0, 0, 26, 2),
(118, 0, 0, 0, 'Fibula Village, Tower Flat', 10110, 1, 0, 0, 0, 0, 77, 2),
(119, 0, 0, 0, 'Fibula Village, Bar', 10370, 1, 0, 0, 0, 0, 79, 2),
(120, 0, 0, 0, 'Fibula Clanhall', 21960, 1, 0, 0, 0, 0, 162, 10),
(121, 0, 0, 0, 'Fibula Village, Villa', 22380, 1, 0, 0, 0, 0, 242, 7),
(122, 0, 0, 0, 'The Tibianic', 66900, 1, 0, 0, 0, 0, 540, 22),
(123, 0, 0, 0, 'Castle of Greenshore', 36380, 1, 0, 0, 0, 0, 294, 12),
(124, 0, 0, 0, 'Greenshore Village, Villa', 20580, 1, 0, 0, 0, 0, 169, 4),
(125, 0, 0, 0, 'Greenshore Village, Shop', 3600, 1, 0, 0, 0, 0, 30, 1),
(126, 0, 0, 0, 'Greenshore Village 1', 4640, 1, 0, 0, 0, 0, 37, 3),
(127, 0, 0, 0, 'Greenshore Village 2', 1560, 1, 0, 0, 0, 0, 13, 1),
(128, 0, 0, 0, 'Greenshore Village 3', 1560, 1, 0, 0, 0, 0, 13, 1),
(129, 0, 0, 0, 'Greenshore Village 4', 1560, 1, 0, 0, 0, 0, 13, 1),
(130, 0, 0, 0, 'Greenshore Village 5', 1560, 1, 0, 0, 0, 0, 13, 1),
(131, 0, 0, 0, 'Greenshore Village 6', 8620, 1, 0, 0, 0, 0, 71, 2),
(132, 0, 0, 0, 'Greenshore Village 7', 2520, 1, 0, 0, 0, 0, 21, 1),
(133, 0, 0, 0, 'Greenshore Clanhall', 20700, 1, 0, 0, 0, 0, 165, 10),
(134, 0, 0, 0, 'Moonkeep', 24540, 2, 0, 0, 0, 0, 288, 16),
(135, 0, 0, 0, 'House of Recreation', 39460, 2, 0, 0, 0, 0, 412, 16),
(136, 0, 0, 0, 'Nordic Stronghold', 34700, 2, 0, 0, 0, 0, 410, 21),
(137, 0, 0, 0, 'Druids Retreat A', 2580, 2, 0, 0, 0, 0, 31, 2),
(138, 0, 0, 0, 'Druids Retreat B', 2420, 2, 0, 0, 0, 0, 29, 2),
(139, 0, 0, 0, 'Druids Retreat C', 1860, 2, 0, 0, 0, 0, 22, 2),
(140, 0, 0, 0, 'Druids Retreat D', 2260, 2, 0, 0, 0, 0, 27, 2),
(141, 0, 0, 0, 'Central Plaza 3', 1200, 2, 0, 0, 0, 0, 12, 0),
(142, 0, 0, 0, 'Central Plaza 2', 1200, 2, 0, 0, 0, 0, 12, 0),
(143, 0, 0, 0, 'Central Plaza 1', 1200, 2, 0, 0, 0, 0, 12, 0),
(144, 0, 0, 0, 'Park Lane 1a', 2340, 2, 0, 0, 0, 0, 28, 2),
(145, 0, 0, 0, 'Park Lane 1b', 2660, 2, 0, 0, 0, 0, 32, 2),
(146, 0, 0, 0, 'Park Lane 3b', 2100, 2, 0, 0, 0, 0, 25, 2),
(147, 0, 0, 0, 'Park Lane 3a', 2340, 2, 0, 0, 0, 0, 28, 2),
(148, 0, 0, 0, 'Park Lane 4', 1860, 2, 0, 0, 0, 0, 22, 2),
(149, 0, 0, 0, 'Park Lane 2', 1860, 2, 0, 0, 0, 0, 22, 2),
(150, 0, 0, 0, 'Theater Avenue 6a', 1540, 2, 0, 0, 0, 0, 16, 2),
(151, 0, 0, 0, 'Theater Avenue 6b', 1540, 2, 0, 0, 0, 0, 16, 2),
(152, 0, 0, 0, 'Theater Avenue 6c', 450, 2, 0, 0, 0, 0, 5, 1),
(153, 0, 0, 0, 'Theater Avenue 6d', 450, 2, 0, 0, 0, 0, 5, 1),
(154, 0, 0, 0, 'Theater Avenue 6e', 1540, 2, 0, 0, 0, 0, 16, 2),
(155, 0, 0, 0, 'Theater Avenue 6f', 1540, 2, 0, 0, 0, 0, 16, 2),
(156, 0, 0, 0, 'Theater Avenue 5a', 900, 2, 0, 0, 0, 0, 10, 1),
(157, 0, 0, 0, 'Theater Avenue 5b', 900, 2, 0, 0, 0, 0, 10, 1),
(158, 0, 0, 0, 'Theater Avenue 5c', 900, 2, 0, 0, 0, 0, 10, 1),
(159, 0, 0, 0, 'Theater Avenue 5d', 900, 2, 0, 0, 0, 0, 10, 1),
(160, 0, 0, 0, 'Theater Avenue 8a', 2440, 2, 0, 0, 0, 0, 26, 2),
(161, 0, 0, 0, 'Theater Avenue 8b', 2540, 2, 0, 0, 0, 0, 26, 3),
(162, 0, 0, 0, 'Theater Avenue 7, Flat 01', 630, 2, 0, 0, 0, 0, 7, 1),
(163, 0, 0, 0, 'Theater Avenue 7, Flat 02', 810, 2, 0, 0, 0, 0, 9, 1),
(164, 0, 0, 0, 'Theater Avenue 7, Flat 03', 810, 2, 0, 0, 0, 0, 9, 1),
(165, 0, 0, 0, 'Theater Avenue 7, Flat 04', 990, 2, 0, 0, 0, 0, 11, 1),
(166, 0, 0, 0, 'Theater Avenue 7, Flat 05', 810, 2, 0, 0, 0, 0, 9, 1),
(167, 0, 0, 0, 'Theater Avenue 7, Flat 06', 630, 2, 0, 0, 0, 0, 7, 1),
(168, 0, 0, 0, 'Theater Avenue 7, Flat 11', 990, 2, 0, 0, 0, 0, 11, 1),
(169, 0, 0, 0, 'Theater Avenue 7, Flat 12', 810, 2, 0, 0, 0, 0, 9, 1),
(170, 0, 0, 0, 'Theater Avenue 7, Flat 13', 810, 2, 0, 0, 0, 0, 9, 1),
(171, 0, 0, 0, 'Theater Avenue 7, Flat 14', 990, 2, 0, 0, 0, 0, 11, 1),
(172, 0, 0, 0, 'Theater Avenue 7, Flat 15', 810, 2, 0, 0, 0, 0, 9, 1),
(173, 0, 0, 0, 'Theater Avenue 7, Flat 16', 810, 2, 0, 0, 0, 0, 9, 1),
(174, 0, 0, 0, 'Theater Avenue 10', 2080, 2, 0, 0, 0, 0, 22, 2),
(175, 0, 0, 0, 'Theater Avenue 12', 1810, 2, 0, 0, 0, 0, 19, 2),
(176, 0, 0, 0, 'Theater Avenue 14 (Shop)', 4230, 2, 0, 0, 0, 0, 47, 1),
(177, 0, 0, 0, 'Theater Avenue 11a', 2710, 2, 0, 0, 0, 0, 29, 2),
(178, 0, 0, 0, 'Theater Avenue 11b', 1170, 2, 0, 0, 0, 0, 13, 1),
(179, 0, 0, 0, 'Theater Avenue 11c', 1170, 2, 0, 0, 0, 0, 13, 1),
(180, 0, 0, 0, 'Magician\'s Alley 1', 2000, 2, 0, 0, 0, 0, 19, 2),
(181, 0, 0, 0, 'Magician\'s Alley 1a', 1300, 2, 0, 0, 0, 0, 12, 2),
(182, 0, 0, 0, 'Magician\'s Alley 1b', 1400, 2, 0, 0, 0, 0, 13, 2),
(183, 0, 0, 0, 'Magician\'s Alley 1c', 1000, 2, 0, 0, 0, 0, 10, 1),
(184, 0, 0, 0, 'Magician\'s Alley 1d', 900, 2, 0, 0, 0, 0, 9, 1),
(185, 0, 0, 0, 'Magician\'s Alley 5a', 700, 2, 0, 0, 0, 0, 7, 1),
(186, 0, 0, 0, 'Magician\'s Alley 5b', 1000, 2, 0, 0, 0, 0, 10, 1),
(187, 0, 0, 0, 'Magician\'s Alley 5c', 2200, 2, 0, 0, 0, 0, 21, 2),
(188, 0, 0, 0, 'Magician\'s Alley 5d', 1000, 2, 0, 0, 0, 0, 10, 1),
(189, 0, 0, 0, 'Magician\'s Alley 5e', 1000, 2, 0, 0, 0, 0, 10, 1),
(190, 0, 0, 0, 'Magician\'s Alley 5f', 2200, 2, 0, 0, 0, 0, 21, 2),
(191, 0, 0, 0, 'Magician\'s Alley 4', 5200, 2, 0, 0, 0, 0, 49, 4),
(192, 0, 0, 0, 'Magician\'s Alley 8', 2700, 2, 0, 0, 0, 0, 26, 2),
(193, 0, 0, 0, 'Carlin Clanhall', 22700, 2, 0, 0, 0, 0, 218, 10),
(194, 0, 0, 0, 'Northern Street 1a', 1780, 2, 0, 0, 0, 0, 21, 2),
(195, 0, 0, 0, 'Northern Street 1b', 1780, 2, 0, 0, 0, 0, 21, 2),
(196, 0, 0, 0, 'Northern Street 1c', 1380, 2, 0, 0, 0, 0, 16, 2),
(197, 0, 0, 0, 'Northern Street 3a', 1380, 2, 0, 0, 0, 0, 16, 2),
(198, 0, 0, 0, 'Northern Street 3b', 1460, 2, 0, 0, 0, 0, 17, 2),
(199, 0, 0, 0, 'Northern Street 5', 3860, 2, 0, 0, 0, 0, 47, 2),
(200, 0, 0, 0, 'Northern Street 7', 3300, 2, 0, 0, 0, 0, 40, 2),
(201, 0, 0, 0, 'Harbour Lane 1 (Shop)', 2080, 2, 0, 0, 0, 0, 26, 0),
(202, 0, 0, 0, 'Harbour Lane 3', 6920, 2, 0, 0, 0, 0, 84, 3),
(203, 0, 0, 0, 'Harbour Lane 2a (Shop)', 1360, 2, 0, 0, 0, 0, 17, 0),
(204, 0, 0, 0, 'Harbour Lane 2b (Shop)', 1360, 2, 0, 0, 0, 0, 17, 0),
(205, 0, 0, 0, 'Harbour Flats, Flat 11', 1040, 2, 0, 0, 0, 0, 13, 1),
(206, 0, 0, 0, 'Harbour Flats, Flat 12', 800, 2, 0, 0, 0, 0, 10, 1),
(207, 0, 0, 0, 'Harbour Flats, Flat 13', 1040, 2, 0, 0, 0, 0, 13, 1),
(208, 0, 0, 0, 'Harbour Flats, Flat 14', 800, 2, 0, 0, 0, 0, 10, 1),
(209, 0, 0, 0, 'Harbour Flats, Flat 15', 720, 2, 0, 0, 0, 0, 9, 1),
(210, 0, 0, 0, 'Harbour Flats, Flat 16', 800, 2, 0, 0, 0, 0, 10, 1),
(211, 0, 0, 0, 'Harbour Flats, Flat 17', 720, 2, 0, 0, 0, 0, 9, 1),
(212, 0, 0, 0, 'Harbour Flats, Flat 18', 800, 2, 0, 0, 0, 0, 10, 1),
(213, 0, 0, 0, 'Harbour Flats, Flat 21', 1620, 2, 0, 0, 0, 0, 19, 2),
(214, 0, 0, 0, 'Harbour Flats, Flat 22', 1860, 2, 0, 0, 0, 0, 22, 2),
(215, 0, 0, 0, 'Harbour Flats, Flat 23', 800, 2, 0, 0, 0, 0, 10, 1),
(216, 0, 0, 0, 'East Lane 1a', 4420, 2, 0, 0, 0, 0, 54, 2),
(217, 0, 0, 0, 'East Lane 1b', 3300, 2, 0, 0, 0, 0, 40, 2),
(218, 0, 0, 0, 'East Lane 2', 9060, 2, 0, 0, 0, 0, 112, 2),
(219, 0, 0, 0, 'Suntower', 19360, 2, 0, 0, 0, 0, 232, 9),
(220, 0, 0, 0, 'Lonely Sea Side Hostel', 23660, 2, 0, 0, 0, 0, 287, 8),
(221, 0, 0, 0, 'Northport Village 1', 2850, 2, 0, 0, 0, 0, 25, 2),
(222, 0, 0, 0, 'Northport Village 2', 2850, 2, 0, 0, 0, 0, 25, 2),
(223, 0, 0, 0, 'Northport Village 3', 10770, 2, 0, 0, 0, 0, 97, 2),
(224, 0, 0, 0, 'Northport Village 4', 5160, 2, 0, 0, 0, 0, 46, 2),
(225, 0, 0, 0, 'Seawatch', 48220, 2, 0, 0, 0, 0, 422, 19),
(226, 0, 0, 0, 'Northport Village 5', 3510, 2, 0, 0, 0, 0, 31, 2),
(227, 0, 0, 0, 'Northport Village 6', 4170, 2, 0, 0, 0, 0, 37, 2),
(228, 0, 0, 0, 'Northport Clanhall', 18720, 2, 0, 0, 0, 0, 162, 10),
(229, 0, 0, 0, 'Senja Village 1a', 1530, 2, 0, 0, 0, 0, 17, 1),
(230, 0, 0, 0, 'Senja Village 1b', 3160, 2, 0, 0, 0, 0, 34, 2),
(231, 0, 0, 0, 'Senja Village 2', 1530, 2, 0, 0, 0, 0, 17, 1),
(232, 0, 0, 0, 'Senja Village 3', 3430, 2, 0, 0, 0, 0, 37, 2),
(233, 0, 0, 0, 'Senja Village 4', 1530, 2, 0, 0, 0, 0, 17, 1),
(234, 0, 0, 0, 'Senja Village 5', 2350, 2, 0, 0, 0, 0, 25, 2),
(235, 0, 0, 0, 'Senja Village 6a', 1530, 2, 0, 0, 0, 0, 17, 1),
(236, 0, 0, 0, 'Senja Village 6b', 1530, 2, 0, 0, 0, 0, 17, 1),
(237, 0, 0, 0, 'Senja Village 7', 1630, 2, 0, 0, 0, 0, 17, 2),
(238, 0, 0, 0, 'Senja Village 8', 3250, 2, 0, 0, 0, 0, 35, 2),
(239, 0, 0, 0, 'Senja Village 9', 5050, 2, 0, 0, 0, 0, 55, 2),
(240, 0, 0, 0, 'Senja Village 10', 2970, 2, 0, 0, 0, 0, 33, 1),
(241, 0, 0, 0, 'Senja Village 11', 5140, 2, 0, 0, 0, 0, 56, 2),
(242, 0, 0, 0, 'Senja Clanhall', 20250, 2, 0, 0, 0, 0, 215, 10),
(243, 0, 0, 0, 'Wolftower', 40900, 3, 0, 0, 0, 0, 387, 23),
(244, 0, 0, 0, 'Hill Hideout', 26500, 3, 0, 0, 0, 0, 251, 15),
(245, 0, 0, 0, 'Riverspring', 37100, 3, 0, 0, 0, 0, 353, 19),
(246, 0, 0, 0, 'The Farms 1', 4820, 3, 0, 0, 0, 0, 42, 3),
(247, 0, 0, 0, 'The Farms 2', 2960, 3, 0, 0, 0, 0, 26, 2),
(248, 0, 0, 0, 'The Farms 3', 2960, 3, 0, 0, 0, 0, 26, 2),
(249, 0, 0, 0, 'The Farms 4', 2960, 3, 0, 0, 0, 0, 26, 2),
(250, 0, 0, 0, 'The Farms 5', 2960, 3, 0, 0, 0, 0, 26, 2),
(251, 0, 0, 0, 'The Farms 6, Fishing Hut', 2410, 3, 0, 0, 0, 0, 21, 2),
(252, 0, 0, 0, 'Nobility Quarter 1', 3530, 3, 0, 0, 0, 0, 37, 3),
(253, 0, 0, 0, 'Nobility Quarter 2', 3530, 3, 0, 0, 0, 0, 37, 3),
(254, 0, 0, 0, 'Nobility Quarter 3', 3530, 3, 0, 0, 0, 0, 37, 3),
(255, 0, 0, 0, 'Nobility Quarter 4', 1530, 3, 0, 0, 0, 0, 17, 1),
(256, 0, 0, 0, 'Nobility Quarter 5', 1530, 3, 0, 0, 0, 0, 17, 1),
(257, 0, 0, 0, 'Nobility Quarter 6', 1530, 3, 0, 0, 0, 0, 17, 1),
(258, 0, 0, 0, 'Nobility Quarter 7', 1530, 3, 0, 0, 0, 0, 17, 1),
(259, 0, 0, 0, 'Nobility Quarter 8', 1530, 3, 0, 0, 0, 0, 17, 1),
(260, 0, 0, 0, 'Nobility Quarter 9', 1530, 3, 0, 0, 0, 0, 17, 1),
(261, 0, 0, 0, 'Upper Barracks 1', 420, 3, 0, 0, 0, 0, 7, 1),
(262, 0, 0, 0, 'Upper Barracks 2', 420, 3, 0, 0, 0, 0, 7, 1),
(263, 0, 0, 0, 'Upper Barracks 3', 420, 3, 0, 0, 0, 0, 7, 1),
(264, 0, 0, 0, 'Upper Barracks 4', 420, 3, 0, 0, 0, 0, 7, 1),
(265, 0, 0, 0, 'Upper Barracks 5', 420, 3, 0, 0, 0, 0, 7, 1),
(266, 0, 0, 0, 'Upper Barracks 6', 420, 3, 0, 0, 0, 0, 7, 1),
(267, 0, 0, 0, 'Upper Barracks 7', 420, 3, 0, 0, 0, 0, 7, 1),
(268, 0, 0, 0, 'Upper Barracks 8', 420, 3, 0, 0, 0, 0, 7, 1),
(269, 0, 0, 0, 'Upper Barracks 9', 420, 3, 0, 0, 0, 0, 7, 1),
(270, 0, 0, 0, 'Upper Barracks 10', 420, 3, 0, 0, 0, 0, 7, 1),
(271, 0, 0, 0, 'Upper Barracks 11', 420, 3, 0, 0, 0, 0, 7, 1),
(272, 0, 0, 0, 'Upper Barracks 12', 420, 3, 0, 0, 0, 0, 7, 1),
(273, 0, 0, 0, 'Upper Barracks 13', 1060, 3, 0, 0, 0, 0, 16, 2),
(274, 0, 0, 0, 'The Market 1 (Shop)', 1300, 3, 0, 0, 0, 0, 13, 0),
(275, 0, 0, 0, 'The Market 2 (Shop)', 2200, 3, 0, 0, 0, 0, 22, 0),
(276, 0, 0, 0, 'The Market 3 (Shop)', 2900, 3, 0, 0, 0, 0, 29, 0),
(277, 0, 0, 0, 'The Market 4 (Shop)', 3600, 3, 0, 0, 0, 0, 36, 0),
(278, 0, 0, 0, 'Lower Barracks 1', 600, 3, 0, 0, 0, 0, 10, 1),
(279, 0, 0, 0, 'Lower Barracks 2', 600, 3, 0, 0, 0, 0, 10, 1),
(280, 0, 0, 0, 'Lower Barracks 3', 600, 3, 0, 0, 0, 0, 10, 1),
(281, 0, 0, 0, 'Lower Barracks 4', 600, 3, 0, 0, 0, 0, 10, 1),
(282, 0, 0, 0, 'Lower Barracks 5', 600, 3, 0, 0, 0, 0, 10, 1),
(283, 0, 0, 0, 'Lower Barracks 6', 600, 3, 0, 0, 0, 0, 10, 1),
(284, 0, 0, 0, 'Lower Barracks 7', 600, 3, 0, 0, 0, 0, 10, 1),
(285, 0, 0, 0, 'Lower Barracks 8', 600, 3, 0, 0, 0, 0, 10, 1),
(286, 0, 0, 0, 'Lower Barracks 9', 600, 3, 0, 0, 0, 0, 10, 1),
(287, 0, 0, 0, 'Lower Barracks 10', 600, 3, 0, 0, 0, 0, 10, 1),
(288, 0, 0, 0, 'Lower Barracks 11', 600, 3, 0, 0, 0, 0, 10, 1),
(289, 0, 0, 0, 'Lower Barracks 12', 600, 3, 0, 0, 0, 0, 10, 1),
(290, 0, 0, 0, 'Lower Barracks 13', 600, 3, 0, 0, 0, 0, 10, 1),
(291, 0, 0, 0, 'Lower Barracks 14', 600, 3, 0, 0, 0, 0, 10, 1),
(292, 0, 0, 0, 'Lower Barracks 15', 600, 3, 0, 0, 0, 0, 10, 1),
(293, 0, 0, 0, 'Lower Barracks 16', 600, 3, 0, 0, 0, 0, 10, 1),
(294, 0, 0, 0, 'Lower Barracks 17', 600, 3, 0, 0, 0, 0, 10, 1),
(295, 0, 0, 0, 'Lower Barracks 18', 600, 3, 0, 0, 0, 0, 10, 1),
(296, 0, 0, 0, 'Lower Barracks 19', 600, 3, 0, 0, 0, 0, 10, 1),
(297, 0, 0, 0, 'Lower Barracks 20', 600, 3, 0, 0, 0, 0, 10, 1),
(298, 0, 0, 0, 'Lower Barracks 21', 600, 3, 0, 0, 0, 0, 10, 1),
(299, 0, 0, 0, 'Lower Barracks 22', 600, 3, 0, 0, 0, 0, 10, 1),
(300, 0, 0, 0, 'Lower Barracks 23', 600, 3, 0, 0, 0, 0, 10, 1),
(301, 0, 0, 0, 'Lower Barracks 24', 600, 3, 0, 0, 0, 0, 10, 1),
(302, 0, 0, 0, 'Tunnel Gardens 1', 3440, 3, 0, 0, 0, 0, 27, 3),
(303, 0, 0, 0, 'Tunnel Gardens 2 ', 3440, 3, 0, 0, 0, 0, 27, 3),
(304, 0, 0, 0, 'Tunnel Gardens 3', 3800, 3, 0, 0, 0, 0, 30, 3),
(305, 0, 0, 0, 'Tunnel Gardens 4', 3800, 3, 0, 0, 0, 0, 30, 3),
(306, 0, 0, 0, 'Tunnel Gardens 5', 2620, 3, 0, 0, 0, 0, 21, 2),
(307, 0, 0, 0, 'Tunnel Gardens 6', 2620, 3, 0, 0, 0, 0, 21, 2),
(308, 0, 0, 0, 'Tunnel Gardens 7', 2620, 3, 0, 0, 0, 0, 21, 2),
(309, 0, 0, 0, 'Tunnel Gardens 8', 2620, 3, 0, 0, 0, 0, 21, 2),
(310, 0, 0, 0, 'Tunnel Gardens 9', 1900, 3, 0, 0, 0, 0, 15, 2),
(311, 0, 0, 0, 'Tunnel Gardens 10', 1900, 3, 0, 0, 0, 0, 15, 2),
(312, 0, 0, 0, 'Tunnel Gardens 11', 2020, 3, 0, 0, 0, 0, 16, 2),
(313, 0, 0, 0, 'Tunnel Gardens 12', 2020, 3, 0, 0, 0, 0, 16, 2),
(314, 0, 0, 0, 'Marble Guildhall', 32020, 3, 0, 0, 0, 0, 338, 17),
(315, 0, 0, 0, 'Iron Guildhall', 29420, 3, 0, 0, 0, 0, 308, 18),
(316, 0, 0, 0, 'Granite Guildhall', 34090, 3, 0, 0, 0, 0, 361, 17),
(317, 0, 0, 0, 'Outlaw Camp 1', 3220, 3, 0, 0, 0, 0, 39, 2),
(318, 0, 0, 0, 'Outlaw Camp 2', 560, 3, 0, 0, 0, 0, 7, 1),
(319, 0, 0, 0, 'Outlaw Camp 3', 1380, 3, 0, 0, 0, 0, 16, 2),
(320, 0, 0, 0, 'Outlaw Camp 4', 400, 3, 0, 0, 0, 0, 5, 1),
(321, 0, 0, 0, 'Outlaw Camp 5', 400, 3, 0, 0, 0, 0, 5, 1),
(322, 0, 0, 0, 'Outlaw Camp 6', 400, 3, 0, 0, 0, 0, 5, 1),
(323, 0, 0, 0, 'Outlaw Camp 7', 1460, 3, 0, 0, 0, 0, 17, 2),
(324, 0, 0, 0, 'Outlaw Camp 8', 560, 3, 0, 0, 0, 0, 7, 1),
(325, 0, 0, 0, 'Outlaw Camp 9', 400, 3, 0, 0, 0, 0, 5, 1),
(326, 0, 0, 0, 'Outlaw Camp 10', 400, 3, 0, 0, 0, 0, 5, 1),
(327, 0, 0, 0, 'Outlaw Camp 11', 400, 3, 0, 0, 0, 0, 5, 1),
(328, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 560, 3, 0, 0, 0, 0, 7, 0),
(329, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 560, 3, 0, 0, 0, 0, 7, 0),
(330, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 1280, 3, 0, 0, 0, 0, 16, 0),
(331, 0, 0, 0, 'Outlaw Castle', 15200, 3, 0, 0, 0, 0, 180, 9),
(332, 0, 0, 0, 'Blessed Shield Guildhall', 15380, 7, 0, 0, 0, 0, 162, 9),
(333, 0, 0, 0, 'Steel Home', 26490, 7, 0, 0, 0, 0, 281, 13),
(334, 0, 0, 0, 'Swamp Watch', 21080, 7, 0, 0, 0, 0, 222, 12),
(335, 0, 0, 0, 'Golden Axe Guildhall', 20070, 7, 0, 0, 0, 0, 213, 10),
(336, 0, 0, 0, 'Valorous Venore', 28070, 7, 0, 0, 0, 0, 303, 9),
(337, 0, 0, 0, 'Dagger Alley 1', 5230, 7, 0, 0, 0, 0, 57, 2),
(338, 0, 0, 0, 'Iron Alley 1', 6600, 7, 0, 0, 0, 0, 70, 4),
(339, 0, 0, 0, 'Iron Alley 2', 6600, 7, 0, 0, 0, 0, 70, 4),
(340, 0, 0, 0, 'Dream Street 1 (Shop)', 8560, 7, 0, 0, 0, 0, 94, 2),
(341, 0, 0, 0, 'Dream Street 2', 6580, 7, 0, 0, 0, 0, 72, 2),
(342, 0, 0, 0, 'Dream Street 3', 5320, 7, 0, 0, 0, 0, 58, 2),
(343, 0, 0, 0, 'Dream Street 4', 7230, 7, 0, 0, 0, 0, 77, 4),
(344, 0, 0, 0, 'Elm Street 1', 5320, 7, 0, 0, 0, 0, 58, 2),
(345, 0, 0, 0, 'Elm Street 2', 5230, 7, 0, 0, 0, 0, 57, 2),
(346, 0, 0, 0, 'Elm Street 3', 5510, 7, 0, 0, 0, 0, 59, 3),
(347, 0, 0, 0, 'Elm Street 4', 5140, 7, 0, 0, 0, 0, 56, 2),
(348, 0, 0, 0, 'Seagull Walk 1', 10090, 7, 0, 0, 0, 0, 111, 2),
(349, 0, 0, 0, 'Seagull Walk 2', 5330, 7, 0, 0, 0, 0, 57, 3),
(350, 0, 0, 0, 'Lucky Lane 1 (Shop)', 13620, 7, 0, 0, 0, 0, 148, 4),
(351, 0, 0, 0, 'Paupers Palace, Flat 01', 810, 7, 0, 0, 0, 0, 9, 1),
(352, 0, 0, 0, 'Paupers Palace, Flat 02', 900, 7, 0, 0, 0, 0, 10, 1),
(353, 0, 0, 0, 'Paupers Palace, Flat 03', 810, 7, 0, 0, 0, 0, 9, 1),
(354, 0, 0, 0, 'Paupers Palace, Flat 04', 900, 7, 0, 0, 0, 0, 10, 1),
(355, 0, 0, 0, 'Paupers Palace, Flat 05', 630, 7, 0, 0, 0, 0, 7, 1),
(356, 0, 0, 0, 'Paupers Palace, Flat 06', 900, 7, 0, 0, 0, 0, 10, 1),
(357, 0, 0, 0, 'Paupers Palace, Flat 07', 1270, 7, 0, 0, 0, 0, 13, 2),
(358, 0, 0, 0, 'Paupers Palace, Flat 11', 630, 7, 0, 0, 0, 0, 7, 1),
(359, 0, 0, 0, 'Paupers Palace, Flat 12', 1270, 7, 0, 0, 0, 0, 13, 2),
(360, 0, 0, 0, 'Paupers Palace, Flat 13', 900, 7, 0, 0, 0, 0, 10, 1),
(361, 0, 0, 0, 'Paupers Palace, Flat 14', 1170, 7, 0, 0, 0, 0, 13, 1),
(362, 0, 0, 0, 'Paupers Palace, Flat 15', 900, 7, 0, 0, 0, 0, 10, 1),
(363, 0, 0, 0, 'Paupers Palace, Flat 16', 1170, 7, 0, 0, 0, 0, 13, 1),
(364, 0, 0, 0, 'Paupers Palace, Flat 17', 900, 7, 0, 0, 0, 0, 10, 1),
(365, 0, 0, 0, 'Paupers Palace, Flat 18', 630, 7, 0, 0, 0, 0, 7, 1),
(366, 0, 0, 0, 'Paupers Palace, Flat 21', 630, 7, 0, 0, 0, 0, 7, 1),
(367, 0, 0, 0, 'Paupers Palace, Flat 22', 900, 7, 0, 0, 0, 0, 10, 1),
(368, 0, 0, 0, 'Paupers Palace, Flat 23', 1170, 7, 0, 0, 0, 0, 13, 1),
(369, 0, 0, 0, 'Paupers Palace, Flat 24', 900, 7, 0, 0, 0, 0, 10, 1),
(370, 0, 0, 0, 'Paupers Palace, Flat 25', 1170, 7, 0, 0, 0, 0, 13, 1),
(371, 0, 0, 0, 'Paupers Palace, Flat 26', 900, 7, 0, 0, 0, 0, 10, 1),
(372, 0, 0, 0, 'Paupers Palace, Flat 27', 1270, 7, 0, 0, 0, 0, 13, 2),
(373, 0, 0, 0, 'Paupers Palace, Flat 28', 630, 7, 0, 0, 0, 0, 7, 1),
(374, 0, 0, 0, 'Paupers Palace, Flat 31', 1710, 7, 0, 0, 0, 0, 19, 1),
(375, 0, 0, 0, 'Paupers Palace, Flat 32', 2170, 7, 0, 0, 0, 0, 23, 2),
(376, 0, 0, 0, 'Paupers Palace, Flat 33', 1530, 7, 0, 0, 0, 0, 17, 1),
(377, 0, 0, 0, 'Paupers Palace, Flat 34', 3250, 7, 0, 0, 0, 0, 35, 2),
(378, 0, 0, 0, 'Salvation Street 1 (Shop)', 12180, 7, 0, 0, 0, 0, 132, 4),
(379, 0, 0, 0, 'Salvation Street 2', 7480, 7, 0, 0, 0, 0, 82, 2),
(380, 0, 0, 0, 'Salvation Street 3', 7480, 7, 0, 0, 0, 0, 82, 2),
(381, 0, 0, 0, 'Mystic Lane 1', 5690, 7, 0, 0, 0, 0, 61, 3),
(382, 0, 0, 0, 'Mystic Lane 2', 5860, 7, 0, 0, 0, 0, 64, 2),
(383, 0, 0, 0, 'Silver Street 1', 5130, 7, 0, 0, 0, 0, 57, 1),
(384, 0, 0, 0, 'Silver Street 2', 3960, 7, 0, 0, 0, 0, 44, 1),
(385, 0, 0, 0, 'Silver Street 3', 3960, 7, 0, 0, 0, 0, 44, 1),
(386, 0, 0, 0, 'Silver Street 4', 6490, 7, 0, 0, 0, 0, 71, 2),
(387, 0, 0, 0, 'Loot Lane 1 (Shop)', 8930, 7, 0, 0, 0, 0, 97, 3),
(388, 0, 0, 0, 'Old Lighthouse', 7120, 7, 0, 0, 0, 0, 78, 2),
(389, 0, 0, 0, 'Market Street 1', 13160, 7, 0, 0, 0, 0, 144, 3),
(390, 0, 0, 0, 'Market Street 2', 9650, 7, 0, 0, 0, 0, 105, 3),
(391, 0, 0, 0, 'Market Street 3', 6850, 7, 0, 0, 0, 0, 75, 2),
(392, 0, 0, 0, 'Market Street 4 (Shop)', 10010, 7, 0, 0, 0, 0, 109, 3),
(393, 0, 0, 0, 'Market Street 5 (Shop)', 12450, 7, 0, 0, 0, 0, 135, 4),
(394, 0, 0, 0, 'Market Street 6', 10570, 7, 0, 0, 0, 0, 113, 5),
(395, 0, 0, 0, 'Market Street 7', 4510, 7, 0, 0, 0, 0, 49, 2),
(396, 0, 0, 0, 'Shadow Towers', 41900, 4, 0, 0, 0, 0, 402, 18),
(397, 0, 0, 0, 'The Hideout', 39700, 4, 0, 0, 0, 0, 378, 20),
(398, 0, 0, 0, 'Underwood 1', 2890, 4, 0, 0, 0, 0, 31, 2),
(399, 0, 0, 0, 'Underwood 2', 2890, 4, 0, 0, 0, 0, 31, 2),
(400, 0, 0, 0, 'Underwood 3', 3170, 4, 0, 0, 0, 0, 33, 3),
(401, 0, 0, 0, 'Underwood 4', 4170, 4, 0, 0, 0, 0, 43, 4),
(402, 0, 0, 0, 'Underwood 5', 2540, 4, 0, 0, 0, 0, 26, 3),
(403, 0, 0, 0, 'Underwood 6', 2990, 4, 0, 0, 0, 0, 31, 3),
(404, 0, 0, 0, 'Underwood 7', 2720, 4, 0, 0, 0, 0, 28, 3),
(405, 0, 0, 0, 'Underwood 8', 1630, 4, 0, 0, 0, 0, 17, 2),
(406, 0, 0, 0, 'Underwood 9', 1170, 4, 0, 0, 0, 0, 13, 1),
(407, 0, 0, 0, 'Underwood 10', 1170, 4, 0, 0, 0, 0, 13, 1),
(408, 0, 0, 0, 'Ab\'Dendriel Clanhall', 28800, 4, 0, 0, 0, 0, 310, 10),
(409, 0, 0, 0, 'Castle of the Winds', 46070, 4, 0, 0, 0, 0, 493, 18),
(410, 0, 0, 0, 'Great Willow 1a', 1000, 4, 0, 0, 0, 0, 10, 1),
(411, 0, 0, 0, 'Great Willow 1b', 1300, 4, 0, 0, 0, 0, 13, 1),
(412, 0, 0, 0, 'Great Willow 1c', 1300, 4, 0, 0, 0, 0, 13, 1),
(413, 0, 0, 0, 'Great Willow 2a', 1300, 4, 0, 0, 0, 0, 13, 1),
(414, 0, 0, 0, 'Great Willow 2b', 900, 4, 0, 0, 0, 0, 9, 1),
(415, 0, 0, 0, 'Great Willow 2c', 1300, 4, 0, 0, 0, 0, 13, 1),
(416, 0, 0, 0, 'Great Willow 2d', 900, 4, 0, 0, 0, 0, 9, 1),
(417, 0, 0, 0, 'Great Willow 3a', 1300, 4, 0, 0, 0, 0, 13, 1),
(418, 0, 0, 0, 'Great Willow 3b', 900, 4, 0, 0, 0, 0, 9, 1),
(419, 0, 0, 0, 'Great Willow 3c', 1300, 4, 0, 0, 0, 0, 13, 1),
(420, 0, 0, 0, 'Great Willow 3d', 900, 4, 0, 0, 0, 0, 9, 1),
(421, 0, 0, 0, 'Great Willow 4a', 1800, 4, 0, 0, 0, 0, 17, 2),
(422, 0, 0, 0, 'Great Willow 4b', 1800, 4, 0, 0, 0, 0, 17, 2),
(423, 0, 0, 0, 'Great Willow 4c', 1800, 4, 0, 0, 0, 0, 17, 2),
(424, 0, 0, 0, 'Great Willow 4d', 1500, 4, 0, 0, 0, 0, 15, 1),
(425, 0, 0, 0, 'Mangrove 1', 3300, 4, 0, 0, 0, 0, 31, 3),
(426, 0, 0, 0, 'Mangrove 2', 2600, 4, 0, 0, 0, 0, 25, 2),
(427, 0, 0, 0, 'Mangrove 3', 2200, 4, 0, 0, 0, 0, 21, 2),
(428, 0, 0, 0, 'Mangrove 4', 1800, 4, 0, 0, 0, 0, 17, 2),
(429, 0, 0, 0, 'Treetop 1', 1300, 4, 0, 0, 0, 0, 13, 1),
(430, 0, 0, 0, 'Treetop 2', 1300, 4, 0, 0, 0, 0, 13, 1),
(431, 0, 0, 0, 'Treetop 3 (Shop)', 2500, 4, 0, 0, 0, 0, 25, 1),
(432, 0, 0, 0, 'Treetop 4 (Shop)', 2500, 4, 0, 0, 0, 0, 25, 1),
(433, 0, 0, 0, 'Treetop 5 (Shop)', 2700, 4, 0, 0, 0, 0, 27, 1),
(434, 0, 0, 0, 'Treetop 6', 900, 4, 0, 0, 0, 0, 9, 1),
(435, 0, 0, 0, 'Treetop 7', 1600, 4, 0, 0, 0, 0, 16, 1),
(436, 0, 0, 0, 'Treetop 8', 1600, 4, 0, 0, 0, 0, 16, 1),
(437, 0, 0, 0, 'Treetop 9', 2200, 4, 0, 0, 0, 0, 21, 2),
(438, 0, 0, 0, 'Treetop 10', 2200, 4, 0, 0, 0, 0, 21, 2),
(439, 0, 0, 0, 'Treetop 11', 1700, 4, 0, 0, 0, 0, 16, 2),
(440, 0, 0, 0, 'Treetop 12 (Shop)', 2700, 4, 0, 0, 0, 0, 27, 1),
(441, 0, 0, 0, 'Treetop 13', 2700, 4, 0, 0, 0, 0, 26, 2),
(442, 0, 0, 0, 'Coastwood 1', 1860, 4, 0, 0, 0, 0, 16, 2),
(443, 0, 0, 0, 'Coastwood 2', 1860, 4, 0, 0, 0, 0, 16, 2),
(444, 0, 0, 0, 'Coastwood 3', 2520, 4, 0, 0, 0, 0, 22, 2),
(445, 0, 0, 0, 'Coastwood 4', 2190, 4, 0, 0, 0, 0, 19, 2),
(446, 0, 0, 0, 'Coastwood 5', 2960, 4, 0, 0, 0, 0, 26, 2),
(447, 0, 0, 0, 'Coastwood 6 (Shop)', 3190, 4, 0, 0, 0, 0, 29, 1),
(448, 0, 0, 0, 'Coastwood 7', 1320, 4, 0, 0, 0, 0, 12, 1),
(449, 0, 0, 0, 'Coastwood 8', 2410, 4, 0, 0, 0, 0, 21, 2),
(450, 0, 0, 0, 'Coastwood 9', 1870, 4, 0, 0, 0, 0, 17, 1),
(451, 0, 0, 0, 'Coastwood 10', 3060, 4, 0, 0, 0, 0, 26, 3),
(452, 0, 0, 0, 'Shadow Caves 1', 600, 4, 0, 0, 0, 0, 10, 1),
(453, 0, 0, 0, 'Shadow Caves 2', 600, 4, 0, 0, 0, 0, 10, 1),
(454, 0, 0, 0, 'Shadow Caves 3', 600, 4, 0, 0, 0, 0, 10, 1),
(455, 0, 0, 0, 'Shadow Caves 4', 600, 4, 0, 0, 0, 0, 10, 1),
(456, 0, 0, 0, 'Shadow Caves 11', 600, 4, 0, 0, 0, 0, 10, 1),
(457, 0, 0, 0, 'Shadow Caves 12', 600, 4, 0, 0, 0, 0, 10, 1),
(458, 0, 0, 0, 'Shadow Caves 13', 600, 4, 0, 0, 0, 0, 10, 1),
(459, 0, 0, 0, 'Shadow Caves 14', 600, 4, 0, 0, 0, 0, 10, 1),
(460, 0, 0, 0, 'Shadow Caves 15', 600, 4, 0, 0, 0, 0, 10, 1),
(461, 0, 0, 0, 'Shadow Caves 16', 600, 4, 0, 0, 0, 0, 10, 1),
(462, 0, 0, 0, 'Shadow Caves 17', 600, 4, 0, 0, 0, 0, 10, 1),
(463, 0, 0, 0, 'Shadow Caves 18', 600, 4, 0, 0, 0, 0, 10, 1),
(464, 0, 0, 0, 'Shadow Caves 21', 600, 4, 0, 0, 0, 0, 10, 1),
(465, 0, 0, 0, 'Shadow Caves 22', 600, 4, 0, 0, 0, 0, 10, 1),
(466, 0, 0, 0, 'Shadow Caves 23', 600, 4, 0, 0, 0, 0, 10, 1),
(467, 0, 0, 0, 'Shadow Caves 24', 600, 4, 0, 0, 0, 0, 10, 1),
(468, 0, 0, 0, 'Shadow Caves 25', 600, 4, 0, 0, 0, 0, 10, 1),
(469, 0, 0, 0, 'Shadow Caves 26', 600, 4, 0, 0, 0, 0, 10, 1),
(470, 0, 0, 0, 'Shadow Caves 27', 600, 4, 0, 0, 0, 0, 10, 1),
(471, 0, 0, 0, 'Shadow Caves 28', 600, 4, 0, 0, 0, 0, 10, 1),
(472, 0, 0, 0, 'Haggler\'s Hangout 1', 2700, 9, 0, 0, 0, 0, 26, 2),
(473, 0, 0, 0, 'Haggler\'s Hangout 2', 2600, 9, 0, 0, 0, 0, 26, 1),
(474, 0, 0, 0, 'Haggler\'s Hangout 3', 14800, 9, 0, 0, 0, 0, 145, 4),
(475, 0, 0, 0, 'Haggler\'s Hangout 4a', 3700, 9, 0, 0, 0, 0, 37, 1),
(476, 0, 0, 0, 'Haggler\'s Hangout 4b', 3100, 9, 0, 0, 0, 0, 31, 1),
(477, 0, 0, 0, 'Haggler\'s Hangout 5', 3100, 9, 0, 0, 0, 0, 31, 1),
(478, 0, 0, 0, 'Haggler\'s Hangout 6', 12600, 9, 0, 0, 0, 0, 123, 4),
(479, 0, 0, 0, 'Banana Bay 1', 900, 9, 0, 0, 0, 0, 10, 1),
(480, 0, 0, 0, 'Banana Bay 2', 1530, 9, 0, 0, 0, 0, 17, 1),
(481, 0, 0, 0, 'Banana Bay 3', 900, 9, 0, 0, 0, 0, 10, 1),
(482, 0, 0, 0, 'Banana Bay 4', 900, 9, 0, 0, 0, 0, 10, 1),
(483, 0, 0, 0, 'Crocodile Bridge 1', 1990, 9, 0, 0, 0, 0, 21, 2),
(484, 0, 0, 0, 'Crocodile Bridge 2', 1630, 9, 0, 0, 0, 0, 17, 2),
(485, 0, 0, 0, 'Crocodile Bridge 3', 2440, 9, 0, 0, 0, 0, 26, 2),
(486, 0, 0, 0, 'Crocodile Bridge 4', 9210, 9, 0, 0, 0, 0, 99, 4),
(487, 0, 0, 0, 'Crocodile Bridge 5', 7840, 9, 0, 0, 0, 0, 86, 2),
(488, 0, 0, 0, 'Woodway 1', 1530, 9, 0, 0, 0, 0, 17, 1),
(489, 0, 0, 0, 'Woodway 2', 1170, 9, 0, 0, 0, 0, 13, 1),
(490, 0, 0, 0, 'Woodway 3', 2980, 9, 0, 0, 0, 0, 32, 2),
(491, 0, 0, 0, 'Woodway 4', 810, 9, 0, 0, 0, 0, 9, 1),
(492, 0, 0, 0, 'Flamingo Flats 1', 1270, 9, 0, 0, 0, 0, 13, 2),
(493, 0, 0, 0, 'Flamingo Flats 2', 1990, 9, 0, 0, 0, 0, 21, 2),
(494, 0, 0, 0, 'Flamingo Flats 3', 1270, 9, 0, 0, 0, 0, 13, 2),
(495, 0, 0, 0, 'Flamingo Flats 4', 1630, 9, 0, 0, 0, 0, 17, 2),
(496, 0, 0, 0, 'Flamingo Flats 5', 3690, 9, 0, 0, 0, 0, 41, 1),
(497, 0, 0, 0, 'Bamboo Garden 1', 3080, 9, 0, 0, 0, 0, 32, 3),
(498, 0, 0, 0, 'Bamboo Garden 2', 1990, 9, 0, 0, 0, 0, 21, 2),
(499, 0, 0, 0, 'Bamboo Garden 3', 2980, 9, 0, 0, 0, 0, 32, 2),
(500, 0, 0, 0, 'Coconut Quay 1', 3430, 9, 0, 0, 0, 0, 37, 2),
(501, 0, 0, 0, 'Coconut Quay 2', 1990, 9, 0, 0, 0, 0, 21, 2),
(502, 0, 0, 0, 'Coconut Quay 3', 3990, 9, 0, 0, 0, 0, 41, 4),
(503, 0, 0, 0, 'Coconut Quay 4', 4070, 9, 0, 0, 0, 0, 43, 3),
(504, 0, 0, 0, 'River Homes 1', 6770, 9, 0, 0, 0, 0, 73, 3),
(505, 0, 0, 0, 'River Homes 2a', 2440, 9, 0, 0, 0, 0, 26, 2),
(506, 0, 0, 0, 'River Homes 2b', 2990, 9, 0, 0, 0, 0, 31, 3),
(507, 0, 0, 0, 'River Homes 3', 9510, 9, 0, 0, 0, 0, 99, 7),
(508, 0, 0, 0, 'Jungle Edge 1', 4790, 9, 0, 0, 0, 0, 51, 3),
(509, 0, 0, 0, 'Jungle Edge 2', 6140, 9, 0, 0, 0, 0, 66, 3),
(510, 0, 0, 0, 'Jungle Edge 3', 1630, 9, 0, 0, 0, 0, 17, 2),
(511, 0, 0, 0, 'Jungle Edge 4', 1630, 9, 0, 0, 0, 0, 17, 2),
(512, 0, 0, 0, 'Jungle Edge 5', 1630, 9, 0, 0, 0, 0, 17, 2),
(513, 0, 0, 0, 'Jungle Edge 6', 900, 9, 0, 0, 0, 0, 10, 1),
(514, 0, 0, 0, 'Shark Manor', 16160, 9, 0, 0, 0, 0, 164, 15),
(515, 0, 0, 0, 'Bamboo Fortress', 42040, 9, 0, 0, 0, 0, 446, 20),
(516, 0, 0, 0, 'The Treehouse', 46040, 9, 0, 0, 0, 0, 548, 23),
(517, 0, 0, 0, 'Castle Shop 1', 3780, 5, 0, 0, 0, 0, 42, 1),
(518, 0, 0, 0, 'Castle Shop 2', 3780, 5, 0, 0, 0, 0, 42, 1),
(519, 0, 0, 0, 'Castle Shop 3', 3780, 5, 0, 0, 0, 0, 42, 1),
(520, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1),
(521, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 1530, 5, 0, 0, 0, 0, 17, 1),
(522, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1),
(523, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1),
(524, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 1530, 5, 0, 0, 0, 0, 17, 1),
(525, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 1990, 5, 0, 0, 0, 0, 21, 2),
(526, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 1440, 5, 0, 0, 0, 0, 16, 1),
(527, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1),
(528, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 1530, 5, 0, 0, 0, 0, 17, 1),
(529, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1),
(530, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1),
(531, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 1530, 5, 0, 0, 0, 0, 17, 1),
(532, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 1890, 5, 0, 0, 0, 0, 21, 1),
(533, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 1440, 5, 0, 0, 0, 0, 16, 1),
(534, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 1890, 5, 0, 0, 0, 0, 21, 1),
(535, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 1440, 5, 0, 0, 0, 0, 16, 1),
(536, 0, 0, 0, 'Castle, Basement, Flat 01', 1170, 5, 0, 0, 0, 0, 13, 1),
(537, 0, 0, 0, 'Castle, Basement, Flat 02', 1170, 5, 0, 0, 0, 0, 13, 1),
(538, 0, 0, 0, 'Castle, Basement, Flat 03', 1170, 5, 0, 0, 0, 0, 13, 1),
(539, 0, 0, 0, 'Castle, Basement, Flat 04', 1170, 5, 0, 0, 0, 0, 13, 1),
(540, 0, 0, 0, 'Castle, Basement, Flat 05', 1170, 5, 0, 0, 0, 0, 13, 1),
(541, 0, 0, 0, 'Castle, Basement, Flat 06', 1170, 5, 0, 0, 0, 0, 13, 1),
(542, 0, 0, 0, 'Castle, Basement, Flat 07', 1170, 5, 0, 0, 0, 0, 13, 1),
(543, 0, 0, 0, 'Castle, Basement, Flat 08', 1170, 5, 0, 0, 0, 0, 13, 1),
(544, 0, 0, 0, 'Castle, Basement, Flat 09', 1170, 5, 0, 0, 0, 0, 13, 1),
(545, 0, 0, 0, 'Castle Street 1', 5600, 5, 0, 0, 0, 0, 60, 3),
(546, 0, 0, 0, 'Castle Street 2', 2890, 5, 0, 0, 0, 0, 31, 2),
(547, 0, 0, 0, 'Castle Street 3', 3430, 5, 0, 0, 0, 0, 37, 2),
(548, 0, 0, 0, 'Castle Street 4', 3430, 5, 0, 0, 0, 0, 37, 2),
(549, 0, 0, 0, 'Castle Street 5', 3430, 5, 0, 0, 0, 0, 37, 2),
(550, 0, 0, 0, 'Edron Flats, Flat 01', 800, 5, 0, 0, 0, 0, 10, 1),
(551, 0, 0, 0, 'Edron Flats, Flat 02', 1620, 5, 0, 0, 0, 0, 19, 2),
(552, 0, 0, 0, 'Edron Flats, Flat 03', 800, 5, 0, 0, 0, 0, 10, 1),
(553, 0, 0, 0, 'Edron Flats, Flat 04', 800, 5, 0, 0, 0, 0, 10, 1),
(554, 0, 0, 0, 'Edron Flats, Flat 05', 800, 5, 0, 0, 0, 0, 10, 1),
(555, 0, 0, 0, 'Edron Flats, Flat 06', 800, 5, 0, 0, 0, 0, 10, 1),
(556, 0, 0, 0, 'Edron Flats, Flat 07', 800, 5, 0, 0, 0, 0, 10, 1),
(557, 0, 0, 0, 'Edron Flats, Flat 08', 800, 5, 0, 0, 0, 0, 10, 1),
(558, 0, 0, 0, 'Edron Flats, Flat 11', 800, 5, 0, 0, 0, 0, 10, 1),
(559, 0, 0, 0, 'Edron Flats, Flat 12', 800, 5, 0, 0, 0, 0, 10, 1),
(560, 0, 0, 0, 'Edron Flats, Flat 13', 800, 5, 0, 0, 0, 0, 10, 1),
(561, 0, 0, 0, 'Edron Flats, Flat 14', 800, 5, 0, 0, 0, 0, 10, 1),
(562, 0, 0, 0, 'Edron Flats, Flat 15', 800, 5, 0, 0, 0, 0, 10, 1),
(563, 0, 0, 0, 'Edron Flats, Flat 16', 800, 5, 0, 0, 0, 0, 10, 1),
(564, 0, 0, 0, 'Edron Flats, Flat 17', 800, 5, 0, 0, 0, 0, 10, 1),
(565, 0, 0, 0, 'Edron Flats, Flat 18', 800, 5, 0, 0, 0, 0, 10, 1),
(566, 0, 0, 0, 'Edron Flats, Flat 21', 1620, 5, 0, 0, 0, 0, 19, 2),
(567, 0, 0, 0, 'Edron Flats, Flat 22', 800, 5, 0, 0, 0, 0, 10, 1),
(568, 0, 0, 0, 'Edron Flats, Flat 23', 800, 5, 0, 0, 0, 0, 10, 1),
(569, 0, 0, 0, 'Edron Flats, Flat 24', 800, 5, 0, 0, 0, 0, 10, 1),
(570, 0, 0, 0, 'Edron Flats, Flat 25', 800, 5, 0, 0, 0, 0, 10, 1),
(571, 0, 0, 0, 'Edron Flats, Flat 26', 800, 5, 0, 0, 0, 0, 10, 1),
(572, 0, 0, 0, 'Edron Flats, Flat 27', 800, 5, 0, 0, 0, 0, 10, 1),
(573, 0, 0, 0, 'Edron Flats, Flat 28', 800, 5, 0, 0, 0, 0, 10, 1),
(574, 0, 0, 0, 'Edron Flats, Basement Flat 1', 2980, 5, 0, 0, 0, 0, 36, 2),
(575, 0, 0, 0, 'Edron Flats, Basement Flat 2', 2980, 5, 0, 0, 0, 0, 36, 2),
(576, 0, 0, 0, 'Central Circle 1', 5940, 5, 0, 0, 0, 0, 73, 2),
(577, 0, 0, 0, 'Central Circle 2', 6500, 5, 0, 0, 0, 0, 80, 2),
(578, 0, 0, 0, 'Central Circle 3', 7920, 5, 0, 0, 0, 0, 94, 5),
(579, 0, 0, 0, 'Central Circle 4', 7920, 5, 0, 0, 0, 0, 94, 5),
(580, 0, 0, 0, 'Central Circle 5', 7920, 5, 0, 0, 0, 0, 94, 5),
(581, 0, 0, 0, 'Central Circle 6 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2),
(582, 0, 0, 0, 'Central Circle 7 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2),
(583, 0, 0, 0, 'Central Circle 8 (Shop)', 7860, 5, 0, 0, 0, 0, 97, 2),
(584, 0, 0, 0, 'Central Circle 9a', 1780, 5, 0, 0, 0, 0, 21, 2),
(585, 0, 0, 0, 'Central Circle 9b', 1780, 5, 0, 0, 0, 0, 21, 2),
(586, 0, 0, 0, 'Wood Avenue 1', 3430, 5, 0, 0, 0, 0, 37, 2),
(587, 0, 0, 0, 'Wood Avenue 2', 3430, 5, 0, 0, 0, 0, 37, 2),
(588, 0, 0, 0, 'Wood Avenue 3', 3430, 5, 0, 0, 0, 0, 37, 2),
(589, 0, 0, 0, 'Wood Avenue 4', 3430, 5, 0, 0, 0, 0, 37, 2),
(590, 0, 0, 0, 'Wood Avenue 5', 3430, 5, 0, 0, 0, 0, 37, 2),
(591, 0, 0, 0, 'Wood Avenue 6a', 2800, 5, 0, 0, 0, 0, 30, 2),
(592, 0, 0, 0, 'Wood Avenue 6b', 2800, 5, 0, 0, 0, 0, 30, 2),
(593, 0, 0, 0, 'Wood Avenue 7', 11720, 5, 0, 0, 0, 0, 128, 3),
(594, 0, 0, 0, 'Wood Avenue 8', 11720, 5, 0, 0, 0, 0, 128, 3),
(595, 0, 0, 0, 'Wood Avenue 9a', 2980, 5, 0, 0, 0, 0, 32, 2),
(596, 0, 0, 0, 'Wood Avenue 9b', 2890, 5, 0, 0, 0, 0, 31, 2),
(597, 0, 0, 0, 'Wood Avenue 10a', 2980, 5, 0, 0, 0, 0, 32, 2),
(598, 0, 0, 0, 'Wood Avenue 10b', 2990, 5, 0, 0, 0, 0, 31, 3),
(599, 0, 0, 0, 'Wood Avenue 11', 13910, 5, 0, 0, 0, 0, 149, 6),
(600, 0, 0, 0, 'Wood Avenue 4a', 2890, 5, 0, 0, 0, 0, 31, 2),
(601, 0, 0, 0, 'Wood Avenue 4b', 2890, 5, 0, 0, 0, 0, 31, 2),
(602, 0, 0, 0, 'Wood Avenue 4c', 3430, 5, 0, 0, 0, 0, 37, 2),
(603, 0, 0, 0, 'Sky Lane, Guild 1', 40090, 5, 0, 0, 0, 0, 421, 23),
(604, 0, 0, 0, 'Sky Lane, Guild 2', 37300, 5, 0, 0, 0, 0, 400, 14),
(605, 0, 0, 0, 'Sky Lane, Guild 3', 32930, 5, 0, 0, 0, 0, 347, 18),
(606, 0, 0, 0, 'Sky Lane, Sea Tower', 9050, 5, 0, 0, 0, 0, 95, 6),
(607, 0, 0, 0, 'Magic Academy, Guild', 22750, 5, 0, 0, 0, 0, 195, 14),
(608, 0, 0, 0, 'Magic Academy, Shop', 3190, 5, 0, 0, 0, 0, 29, 1),
(609, 0, 0, 0, 'Magic Academy, Flat 1', 2730, 5, 0, 0, 0, 0, 23, 3),
(610, 0, 0, 0, 'Magic Academy, Flat 2', 2960, 5, 0, 0, 0, 0, 26, 2),
(611, 0, 0, 0, 'Magic Academy, Flat 3', 2860, 5, 0, 0, 0, 0, 26, 1),
(612, 0, 0, 0, 'Magic Academy, Flat 4', 2960, 5, 0, 0, 0, 0, 26, 2),
(613, 0, 0, 0, 'Magic Academy, Flat 5', 2860, 5, 0, 0, 0, 0, 26, 1),
(614, 0, 0, 0, 'Stonehome Village 1', 3460, 5, 0, 0, 0, 0, 42, 2),
(615, 0, 0, 0, 'Stonehome Village 2', 1280, 5, 0, 0, 0, 0, 16, 1),
(616, 0, 0, 0, 'Stonehome Village 3', 1360, 5, 0, 0, 0, 0, 17, 1),
(617, 0, 0, 0, 'Stonehome Village 4', 1780, 5, 0, 0, 0, 0, 21, 2),
(618, 0, 0, 0, 'Stonehome Village 5', 2180, 5, 0, 0, 0, 0, 26, 2),
(619, 0, 0, 0, 'Stonehome Village 6', 2500, 5, 0, 0, 0, 0, 30, 2),
(620, 0, 0, 0, 'Stonehome Village 7', 2180, 5, 0, 0, 0, 0, 26, 2),
(621, 0, 0, 0, 'Stonehome Village 8', 1360, 5, 0, 0, 0, 0, 17, 1),
(622, 0, 0, 0, 'Stonehome Village 9', 1360, 5, 0, 0, 0, 0, 17, 1),
(623, 0, 0, 0, 'Stonehome Flats, Flat 01', 800, 5, 0, 0, 0, 0, 10, 1),
(624, 0, 0, 0, 'Stonehome Flats, Flat 02', 1380, 5, 0, 0, 0, 0, 16, 2),
(625, 0, 0, 0, 'Stonehome Flats, Flat 03', 800, 5, 0, 0, 0, 0, 10, 1),
(626, 0, 0, 0, 'Stonehome Flats, Flat 04', 800, 5, 0, 0, 0, 0, 10, 1),
(627, 0, 0, 0, 'Stonehome Flats, Flat 05', 800, 5, 0, 0, 0, 0, 10, 1),
(628, 0, 0, 0, 'Stonehome Flats, Flat 06', 800, 5, 0, 0, 0, 0, 10, 1),
(629, 0, 0, 0, 'Stonehome Flats, Flat 11', 1380, 5, 0, 0, 0, 0, 16, 2),
(630, 0, 0, 0, 'Stonehome Flats, Flat 12', 1380, 5, 0, 0, 0, 0, 16, 2),
(631, 0, 0, 0, 'Stonehome Flats, Flat 13', 800, 5, 0, 0, 0, 0, 10, 1),
(632, 0, 0, 0, 'Stonehome Flats, Flat 14', 800, 5, 0, 0, 0, 0, 10, 1),
(633, 0, 0, 0, 'Stonehome Flats, Flat 15', 800, 5, 0, 0, 0, 0, 10, 1),
(634, 0, 0, 0, 'Stonehome Flats, Flat 16', 800, 5, 0, 0, 0, 0, 10, 1),
(635, 0, 0, 0, 'Stonehome Clanhall', 16260, 5, 0, 0, 0, 0, 192, 10),
(636, 0, 0, 0, 'Cormaya Flats, Flat 01', 900, 5, 0, 0, 0, 0, 10, 1),
(637, 0, 0, 0, 'Cormaya Flats, Flat 02', 900, 5, 0, 0, 0, 0, 10, 1),
(638, 0, 0, 0, 'Cormaya Flats, Flat 03', 1540, 5, 0, 0, 0, 0, 16, 2),
(639, 0, 0, 0, 'Cormaya Flats, Flat 04', 1540, 5, 0, 0, 0, 0, 16, 2),
(640, 0, 0, 0, 'Cormaya Flats, Flat 05', 900, 5, 0, 0, 0, 0, 10, 1),
(641, 0, 0, 0, 'Cormaya Flats, Flat 06', 900, 5, 0, 0, 0, 0, 10, 1),
(642, 0, 0, 0, 'Cormaya Flats, Flat 11', 900, 5, 0, 0, 0, 0, 10, 1),
(643, 0, 0, 0, 'Cormaya Flats, Flat 12', 900, 5, 0, 0, 0, 0, 10, 1),
(644, 0, 0, 0, 'Cormaya Flats, Flat 13', 1540, 5, 0, 0, 0, 0, 16, 2),
(645, 0, 0, 0, 'Cormaya Flats, Flat 14', 1540, 5, 0, 0, 0, 0, 16, 2),
(646, 0, 0, 0, 'Cormaya Flats, Flat 15', 900, 5, 0, 0, 0, 0, 10, 1),
(647, 0, 0, 0, 'Cormaya Flats, Flat 16', 900, 5, 0, 0, 0, 0, 10, 1),
(648, 0, 0, 0, 'Cormaya 1', 2440, 5, 0, 0, 0, 0, 26, 2),
(649, 0, 0, 0, 'Cormaya 2', 7220, 5, 0, 0, 0, 0, 78, 3),
(650, 0, 0, 0, 'Cormaya 3', 3970, 5, 0, 0, 0, 0, 43, 2),
(651, 0, 0, 0, 'Cormaya 4', 3340, 5, 0, 0, 0, 0, 36, 2),
(652, 0, 0, 0, 'Cormaya 5', 11000, 5, 0, 0, 0, 0, 120, 3),
(653, 0, 0, 0, 'Cormaya 6', 4690, 5, 0, 0, 0, 0, 51, 2),
(654, 0, 0, 0, 'Cormaya 7', 4690, 5, 0, 0, 0, 0, 51, 2),
(655, 0, 0, 0, 'Cormaya 8', 5320, 5, 0, 0, 0, 0, 58, 2),
(656, 0, 0, 0, 'Cormaya 9a', 2350, 5, 0, 0, 0, 0, 25, 2),
(657, 0, 0, 0, 'Cormaya 9b', 5140, 5, 0, 0, 0, 0, 56, 2),
(658, 0, 0, 0, 'Cormaya 9c', 2350, 5, 0, 0, 0, 0, 25, 2),
(659, 0, 0, 0, 'Cormaya 9d', 5140, 5, 0, 0, 0, 0, 56, 2),
(660, 0, 0, 0, 'Cormaya 10', 7400, 5, 0, 0, 0, 0, 80, 3),
(661, 0, 0, 0, 'Cormaya 11', 3970, 5, 0, 0, 0, 0, 43, 2),
(662, 0, 0, 0, 'Castle of the White Dragon', 48150, 5, 0, 0, 0, 0, 515, 19),
(663, 0, 0, 0, 'Chameken I', 1700, 8, 0, 0, 0, 0, 17, 1),
(664, 0, 0, 0, 'Chameken II', 1700, 8, 0, 0, 0, 0, 17, 1),
(665, 0, 0, 0, 'Thanah I a', 1700, 8, 0, 0, 0, 0, 17, 1),
(666, 0, 0, 0, 'Thanah I b', 5800, 8, 0, 0, 0, 0, 56, 3),
(667, 0, 0, 0, 'Thanah I c', 6300, 8, 0, 0, 0, 0, 61, 3),
(668, 0, 0, 0, 'Thanah I d', 5500, 8, 0, 0, 0, 0, 52, 4),
(669, 0, 0, 0, 'Thanah II a', 1700, 8, 0, 0, 0, 0, 17, 1),
(670, 0, 0, 0, 'Thanah II b', 900, 8, 0, 0, 0, 0, 9, 1),
(671, 0, 0, 0, 'Thanah II c', 900, 8, 0, 0, 0, 0, 9, 1),
(672, 0, 0, 0, 'Thanah II d', 700, 8, 0, 0, 0, 0, 7, 1),
(673, 0, 0, 0, 'Thanah II e', 700, 8, 0, 0, 0, 0, 7, 1),
(674, 0, 0, 0, 'Thanah II f', 5500, 8, 0, 0, 0, 0, 53, 3),
(675, 0, 0, 0, 'Thanah II g', 3200, 8, 0, 0, 0, 0, 31, 2),
(676, 0, 0, 0, 'Thanah II h', 2700, 8, 0, 0, 0, 0, 26, 2),
(677, 0, 0, 0, 'Thrarhor I a (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1),
(678, 0, 0, 0, 'Thrarhor I b (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1),
(679, 0, 0, 0, 'Thrarhor I c (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1),
(680, 0, 0, 0, 'Thrarhor I d (Shop)', 2100, 8, 0, 0, 0, 0, 21, 1),
(681, 0, 0, 0, 'Botham I a', 1900, 8, 0, 0, 0, 0, 19, 1),
(682, 0, 0, 0, 'Botham I b', 5800, 8, 0, 0, 0, 0, 56, 3),
(683, 0, 0, 0, 'Botham I c', 3300, 8, 0, 0, 0, 0, 32, 2),
(684, 0, 0, 0, 'Botham I d', 5900, 8, 0, 0, 0, 0, 57, 3),
(685, 0, 0, 0, 'Botham I e', 3200, 8, 0, 0, 0, 0, 31, 2),
(686, 0, 0, 0, 'Botham II a', 1700, 8, 0, 0, 0, 0, 17, 1),
(687, 0, 0, 0, 'Botham II b', 3100, 8, 0, 0, 0, 0, 30, 2),
(688, 0, 0, 0, 'Botham II c', 2400, 8, 0, 0, 0, 0, 23, 2),
(689, 0, 0, 0, 'Botham II d', 3800, 8, 0, 0, 0, 0, 37, 2),
(690, 0, 0, 0, 'Botham II e', 3200, 8, 0, 0, 0, 0, 31, 2),
(691, 0, 0, 0, 'Botham II f', 3200, 8, 0, 0, 0, 0, 31, 2),
(692, 0, 0, 0, 'Botham II g', 2700, 8, 0, 0, 0, 0, 26, 2),
(693, 0, 0, 0, 'Botham III a', 2700, 8, 0, 0, 0, 0, 26, 2),
(694, 0, 0, 0, 'Botham III b', 1800, 8, 0, 0, 0, 0, 17, 2),
(695, 0, 0, 0, 'Botham III c', 1700, 8, 0, 0, 0, 0, 17, 1),
(696, 0, 0, 0, 'Botham III d', 1700, 8, 0, 0, 0, 0, 17, 1),
(697, 0, 0, 0, 'Botham III e', 1700, 8, 0, 0, 0, 0, 17, 1),
(698, 0, 0, 0, 'Botham III f', 4500, 8, 0, 0, 0, 0, 43, 3),
(699, 0, 0, 0, 'Botham III g', 3200, 8, 0, 0, 0, 0, 31, 2),
(700, 0, 0, 0, 'Botham III h', 7300, 8, 0, 0, 0, 0, 71, 3),
(701, 0, 0, 0, 'Botham IV a', 2700, 8, 0, 0, 0, 0, 26, 2),
(702, 0, 0, 0, 'Botham IV b', 1700, 8, 0, 0, 0, 0, 17, 1),
(703, 0, 0, 0, 'Botham IV c', 1700, 8, 0, 0, 0, 0, 17, 1),
(704, 0, 0, 0, 'Botham IV d', 1700, 8, 0, 0, 0, 0, 17, 1),
(705, 0, 0, 0, 'Botham IV e', 1700, 8, 0, 0, 0, 0, 17, 1),
(706, 0, 0, 0, 'Botham IV f', 3300, 8, 0, 0, 0, 0, 32, 2),
(707, 0, 0, 0, 'Botham IV g', 3200, 8, 0, 0, 0, 0, 31, 2),
(708, 0, 0, 0, 'Botham IV h', 3700, 8, 0, 0, 0, 0, 37, 1),
(709, 0, 0, 0, 'Botham IV i', 3400, 8, 0, 0, 0, 0, 32, 3),
(710, 0, 0, 0, 'Ramen Tah', 13800, 8, 0, 0, 0, 0, 123, 16),
(711, 0, 0, 0, 'Charsirakh I a', 560, 8, 0, 0, 0, 0, 7, 1),
(712, 0, 0, 0, 'Charsirakh I b', 3060, 8, 0, 0, 0, 0, 37, 2),
(713, 0, 0, 0, 'Charsirakh II', 2180, 8, 0, 0, 0, 0, 26, 2),
(714, 0, 0, 0, 'Charsirakh III', 1360, 8, 0, 0, 0, 0, 17, 1),
(715, 0, 0, 0, 'Othehothep I a', 560, 8, 0, 0, 0, 0, 7, 1),
(716, 0, 0, 0, 'Othehothep I b', 2660, 8, 0, 0, 0, 0, 32, 2),
(717, 0, 0, 0, 'Othehothep I c', 3240, 8, 0, 0, 0, 0, 38, 3),
(718, 0, 0, 0, 'Othehothep I d', 3740, 8, 0, 0, 0, 0, 43, 4),
(719, 0, 0, 0, 'Othehothep II a', 800, 8, 0, 0, 0, 0, 10, 1),
(720, 0, 0, 0, 'Othehothep II b', 3640, 8, 0, 0, 0, 0, 43, 3),
(721, 0, 0, 0, 'Othehothep II c', 1680, 8, 0, 0, 0, 0, 21, 1),
(722, 0, 0, 0, 'Othehothep II d', 1680, 8, 0, 0, 0, 0, 21, 1),
(723, 0, 0, 0, 'Othehothep II e', 2580, 8, 0, 0, 0, 0, 31, 2),
(724, 0, 0, 0, 'Othehothep II f', 2580, 8, 0, 0, 0, 0, 31, 2),
(725, 0, 0, 0, 'Othehothep III a', 560, 8, 0, 0, 0, 0, 7, 1),
(726, 0, 0, 0, 'Othehothep III b', 2580, 8, 0, 0, 0, 0, 31, 2),
(727, 0, 0, 0, 'Othehothep III c', 1780, 8, 0, 0, 0, 0, 21, 2),
(728, 0, 0, 0, 'Othehothep III d', 2080, 8, 0, 0, 0, 0, 26, 1),
(729, 0, 0, 0, 'Othehothep III e', 1680, 8, 0, 0, 0, 0, 21, 1),
(730, 0, 0, 0, 'Othehothep III f', 1360, 8, 0, 0, 0, 0, 17, 1),
(731, 0, 0, 0, 'Harrah I', 10580, 8, 0, 0, 0, 0, 121, 10),
(732, 0, 0, 0, 'Murkhol I a', 880, 8, 0, 0, 0, 0, 11, 1),
(733, 0, 0, 0, 'Murkhol I b', 880, 8, 0, 0, 0, 0, 11, 1),
(734, 0, 0, 0, 'Murkhol I c', 880, 8, 0, 0, 0, 0, 11, 1),
(735, 0, 0, 0, 'Murkhol I d', 880, 8, 0, 0, 0, 0, 11, 1),
(736, 0, 0, 0, 'Oskahl I a', 3060, 8, 0, 0, 0, 0, 37, 2),
(737, 0, 0, 0, 'Oskahl I b', 1680, 8, 0, 0, 0, 0, 21, 1),
(738, 0, 0, 0, 'Oskahl I c', 1360, 8, 0, 0, 0, 0, 17, 1),
(739, 0, 0, 0, 'Oskahl I d', 2180, 8, 0, 0, 0, 0, 26, 2),
(740, 0, 0, 0, 'Oskahl I e', 1680, 8, 0, 0, 0, 0, 21, 1),
(741, 0, 0, 0, 'Oskahl I f', 1680, 8, 0, 0, 0, 0, 21, 1),
(742, 0, 0, 0, 'Oskahl I g', 2180, 8, 0, 0, 0, 0, 26, 2),
(743, 0, 0, 0, 'Oskahl I h', 3320, 8, 0, 0, 0, 0, 39, 3),
(744, 0, 0, 0, 'Oskahl I i', 1680, 8, 0, 0, 0, 0, 21, 1),
(745, 0, 0, 0, 'Oskahl I j', 1360, 8, 0, 0, 0, 0, 17, 1),
(746, 0, 0, 0, 'Mothrem I', 2180, 8, 0, 0, 0, 0, 26, 2),
(747, 0, 0, 0, 'Arakmehn I', 2440, 8, 0, 0, 0, 0, 28, 3),
(748, 0, 0, 0, 'Arakmehn II', 2080, 8, 0, 0, 0, 0, 26, 1),
(749, 0, 0, 0, 'Arakmehn III', 2180, 8, 0, 0, 0, 0, 26, 2),
(750, 0, 0, 0, 'Arakmehn IV', 2340, 8, 0, 0, 0, 0, 28, 2),
(751, 0, 0, 0, 'Unklath I a', 2180, 8, 0, 0, 0, 0, 26, 2),
(752, 0, 0, 0, 'Unklath I b', 2820, 8, 0, 0, 0, 0, 34, 2),
(753, 0, 0, 0, 'Unklath I c', 2820, 8, 0, 0, 0, 0, 34, 2),
(754, 0, 0, 0, 'Unklath I d', 3160, 8, 0, 0, 0, 0, 37, 3),
(755, 0, 0, 0, 'Unklath I e', 3060, 8, 0, 0, 0, 0, 37, 2),
(756, 0, 0, 0, 'Unklath I f', 3060, 8, 0, 0, 0, 0, 37, 2),
(757, 0, 0, 0, 'Unklath I g', 2960, 8, 0, 0, 0, 0, 37, 1),
(758, 0, 0, 0, 'Unklath II a', 2080, 8, 0, 0, 0, 0, 26, 1),
(759, 0, 0, 0, 'Unklath II b', 1360, 8, 0, 0, 0, 0, 17, 1),
(760, 0, 0, 0, 'Unklath II c', 1360, 8, 0, 0, 0, 0, 17, 1),
(761, 0, 0, 0, 'Unklath II d', 3060, 8, 0, 0, 0, 0, 37, 2),
(762, 0, 0, 0, 'Rathal I a', 2180, 8, 0, 0, 0, 0, 26, 2),
(763, 0, 0, 0, 'Rathal I b', 1360, 8, 0, 0, 0, 0, 17, 1),
(764, 0, 0, 0, 'Rathal I c', 1360, 8, 0, 0, 0, 0, 17, 1),
(765, 0, 0, 0, 'Rathal I d', 1460, 8, 0, 0, 0, 0, 17, 2),
(766, 0, 0, 0, 'Rathal I e', 1460, 8, 0, 0, 0, 0, 17, 2),
(767, 0, 0, 0, 'Rathal II a', 2080, 8, 0, 0, 0, 0, 26, 1),
(768, 0, 0, 0, 'Rathal II b', 1360, 8, 0, 0, 0, 0, 17, 1),
(769, 0, 0, 0, 'Rathal II c', 1360, 8, 0, 0, 0, 0, 17, 1),
(770, 0, 0, 0, 'Rathal II d', 2820, 8, 0, 0, 0, 0, 34, 2),
(771, 0, 0, 0, 'Uthemath I a', 800, 8, 0, 0, 0, 0, 10, 1),
(772, 0, 0, 0, 'Uthemath I b', 1600, 8, 0, 0, 0, 0, 20, 1),
(773, 0, 0, 0, 'Uthemath I c', 1700, 8, 0, 0, 0, 0, 20, 2),
(774, 0, 0, 0, 'Uthemath I d', 1680, 8, 0, 0, 0, 0, 21, 1),
(775, 0, 0, 0, 'Uthemath I e', 1780, 8, 0, 0, 0, 0, 21, 2),
(776, 0, 0, 0, 'Uthemath I f', 4680, 8, 0, 0, 0, 0, 56, 3),
(777, 0, 0, 0, 'Uthemath II', 8220, 8, 0, 0, 0, 0, 94, 8),
(778, 0, 0, 0, 'Esuph I', 1360, 8, 0, 0, 0, 0, 17, 1),
(779, 0, 0, 0, 'Esuph II a', 560, 8, 0, 0, 0, 0, 7, 1),
(780, 0, 0, 0, 'Esuph II b', 2660, 8, 0, 0, 0, 0, 32, 2),
(781, 0, 0, 0, 'Esuph III a', 560, 8, 0, 0, 0, 0, 7, 1),
(782, 0, 0, 0, 'Esuph III b', 2580, 8, 0, 0, 0, 0, 31, 2),
(783, 0, 0, 0, 'Esuph IV a', 800, 8, 0, 0, 0, 0, 10, 1),
(784, 0, 0, 0, 'Esuph IV b', 800, 8, 0, 0, 0, 0, 10, 1),
(785, 0, 0, 0, 'Esuph IV c', 800, 8, 0, 0, 0, 0, 10, 1),
(786, 0, 0, 0, 'Esuph IV d', 1600, 8, 0, 0, 0, 0, 20, 1),
(787, 0, 0, 0, 'Horakhal', 17540, 8, 0, 0, 0, 0, 203, 14),
(788, 0, 0, 0, 'Darashia 1, Flat 01', 2100, 6, 0, 0, 0, 0, 25, 2),
(789, 0, 0, 0, 'Darashia 1, Flat 02', 2000, 6, 0, 0, 0, 0, 25, 1),
(790, 0, 0, 0, 'Darashia 1, Flat 03', 5020, 6, 0, 0, 0, 0, 59, 4),
(791, 0, 0, 0, 'Darashia 1, Flat 04', 2000, 6, 0, 0, 0, 0, 25, 1),
(792, 0, 0, 0, 'Darashia 1, Flat 05', 2100, 6, 0, 0, 0, 0, 25, 2),
(793, 0, 0, 0, 'Darashia 1, Flat 11', 2100, 6, 0, 0, 0, 0, 25, 2),
(794, 0, 0, 0, 'Darashia 1, Flat 12', 3460, 6, 0, 0, 0, 0, 42, 2),
(795, 0, 0, 0, 'Darashia 1, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2),
(796, 0, 0, 0, 'Darashia 1, Flat 14', 5120, 6, 0, 0, 0, 0, 59, 5);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `beds`) VALUES
(797, 0, 0, 0, 'Darashia 2, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1),
(798, 0, 0, 0, 'Darashia 2, Flat 02', 2000, 6, 0, 0, 0, 0, 25, 1),
(799, 0, 0, 0, 'Darashia 2, Flat 03', 2320, 6, 0, 0, 0, 0, 29, 1),
(800, 0, 0, 0, 'Darashia 2, Flat 04', 1040, 6, 0, 0, 0, 0, 13, 1),
(801, 0, 0, 0, 'Darashia 2, Flat 05', 2420, 6, 0, 0, 0, 0, 29, 2),
(802, 0, 0, 0, 'Darashia 2, Flat 06', 1040, 6, 0, 0, 0, 0, 13, 1),
(803, 0, 0, 0, 'Darashia 2, Flat 07', 2000, 6, 0, 0, 0, 0, 25, 1),
(804, 0, 0, 0, 'Darashia 2, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1),
(805, 0, 0, 0, 'Darashia 2, Flat 12', 1040, 6, 0, 0, 0, 0, 13, 1),
(806, 0, 0, 0, 'Darashia 2, Flat 13', 2320, 6, 0, 0, 0, 0, 29, 1),
(807, 0, 0, 0, 'Darashia 2, Flat 14', 1040, 6, 0, 0, 0, 0, 13, 1),
(808, 0, 0, 0, 'Darashia 2, Flat 15', 2420, 6, 0, 0, 0, 0, 29, 2),
(809, 0, 0, 0, 'Darashia 2, Flat 16', 1360, 6, 0, 0, 0, 0, 17, 1),
(810, 0, 0, 0, 'Darashia 2, Flat 17', 2000, 6, 0, 0, 0, 0, 25, 1),
(811, 0, 0, 0, 'Darashia 2, Flat 18', 1360, 6, 0, 0, 0, 0, 17, 1),
(812, 0, 0, 0, 'Darashia 3, Flat 01', 2100, 6, 0, 0, 0, 0, 25, 2),
(813, 0, 0, 0, 'Darashia 3, Flat 02', 3140, 6, 0, 0, 0, 0, 38, 2),
(814, 0, 0, 0, 'Darashia 3, Flat 03', 2100, 6, 0, 0, 0, 0, 25, 2),
(815, 0, 0, 0, 'Darashia 3, Flat 04', 3140, 6, 0, 0, 0, 0, 38, 2),
(816, 0, 0, 0, 'Darashia 3, Flat 05', 2000, 6, 0, 0, 0, 0, 25, 1),
(817, 0, 0, 0, 'Darashia 3, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1),
(818, 0, 0, 0, 'Darashia 3, Flat 12', 4800, 6, 0, 0, 0, 0, 55, 5),
(819, 0, 0, 0, 'Darashia 3, Flat 13', 2100, 6, 0, 0, 0, 0, 25, 2),
(820, 0, 0, 0, 'Darashia 3, Flat 14', 4600, 6, 0, 0, 0, 0, 55, 3),
(821, 0, 0, 0, 'Darashia 4, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1),
(822, 0, 0, 0, 'Darashia 4, Flat 02', 3460, 6, 0, 0, 0, 0, 42, 2),
(823, 0, 0, 0, 'Darashia 4, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1),
(824, 0, 0, 0, 'Darashia 4, Flat 04', 3460, 6, 0, 0, 0, 0, 42, 2),
(825, 0, 0, 0, 'Darashia 4, Flat 05', 2100, 6, 0, 0, 0, 0, 25, 2),
(826, 0, 0, 0, 'Darashia 4, Flat 11', 2000, 6, 0, 0, 0, 0, 25, 1),
(827, 0, 0, 0, 'Darashia 4, Flat 12', 4920, 6, 0, 0, 0, 0, 59, 3),
(828, 0, 0, 0, 'Darashia 4, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2),
(829, 0, 0, 0, 'Darashia 4, Flat 14', 3460, 6, 0, 0, 0, 0, 42, 2),
(830, 0, 0, 0, 'Darashia 5, Flat 01', 2000, 6, 0, 0, 0, 0, 25, 1),
(831, 0, 0, 0, 'Darashia 5, Flat 02', 3140, 6, 0, 0, 0, 0, 38, 2),
(832, 0, 0, 0, 'Darashia 5, Flat 03', 2000, 6, 0, 0, 0, 0, 25, 1),
(833, 0, 0, 0, 'Darashia 5, Flat 04', 3140, 6, 0, 0, 0, 0, 38, 2),
(834, 0, 0, 0, 'Darashia 5, Flat 05', 2000, 6, 0, 0, 0, 0, 25, 1),
(835, 0, 0, 0, 'Darashia 5, Flat 11', 3460, 6, 0, 0, 0, 0, 42, 2),
(836, 0, 0, 0, 'Darashia 5, Flat 12', 3140, 6, 0, 0, 0, 0, 38, 2),
(837, 0, 0, 0, 'Darashia 5, Flat 13', 3460, 6, 0, 0, 0, 0, 42, 2),
(838, 0, 0, 0, 'Darashia 5, Flat 14', 3140, 6, 0, 0, 0, 0, 38, 2),
(839, 0, 0, 0, 'Darashia 6a', 6130, 6, 0, 0, 0, 0, 67, 2),
(840, 0, 0, 0, 'Darashia 6b', 6760, 6, 0, 0, 0, 0, 74, 2),
(841, 0, 0, 0, 'Darashia 7, Flat 01', 2250, 6, 0, 0, 0, 0, 25, 1),
(842, 0, 0, 0, 'Darashia 7, Flat 02', 2250, 6, 0, 0, 0, 0, 25, 1),
(843, 0, 0, 0, 'Darashia 7, Flat 03', 5610, 6, 0, 0, 0, 0, 59, 4),
(844, 0, 0, 0, 'Darashia 7, Flat 04', 2250, 6, 0, 0, 0, 0, 25, 1),
(845, 0, 0, 0, 'Darashia 7, Flat 05', 2350, 6, 0, 0, 0, 0, 25, 2),
(846, 0, 0, 0, 'Darashia 7, Flat 11', 2250, 6, 0, 0, 0, 0, 25, 1),
(847, 0, 0, 0, 'Darashia 7, Flat 12', 5610, 6, 0, 0, 0, 0, 59, 4),
(848, 0, 0, 0, 'Darashia 7, Flat 13', 2250, 6, 0, 0, 0, 0, 25, 1),
(849, 0, 0, 0, 'Darashia 7, Flat 14', 5610, 6, 0, 0, 0, 0, 59, 4),
(850, 0, 0, 0, 'Darashia 8, Flat 01', 4870, 6, 0, 0, 0, 0, 53, 2),
(851, 0, 0, 0, 'Darashia 8, Flat 02', 6670, 6, 0, 0, 0, 0, 73, 2),
(852, 0, 0, 0, 'Darashia 8, Flat 03', 9200, 6, 0, 0, 0, 0, 100, 3),
(853, 0, 0, 0, 'Darashia 8, Flat 04', 5590, 6, 0, 0, 0, 0, 61, 2),
(854, 0, 0, 0, 'Darashia 8, Flat 05', 5230, 6, 0, 0, 0, 0, 57, 2),
(855, 0, 0, 0, 'Darashia, Villa', 10470, 6, 0, 0, 0, 0, 113, 4),
(856, 0, 0, 0, 'Darashia, Western Guildhall', 19570, 6, 0, 0, 0, 0, 203, 14),
(857, 0, 0, 0, 'Darashia, Eastern Guildhall', 23820, 6, 0, 0, 0, 0, 248, 16),
(858, 0, 0, 0, 'Darashia 8, Flat 11', 3880, 6, 0, 0, 0, 0, 42, 2),
(859, 0, 0, 0, 'Darashia 8, Flat 12', 3520, 6, 0, 0, 0, 0, 38, 2),
(860, 0, 0, 0, 'Darashia 8, Flat 13', 3880, 6, 0, 0, 0, 0, 42, 2),
(861, 0, 0, 0, 'Darashia 8, Flat 14', 3520, 6, 0, 0, 0, 0, 38, 2);

-- --------------------------------------------------------

--
-- Table structure for table `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `soul` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint(1) NOT NULL DEFAULT '1',
  `skull` tinyint(1) NOT NULL DEFAULT '0',
  `skulltime` int(11) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint(2) NOT NULL DEFAULT '0',
  `onlinetime` int(11) NOT NULL DEFAULT '0',
  `deletion` bigint(15) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint(5) unsigned NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `stamina` smallint(5) NOT NULL DEFAULT '3360',
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `fake_player` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT '0',
  `unjustified` tinyint(1) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL,
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(6) NOT NULL DEFAULT '0',
  `count` smallint(5) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_murders`
--

CREATE TABLE `player_murders` (
  `id` bigint(20) NOT NULL,
  `player_id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('motd_hash', '591d7fcbec26bc2982bdf5b0f13fd6bcbbd3aa0c'),
('motd_num', '1'),
('players_record', '2');

-- --------------------------------------------------------

--
-- Table structure for table `global_storage`
--

CREATE TABLE IF NOT EXISTS `global_storage` (
  `key` int(10) unsigned NOT NULL DEFAULT '0',
  `value` int(11) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

--
-- Dumping data for table `global_storage`
--

INSERT INTO `global_storage` (`key`, `value`) VALUES
(1, 0); -- key 1 = blooming griffinclaw; value 0 = not started in this month, value 1 = already started once

-- --------------------------------------------------------

--
-- Table structure for table `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Indexes for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Indexes for table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Indexes for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Indexes for table `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Indexes for table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Indexes for table `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Indexes for table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `player_murders`
--
ALTER TABLE `player_murders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Indexes for table `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Indexes for table `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Indexes for table `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=862;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `player_murders`
--
ALTER TABLE `player_murders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD CONSTRAINT `guild1_ibfk_1` FOREIGN KEY (`guild1`) REFERENCES `guilds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild2_ibfk_1` FOREIGN KEY (`guild2`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;
COMMIT;
  
--
-- Constraints for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
