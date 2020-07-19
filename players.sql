-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 19, 2020 at 10:39 AM
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

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `license`, `accounts`, `perm_level`, `job`, `job_grade`, `inv`, `pos`) VALUES
(12, 'license:e1c5d1fad8a9f0305aee6ff0c4b73a1548e92374', '{\"money\":500,\"bank\":2000}', 0, 'Aucun', '0', '{\"repairkit\":{\"label\":\"Repair kit\",\"count\":1}}', '{\"x\":55.89034652709961,\"z\":69.4189682006836,\"y\":19.083532333374025}');

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
