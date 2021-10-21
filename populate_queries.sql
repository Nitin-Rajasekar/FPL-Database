INSERT INTO PLAYER(`Name`, `Club`, `Market_cost`) VALUES ('Guilty Sigurdsson', 'Everton FC', 6.9);
INSERT INTO PLAYER(`Name`, `Club`, `Market_cost`) VALUES ('Benjailmin Mendy', 'Manchester City FC', 8.2);
INSERT INTO PLAYER(`Name`, `Club`, `Market_cost`) VALUES ('Timo Werner', 'Chelsea FC', 10.5);
INSERT INTO PLAYER(`Name`, `Club`, `Market_cost`) VALUES ('Harry Maguire', 'Manchester United FC', 7.5);
INSERT INTO PLAYER(`Name`, `Club`, `Market_cost`) VALUES ('Erling Braut Haaland', 'Newcastle United', 12.5);


UPDATE ADD_POINTS1 AS A1 SET Player_points=(
    SELECT (CASE
        WHEN Chip_name='Triple Captain' AND Is_captain=True THEN 3*P1.Player_points
        WHEN Chip_name='Bench Boost' AND Is_starting=False THEN P1.Player_points
        WHEN Is_captain=True THEN 2*P1.Player_points
        WHEN Is_starting=False THEN 0
        ELSE P1.Player_points
    END)
    FROM ACTIVATES AS A2, PLAYS_IN AS P1, PLAYS AS P2
    WHERE A1.Team_name=A2.Team_name AND A1.Week_number=A2.Week_number AND A1.Team_name=P2.Team_name AND A1.Week_number=P2.Gameweek_number AND A1.Player_name=P2.Player_name AND P1.Player_name=P2.Player_name)
WHERE Player_points IS NULL;

UPDATE ACTIVATES AS A1 SET `Gameweek Points`=(
    SELECT SUM(Player_points)
    FROM ADD_POINTS1 AS A2
    WHERE A1.Team_name=A2.Team_name AND A1.Week_number=A2.Week_number)
WHERE `Gameweek Points` IS NULL;



UPDATE PLAYS_IN SET Player_points=7 WHERE Player_name='Ali Dia';
UPDATE PLAYS_IN SET Player_points=2 WHERE Player_name='Benjailmin Mendy';
UPDATE PLAYS_IN SET Player_points=0 WHERE Player_name='Donny van de Beek';
UPDATE PLAYS_IN SET Player_points=1 WHERE Player_name='Eric Dier';
UPDATE PLAYS_IN SET Player_points=17 WHERE Player_name='Erling Braut Haaland';
UPDATE PLAYS_IN SET Player_points=-3 WHERE Player_name='Fred';
UPDATE PLAYS_IN SET Player_points=2 WHERE Player_name='Guilty Sigurdsson';
UPDATE PLAYS_IN SET Player_points=-7 WHERE Player_name='Harry Maguire';
UPDATE PLAYS_IN SET Player_points=9 WHERE Player_name='Jamie Vardy';
UPDATE PLAYS_IN SET Player_points=12 WHERE Player_name='Jonjo Shelvey';
UPDATE PLAYS_IN SET Player_points=8 WHERE Player_name='Kepa Arrizabalaga';
UPDATE PLAYS_IN SET Player_points=20 WHERE Player_name='Kylian Mbappe';
UPDATE PLAYS_IN SET Player_points=16 WHERE Player_name='Lionel Messi';
UPDATE PLAYS_IN SET Player_points=12 WHERE Player_name='Nick Pope';
UPDATE PLAYS_IN SET Player_points=10 WHERE Player_name='Teemu Pukki';
UPDATE PLAYS_IN SET Player_points=2 WHERE Player_name='Timo Werner';

INSERT INTO FIXTURE2b VALUES('Villa Park','Birmingham');
INSERT INTO FIXTURE2b VALUES('Stamford Bridge','London');
INSERT INTO FIXTURE2b VALUES('Goodison Park','Liverpool');
INSERT INTO FIXTURE2b VALUES('Elland Road','Leeds');
INSERT INTO FIXTURE2b VALUES('Etihad','Manchester');
INSERT INTO FIXTURE2b VALUES('St.James Park','Newcastle');
INSERT INTO FIXTURE2b VALUES('Carrow Road','Norwich');
INSERT INTO FIXTURE2b VALUES('Tottenham Hotspur Stadium','London');
INSERT INTO FIXTURE2b VALUES('London Stadium','London');
INSERT INTO FIXTURE2b VALUES('Molineaux','Wolverhampton');

INSERT INTO FIXTURE2a VALUES('Aston Villa','Villa Park');
INSERT INTO FIXTURE2a VALUES('Chelsea','Stamford Bridge');
INSERT INTO FIXTURE2a VALUES('Everton','Goodison Park');
INSERT INTO FIXTURE2a VALUES('Leeds United','Elland Road');
INSERT INTO FIXTURE2a VALUES('Manchester City','Etihad');
INSERT INTO FIXTURE2a VALUES('Newcastle United','St.James Park');
INSERT INTO FIXTURE2a VALUES('Norwich City','Carrow Road');
INSERT INTO FIXTURE2a VALUES('Tottenham Hotspurs','Tottenham Hotspur Stadium');
INSERT INTO FIXTURE2a VALUES('West Ham United','London Stadium');
INSERT INTO FIXTURE2a VALUES('Wolverhampton Wanderers','Molineaux');
