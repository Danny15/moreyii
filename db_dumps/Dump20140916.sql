CREATE DATABASE  IF NOT EXISTS `mor_yiiapp` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mor_yiiapp`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: mor_yiiapp
-- ------------------------------------------------------
-- Server version	5.5.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dm_auth_assignment`
--

DROP TABLE IF EXISTS `dm_auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_auth_assignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`),
  CONSTRAINT `dm_auth_assignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `dm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_auth_assignment`
--

LOCK TABLES `dm_auth_assignment` WRITE;
/*!40000 ALTER TABLE `dm_auth_assignment` DISABLE KEYS */;
INSERT INTO `dm_auth_assignment` VALUES ('admin','1',NULL,'N;'),('viewer','2',NULL,'N;');
/*!40000 ALTER TABLE `dm_auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_auth_item`
--

DROP TABLE IF EXISTS `dm_auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_auth_item` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_auth_item`
--

LOCK TABLES `dm_auth_item` WRITE;
/*!40000 ALTER TABLE `dm_auth_item` DISABLE KEYS */;
INSERT INTO `dm_auth_item` VALUES ('admin',2,'',NULL,'N;'),('adminDepartment',0,'',NULL,'N;'),('adminEmployee',0,'',NULL,'N;'),('adminUser',0,'',NULL,'N;'),('createDepartment',0,'',NULL,'N;'),('createEmployee',0,'',NULL,'N;'),('createUser',0,'',NULL,'N;'),('deleteDepartment',0,'',NULL,'N;'),('deleteEmployee',0,'',NULL,'N;'),('deleteUser',0,'',NULL,'N;'),('updateDepartment',0,'',NULL,'N;'),('updateEmployee',0,'',NULL,'N;'),('updateUser',0,'',NULL,'N;'),('viewer',2,'',NULL,'N;');
/*!40000 ALTER TABLE `dm_auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_auth_item_child`
--

DROP TABLE IF EXISTS `dm_auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_auth_item_child` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `dm_auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `dm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dm_auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `dm_auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_auth_item_child`
--

LOCK TABLES `dm_auth_item_child` WRITE;
/*!40000 ALTER TABLE `dm_auth_item_child` DISABLE KEYS */;
INSERT INTO `dm_auth_item_child` VALUES ('admin','adminDepartment'),('admin','adminEmployee'),('admin','adminUser'),('viewer','createDepartment'),('viewer','createEmployee'),('admin','createUser'),('admin','deleteDepartment'),('admin','deleteEmployee'),('admin','deleteUser'),('viewer','updateDepartment'),('viewer','updateEmployee'),('admin','updateUser'),('admin','viewer');
/*!40000 ALTER TABLE `dm_auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_department`
--

DROP TABLE IF EXISTS `dm_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_department` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_department`
--

LOCK TABLES `dm_department` WRITE;
/*!40000 ALTER TABLE `dm_department` DISABLE KEYS */;
INSERT INTO `dm_department` VALUES (1,'IT Department');
/*!40000 ALTER TABLE `dm_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_employee`
--

DROP TABLE IF EXISTS `dm_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_employee` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `departmentId` tinyint(3) unsigned NOT NULL COMMENT 'CONSTRAINT FOREIGN KEY (departmentId) REFERENCES Department(id)',
  `firstName` varchar(20) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `email` varchar(60) NOT NULL,
  `ext` smallint(5) unsigned DEFAULT NULL,
  `hireDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `leaveDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`lastName`,`firstName`),
  KEY `departmentId` (`departmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_employee`
--

LOCK TABLES `dm_employee` WRITE;
/*!40000 ALTER TABLE `dm_employee` DISABLE KEYS */;
INSERT INTO `dm_employee` VALUES (1,1,'Danny','Morey','danny@gmail.com',1221,'2014-09-14 18:56:47','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `dm_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dm_user`
--

DROP TABLE IF EXISTS `dm_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dm_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `type` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dm_user`
--

LOCK TABLES `dm_user` WRITE;
/*!40000 ALTER TABLE `dm_user` DISABLE KEYS */;
INSERT INTO `dm_user` VALUES (1,'Daniel','2dfe5c3abbff57d8428ccc69fd096adc','dannymorey@gmail.com',1),(2,'Bob','2dfe5c3abbff57d8428ccc69fd096adc','danny.morey@dcmcompliance.com',1);
/*!40000 ALTER TABLE `dm_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-16 16:15:22
