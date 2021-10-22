-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: FPL
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACTIVATES`
--

DROP TABLE IF EXISTS `ACTIVATES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACTIVATES` (
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  `Chip_name` varchar(15) DEFAULT NULL,
  `Gameweek Points` int DEFAULT NULL,
  PRIMARY KEY (`Team_name`,`Week_number`),
  KEY `Week_number` (`Week_number`),
  KEY `Chip_name` (`Chip_name`),
  CONSTRAINT `ACTIVATES_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `ACTIVATES_ibfk_2` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `ACTIVATES_ibfk_3` FOREIGN KEY (`Chip_name`) REFERENCES `CHIP` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACTIVATES`
--

LOCK TABLES `ACTIVATES` WRITE;
/*!40000 ALTER TABLE `ACTIVATES` DISABLE KEYS */;
INSERT INTO `ACTIVATES` VALUES ('Team 4',1,'Triple Captain',107);
INSERT INTO `ACTIVATES` VALUES ('Team Bob',1,'NULL',107);

/*!40000 ALTER TABLE `ACTIVATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ADD_POINTS1`
--

DROP TABLE IF EXISTS `ADD_POINTS1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ADD_POINTS1` (
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Player_points` int DEFAULT NULL,
  PRIMARY KEY (`Team_name`,`Week_number`,`Player_name`,`Home_club`,`Away_club`),
  KEY `Week_number` (`Week_number`),
  KEY `Player_name` (`Player_name`),
  KEY `Home_club` (`Home_club`,`Away_club`),
  CONSTRAINT `ADD_POINTS1_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `ADD_POINTS1_ibfk_2` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `ADD_POINTS1_ibfk_3` FOREIGN KEY (`Player_name`) REFERENCES `PLAYER` (`Name`),
  CONSTRAINT `ADD_POINTS1_ibfk_4` FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1` (`Home_club`, `Away_club`),
  CONSTRAINT `ADD_POINTS1_chk_1` CHECK ((`Week_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADD_POINTS1`
--

LOCK TABLES `ADD_POINTS1` WRITE;
/*!40000 ALTER TABLE `ADD_POINTS1` DISABLE KEYS */;
INSERT INTO `ADD_POINTS1` VALUES ('Team 4',1,'Ali Dia','Leeds United','Southampton',7),('Team 4',1,'Benjailmin Mendy','Manchester City','Liverpool',2),('Team 4',1,'Donny van de Beek','Newcastle United','Manchester United',0),('Team 4',1,'Eric Dier','Tottenham Hotspurs','Crystal Palace',1),('Team 4',1,'Erling Braut Haaland','Newcastle United','Manchester United',17),('Team 4',1,'Fred','Newcastle United','Manchester United',-3),('Team 4',1,'Guilty Sigurdsson','Everton','Brentford',0),('Team 4',1,'Harry Maguire','Newcastle United','Manchester United',-7),('Team 4',1,'Jonjo Shelvey','Newcastle United','Manchester United',12),('Team 4',1,'Kepa Arrizabalaga','Chelsea','Burnley',8),('Team 4',1,'Kylian Mbappe','Newcastle United','Manchester United',20),('Team 4',1,'Lionel Messi','Norwich City','Arsenal',48),('Team 4',1,'Nick Pope','Chelsea','Burnley',0),('Team 4',1,'Teemu Pukki','Norwich City','Arsenal',0),('Team 4',1,'Timo Werner','Chelsea','Burnley',2);

INSERT INTO `ADD_POINTS1` VALUES ('Team Bob',1,'Christian Pulisic','Chelsea','Burnley',14),('Team Bob',1,'Benjailmin Mendy','Manchester City','Liverpool',2),('Team Bob',1,'Donny van de Beek','Newcastle United','Manchester United',0),('Team Bob',1,'Eric Dier','Tottenham Hotspurs','Crystal Palace',1),('Team Bob',1,'Erling Braut Haaland','Newcastle United','Manchester United',17),('Team Bob',1,'Fred','Newcastle United','Manchester United',-3),('Team Bob',1,'Guilty Sigurdsson','Everton','Brentford',0),('Team Bob',1,'Marcos Alonso','Chelsea','Burnley',10),('Team Bob',1,'Jonjo Shelvey','Newcastle United','Manchester United',24),('Team Bob',1,'Kepa Arrizabalaga','Chelsea','Burnley',8),('Team Bob',1,'Michail Antonio','West Ham United','Brighton',10),('Team Bob',1,'Richarlison','Everton','Brentford',22),('Team Bob',1,'Nick Pope','Chelsea','Burnley',0),('Team Bob',1,'Gabriel Jesus','Manchester City','Liverpool',0),('Team Bob',1,'Timo Werner','Chelsea','Burnley',2);

/*!40000 ALTER TABLE `ADD_POINTS1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ADD_POINTS2`
--

DROP TABLE IF EXISTS `ADD_POINTS2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ADD_POINTS2` (
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Player_points` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`,`Home_club`,`Away_club`),
  KEY `Home_club` (`Home_club`,`Away_club`),
  CONSTRAINT `ADD_POINTS2_ibfk_1` FOREIGN KEY (`Player_name`) REFERENCES `PLAYER` (`Name`),
  CONSTRAINT `ADD_POINTS2_ibfk_2` FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1` (`Home_club`, `Away_club`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADD_POINTS2`
--

LOCK TABLES `ADD_POINTS2` WRITE;
/*!40000 ALTER TABLE `ADD_POINTS2` DISABLE KEYS */;
INSERT INTO `ADD_POINTS2` VALUES ('Ali Dia','Leeds United','Southampton',NULL),('Benjailmin Mendy','Manchester City','Liverpool',NULL),('Donny van de Beek','Newcastle United','Manchester United',NULL),('Eric Dier','Tottenham Hotspurs','Crystal Palace',NULL),('Erling Braut Haaland','Newcastle United','Manchester United',NULL),('Fred','Newcastle United','Manchester United',NULL),('Guilty Sigurdsson','Everton','Brentford',NULL),('Harry Maguire','Newcastle United','Manchester United',NULL),('Jonjo Shelvey','Newcastle United','Manchester United',NULL),('Kepa Arrizabalaga','Chelsea','Burnley',NULL),('Kylian Mbappe','Newcastle United','Manchester United',NULL),('Lionel Messi','Norwich City','Arsenal',NULL),('Nick Pope','Chelsea','Burnley',NULL),('Teemu Pukki','Norwich City','Arsenal',NULL),('Timo Werner','Chelsea','Burnley',NULL);
/*!40000 ALTER TABLE `ADD_POINTS2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATEGORY`
--

DROP TABLE IF EXISTS `CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORY` (
  `Partner_name` varchar(100) NOT NULL,
  `Partner_category` varchar(50) NOT NULL,
  PRIMARY KEY (`Partner_category`,`Partner_name`),
  KEY `Partner_name` (`Partner_name`),
  CONSTRAINT `CATEGORY_ibfk_1` FOREIGN KEY (`Partner_name`) REFERENCES `PARTNER1` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORY`
--

LOCK TABLES `CATEGORY` WRITE;
/*!40000 ALTER TABLE `CATEGORY` DISABLE KEYS */;
/*!40000 ALTER TABLE `CATEGORY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CHIP`
--

DROP TABLE IF EXISTS `CHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CHIP` (
  `Name` varchar(15) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CHIP`
--

LOCK TABLES `CHIP` WRITE;
/*!40000 ALTER TABLE `CHIP` DISABLE KEYS */;
INSERT INTO `CHIP` VALUES ('Bench Boost'),('Freehit'),('Triple Captain'),('Wildcard');
/*!40000 ALTER TABLE `CHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPETES`
--

DROP TABLE IF EXISTS `COMPETES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPETES` (
  `Team_name` varchar(100) NOT NULL,
  `League_code` char(6) NOT NULL,
  `Rank` int DEFAULT NULL,
  PRIMARY KEY (`Team_name`,`League_code`),
  KEY `League_code` (`League_code`),
  CONSTRAINT `COMPETES_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `COMPETES_ibfk_2` FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPETES`
--

LOCK TABLES `COMPETES` WRITE;
/*!40000 ALTER TABLE `COMPETES` DISABLE KEYS */;
/*!40000 ALTER TABLE `COMPETES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFENDER`
--

DROP TABLE IF EXISTS `DEFENDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEFENDER` (
  `Player_name` varchar(100) NOT NULL,
  `Clearances` int DEFAULT NULL,
  `Tackles` int DEFAULT NULL,
  `Interceptions` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFENDER`
--

LOCK TABLES `DEFENDER` WRITE;
/*!40000 ALTER TABLE `DEFENDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `DEFENDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EDITION`
--

DROP TABLE IF EXISTS `EDITION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EDITION` (
  `Season` int NOT NULL,
  `Winner` varchar(100) DEFAULT NULL,
  `Runners_up` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Season`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EDITION`
--

LOCK TABLES `EDITION` WRITE;
/*!40000 ALTER TABLE `EDITION` DISABLE KEYS */;
/*!40000 ALTER TABLE `EDITION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FIXTURE1`
--

DROP TABLE IF EXISTS `FIXTURE1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FIXTURE1` (
  `Home_club` varchar(50) NOT NULL,
  `Away_club` varchar(50) NOT NULL,
  `Result` varchar(100) NOT NULL,
  `Year` int NOT NULL,
  `Month` int NOT NULL,
  `Day` int NOT NULL,
  `Hours` int NOT NULL,
  `Minutes` int NOT NULL,
  `Week_number` int NOT NULL,
  PRIMARY KEY (`Home_club`,`Away_club`),
  KEY `Week_number` (`Week_number`),
  CONSTRAINT `FIXTURE1_ibfk_1` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `FIXTURE1_chk_1` CHECK ((`Week_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FIXTURE1`
--

LOCK TABLES `FIXTURE1` WRITE;
/*!40000 ALTER TABLE `FIXTURE1` DISABLE KEYS */;
INSERT INTO `FIXTURE1` VALUES ('Aston Villa','Leicester City','2-4',2021,10,22,21,30,1),('Chelsea','Burnley','0-0',2021,10,21,19,30,1),('Everton','Brentford','1-3',2021,10,21,19,30,1),('Leeds United','Southampton','2-3',2021,10,23,1,30,1),('Manchester City','Liverpool','3-0',2021,10,21,19,30,1),('Newcastle United','Manchester United','17-0',2021,10,21,19,30,1),('Norwich City','Arsenal','4-4',2021,10,21,19,30,1),('Tottenham Hotspurs','Crystal Palace','3-2',2021,10,22,17,30,1),('West Ham United','Brighton','0-0',2021,10,22,23,30,1),('Wolverhampton Wanderers','Watford','1-0',2021,10,22,19,30,1);
/*!40000 ALTER TABLE `FIXTURE1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FIXTURE2a`
--

DROP TABLE IF EXISTS `FIXTURE2a`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FIXTURE2a` (
  `Home_club` varchar(50) NOT NULL,
  `Stadium` varchar(50) NOT NULL,
  PRIMARY KEY (`Home_club`,`Stadium`),
  KEY `Stadium` (`Stadium`),
  CONSTRAINT `FIXTURE2a_ibfk_1` FOREIGN KEY (`Home_club`) REFERENCES `FIXTURE1` (`Home_club`),
  CONSTRAINT `FIXTURE2a_ibfk_2` FOREIGN KEY (`Stadium`) REFERENCES `FIXTURE2b` (`Stadium`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FIXTURE2a`
--

LOCK TABLES `FIXTURE2a` WRITE;
/*!40000 ALTER TABLE `FIXTURE2a` DISABLE KEYS */;
INSERT INTO `FIXTURE2a` VALUES ('Norwich City','Carrow Road'),('Leeds United','Elland Road'),('Manchester City','Etihad'),('Everton','Goodison Park'),('West Ham United','London Stadium'),('Wolverhampton Wanderers','Molineaux'),('Newcastle United','St.James Park'),('Chelsea','Stamford Bridge'),('Tottenham Hotspurs','Tottenham Hotspur Stadium'),('Aston Villa','Villa Park');
/*!40000 ALTER TABLE `FIXTURE2a` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FIXTURE2b`
--

DROP TABLE IF EXISTS `FIXTURE2b`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FIXTURE2b` (
  `Stadium` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  PRIMARY KEY (`Stadium`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FIXTURE2b`
--

LOCK TABLES `FIXTURE2b` WRITE;
/*!40000 ALTER TABLE `FIXTURE2b` DISABLE KEYS */;
INSERT INTO `FIXTURE2b` VALUES ('Carrow Road','Norwich'),('Elland Road','Leeds'),('Etihad','Manchester'),('Goodison Park','Liverpool'),('London Stadium','London'),('Molineaux','Wolverhampton'),('St.James Park','Newcastle'),('Stamford Bridge','London'),('Tottenham Hotspur Stadium','London'),('Villa Park','Birmingham');
/*!40000 ALTER TABLE `FIXTURE2b` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FORWARD`
--

DROP TABLE IF EXISTS `FORWARD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FORWARD` (
  `Player_name` varchar(100) NOT NULL,
  `Shots_on_target` int DEFAULT NULL,
  `Touches_inside_box` int DEFAULT NULL,
  `Dribbles` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FORWARD`
--

LOCK TABLES `FORWARD` WRITE;
/*!40000 ALTER TABLE `FORWARD` DISABLE KEYS */;
INSERT INTO `FORWARD` VALUES ('Erling Braut Haaland',3.4,17.1,2.1),('Jamie Vardy',2.5,25.2,0.9),('Kylian Mbappe',1.8,35.7,3.4),('Teemu Pukki',0.7,9.4,0.4),('Richarlison',1.9,28.8,2.5),('Michail Antonio',1.7,21.1,1.1),('Gabriel Jesus',2.1,34.4,3.8),('Ali Dia',1.4,0.1,0),('Lionel Messi',2.9,45.2,6.8),('Timo Werner',2.7,19.1,1.0);
/*!40000 ALTER TABLE `FORWARD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GAMEWEEK`
--

DROP TABLE IF EXISTS `GAMEWEEK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GAMEWEEK` (
  `Week_number` int NOT NULL DEFAULT '1',
  `Highest_points` int DEFAULT NULL,
  `Average_points` int DEFAULT NULL,
  `Month` int NOT NULL,
  `Day` int NOT NULL,
  `Hours` int NOT NULL,
  `Minutes` int NOT NULL,
  PRIMARY KEY (`Week_number`),
  CONSTRAINT `GAMEWEEK_chk_1` CHECK ((`Week_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GAMEWEEK`
--

LOCK TABLES `GAMEWEEK` WRITE;
/*!40000 ALTER TABLE `GAMEWEEK` DISABLE KEYS */;
INSERT INTO `GAMEWEEK` VALUES (1,NULL,NULL,10,21,18,30);
/*!40000 ALTER TABLE `GAMEWEEK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HAS_ACTIVE`
--

DROP TABLE IF EXISTS `HAS_ACTIVE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HAS_ACTIVE` (
  `Team_name` varchar(100) NOT NULL,
  `Chip_name` varchar(15) NOT NULL,
  PRIMARY KEY (`Team_name`,`Chip_name`),
  KEY `Chip_name` (`Chip_name`),
  CONSTRAINT `HAS_ACTIVE_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `HAS_ACTIVE_ibfk_2` FOREIGN KEY (`Chip_name`) REFERENCES `CHIP` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HAS_ACTIVE`
--

LOCK TABLES `HAS_ACTIVE` WRITE;
/*!40000 ALTER TABLE `HAS_ACTIVE` DISABLE KEYS */;
INSERT INTO `HAS_ACTIVE` VALUES ('Team 4','Bench Boost'),('Team 4','Freehit'),('Team 4','Triple Captain'),('Team 4','Wildcard');

INSERT INTO `HAS_ACTIVE` VALUES ('Team Bob','Bench Boost'),('Team Bob','Freehit'),('Team Bob','Triple Captain'),('Team Bob','Wildcard');


/*!40000 ALTER TABLE `HAS_ACTIVE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HEAD_TO_HEAD`
--

DROP TABLE IF EXISTS `HEAD_TO_HEAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HEAD_TO_HEAD` (
  `Teamname_1` varchar(100) NOT NULL,
  `Teamname_2` varchar(100) NOT NULL,
  `League_code` char(6) NOT NULL,
  `Result` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Teamname_1`,`Teamname_2`,`League_code`),
  KEY `Teamname_2` (`Teamname_2`),
  KEY `League_code` (`League_code`),
  CONSTRAINT `HEAD_TO_HEAD_ibfk_1` FOREIGN KEY (`Teamname_1`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `HEAD_TO_HEAD_ibfk_2` FOREIGN KEY (`Teamname_2`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `HEAD_TO_HEAD_ibfk_3` FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HEAD_TO_HEAD`
--

LOCK TABLES `HEAD_TO_HEAD` WRITE;
/*!40000 ALTER TABLE `HEAD_TO_HEAD` DISABLE KEYS */;
/*!40000 ALTER TABLE `HEAD_TO_HEAD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEEPER`
--

DROP TABLE IF EXISTS `KEEPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEEPER` (
  `Player_name` varchar(100) NOT NULL,
  `Saves` int DEFAULT NULL,
  `Clean_sheets` int DEFAULT NULL,
  `Penalties Saved` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEEPER`
--

LOCK TABLES `KEEPER` WRITE;
/*!40000 ALTER TABLE `KEEPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `KEEPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KINGS_OF _THE_GAMEWEEK`
--

DROP TABLE IF EXISTS `KINGS_OF _THE_GAMEWEEK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KINGS_OF _THE_GAMEWEEK` (
  `Player_name` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  KEY `Player_name` (`Player_name`),
  KEY `Week_number` (`Week_number`),
  CONSTRAINT `KINGS_OF _THE_GAMEWEEK_ibfk_1` FOREIGN KEY (`Player_name`) REFERENCES `PLAYER` (`Name`),
  CONSTRAINT `KINGS_OF _THE_GAMEWEEK_ibfk_2` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `KINGS_OF _THE_GAMEWEEK_chk_1` CHECK ((`Week_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KINGS_OF _THE_GAMEWEEK`
--

LOCK TABLES `KINGS_OF _THE_GAMEWEEK` WRITE;
/*!40000 ALTER TABLE `KINGS_OF _THE_GAMEWEEK` DISABLE KEYS */;
/*!40000 ALTER TABLE `KINGS_OF _THE_GAMEWEEK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LEAGUE`
--

DROP TABLE IF EXISTS `LEAGUE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LEAGUE` (
  `League_code` char(6) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Number_of_teams` int DEFAULT '0',
  PRIMARY KEY (`League_code`),
  UNIQUE KEY `League_name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LEAGUE`
--

LOCK TABLES `LEAGUE` WRITE;
/*!40000 ALTER TABLE `LEAGUE` DISABLE KEYS */;
/*!40000 ALTER TABLE `LEAGUE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIDFIELDER`
--

DROP TABLE IF EXISTS `MIDFIELDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MIDFIELDER` (
  `Player_name` varchar(100) NOT NULL,
  `Passing Accuracy` int DEFAULT NULL,
  `Chances Created` int DEFAULT NULL,
  `Through_balls` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIDFIELDER`
--

LOCK TABLES `MIDFIELDER` WRITE;
/*!40000 ALTER TABLE `MIDFIELDER` DISABLE KEYS */;
INSERT INTO `MIDFIELDER` VALUES ('Donny can de Beek',88,2.4,0.9),('Guilty Sigurdsson',79,1.9,0.7),('Fred',92,1.1,0.2),('Jonjo Shelvey',93,0.9,0.5),('Christian Pulisic',74,2.4,1.3);
/*!40000 ALTER TABLE `MIDFIELDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTNER1`
--

DROP TABLE IF EXISTS `PARTNER1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARTNER1` (
  `Name` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  PRIMARY KEY (`Name`),
  KEY `City` (`City`),
  CONSTRAINT `PARTNER1_ibfk_1` FOREIGN KEY (`City`) REFERENCES `PARTNER2` (`City`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARTNER1`
--

LOCK TABLES `PARTNER1` WRITE;
/*!40000 ALTER TABLE `PARTNER1` DISABLE KEYS */;
/*!40000 ALTER TABLE `PARTNER1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PARTNER2`
--

DROP TABLE IF EXISTS `PARTNER2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PARTNER2` (
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  PRIMARY KEY (`City`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PARTNER2`
--

LOCK TABLES `PARTNER2` WRITE;
/*!40000 ALTER TABLE `PARTNER2` DISABLE KEYS */;
/*!40000 ALTER TABLE `PARTNER2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYER`
--

DROP TABLE IF EXISTS `PLAYER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLAYER` (
  `Name` varchar(100) NOT NULL,
  `Club` varchar(100) NOT NULL,
  `Market_cost` decimal(5,2) NOT NULL,
  `Form` int DEFAULT NULL,
  `Total_points` int DEFAULT NULL,
  `Selection %` decimal(4,2) DEFAULT NULL,
  `Fitness Status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYER`
--

LOCK TABLES `PLAYER` WRITE;
/*!40000 ALTER TABLE `PLAYER` DISABLE KEYS */;
INSERT INTO `PLAYER` VALUES ('Ali Dia','Southampton',4.50,NULL,NULL,NULL,NULL),('Benjailmin Mendy','Manchester City',8.20,NULL,NULL,NULL,NULL),('Donny van de Beek','Manchester United',5.00,NULL,NULL,NULL,NULL),('Eric Dier','Tottenham Hotspurs',7.00,NULL,NULL,NULL,NULL),('Erling Braut Haaland','Newcastle United',12.50,NULL,NULL,NULL,NULL),('Fred','Manchester United',8.00,NULL,NULL,NULL,NULL),('Guilty Sigurdsson','Everton',6.90,NULL,NULL,NULL,NULL),('Harry Maguire','Manchester United',7.50,NULL,NULL,NULL,NULL),('Jamie Vardy','Leicester City',11.30,NULL,NULL,NULL,NULL),('Jonjo Shelvey','Newcastle United',6.00,NULL,NULL,NULL,NULL),('Kepa Arrizabalaga','Chelsea',6.50,NULL,NULL,NULL,NULL),('Kylian Mbappe','Newcastle United',14.00,NULL,NULL,NULL,NULL),('Lionel Messi','Arsenal',17.00,NULL,NULL,NULL,NULL),('Nick Pope','Burnley',4.50,NULL,NULL,NULL,NULL),('Teemu Pukki','Norwich City',7.50,NULL,NULL,NULL,NULL),('Timo Werner','Chelsea',10.50,NULL,NULL,NULL,NULL),('Michail Antonio','West Ham United',12.00,NULL,NULL,NULL,NULL),('Gabriel Jesus','Manchester City',12.00,NULL,NULL,NULL,NULL),('Marcos Alonso','Chelsea',9.00,NULL,NULL,NULL,NULL),('Richarlison','Everton',11.5,NULL,NULL,NULL,NULL),('Christian Pulisic','Chelsea',12.00,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `PLAYER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYS`
--

DROP TABLE IF EXISTS `PLAYS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLAYS` (
  `Team_name` varchar(100) NOT NULL,
  `Gameweek_number` int NOT NULL DEFAULT '1',
  `Player_name` varchar(100) NOT NULL,
  `Is_captain` tinyint(1) DEFAULT NULL,
  `Is_vice_captain` tinyint(1) DEFAULT NULL,
  `Is_starting` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Team_name`,`Gameweek_number`,`Player_name`),
  KEY `Gameweek_number` (`Gameweek_number`),
  KEY `Player_name` (`Player_name`),
  CONSTRAINT `PLAYS_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `PLAYS_ibfk_2` FOREIGN KEY (`Gameweek_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `PLAYS_ibfk_3` FOREIGN KEY (`Player_name`) REFERENCES `PLAYER` (`Name`),
  CONSTRAINT `PLAYS_chk_1` CHECK ((`Gameweek_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYS`
--

LOCK TABLES `PLAYS` WRITE;
/*!40000 ALTER TABLE `PLAYS` DISABLE KEYS */;
INSERT INTO `PLAYS` VALUES ('Team 4',1,'Ali Dia',0,0,1),('Team 4',1,'Benjailmin Mendy',0,0,1),('Team 4',1,'Donny van de Beek',0,0,0),('Team 4',1,'Eric Dier',0,0,1),('Team 4',1,'Erling Braut Haaland',0,0,1),('Team 4',1,'Fred',0,0,1),('Team 4',1,'Guilty Sigurdsson',0,0,0),('Team 4',1,'Harry Maguire',0,0,1),('Team 4',1,'Jonjo Shelvey',0,1,1),('Team 4',1,'Kepa Arrizabalaga',0,0,1),('Team 4',1,'Kylian Mbappe',0,0,1),('Team 4',1,'Lionel Messi',1,0,1),('Team 4',1,'Nick Pope',0,0,0),('Team 4',1,'Teemu Pukki',0,0,0),('Team 4',1,'Timo Werner',0,0,1);

INSERT INTO `PLAYS` VALUES ('Team Bob',1,'Cristian Pulisic',0,0,1),('Team Bob',1,'Benjailmin Mendy',0,0,1),('Team Bob',1,'Donny van de Beek',0,0,0),('Team Bob',1,'Eric Dier',0,0,1),('Team Bob',1,'Erling Braut Haaland',0,0,1),('Team Bob',1,'Fred',0,0,1),('Team Bob',1,'Guilty Sigurdsson',0,0,0),('Team Bob',1,'MArcos Alonso',0,0,1),('Team Bob',1,'Jonjo Shelvey',0,1,1),('Team Bob',1,'Kepa Arrizabalaga',0,0,1),('Team Bob',1,'Marcos Antonio',0,0,1),('Team Bob',1,'Richarlison',1,0,1),('Team Bob',1,'Nick Pope',0,0,0),('Team Bob',1,'Gabriel Jesus',0,0,0),('Team Bob',1,'Timo Werner',0,0,1);


/*!40000 ALTER TABLE `PLAYS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYS_IN`
--

DROP TABLE IF EXISTS `PLAYS_IN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLAYS_IN` (
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  `Player_points` int DEFAULT NULL,
  PRIMARY KEY (`Player_name`,`Home_club`,`Away_club`,`Week_number`),
  KEY `Home_club` (`Home_club`,`Away_club`),
  KEY `Week_number` (`Week_number`),
  CONSTRAINT `PLAYS_IN_ibfk_1` FOREIGN KEY (`Player_name`) REFERENCES `PLAYER` (`Name`),
  CONSTRAINT `PLAYS_IN_ibfk_2` FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1` (`Home_club`, `Away_club`),
  CONSTRAINT `PLAYS_IN_ibfk_3` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  CONSTRAINT `PLAYS_IN_chk_1` CHECK ((`Week_number` <= 38))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYS_IN`
--

LOCK TABLES `PLAYS_IN` WRITE;
/*!40000 ALTER TABLE `PLAYS_IN` DISABLE KEYS */;
INSERT INTO `PLAYS_IN` VALUES ('Ali Dia','Leeds United','Southampton',1,7),('Benjailmin Mendy','Manchester City','Liverpool',1,2),('Donny van de Beek','Newcastle United','Manchester United',1,0),('Eric Dier','Tottenham Hotspurs','Crystal Palace',1,1),('Erling Braut Haaland','Newcastle United','Manchester United',1,17),('Fred','Newcastle United','Manchester United',1,-3),('Guilty Sigurdsson','Everton','Brentford',1,2),('Harry Maguire','Newcastle United','Manchester United',1,-7),('Jamie Vardy','Aston Villa','Leicester City',1,9),('Jonjo Shelvey','Newcastle United','Manchester United',1,12),('Kepa Arrizabalaga','Chelsea','Burnley',1,8),('Kylian Mbappe','Newcastle United','Manchester United',1,20),('Lionel Messi','Norwich City','Arsenal',1,16),('Nick Pope','Chelsea','Burnley',1,12),('Teemu Pukki','Norwich City','Arsenal',1,10),('Timo Werner','Chelsea','Burnley',1,2),('Michail Antonio','West Ham United','Brighton',1,10),('Richarlison','Everton','Brentford',1,11),('Marcos Alonso','Chelsea','Burnley',1,10),('Gabriel Jesus','Manchester City','Liverpool',1,13),('Christian Pulisic','Chelsea','Burnley',1,14);
/*!40000 ALTER TABLE `PLAYS_IN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SPONSORS`
--

DROP TABLE IF EXISTS `SPONSORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SPONSORS` (
  `Partner_name` varchar(100) NOT NULL,
  `Season` int NOT NULL,
  PRIMARY KEY (`Partner_name`,`Season`),
  KEY `Season` (`Season`),
  CONSTRAINT `SPONSORS_ibfk_1` FOREIGN KEY (`Partner_name`) REFERENCES `PARTNER1` (`Name`),
  CONSTRAINT `SPONSORS_ibfk_2` FOREIGN KEY (`Season`) REFERENCES `EDITION` (`Season`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SPONSORS`
--

LOCK TABLES `SPONSORS` WRITE;
/*!40000 ALTER TABLE `SPONSORS` DISABLE KEYS */;
/*!40000 ALTER TABLE `SPONSORS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAM` (
  `Name` varchar(100) NOT NULL,
  `Manager_First_name` varchar(100) NOT NULL,
  `Manager_Last_name` varchar(100) NOT NULL,
  `Nationality` varchar(40) NOT NULL,
  `Total Points` int DEFAULT '0',
  `Squad Value` decimal(5,2) NOT NULL,
  `Transfers_left` int DEFAULT '1',
  `Money_left` decimal(5,2) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `Manager_name` (`Manager_First_name`,`Manager_Last_name`),
  CONSTRAINT `TEAM_chk_1` CHECK ((`Transfers_left` <= 2)),
  CONSTRAINT `TEAM_chk_2` CHECK ((`Squad Value` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
INSERT INTO `TEAM` VALUES ('Team 4','DNA','Monsoon','India',0,98.50,1,1.50);
INSERT INTO `TEAM` VALUES ('Team Bob','Bob','Spring','India',0,96,1,4);

/*!40000 ALTER TABLE `TEAM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TRANSFER`
--

DROP TABLE IF EXISTS `TRANSFER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TRANSFER` (
  `Year` int NOT NULL,
  `Month` int NOT NULL,
  `Day` int NOT NULL,
  `Hours` int NOT NULL,
  `Minutes` int NOT NULL,
  `Player_in` varchar(100) NOT NULL,
  `Player_out` varchar(100) NOT NULL,
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  PRIMARY KEY (`Player_in`,`Player_out`,`Team_name`,`Week_number`),
  KEY `Team_name` (`Team_name`),
  KEY `Week_number` (`Week_number`),
  CONSTRAINT `TRANSFER_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  CONSTRAINT `TRANSFER_ibfk_2` FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TRANSFER`
--

LOCK TABLES `TRANSFER` WRITE;
/*!40000 ALTER TABLE `TRANSFER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TRANSFER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TYPE`
--

DROP TABLE IF EXISTS `TYPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TYPE` (
  `League_code` char(6) NOT NULL,
  `League_Type` varchar(20) NOT NULL,
  PRIMARY KEY (`League_code`,`League_Type`),
  CONSTRAINT `TYPE_ibfk_1` FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`),
  CONSTRAINT `TYPE_chk_1` CHECK (((`League_Type` = _utf8mb4'Classic') or (`League_Type` = _utf8mb4'Public') or (`League_Type` = _utf8mb4'Invitational') or (`League_Type` = _utf8mb4'Head-to-Head') or (`League_Type` = _utf8mb4'General')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TYPE`
--

LOCK TABLES `TYPE` WRITE;
/*!40000 ALTER TABLE `TYPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `TYPE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-21 18:06:07
