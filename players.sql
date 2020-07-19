-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 19, 2020 at 07:31 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `irp`
--

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) NOT NULL,
  `accounts` text NOT NULL,
  `perm_level` int(11) NOT NULL,
  `job` varchar(255) NOT NULL,
  `job_grade` varchar(255) NOT NULL,
  `inv` text NOT NULL,
  `pos` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license` (`license`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `players_veh`
--

DROP TABLE IF EXISTS `players_veh`;
CREATE TABLE IF NOT EXISTS `players_veh` (
  `owner` varchar(255) NOT NULL,
  `owned` int(11) NOT NULL DEFAULT 0,
  `plate` varchar(255) NOT NULL,
  `stored` int(11) NOT NULL DEFAULT 1,
  `props` text NOT NULL,
  `mileage` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`plate`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `society`
--

DROP TABLE IF EXISTS `society`;
CREATE TABLE IF NOT EXISTS `society` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society_name` varchar(50) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `inventory` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `society`
--

INSERT INTO `society` (`id`, `society_name`, `money`, `inventory`) VALUES
(1, 'test_society', 1000, '{}'),
(2, 'test_society2', 1500, '{}');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
