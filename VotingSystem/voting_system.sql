CREATE DATABASE  IF NOT EXISTS `voting_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `voting_system`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: voting_system
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidates` (
  `candidate_id` int NOT NULL AUTO_INCREMENT,
  `candidate_name` varchar(30) DEFAULT NULL,
  `candidate_description` varchar(60) DEFAULT NULL,
  `aadhar_number` varchar(14) DEFAULT NULL,
  `profile_pic_id` int NOT NULL,
  `party_name` varchar(45) DEFAULT NULL,
  `party_logo_id` int NOT NULL,
  `vote_count` int NOT NULL DEFAULT '0',
  `created_by` int NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  `is_candidature_revoked` bit(1) NOT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `party_logo_id` (`party_logo_id`),
  KEY `profile_pic_id` (`profile_pic_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`party_logo_id`) REFERENCES `image` (`image_id`),
  CONSTRAINT `candidates_ibfk_2` FOREIGN KEY (`profile_pic_id`) REFERENCES `image` (`image_id`),
  CONSTRAINT `candidates_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (2,'Anand Raj','I will repair all the roads','5421-6545-6816',10,'NOTA',11,0,4,NULL,_binary '\0'),(3,'Shaheel Saha','Noida banega naya New York','2216-5465-1658',13,'UJP',14,0,6,NULL,_binary '\0'),(4,'Narendra Modi','Sabka Saath, Sabka Vikas','5879-6456-1236',15,'BJP',16,0,4,NULL,_binary '\0'),(5,'Pawan Kalyan','cannot be wiped out','2656-4168-4146',17,'Janasena Party',18,0,4,'2024-10-08 12:12:06.246880',_binary '\0');
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `election_participants`
--

DROP TABLE IF EXISTS `election_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `election_participants` (
  `election_id` int NOT NULL,
  `candidate_id` int NOT NULL,
  PRIMARY KEY (`election_id`,`candidate_id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `election_participants_ibfk_1` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`),
  CONSTRAINT `election_participants_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `election_participants`
--

LOCK TABLES `election_participants` WRITE;
/*!40000 ALTER TABLE `election_participants` DISABLE KEYS */;
INSERT INTO `election_participants` VALUES (1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4),(17,4),(5,5);
/*!40000 ALTER TABLE `election_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elections`
--

DROP TABLE IF EXISTS `elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elections` (
  `election_id` int NOT NULL AUTO_INCREMENT,
  `assigned_to` int NOT NULL,
  `created_by` int NOT NULL,
  `election_name` varchar(60) DEFAULT NULL,
  `election_type` varchar(32) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`election_id`),
  KEY `fk_creator` (`created_by`),
  KEY `fk_manager` (`assinged_to`),
  CONSTRAINT `fk_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_manager` FOREIGN KEY (`assinged_to`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elections`
--

LOCK TABLES `elections` WRITE;
/*!40000 ALTER TABLE `elections` DISABLE KEYS */;
INSERT INTO `elections` VALUES (1,5,4,'India General Election','Lok Sabha','2024-05-20 00:00:00.000000','2024-03-01 00:00:00.000000'),(2,5,7,'State Assembly Election','Rajya Sabha','2023-10-10 00:00:00.000000','2023-08-01 00:00:00.000000'),(3,6,4,'City Municipal Election','Municipal Corporation','2023-12-15 00:00:00.000000','2023-10-05 00:00:00.000000'),(4,6,4,'National Election','Lok Sabha','2025-07-01 00:00:00.000000','2025-05-01 00:00:00.000000'),(5,5,7,'Urban Municipality Election','Municipal Corporation','2024-04-20 00:00:00.000000','2024-02-15 00:00:00.000000'),(6,6,4,'State Senate Election','Rajya Sabha','2025-03-10 00:00:00.000000','2024-12-10 00:00:00.000000'),(7,6,4,'Capital City Election','Municipal Corporation','2023-11-30 00:00:00.000000','2023-09-25 00:00:00.000000'),(8,5,7,'National Election Phase 1','Lok Sabha','2024-08-15 00:00:00.000000','2024-06-10 00:00:00.000000'),(9,6,7,'Provincial Election','Rajya Sabha','2024-10-05 00:00:00.000000','2024-07-20 00:00:00.000000'),(10,5,4,'City Council Election','Municipal Corporation','2023-09-25 00:00:00.000000','2023-07-10 00:00:00.000000'),(11,5,7,'State Election Round 2','Lok Sabha','2025-01-01 00:00:00.000000','2024-11-01 00:00:00.000000'),(12,6,4,'State General Election','Rajya Sabha','2023-12-05 00:00:00.000000','2023-10-01 00:00:00.000000'),(13,5,7,'Township Election','Municipal Corporation','2023-10-20 00:00:00.000000','2023-09-01 00:00:00.000000'),(14,5,4,'National Election Final Round','Lok Sabha','2025-06-15 00:00:00.000000','2025-04-10 00:00:00.000000'),(15,5,4,'Urban Election Phase 1','Municipal Corporation','2023-11-10 00:00:00.000000','2023-09-05 00:00:00.000000'),(16,6,4,'State Council Election','Rajya Sabha','2023-09-30 00:00:00.000000','2023-07-20 00:00:00.000000'),(17,6,7,'National Election Phase 2','Lok Sabha','2024-05-30 00:00:00.000000','2024-03-10 00:00:00.000000'),(18,6,7,'City Municipality Election','Municipal Corporation','2024-04-05 00:00:00.000000','2024-02-25 00:00:00.000000'),(19,5,7,'Provincial Council Election','Rajya Sabha','2024-12-15 00:00:00.000000','2024-10-01 00:00:00.000000'),(20,5,4,'Local Election Phase 1','Municipal Corporation','2023-10-01 00:00:00.000000','2023-08-01 00:00:00.000000');
/*!40000 ALTER TABLE `elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'xgljencrmvtpxnncov1y'),(2,'r8i7x2m8sqlm9jcdbut8'),(3,'dmgsqmwrlwaulkwlc33d'),(4,'bkuaywanpwapsejjlli2'),(5,'lcfoj1ic5kqc8f8frw2f'),(6,'sn7a75ssxdqsyea2xtnb'),(7,'tkch3mlbxskxqumwyksx'),(8,'emudszslohsm545gryxe'),(9,'a3tpobp1iu3mnm5f3cf8'),(10,'xb5lose9tbzoaupsqlle'),(11,'pkftnxnym9ewkdqiq6gh'),(12,'vxdt3tdpfsbmyqdtcdqy'),(13,'u9ixzuyz5umjotnthviv'),(14,'stz5q2pnldp2pkybxsb7'),(15,'g3lbviz10pwscjolhxic'),(16,'dtgkzeonkrnoclina0ie'),(17,'pt8ipvca4hhp51y0vbil'),(18,'mnkt6ax2b0bhkhdeujff');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rejected_voters`
--

DROP TABLE IF EXISTS `rejected_voters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rejected_voters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `email` varchar(35) NOT NULL,
  `aadhar_number` varchar(14) NOT NULL,
  `rejection_reason` varchar(100) NOT NULL,
  `rejection_date` datetime NOT NULL,
  `rejector_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rejector_id` (`rejector_id`),
  CONSTRAINT `rejected_voters_ibfk_1` FOREIGN KEY (`rejector_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rejected_voters`
--

LOCK TABLES `rejected_voters` WRITE;
/*!40000 ALTER TABLE `rejected_voters` DISABLE KEYS */;
/*!40000 ALTER TABLE `rejected_voters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `aadhar_number` varchar(255) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_approved` bit(1) NOT NULL,
  `is_authority_revoked` bit(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `profile_picture_id` int NOT NULL,
  `role` int NOT NULL,
  `created_on` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UK2hrluauwb53v8e0geuf6iovoe` (`aadhar_number`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  KEY `fk_images` (`profile_picture_id`),
  CONSTRAINT `fk_images` FOREIGN KEY (`profile_picture_id`) REFERENCES `image` (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'678509875674',0,'ybjais@yahoo.com',_binary '',_binary '\0','Yashasvi Jaiswal','$2a$10$uLuPnqDxP2zE9ERYurqiMeJCbAMrWLufrxzfBumdZoqwj6QRIVEXq',4,1,NULL),(5,'563784870193',0,'ro45@gmail.com',_binary '\0',_binary '\0','Rohit Sharma','$2a$10$faMQuCkUbh4ZPpk7AAi6selN.6aIAaLv1eaBlvktXEZnJlmKoZqQe',5,2,NULL),(6,'435673289046',0,'vk18@gmail.com',_binary '\0',_binary '\0','Virat Kohli','$2a$10$gmOGnCRp3FwnC8w1WNEOm.fhA9bOMAB0p2hhaCwxtGxX8KJViujYy',6,2,NULL),(7,'659578686903',0,'sahil@gmail.com',_binary '',_binary '\0','Shaheel Saha','$2a$10$cy00T2aGrg6tW8V/H1C1teMd8xn8ovchRpD0gOkvlhiMtUZ0BSD7G',7,1,NULL),(8,'325648465165',0,'cloud@gam.com',_binary '\0',_binary '','Test img','$2a$10$R0yzRu4Dh34XYB/bHV7JbOqqTyVLlGTwd3rPKExlWPwnSHooeyQ26',12,3,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote` (
  `vote_id` int NOT NULL AUTO_INCREMENT,
  `voter_id` int DEFAULT NULL,
  `election_id` int DEFAULT NULL,
  `candidate_id` int DEFAULT NULL,
  `voted_at` datetime NOT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `voter_id` (`voter_id`),
  KEY `election_id` (`election_id`),
  KEY `candidate_id` (`candidate_id`),
  CONSTRAINT `vote_ibfk_1` FOREIGN KEY (`voter_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `vote_ibfk_2` FOREIGN KEY (`election_id`) REFERENCES `elections` (`election_id`),
  CONSTRAINT `vote_ibfk_3` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote`
--

LOCK TABLES `vote` WRITE;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-08 17:52:16