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


def takeChoice(db,cur):
    print('1. Update the result of fixture')
    print('2. Update the statistics of a player')
    choice=int(input('Enter your choice: '))
    if choice == 1:
        updateScores(db,cur)
    if choice == 2:
        playerStats(db,cur)
