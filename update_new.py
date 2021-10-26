import subprocess as sp

def updateScores(db,cur):
    # Get the fixture result
    home_club = str(input('Enter the home club: '))
    away_club = str(input('Enter the away club: '))
    home, away = map(str, input('Date (in home-teams goals-away teams goals format): ').split('-'))
    query='UPDATE `FIXTURE1` SET `Result` = "%s-%s" WHERE `HOME_CLUB`= "%s" AND `AWAY_CLUB`= "%s";' % (home, away,home_club,away_club)
    cur.execute(query)
    db.commit()
    print('')
    print('Match score has been updated')
    input('Press any key to continue...')


def playerStats(db,cur):
    # Get the fixture result
    player_name = input('Enter the name of the player: ')
    stat_name = str(input('Enter the name of the statistic to alter: '))
    new_stat = str(input('Enter the name of the new value of the statistic: '))
    if stat_name == "Shots_on_target" or stat_name == "Touches_inside_box" or stat_name == "Dribbles":
        query='UPDATE `FORWARD` SET `%s` = %s WHERE `Player_name`= "%s";' % (stat_name,new_stat,player_name)
    elif stat_name == "Passing Accuracy" or stat_name == "Chances Created" or stat_name == "Through_balls":
        query='UPDATE `MIDFIELDER` SET `%s` = "%s" WHERE `Player_name`= "%s";' % (stat_name,new_stat,player_name)
    elif stat_name == "Clearances" or stat_name == "Tackles" or stat_name == "Interceptions":
        query='UPDATE `DEFENDER` SET `"%s"` = "%s" WHERE `Player_name`= "%s";' % (stat_name,new_stat,player_name)
    elif stat_name == "Save" or stat_name == "Clean_sheets" or stat_name == "Penalties Saved":
        query='UPDATE `KEEPER` SET `"%s"` = "%s" WHERE `Player_name`= "%s";' % (stat_name,new_stat,player_name)
    cur.execute(query)
    db.commit()
    print('')
    print('Player`s statistic has been updated')
    input('Press any key to continue...')

def playerPoints(db,cur):
    player_name = input('Enter the name of the player: ')
    home_club = str(input('Enter the home club of the concerned fixture: '))
    away_club = str(input('Enter the away club of the concerned fixture: '))
    player_points = str(input('Enter the number of points: '))
    query='UPDATE `PLAYS_IN` SET `Player_points` = %s WHERE `Player_name`= "%s" AND `HOME_CLUB`= "%s" AND `AWAY_CLUB`= "%s";' % (player_points,player_name,home_club,away_club)
    cur.execute(query)
    db.commit()
    print('')
    print('Player`s statistic has been updated')
    input('Press any key to continue...')


def teamPoints(db,cur):
    query="""UPDATE ADD_POINTS1 AS A1 SET Player_points=(
    SELECT (CASE WHEN Chip_name='Triple Captain' AND Is_captain=True THEN 3*P1.Player_points         WHEN Chip_name='Bench Boost' AND Is_starting=False THEN P1.Player_points
    WHEN Is_captain=True THEN 2*P1.Player_points WHEN Is_starting=False THEN 0         ELSE P1.Player_points     END)     FROM ACTIVATES AS A2, PLAYS_IN AS P1, PLAYS AS P2     WHERE A1.Team_name=A2.Team_name AND A1.Week_number=A2.Week_number AND A1.Team_name=P2.Team_name AND A1.Week_number=P2.Gameweek_number AND A1.Player_name=P2.Player_name AND P1.Player_name=P2.Player_name AND P1.Week_number=A1.Week_number AND A1.Home_club=P1.Home_club AND A1.Away_club=P1.Away_club);"""
    cur.execute(query)
    db.commit()
    print('')
    query="""UPDATE ACTIVATES AS A1 SET `Gameweek Points`=(
    SELECT SUM(Player_points)
    FROM ADD_POINTS1 AS A2
    WHERE A1.Team_name=A2.Team_name AND A1.Week_number=A2.Week_number);"""
    cur.execute(query)
    db.commit()
    cur.execute("UPDATE TEAM AS T SET `Total Points`=(SELECT SUM(`Gameweek Points`) FROM ACTIVATES AS A WHERE A.Team_name=T.name);")
    db.commit()
    cur.execute("UPDATE GAMEWEEK AS G SET `Highest_points`=(SELECT MAX(`Gameweek Points`) FROM ACTIVATES AS A WHERE A.Week_number=G.Week_number);")
    db.commit()
    cur.execute("UPDATE GAMEWEEK AS G SET `Average_points`=(SELECT SUM(`Gameweek Points`)/COUNT(*) FROM ACTIVATES AS A WHERE A.Week_number=G.Week_number);")
    db.commit()
    cur.execute("UPDATE PLAYER AS P1 SET Total_points=(SELECT SUM(Player_points) FROM PLAYS_IN AS P2 WHERE P1.Name=P2.Player_name);")
    db.commit()
    cur.execute("UPDATE PLAYER AS P1 SET `Selection %`=(SELECT 100*COUNT(*) FROM PLAYS AS P2 WHERE P1.Name=P2.Player_name AND Gameweek_number=(SELECT MAX(Week_number) FROM GAMEWEEK) ) / (SELECT COUNT(*) FROM TEAM);")
    db.commit()
    print('Team`s points have been updated')
    input('Press any key to continue...')



def updateLeague(db,cur):
    #updates result
    query="""UPDATE HEAD_TO_HEAD SET `Result` = CONCAT((SELECT `Gameweek Points` FROM ACTIVATES AS A  WHERE A.Team_name=HEAD_TO_HEAD.Teamname_1
    AND A.Week_number=(SELECT MAX(Week_number) FROM ACTIVATES)),'-',(SELECT `Gameweek Points` FROM ACTIVATES AS A   
    WHERE A.Team_name=HEAD_TO_HEAD.Teamname_2 AND A.Week_number=(SELECT MAX(Week_number) FROM ACTIVATES)))
            """ 
    cur.execute(query)
    db.commit()

    # updates rank
    query="""CREATE TEMPORARY TABLE new_tbl SELECT Team_name, League_code, TEAM.`Total Points`, DENSE_RANK()
            OVER (ORDER BY TEAM.`Total Points` DESC) MY_RANK FROM COMPETES, TEAM WHERE COMPETES.`Team_name`=TEAM.Name;
            """
    query_2="UPDATE `COMPETES` SET `Rank` = (SELECT `MY_RANK` FROM new_tbl WHERE COMPETES.Team_name=new_tbl.Team_name AND COMPETES.League_code=new_tbl.league_code);"
    query_3="DROP TABLE new_tbl;"
    cur.execute(query)
    db.commit()
    cur.execute(query_2)
    db.commit()
    cur.execute(query_3)
    db.commit()

    print('')
    print('League details have been updated')
    input('Press any key to continue...')




   





def takeChoice(db,cur):
    print('1. Update the result of fixture')
    print('2. Update the statistics of a player')
    print('3. Update the Points of a player')
    print('4. Update a team`s points')
    print('5. Update league results and rankings')



    choice=int(input('Enter your choice: '))
    if choice == 1:
        updateScores(db,cur)
    if choice == 2:
        playerStats(db,cur)
    if choice == 3:
        playerPoints(db,cur)
    if choice == 4:
        teamPoints(db,cur)
    if choice == 5:
        updateLeague(db,cur)
