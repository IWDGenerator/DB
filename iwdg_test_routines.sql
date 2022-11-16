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
-- Dumping routines for database 'iwdg_test'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_authenticate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`iwdgadmin`@`%` PROCEDURE `sp_authenticate`(
	IN p_user VARCHAR(50),
	IN p_pass VARCHAR(50)
)
BEGIN
	SELECT A.*, B.* FROM `iwdg_test`.`users` A JOIN  `iwdg_test`.`user_permissions` B ON A.user = B.user where A.password = p_pass AND A.user = p_user LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_authenticate_v1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`iwdgadmin`@`%` PROCEDURE `sp_authenticate_v1`(
	IN p_user VARCHAR(50),
	IN p_pass VARCHAR(50)
)
BEGIN

IF EXISTS(SELECT * FROM `iwdg_test`.`user_permissions` WHERE `user` = p_user AND role = 1) THEN 
	SELECT C.*, B.* FROM `iwdg_test`.`user_ids` A JOIN  `iwdg_test`.`user_permissions` B ON A.user = B.user left join `iwdg_test`.`users` C on B.user=C.user where C.password = p_pass AND A.user = p_user LIMIT 1;
ELSE 
	SELECT "User not found" as message, 404 as status;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reset_password` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`iwdgadmin`@`%` PROCEDURE `sp_reset_password`(
	IN user VARCHAR(100),
    IN password VARCHAR(255),
    IN token VARCHAR(128)
)
BEGIN
	DECLARE status varchar(150);
	DECLARE exp_date_token BIGINT(20);
    DECLARE is_token_used varchar(128);
    
    DECLARE error_found tinyint(1);
    SET error_found = 0;
    
	IF NOT EXISTS(SELECT * FROM `iwdg_test`.`users` as U WHERE U.user = user) THEN
		SELECT "Unauthorized" as message, 401 as status;
        SET error_found = 1;
	ELSE
		IF EXISTS(SELECT * FROM `iwdg_test`.`users` as U WHERE U.user = user AND U.password = password) THEN
			SELECT "New password is same as current one." as message, 403 as status;
			SET error_found = 1;
        ELSE
			IF NOT EXISTS(SELECT * FROM `iwdg_test`.`user_password_reset_tokens` as T WHERE T.token = token) THEN
				SELECT "Invalid token" as message, 401 as status;
				SET error_found = 1;
			ELSE
				SELECT T.token_used, T.token_expiration_timestamp INTO is_token_used, exp_date_token FROM `iwdg_test`.`user_password_reset_tokens` T WHERE T.token = token;
				IF is_token_used = 1 THEN
					SELECT "Token has already been used" as message, 403 as status;
					SET error_found = 1;
				ELSE 
					IF !(current_timestamp() < FROM_UNIXTIME(exp_date_token/1000)) THEN
						SELECT "Expiration time of the token has passed" as message, 403 as status;
						SET error_found = 1;
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
   
    IF error_found = 0 THEN 
		UPDATE `iwdg_test`.`users` as U SET password = password, first_login = 0, updated_utc = current_timestamp() WHERE U.user = user;
		UPDATE `iwdg_test`.`user_password_reset_tokens` as PRT SET token_used = 1, updated_utc = current_timestamp() WHERE PRT.user = user AND PRT.token = token;
		SELECT 'User password changed' as message, 200 as status;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-16 12:43:35
