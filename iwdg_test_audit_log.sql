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
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `RowID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AppID` varchar(50) NOT NULL,
  `EntityOperationName` varchar(200) DEFAULT NULL,
  `CorrelationID` varchar(200) NOT NULL,
  `EventUniqueID` varchar(200) NOT NULL,
  `User` varchar(100) DEFAULT NULL,
  `ExecutionDateTime` datetime NOT NULL,
  `MSGState` varchar(10) NOT NULL,
  `Parameters` tinytext,
  `Payload` text,
  `SL_PipelineName` varchar(100) DEFAULT NULL,
  `SL_PipelineRunID` varchar(200) DEFAULT NULL,
  `SL_PipelineParentRunID` varchar(200) DEFAULT NULL,
  `SL_PipelineInstanceID` varchar(200) DEFAULT NULL,
  `SL_ProjectPath` varchar(300) DEFAULT NULL,
  `SL_Host` varchar(200) DEFAULT NULL,
  `SL_PlexPath` varchar(300) DEFAULT NULL,
  `SL_User` varchar(100) DEFAULT NULL,
  `SL_URLPath` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`RowID`)
) ENGINE=InnoDB AUTO_INCREMENT=17283 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-16 12:42:18
