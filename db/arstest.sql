-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2016 at 11:37 PM
-- Server version: 5.5.25
-- PHP Version: 5.5.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `arstest`
--

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE IF NOT EXISTS `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_side_id` int(11) NOT NULL,
  `account_namber` bigint(20) NOT NULL,
  `bic` int(9) NOT NULL,
  `name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_side_id` (`payment_side_id`),
  KEY `payment_side_id_2` (`payment_side_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `banks`
--

INSERT INTO `banks` (`id`, `payment_side_id`, `account_namber`, `bic`, `name`, `city`) VALUES
(1, 1, 9223372036854775807, 44585416, 'КИВИ БАНК (ЗАО), Г. МОСКВА ', 'МОСКВА'),
(2, 2, 9223372036854775806, 44585415, 'ООО РНКО "РИБ", Г. МОСКВА ', 'МОСКВА '),
(3, 3, 9223372036854775805, 44585417, 'КИВИ БАНК (ЗАО), Г. Зеленоград', 'Зеленоград'),
(4, 4, 9223372036854775804, 44585417, 'ООО РНКО "РИБ", Г. Зеленоград', 'Зеленоград');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_type` varchar(20) NOT NULL,
  `doc_date` date NOT NULL,
  `doc_number` bigint(20) NOT NULL,
  `document_type` varchar(1) NOT NULL,
  `form_revision` date NOT NULL,
  `operation_type` int(2) NOT NULL,
  `queue` int(2) NOT NULL,
  `payment_info` varchar(255) NOT NULL,
  `amount` float NOT NULL,
  `currency` varchar(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `delivery_type`, `doc_date`, `doc_number`, `document_type`, `form_revision`, `operation_type`, `queue`, `payment_info`, `amount`, `currency`) VALUES
(1, 'электронно', '2013-09-02', 987, 'd', '2003-06-01', 1, 5, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается.', 2940, 'RUR'),
(2, 'электронно', '2013-09-03', 988, 'd', '2003-06-01', 1, 5, 'Перечисление денежных средств', 2000, 'RUR');

-- --------------------------------------------------------

--
-- Table structure for table `payment_sides`
--

CREATE TABLE IF NOT EXISTS `payment_sides` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_id` int(11) NOT NULL,
  `type` varchar(5) NOT NULL,
  `inn` bigint(12) NOT NULL,
  `kpp` bigint(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_id` (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `payment_sides`
--

INSERT INTO `payment_sides` (`id`, `payment_id`, `type`, `inn`, `kpp`, `name`, `number`) VALUES
(1, 1, 'payer', 3123011520, 123456789, 'КИВИ БАНК (ЗАО)', 9223372036854775807),
(2, 1, 'payee', 7704019762, 123456798, 'ООО РНКО РИБ', 3023381000000000000),
(3, 2, 'payer', 3123011521, 123456786, 'КИВИ БАНК (ЗАО)', 9223372036854775806),
(4, 2, 'payee', 7704019763, 123456797, 'ООО РНКО РИБ', 3023381000000000001);

-- --------------------------------------------------------

--
-- Table structure for table `registries`
--

CREATE TABLE IF NOT EXISTS `registries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_order` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_order` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `document_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `payer` bigint(20) NOT NULL,
  `payer_bank` varchar(255) NOT NULL,
  `payee` bigint(20) NOT NULL,
  `payment_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Dumping data for table `registries`
--

INSERT INTO `registries` (`id`, `start_order`, `end_order`, `document_id`, `amount`, `payer`, `payer_bank`, `payee`, `payment_name`) VALUES
(1, '2016-05-26 03:24:00', '0000-00-00 00:00:00', 0, 0, 0, '', 0, '1'),
(25, '2016-05-26 10:18:11', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \n'),
(26, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r'),
(27, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r'),
(28, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r'),
(29, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r'),
(30, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r'),
(31, '2013-09-01 14:00:00', '2013-09-01 14:00:00', 987, 2940, 9223372036854775807, 'КИВИ БАНК (ЗАО), Г. МОСКВА \r', 3023381000000000000, 'Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. \r');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `banks`
--
ALTER TABLE `banks`
  ADD CONSTRAINT `banks_ibfk_1` FOREIGN KEY (`payment_side_id`) REFERENCES `payment_sides` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment_sides`
--
ALTER TABLE `payment_sides`
  ADD CONSTRAINT `payment_sides_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
