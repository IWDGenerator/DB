-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: iwdgdb.mysql.database.azure.com    Database: iwdg_test
-- ------------------------------------------------------
-- Server version	5.7.38-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `organization_id` int(11) NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(200) DEFAULT NULL,
  `organization_type` int(11) DEFAULT NULL,
  `organization_status` tinyint(1) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `service_email` varchar(100) DEFAULT NULL,
  `service_email_password` varchar(255) DEFAULT NULL,
  `subscription` varchar(200) DEFAULT NULL,
  `task_url` varchar(255) DEFAULT NULL,
  `task_auth` varchar(45) DEFAULT NULL,
  `inserted_utc` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updated_utc` timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`organization_id`),
  KEY `company_id_idx` (`company_id`),
  KEY `organization_type_idx` (`organization_type`),
  KEY `organization_status_idx` (`organization_status`),
  KEY `organization_name&service_email_idx` (`organization_name`,`service_email`),
  CONSTRAINT `company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `organization_status` FOREIGN KEY (`organization_status`) REFERENCES `organization_statuses` (`organization_status`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `organization_type` FOREIGN KEY (`organization_type`) REFERENCES `organization_types` (`organization_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-16 12:42:27
