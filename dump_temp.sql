DROP DATABASE IF EXISTS `FPL`;
CREATE SCHEMA `FPL`;
USE `FPL`;

DROP TABLE IF EXISTS `TEAM`;
CREATE TABLE `TEAM` (
  `Name` varchar(100) NOT NULL,
  `Manager_First_name` varchar(100) NOT NULL,
  `Manager_Last_name` varchar(100) NOT NULL,
  `Nationality` varchar(40) NOT NULL,
  `Total Points` int DEFAULT 0,
  `Squad Value` decimal(5,2) NOT NULL,
  `Transfers_left` int DEFAULT 1,
  `Money_left` decimal(5,2) NOT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `Manager_name`(`Manager_First_name`, `Manager_Last_name`),
  CHECK (`Transfers_left` <= 2),
  CHECK (`Squad Value` > 0)
);

DROP TABLE IF EXISTS `GAMEWEEK`;
CREATE TABLE `GAMEWEEK` (
  `Week_number` int(2) DEFAULT 1,
  `Highest_points` int,
  `Average_points` int,
  `Month` int NOT NULL,
  `Day` int NOT NULL,
  `Hours` int NOT NULL,
  `Minutes` int NOT NULL,
  PRIMARY KEY (`Week_number`),
  CHECK (`Week_number` <= 38)
);

DROP TABLE IF EXISTS `FIXTURE1`;
CREATE TABLE `FIXTURE1` (
  `Home_club` varchar(50) NOT NULL,
  `Away_club` varchar(50) NOT NULL,
  `Result` varchar(100),
  `Year` int(2) NOT NULL,
  `Month` int(2) NOT NULL,
  `Day` int(2) NOT NULL,
  `Hours` int(2) NOT NULL,
  `Minutes` int(2) NOT NULL,
  `Week_number` int(2) NOT NULL,
  PRIMARY KEY (`Home_club`, `Away_club`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK`(`Week_number`),
  CHECK (`Week_number` <= 38)
);

DROP TABLE IF EXISTS `FIXTURE2b`;
CREATE TABLE `FIXTURE2b` (
  `Stadium` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  PRIMARY KEY (`Stadium`)
);

DROP TABLE IF EXISTS `FIXTURE2a`;
CREATE TABLE `FIXTURE2a` (
  `Home_club` varchar(50) NOT NULL,
  `Stadium` varchar(50) NOT NULL,
  PRIMARY KEY(`Home_club`,`Stadium`),
  FOREIGN KEY (`Home_club`) REFERENCES `FIXTURE1`(`Home_club`),
  FOREIGN KEY (`Stadium`) REFERENCES `FIXTURE2b`(`Stadium`) 
);

DROP TABLE IF EXISTS `PLAYER`;
CREATE TABLE `PLAYER` (
  `Name` varchar(100) NOT NULL,
  `Club` varchar(100) NOT NULL,
  `Market_cost` decimal(5,2) NOT NULL,
  `Form` int,
  `Total_points` int,
  `Selection %` decimal(4,2),
  `Fitness Status` varchar(100),
  PRIMARY KEY (`Name`)
);

DROP TABLE IF EXISTS `FORWARD`;
CREATE TABLE `FORWARD` (
  `Player_name` varchar(100) NOT NULL,
  `Shots_on_target` int,
  `Touches_inside_box` int,
  `Dribbles` int,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `MIDFIELDER`;
CREATE TABLE `MIDFIELDER` (
  `Player_name` varchar(100) NOT NULL,
  `Passing Accuracy` int,
  `Chances Created` int,
  `Through_balls` int,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `DEFENDER`;
CREATE TABLE `DEFENDER` (
  `Player_name` varchar(100) NOT NULL,
  `Clearances` int,
  `Tackles` int,
  `Interceptions` int,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `KEEPER`;
CREATE TABLE `KEEPER` (
  `Player_name` varchar(100) NOT NULL,
  `Saves` int,
  `Clean_sheets` int,
  `Penalties Saved` int,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `LEAGUE`;
CREATE TABLE `LEAGUE` (
  `League_code` char(6) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Number_of_teams` int(6) DEFAULT 0,
  PRIMARY KEY (`League_code`),
  UNIQUE KEY `League_name` (`Name`)
);

DROP TABLE IF EXISTS `TYPE`;
CREATE TABLE `TYPE` (
  `League_code` char(6) NOT NULL,
  `League_Type` varchar(20) NOT NULL,
  PRIMARY KEY (`League_code`, `League_Type`),
  CHECK (`League_Type`='Classic' OR `League_Type`='Public' OR `League_Type`='Invitational' OR `League_Type`='Head-to-Head' OR `League_Type`='General'), 
  FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`)
);

DROP TABLE IF EXISTS `CHIP`;
CREATE TABLE `CHIP` (
  `Name` varchar(15) NOT NULL,
  PRIMARY KEY (`Name`)
);

DROP TABLE IF EXISTS `TRANSFER`;
CREATE TABLE `TRANSFER` (
  `Year` int(4) NOT NULL,
  `Month` int(2) NOT NULL,
  `Day` int(2) NOT NULL,
  `Hours` int(2) NOT NULL,
  `Minutes` int(2) NOT NULL,
  `Player_in` varchar(100) NOT NULL,
  `Player_out` varchar(100) NOT NULL,
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int(2) NOT NULL,
  PRIMARY KEY (`Player_in`, `Player_out`, `Team_name`, `Week_number`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`)
);
 
DROP TABLE IF EXISTS `COMPETES`;
CREATE TABLE `COMPETES` (
  `Team_name` varchar(100) NOT NULL,
  `League_code` char(6) NOT NULL,
  `Rank` int,
  PRIMARY KEY(`Team_name`,`League_code`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`)
);
 
DROP TABLE IF EXISTS `PLAYS`;
CREATE TABLE `PLAYS` (
  `Team_name` varchar(100) NOT NULL,
  `Gameweek_number` int(2) DEFAULT 1,
  `Player_name` varchar(100) NOT NULL,
  `Is_captain` boolean ,
  `Is_vice_captain` boolean,
  `Is_starting` boolean,
  PRIMARY KEY(`Team_name`, `Gameweek_number`, `Player_name`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM`(`Name`),
  FOREIGN KEY (`Gameweek_number`) REFERENCES `GAMEWEEK`(`Week_number`),
  FOREIGN KEY (`Player_name`) REFERENCES `PLAYER`(`Name`),
  CHECK (`Gameweek_number` <= 38)
);
 
DROP TABLE IF EXISTS `PLAYS_IN`;
CREATE TABLE `PLAYS_IN` (
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Week_number` int NOT NULL,
  `Player_points` int,
  PRIMARY KEY(`Player_name`, `Home_club`, `Away_club`, `Week_number`),
  FOREIGN KEY (`Player_name`) REFERENCES `PLAYER`(`Name`),
  FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1`(`Home_club`, `Away_club`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK`(`Week_number`),
  CHECK (`Week_number` <= 38) 
);
 
DROP TABLE IF EXISTS `ADD_POINTS1`;
CREATE TABLE `ADD_POINTS1` (
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int(2) NOT NULL,
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Player_points` int,
  PRIMARY KEY(`Team_name`, `Week_number`, `Player_name`, `Home_club`, `Away_club`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM`(`Name`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK`(`Week_number`),
  FOREIGN KEY (`Player_name`) REFERENCES `PLAYER`(`Name`),
  FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1`(`Home_club`, `Away_club`),
  CHECK (`Week_number` <= 38) 
);
 
DROP TABLE IF EXISTS `HEAD_TO_HEAD`;
CREATE TABLE `HEAD_TO_HEAD` (
  `Teamname_1` varchar(100) NOT NULL,
  `Teamname_2` varchar(100) NOT NULL,
  `League_code` char(6) NOT NULL,
  `Result` varchar(10),
  PRIMARY KEY (`Teamname_1`, `Teamname_2`, `League_code`),
  FOREIGN KEY (`Teamname_1`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`Teamname_2`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`League_code`) REFERENCES `LEAGUE` (`League_code`)
);
 
DROP TABLE IF EXISTS `ACTIVATES`;
CREATE TABLE `ACTIVATES` (
  `Team_name` varchar(100) NOT NULL,
  `Week_number` int(2) NOT NULL,
  `Chip_name` varchar(15),
  `Gameweek Points` int,
  PRIMARY KEY (`Team_name`, `Week_number`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK` (`Week_number`),
  FOREIGN KEY (`Chip_name`) REFERENCES `CHIP` (`Name`)
);
 
DROP TABLE IF EXISTS `ADD_POINTS2`;
CREATE TABLE `ADD_POINTS2` (
  `Player_name` varchar(100) NOT NULL,
  `Home_club` varchar(100) NOT NULL,
  `Away_club` varchar(100) NOT NULL,
  `Player_points` int,
  PRIMARY KEY (`Player_name`, `Home_club`, `Away_club`),
  FOREIGN KEY (`Player_name`) REFERENCES `PLAYER`(`Name`),
  FOREIGN KEY (`Home_club`, `Away_club`) REFERENCES `FIXTURE1`(`Home_club`, `Away_club`)
);	
 
DROP TABLE IF EXISTS `HAS_ACTIVE`;
CREATE TABLE `HAS_ACTIVE` (
  `Team_name` varchar(100) NOT NULL,
  `Chip_name` varchar(15) NOT NULL,
  PRIMARY KEY (`Team_name`, `Chip_name`),
  FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`Name`),
  FOREIGN KEY (`Chip_name`) REFERENCES `CHIP` (`Name`)
);
 
DROP TABLE IF EXISTS `KINGS_OF_THE_GAMEWEEK`;
CREATE TABLE `KINGS_OF _THE_GAMEWEEK` (
  `Player_name` varchar(100) NOT NULL,
  `Week_number` int(2) NOT NULL,
  FOREIGN KEY (`Player_name`) REFERENCES `PLAYER`(`Name`),
  FOREIGN KEY (`Week_number`) REFERENCES `GAMEWEEK`(`Week_number`),
  CHECK (`Week_number` <= 38)
);
 
DROP TABLE IF EXISTS `PARTNER2`;
CREATE TABLE `PARTNER2` (
  `City` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  PRIMARY KEY (`City`)
);
 
DROP TABLE IF EXISTS `PARTNER1`;
CREATE TABLE `PARTNER1` (
  `Name` varchar(100) NOT NULL,
  `City` varchar(50) NOT NULL,
  PRIMARY KEY (`Name`),
  FOREIGN KEY (`City`) REFERENCES `PARTNER2` (`City`)
);

DROP TABLE IF EXISTS `CATEGORY`;
CREATE TABLE `CATEGORY` (
  `Partner_name` varchar(100) NOT NULL,
  `Partner_category` varchar(50) NOT NULL,
  PRIMARY KEY (`Partner_category`,`Partner_name`),
  FOREIGN KEY (`Partner_name`) REFERENCES `PARTNER1` (`Name`)
);

DROP TABLE IF EXISTS `EDITION`;
CREATE TABLE `EDITION` (
  `Season` int(4) NOT NULL,
  `Winner` varchar(100),
  `Runners_up` varchar(100),
  PRIMARY KEY (`Season`)
);

DROP TABLE IF EXISTS `SPONSORS`;
CREATE TABLE `SPONSORS` (
  `Partner_name` varchar(100) NOT NULL,
  `Season` int(4) NOT NULL,
  PRIMARY KEY (`Partner_name`,`Season`),
  FOREIGN KEY (`Partner_name`) REFERENCES `PARTNER1` (`Name`),
  FOREIGN KEY (`Season`) REFERENCES `EDITION` (`Season`)
);

