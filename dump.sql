DROP DATABASE IF EXISTS `FPL`;
CREATE SCHEMA `FPL`;
USE `FPL`;

DROP TABLE IF EXISTS `TYPE`;
CREATE TABLE `TYPE` (
  `League_code` <type>,
  `League_Type` <type>,
  PRIMARY KEY (`League_Type`)
);

DROP TABLE IF EXISTS `COMPETES`;
CREATE TABLE `COMPETES` (
  `Team_name` <type>,
  `League_code` <type>,
  `Rank` <type>
);

DROP TABLE IF EXISTS `PLAYS`;
CREATE TABLE `PLAYS` (
  `Team_name` <type>,
  `Gameweek_number` <type>,
  `Player_name` <type>,
  `Is_captain` <type>,
  `Is_vice_captain` <type>,
  `Is_starting` <type>
);

DROP TABLE IF EXISTS `FORWARD`;
CREATE TABLE `FORWARD` (
  `Player_name` <type>,
  `Shots_on_target` <type>,
  `Touches_inside_box` <type>,
  `Dribbles` <type>,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `FIXTURE2b`;
CREATE TABLE `FIXTURE2b` (
  `Stadium` <type>,
  `City` <type>,
  PRIMARY KEY (`Stadium`)
);

DROP TABLE IF EXISTS `GAMEWEEK`;
CREATE TABLE `GAMEWEEK` (
  `Week_number` <type>,
  `Highest_points` <type>,
  `Average_points` <type>,
  `Month` <type>,
  `Day` <type>,
  `Hours` <type>,
  `Minutes` <type>,
  PRIMARY KEY (`Week_number`)
);

DROP TABLE IF EXISTS `TEAM`;
CREATE TABLE `TEAM` (
  `Name` <type>,
  `Manager_First_name` <type>,
  `Manager_Last_name` <type>,
  `Nationality` <type>,
  `Total Points` <type>,
  `Squad Value` <type>,
  `Transfers_left` <type>,
  `Money_left` <type>,
  PRIMARY KEY (`Name`),
  KEY `CK` (`Manager_First_name`, `Manager_Last_name`)
);

DROP TABLE IF EXISTS `MIDFIELDER`;
CREATE TABLE `MIDFIELDER` (
  `Player_name` <type>,
  `Passing Accuracy` <type>,
  `Chances Created` <type>,
  `Through_balls` <type>,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `PLAYS_IN`;
CREATE TABLE `PLAYS_IN` (
  `Player_name` <type>,
  `Home_club` <type>,
  `Away_club` <type>,
  `Week_number` <type>,
  `Player_points` <type>
);

DROP TABLE IF EXISTS `SPONSORS`;
CREATE TABLE `SPONSORS` (
  `Partner_name` <type>,
  `Season` <type>
);

DROP TABLE IF EXISTS `CATEGORY`;
CREATE TABLE `CATEGORY` (
  `Partner_name` <type>,
  `Partner_category` <type>,
  PRIMARY KEY (`Partner_category`)
);

DROP TABLE IF EXISTS `ADD_POINTS1`;
CREATE TABLE `ADD_POINTS1` (
  `Team_name` <type>,
  `Week_number` <type>,
  `Player_name` <type>,
  `Home_club` <type>,
  `Away_club` <type>
);

DROP TABLE IF EXISTS `LEAGUE`;
CREATE TABLE `LEAGUE` (
  `League_code` <type>,
  `Name` <type>,
  `Number_of_teams` <type>,
  PRIMARY KEY (`League_code`),
  KEY `CK` (`Name`)
);

DROP TABLE IF EXISTS `DEFENDER`;
CREATE TABLE `DEFENDER` (
  `Player_name` <type>,
  `Clearances` <type>,
  `Tackles` <type>,
  `Interceptions` <type>,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `TRANSFER`;
CREATE TABLE `TRANSFER` (
  `Year` <type>,
  `Month` <type>,
  `Day` <type>,
  `Hours` <type>,
  `Minutes` <type>,
  `Player_in` <type>,
  `Player_out` <type>,
  `Team_name` <type>,
  `Week_number` <type>,
  PRIMARY KEY (`Player_in`, `Player_out`)
);

DROP TABLE IF EXISTS `HEAD_TO_HEAD`;
CREATE TABLE `HEAD_TO_HEAD` (
  `Teamname_1` <type>,
  `Teamname_2` <type>,
  `League_code` <type>,
  `     Result` <type>
);

DROP TABLE IF EXISTS `ACTIVATES`;
CREATE TABLE `ACTIVATES` (
  `Team_name` <type>,
  `Week_number` <type>,
  `Chip_name` <type>,
  `Gameweek Points` <type>
);

DROP TABLE IF EXISTS `EDITION`;
CREATE TABLE `EDITION` (
  `Season` <type>,
  `Winner` <type>,
  `Runners_up` <type>,
  PRIMARY KEY (`Season`)
);

DROP TABLE IF EXISTS `CHIP`;
CREATE TABLE `CHIP` (
  `Name` <type>,
  PRIMARY KEY (`Name`)
);

DROP TABLE IF EXISTS `ADD_POINTS2`;
CREATE TABLE `ADD_POINTS2` (
  `Player_name` <type>,
  `Home_club` <type>,
  `Away_club` <type>,
  `Player_points` <type>
);

DROP TABLE IF EXISTS `KEEPER`;
CREATE TABLE `KEEPER` (
  `Player_name` <type>,
  `Saves` <type>,
  `Clean_sheets` <type>,
  `Penalties Saved` <type>,
  PRIMARY KEY (`Player_name`)
);

DROP TABLE IF EXISTS `PARTNER1`;
CREATE TABLE `PARTNER1` (
  `Name` <type>,
  `City` <type>,
  PRIMARY KEY (`Name`)
);

DROP TABLE IF EXISTS `HAS_ACTIVE`;
CREATE TABLE `HAS_ACTIVE` (
  `Team_name` <type>,
  `Chip_name` <type>
);

DROP TABLE IF EXISTS `FIXTURE2a`;
CREATE TABLE `FIXTURE2a` (
  `Home_club` <type>,
  `Stadium` <type>
);

DROP TABLE IF EXISTS `KINGS_OF_THE_GAMEWEEK`;
CREATE TABLE `KINGS_OF _THE_GAMEWEEK` (
  `Player_name` <type>,
  `Week_number` <type>
);

DROP TABLE IF EXISTS `PLAYER`;
CREATE TABLE `PLAYER` (
  `Name` <type>,
  `Club` <type>,
  `Market_cost` <type>,
  `Form` <type>,
  `Total_points` <type>,
  `Selection %` <type>,
  `Fitness Status` <type>,
  PRIMARY KEY (`Name`)
);

DROP TABLE IF EXISTS `FIXTURE1`;
CREATE TABLE `FIXTURE1` (
  `Home_club` <type>,
  `Away_club` <type>,
  `Result` <type>,
  `Year` <type>,
  `Month` <type>,
  `Day` <type>,
  `Hours` <type>,
  `Minutes` <type>,
  `Week_number` <type>,
  PRIMARY KEY (`Home_club`, `Away_club`)
);

DROP TABLE IF EXISTS `PARTNER2`;
CREATE TABLE `PARTNER2` (
  `City` <type>,
  `Country` <type>,
  PRIMARY KEY (`City`)
);

