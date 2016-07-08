-- MySQL dump 10.13  Distrib 5.6.27, for Win32 (x86)
--
-- Host: localhost    Database: clouddisk
-- ------------------------------------------------------
-- Server version	5.6.27

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
-- Table structure for table `t_file`
--

DROP TABLE IF EXISTS `t_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_file` (
  `id` varchar(32) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `uid` varchar(32) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `parentid` varchar(32) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  `ext` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_file`
--

LOCK TABLES `t_file` WRITE;
/*!40000 ALTER TABLE `t_file` DISABLE KEYS */;
INSERT INTO `t_file` VALUES ('1460178009871','data',2,'1','2016-04-09 13:00:09',NULL,'',''),('1460178015351','a.mp4',1,'1','2016-04-09 13:00:15',NULL,'0B','.mp4'),('1460178025836','qq_cut.jpg',1,'1','2016-04-09 13:00:25',NULL,'213KB','.jpg'),('1460178032849','1-s2.0-S0031320315003696-main.pdf',1,'1','2016-04-09 13:00:32',NULL,'997KB','.pdf'),('1460178156291','English.docx',1,'1','2016-04-09 13:02:36',NULL,'0B','.docx'),('1460178190143','Coldplay - Yellow.mp3',1,'1','2016-04-09 13:03:10',NULL,'4MB','.mp3'),('1460178207360','Angelis - Somewhere Over The Rainbow.mp3',1,'1','2016-04-09 13:03:27','1460178009871','4MB','.mp3'),('1460178349760','Backstreet Boys - Any Other Way.mp3',1,'1','2016-04-09 13:05:49','1460178009871','3MB','.mp3'),('1460178358512','Towards understanding.pdf',1,'1','2016-04-09 13:05:58','1460178009871','2MB','.pdf'),('1460178371160','a33-mastelic.pdf',1,'1','2016-04-09 13:06:11',NULL,'994KB','.pdf'),('1460179703705','a33-mastelic.pdf',1,'1','2016-04-09 13:28:23',NULL,'994KB','.pdf'),('1460179939124','1-s2.0-S016412121400288X-main.pdf',1,'1','2016-04-09 13:32:19','1460178009871','2MB','.pdf'),('1460179944839','Considering DVFS.zip',1,'1','2016-04-09 13:32:24','1460178009871','2MB','unknown'),('1460179957651','Energy efficient scheduling of virtual machines in cloud with deadline.pdf',1,'1','2016-04-09 13:32:37','1460178009871','1MB','.pdf'),('1460179973495','Energy-efficient Task Scheduling for Multi-core Platforms with per-core DVFS.pdf',1,'1','2016-04-09 13:32:53',NULL,'641KB','.pdf'),('1460179980052','1-s2.0-S016412121400288X-main.pdf',1,'1','2016-04-09 13:33:00',NULL,'2MB','.pdf'),('1460179993700','RT-ROS-A-real-time-ROS-architecture-on-multi-core-processors_2016_Future-Generation-Computer-Systems.pdf',1,'1','2016-04-09 13:33:13',NULL,'2MB','.pdf'),('1460180021785','A-hierarchical-approach-for-energy-efficient-scheduling-of-large-workloads-in-multicore-distributed-systems_2014_Sustainable-Computing-Informatics-and.pdf',1,'1','2016-04-09 13:33:41',NULL,'2MB','.pdf'),('1460180378574','myfile',2,'1','2016-04-09 13:39:38',NULL,'',''),('1460180391224','c',2,'1','2016-04-09 13:39:51',NULL,'',''),('1460180394195','d',2,'1','2016-04-09 13:39:54',NULL,'',''),('1460180397380','e',2,'1','2016-04-09 13:39:57',NULL,'',''),('1460180419647','Energy-efficient-deadline-scheduling-for-heterogeneous-systems_2012_Journal-of-Parallel-and-Distributed-Computing.pdf',1,'1','2016-04-09 13:40:19','1460180394195','844KB','.pdf'),('1460184288762','lol.gif',1,'1','2016-04-09 14:44:48',NULL,'4MB','.gif'),('1460734674010','????.jpg',1,'1460022261551','2016-04-15 23:37:54',NULL,'283KB','.jpg'),('1460734692379','wenjianjia',2,'1460022261551','2016-04-15 23:38:12',NULL,'','');
/*!40000 ALTER TABLE `t_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sharefile`
--

DROP TABLE IF EXISTS `t_sharefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sharefile` (
  `id` varchar(32) NOT NULL,
  `fromuser` varchar(255) DEFAULT NULL,
  `fileid` varchar(255) DEFAULT NULL,
  `type` int(4) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `pwd` varchar(32) DEFAULT NULL,
  `shareurlid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sharefile`
--

LOCK TABLES `t_sharefile` WRITE;
/*!40000 ALTER TABLE `t_sharefile` DISABLE KEYS */;
INSERT INTO `t_sharefile` VALUES ('1460194119166','1','1460178025836',0,0,'1460194119166','1460194119166'),('1460194119231','1','1460184288762',0,0,'1460194119166','1460194119166'),('1460734707555','1460022261551','1460734674010',1,0,'1460734707555','1460734707555'),('1460772894315','1','1460178009871',0,0,'1460772894315','1460772894315'),('1460776217375','1','1460178025836',0,0,'1460776217375','1460776217375'),('1460778783701','1','1460184288762',1,0,'1460778783701','1460778783701'),('1460779114774','1','1460178190143',1,0,'1460779114774','1460779114774'),('1460779141489','1','1460178349760',0,0,'1460779141489','1460779141489');
/*!40000 ALTER TABLE `t_sharefile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` varchar(32) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES ('1','xx','123'),('1460017797744','evergreen','1992'),('1460022027044','12121','1111'),('1460022261551','Evergreen','1992');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-16 22:09:08
