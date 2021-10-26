import subprocess as sp
import string
import random
from prettytable import PrettyTable

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
        print('Fixture', i+1)
        HClub = input('Enter Home Club: ')
        AClub = input('Enter Away Club: ')
        print('Enter the Fixture date and time')
        day, month, year = map(str, input('Date (in DD-MM-YYYY format): ').split('-'))
        hrs, mins = map(str, input('Time (in hh:mm format): ').split(':'))
        query = "INSERT INTO FIXTURE1(Home_club,Away_club,Year,Month,Day,Hours,Minutes,Week_number) VALUES ('%s','%s',%s,%s,%s,%s,%s,%s)" % (HClub,AClub,year,month,day,hrs,mins,GW)
        cur.execute(query)
        db.commit()

    print('\nFinished scheduling Gameweek',GW)
    input('Press any key to continue...')

def createTeam(db,cur):
    sp.call('clear', shell=True)

    # Get team details
    Team = input('Enter team name: ')
    Manager = []
    Manager.append(input('Enter manager first name: '))
    Manager.append(input('Enter manager last name: '))
    Nationality = input('Enter nationality: ')

    # Get squad details
    Squad = []
    Squad_value = 0.0
    Money_left = 120.0
    while(1):
        # Keeper list
        cur.execute('SELECT Name,Club,Market_cost,Total_points FROM PLAYER,KEEPER WHERE Name=Player_name;')
        Keepers = cur.fetchall()
        t = PrettyTable(['No','Player name','Club','Market cost','Total points'])
        for j in range(len(Keepers)):
            t.add_row([j+1,Keepers[j]['Name'],Keepers[j]['Club'],str(Keepers[j]['Market_cost'])+' million',Keepers[j]['Total_points']])
        k = len(Keepers)
        for i in range(2):
            sp.call('clear', shell=True)
            print('Pick your squad:-\n')
            print(t)
            print('Money left in bank:',Money_left,'million\n')
            n = int(input('Choose a keeper ('+str(2-i)+' left): ')) - 1
            '''
            if n > k:
                if i <= n:
                    t.del_row(n-i)
                else:
                    t.del_row(0)
            else:
                t.del_row(n)
            k = min(k,n)
            '''
            Squad.append(Keepers[n]['Name'])
            Squad_value += float(Keepers[n]['Market_cost'])
            Money_left -= float(Keepers[n]['Market_cost'])

        # Defender list
        cur.execute('SELECT Name,Club,Market_cost,Total_points FROM PLAYER,DEFENDER WHERE Name=Player_name;')
        Defenders = cur.fetchall()
        t = PrettyTable(['No','Player name','Club','Market cost','Total points'])
        for j in range(len(Defenders)):
            t.add_row([j+1,Defenders[j]['Name'],Defenders[j]['Club'],str(Defenders[j]['Market_cost'])+' million',Defenders[j]['Total_points']])
        k = len(Defenders)
        for i in range(5):
            sp.call('clear', shell=True)
            print('Pick your squad:-\n')
            print(t)
            print('Money left in bank:',Money_left,'million\n')
            n = int(input('Choose a defender ('+str(5-i)+' left): ')) - 1
            '''
            if n > k:
                if i <= n:
                    t.del_row(n-i)
                else:
                    t.del_row(0)
            else:
                t.del_row(n)
            k = min(k,n)
            '''
            Squad.append(Defenders[n]['Name'])
            Squad_value += float(Defenders[n]['Market_cost'])
            Money_left -= float(Defenders[n]['Market_cost'])

        # Midfielder list
        cur.execute('SELECT Name,Club,Market_cost,Total_points FROM PLAYER,MIDFIELDER WHERE Name=Player_name;')
        Midfielders = cur.fetchall()
        t = PrettyTable(['No','Player name','Club','Market cost','Total points'])
        for j in range(len(Midfielders)):
            t.add_row([j+1,Midfielders[j]['Name'],Midfielders[j]['Club'],str(Midfielders[j]['Market_cost'])+' million',Midfielders[j]['Total_points']])
        k = len(Midfielders)
        for i in range(5):
            sp.call('clear', shell=True)
            print('Pick your squad:-\n')
            print(t)
            print('Money left in bank:',Money_left,'million\n')
            n = int(input('Choose a midfielder ('+str(5-i)+' left): ')) - 1
            '''
            if n > k:
                if i <= n:
                    t.del_row(n-i)
                else:
                    t.del_row(0)
            else:
                t.del_row(n)
            k = min(k,n)
            '''
            Squad.append(Midfielders[n]['Name'])
            Squad_value += float(Midfielders[n]['Market_cost'])
            Money_left -= float(Midfielders[n]['Market_cost'])

        # Forward list
        cur.execute('SELECT Name,Club,Market_cost,Total_points FROM PLAYER,FORWARD WHERE Name=Player_name;')
        Forwards = cur.fetchall()
        t = PrettyTable(['No','Player name','Club','Market cost','Total points'])
        for j in range(len(Forwards)):
            t.add_row([j+1,Forwards[j]['Name'],Forwards[j]['Club'],str(Forwards[j]['Market_cost'])+' million',Forwards[j]['Total_points']])
        k = len(Forwards)
        for i in range(3):
            sp.call('clear', shell=True)
            print('Pick your squad:-\n')
            print(t)
            print('Money left in bank:',Money_left,'million\n')
            n = int(input('Choose a forward ('+str(3-i)+' left): ')) - 1
            '''
            if n > k:
                if i <= n:
                    t.del_row(n-i)
                else:
                    t.del_row(0)
            else:
                t.del_row(n)
            k = min(k,n)
            '''
            Squad.append(Forwards[n]['Name'])
            Squad_value += float(Forwards[n]['Market_cost'])
            Money_left -= float(Forwards[n]['Market_cost'])

        if Money_left < 0:
            Squad = []
            Squad_value = 0.0
            Money_left = 120.0
            print('Insufficient funds to pick this squad. Please choose a different squad')
            input('Press any key to continue...')
        else:
            break

    # Insert into TEAM
    cur.execute("INSERT IGNORE INTO TEAM VALUES ('{0}','{1}','{2}','{3}',0,{4},1,{5});".format(Team,Manager[0],Manager[1],Nationality,Squad_value,Money_left))
    db.commit()

    # Insert into PLAYS
    cur.execute('SELECT MAX(Week_number) AS GW FROM GAMEWEEK;')
    GW = cur.fetchone()['GW']
    for i in range(len(Squad)):
        if i == 4:
            cur.execute("INSERT INTO PLAYS VALUES('{0}',{1},'{2}',1,0,1);".format(Team,GW,Squad[i]))
        elif i == 7:
            cur.execute("INSERT INTO PLAYS VALUES('{0}',{1},'{2}',0,1,1);".format(Team,GW,Squad[i]))
        elif i > 10:
            cur.execute("INSERT INTO PLAYS VALUES('{0}',{1},'{2}',0,0,0);".format(Team,GW,Squad[i]))
        else:
            cur.execute("INSERT INTO PLAYS VALUES('{0}',{1},'{2}',0,0,1);".format(Team,GW,Squad[i]))
        db.commit()
    
    print('Successfully created team!')
    input('Press any key to continue...')

def createLeague(db,cur):
    Code = ''.join(random.choices(string.ascii_lowercase+string.digits, k = 6))
    Name = input('Enter League name: ')
    Type = ['Invitational','Public','General']
    Mode = ['Classic', 'Head-to-Head']

    print('\n1. Invitational')
    print('2. Public')
    print('3. General')
    ch1 = int(input('Choose type of league (1-3): '))

    print('\n1. Classic')
    print('2. Head-to-Head')
    ch2 = int(input('Choose mode of league (1-2): '))

    # Insert into LEAGUE table
    cur.execute("INSERT INTO LEAGUE VALUES('{0}','{1}',0)".format(Code,Name))
    db.commit()

    # Insert into PLAYS table
    cur.execute("INSERT INTO TYPE VALUES('{0}','{1}'),('{0}','{2}')".format(Code,Type[ch1-1],Mode[ch2-2]))
    db.commit()

    print('Successfully created league!')
    input('Press any key to continue...')
