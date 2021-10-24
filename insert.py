import subprocess as sp

def scheduleGW(db,cur):
    # Get the upcoming gameweek number
    query = 'SELECT MAX(Week_number) AS GW FROM GAMEWEEK;'
    cur.execute(query)
    GW = int(cur.fetchone()['GW']) + 1
    print('Scheduling Gameweek',str(GW)+'...')

    # Insert into GAMEWEEK table
    print('Enter the Gameweek Deadline')
    day, month, year = map(str, input('Date (in DD-MM-YYYY format): ').split('-'))
    hrs, mins = map(str, input('Time (in hh:mm format): ').split(':'))
    query = 'INSERT INTO GAMEWEEK(Week_number,Year,Month,Day,Hours,Minutes) VALUES (%s,%s,%s,%s,%s,%s)' % (GW,year,month,day,hrs,mins)
    cur.execute(query)
    db.commit()

    # Get team squads from previous gameweek
    query='INSERT IGNORE INTO PLAYS SELECT Team_name,%s,Player_name,Is_captain,Is_vice_captain,Is_starting FROM PLAYS AS P WHERE P.Gameweek_number=%s;' % (GW,GW-1)
    cur.execute(query)
    db.commit()

    # Insert into ACTIVATES table
    query='INSERT IGNORE INTO ACTIVATES(Team_name,Week_number) SELECT Name,%s FROM TEAM;' % (GW)
    cur.execute(query)
    db.commit()

    sp.call('clear', shell=True)
    # Insert into FIXTURE table
    print('Scheduling fixtures...')
    n = int(input('Enter the number of fixtures to be scheduled: '))
    for i in range(n):
        sp.call('clear', shell=True)
        print('Fixture',i+1)
        HClub = input('Enter Home Club: ')
        AClub = input('Enter Away Club: ')
        print('Enter the Fixture date and time')
        day, month, year = map(str, input('Date (in DD-MM-YYYY format): ').split('-'))
        hrs, mins = map(str, input('Time (in hh:mm format): ').split(':'))
        query = "INSERT INTO FIXTURE1(Home_club,Away_club,Year,Month,Day,Hours,Minutes,Week_number) VALUES ('%s','%s',%s,%s,%s,%s,%s,%s)" % (HClub,AClub,year,month,day,hrs,mins,GW)
        cur.execute(query)
        db.commit()

    print('')
    print('Finished scheduling Gameweek',GW)
    input('Press any key to continue...')
