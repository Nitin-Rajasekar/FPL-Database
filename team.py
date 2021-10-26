import subprocess as sp
import datetime as dt
from prettytable import PrettyTable

def playChip(db,cur,ActiveChip,Chips,Team,GW):
    sp.call('clear', shell=True)
    if ActiveChip['Chip_name'] != None:
        print(ActiveChip['Chip_name'],"is already active")
        input('Press any key to continue...')
        return
    if len(Chips) == 0:
        print('No Chips are available')
        input('Press any key to continue...')
        return

    # List available chips
    print('Available Chips:-')
    for i in range(len(Chips)):
        print(str(i+1)+'.',Chips[i]['Chip_name'])
    
    ch = int(input('\nChoose a chip to be activated (Enter 0 to cancel and go back): ')) - 1
    if ch < 0 or ch >= len(Chips):
        input('Press any key to continue...')
        return

    # Update chip name in ACTIVATES table
    cur.execute("UPDATE ACTIVATES SET Chip_name='%s' WHERE Team_name='%s' AND Week_number=%s AND Chip_name IS NULL;" % (Chips[ch]['Chip_name'],Team,GW))
    db.commit()

    # Delete chip name in HAS_ACTIVE table
    cur.execute("DELETE FROM HAS_ACTIVE WHERE Team_name='%s' AND Chip_name='%s';" % (Team,Chips[ch]['Chip_name']))
    db.commit()

    # Update TEAM table
    if Chips[ch]['Chip_name'] == 'Wildcard' or Chips[ch]['Chip_name'] == 'Freehit':
        cur.execute("UPDATE TEAM SET Transfers_left=NULL WHERE Name='{0}';".format(Team))
        db.commit()

    print('\n'+Chips[ch]['Chip_name'],'has been activated')
    input('Press any key to continue...')

def makeTransfer(db,cur,Squad,TeamDetails,GW):
    sp.call('clear',shell=True)
    if TeamDetails['Transfers_left'] == 0:
        print('No transfers available')
        input('Press any key to continue...')
        return
    
    # Squad Details
    print('Squad:-\n')
    t1=PrettyTable(['No','Player Name','Club','Market Cost','Fitness Status'])
    for i in range(len(Squad)):
        t1.add_row([i+1,Squad[i]['Player_name'],Squad[i]['Club'],str(Squad[i]['Market_cost'])+' million',Squad[i]['Fitness Status']])
    print(t1)

    if TeamDetails['Transfers_left'] == None:
        print('\nTransfers left: Unlimited    ',end=' ')
    else:
        print('\nTransfers left:',TeamDetails['Transfers_left'],end='     ')
    print('Money left in bank:',TeamDetails['Money_left'],'million')
    pout = int(input('Choose player to be transferred out(1-15): ')) - 1    
    if pout > 15 or pout < 1:
        input('\nInvalid choice\nPress any key to continue...')
        return

    # List out players available to transfer in
    cur.execute("SELECT Name,Club,Market_cost,Total_points,`Selection %`,`Fitness Status` FROM PLAYER,FORWARD WHERE '{0}' IN (SELECT Player_name FROM FORWARD) AND Name=Player_name AND Name NOT IN (SELECT Player_name FROM PLAYS WHERE Team_name='{1}' AND Gameweek_number={2}) UNION SELECT Name,Club,Market_cost,Total_points,`Selection %`,`Fitness Status` FROM PLAYER,MIDFIELDER WHERE '{0}' IN (SELECT Player_name FROM MIDFIELDER) AND Name=Player_name AND Name NOT IN (SELECT Player_name FROM PLAYS WHERE Team_name='{1}' AND Gameweek_number={2}) UNION SELECT Name,Club,Market_cost,Total_points,`Selection %`,`Fitness Status` FROM PLAYER,DEFENDER WHERE '{0}' IN (SELECT Player_name FROM DEFENDER) AND Name=Player_name AND Name NOT IN (SELECT Player_name FROM PLAYS WHERE Team_name='{1}' AND Gameweek_number={2}) UNION SELECT Name,Club,Market_cost,Total_points,`Selection %`,`Fitness Status` FROM PLAYER,KEEPER WHERE '{0}' IN (SELECT Player_name FROM KEEPER) AND Name=Player_name AND Name NOT IN (SELECT Player_name FROM PLAYS WHERE Team_name='{1}' AND Gameweek_number={2});".format(Squad[pout]['Player_name'],TeamDetails['Name'],GW))
    PlayerInList = cur.fetchall()
    t2=PrettyTable(['No','Player Name','Club','Market Cost','Total Points','Selection Percentage','Fitness Status'])
    for i in range(len(PlayerInList)):
        t2.add_row([i+1,PlayerInList[i]['Name'],PlayerInList[i]['Club'],str(PlayerInList[i]['Market_cost'])+' million',PlayerInList[i]['Total_points'],str(PlayerInList[i]['Selection %'])+' %',PlayerInList[i]['Fitness Status']])
    print(t2)
    print('\nMoney left in bank:',TeamDetails['Money_left']+Squad[pout]['Market_cost'],'million')
    pin = int(input('Choose player to be transferred in(1-{0}): '.format(i))) - 1

    # Check if transfer is viable
    if TeamDetails['Money_left'] + Squad[pout]['Market_cost'] < PlayerInList[pin]['Market_cost']:
        print('\nInsufficient funds to complete transfer')
        input('Press any key to continue...')
        return

    # Insert into TRANSFERS table
    x = dt.datetime.now()
    cur.execute("INSERT INTO TRANSFER VALUES({0},{1},{2},{3},{4},'{5}','{6}','{7}',{8})".format(x.year,x.month,x.day,x.hour,x.minute,PlayerInList[pin]['Name'],Squad[pout]['Player_name'],TeamDetails['Name'],GW))
    db.commit()

    # Update PLAYS table
    cur.execute("UPDATE PLAYS SET Player_name='{0}' WHERE Player_name='{1}' AND Team_name='{2}' AND Gameweek_number={3}".format(PlayerInList[pin]['Name'],Squad[pout]['Player_name'],TeamDetails['Name'],GW))
    db.commit()

    # Update ADDPOINTS1 table
    # cur.execute("UPDATE PLAYS SET Player_name='{0}' WHERE Player_name='{1}' AND Team_name='{2}' AND Gameweek_number={3}".format(PlayerInList[pin]['Name'],Squad[pout]['Player_name'],TeamDetails['Name'],GW))
    # db.commit()

    # Update Selection % in PLAYER table
    cur.execute("UPDATE PLAYER AS P1 SET `Selection %`=(SELECT 100*COUNT(*) FROM PLAYS AS P2 WHERE P1.Name=P2.Player_name AND Gameweek_number=(SELECT MAX(Week_number) FROM GAMEWEEK) ) / (SELECT COUNT(*) FROM TEAM);")
    db.commit()

    # Update TEAM table
    if TeamDetails['Transfers_left'] != None:
        cur.execute("UPDATE TEAM SET Transfers_left=Transfers_left-1, `Squad Value`=`Squad Value`+{0}-{1}, Money_left=Money_left+{0}-{1} WHERE Name='{2}'".format(PlayerInList[pin]['Market_cost'],Squad[pout]['Market_cost'],TeamDetails['Name']))
        db.commit()
    
    print('Successfully completed transfer!')
    input('Press any key to continue...')

def makeCaptain(db,cur,Team,GW,Squad):
    n = int(input('\nChoose a player to captain(1-15): ')) - 1
            
    if Squad[n]['Is_starting'] == 0:
        input('\nCannot captain a benched player. Press any key to continue...')
        return

    # Update PLAYS table
    if Squad[n]['Is_vice_captain'] == 1:
        cur.execute("UPDATE PLAYS SET Is_captain=0,Is_vice_captain=1 WHERE Is_captain=1 AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW))
        db.commit()
    else:
        cur.execute("UPDATE PLAYS SET Is_captain=0 WHERE Is_captain=1 AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW))
        db.commit()

    cur.execute("UPDATE PLAYS SET Is_captain=1,Is_vice_captain=0 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n]['Player_name']))
    db.commit()

    print('\nSuccessfully made changes!')
    input('Press any key to continue...')

def makeViceCaptain(db,cur,Team,GW,Squad):
    n = int(input('\nChoose a player to vice-captain(1-15): ')) - 1

    if Squad[n]['Is_starting'] == 0:
        input('\nCannot vice-captain a benched player. Press any key to continue...')
        return

    # Update PLAYS table
    if Squad[n]['Is_captain'] == 1:
        cur.execute("UPDATE PLAYS SET Is_captain=1,Is_vice_captain=0 WHERE Is_vice_captain=1 AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW))
        db.commit()
    else:
        cur.execute("UPDATE PLAYS SET Is_vice_captain=0 WHERE Is_vice_captain=1 AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW))
        db.commit()

    cur.execute("UPDATE PLAYS SET Is_vice_captain=1,Is_captain=0 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n]['Player_name']))
    db.commit()

    print('\nSuccessfully made changes!')
    input('Press any key to continue...')

def makeSubstitution(db,cur,Team,GW,Squad):
    n1 = int(input('\nChoose a player to be subbed in(1-15): ')) - 1
    if Squad[n1]['Is_starting'] == 1:
        input('\nCannot sub in a player who is already starting. Press any key to continue...')
        return

    n2 = int(input('Choose a player to be subbed out(1-15): ')) - 1
    if Squad[n2]['Is_starting'] == 0:
        input('\nCannot sub out a player who is already benched. Press any key to continue...')
        return

    # Update PLAYS table
    if Squad[n2]['Is_captain'] == 1:
        cur.execute("UPDATE PLAYS SET Is_starting=1,Is_captain=1 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n1]['Player_name']))
        db.commit()

        cur.execute("UPDATE PLAYS SET Is_starting=0,Is_captain=0 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n2]['Player_name']))
        db.commit()
    
    if Squad[n2]['Is_vice_captain'] == 1:
        cur.execute("UPDATE PLAYS SET Is_starting=1,Is_vice_captain=1 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n1]['Player_name']))
        db.commit()

        cur.execute("UPDATE PLAYS SET Is_starting=0,Is_vice_captain=0 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n2]['Player_name']))
        db.commit()
    
    else:
        cur.execute("UPDATE PLAYS SET Is_starting=1 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n1]['Player_name']))
        db.commit()

        cur.execute("UPDATE PLAYS SET Is_starting=0 WHERE Player_name='{2}' AND Team_name='{0}' AND Gameweek_number={1}".format(Team,GW,Squad[n2]['Player_name']))
        db.commit()

    print('\nSuccessfully made substitution!')
    input('Press any key to continue...')

def changeLineup(db,cur,Team,GW):
    while(1):
        sp.call('clear',shell=True)
        cur.execute("SELECT Player_name,Is_captain,Is_vice_captain,Is_starting,Club,Market_cost,`Fitness Status` FROM PLAYS AS P1,PLAYER AS P2 WHERE Team_name='%s' AND P1.Player_name=P2.Name AND Gameweek_number=(SELECT MAX(Week_number) FROM GAMEWEEK);" % (Team))
        Squad = cur.fetchall()
        
        # Prompt
        print('Lineup:-')
        t=PrettyTable(['No','Player Name','Club','Fitness Status','Designation'])
        for i in range(len(Squad)):
            if Squad[i]['Is_captain'] == 1:
                t.add_row([i+1,Squad[i]['Player_name'],Squad[i]['Club'],Squad[i]['Fitness Status'],'Captain'])
            elif Squad[i]['Is_vice_captain'] == 1:
                t.add_row([i+1,Squad[i]['Player_name'],Squad[i]['Club'],Squad[i]['Fitness Status'],'Vice-captain'])
            elif Squad[i]['Is_starting'] == 0:
                t.add_row([i+1,Squad[i]['Player_name'],Squad[i]['Club'],Squad[i]['Fitness Status'],'Benchwarmer'])
            else:
                t.add_row([i+1,Squad[i]['Player_name'],Squad[i]['Club'],Squad[i]['Fitness Status'],''])  
        print(t)
        print('\nWhat changes would you like to make?')
        print('1. Change captain')
        print('2. Change vice-captain')
        print('3. Make a substitution')
        print('4. Go back')
        ch = int(input('Choose an option: '))

        if ch == 4:
            return
        
        elif ch == 1:            
            makeCaptain(db,cur,Team,GW,Squad)

        elif ch == 2:
            makeViceCaptain(db,cur,Team,GW,Squad)
        
        elif ch == 3:
            makeSubstitution(db,cur,Team,GW,Squad)

        else:
            input('Invalid option. Press any key to continue...')


def manageTeam(db,cur):
    Team = input('Enter team name: ')
    
    while(1):
        sp.call('clear', shell=True)
        cur.execute("SELECT * FROM TEAM WHERE Name='%s';" % (Team))
        TeamDetails = cur.fetchone()
        cur.execute("SELECT * FROM HAS_ACTIVE WHERE Team_name='%s';" % (Team))
        Chips = cur.fetchall()
        cur.execute("SELECT Chip_name FROM ACTIVATES WHERE Team_name='%s' AND Week_number=(SELECT MAX(Week_number) FROM GAMEWEEK);" % (Team))
        ActiveChip = cur.fetchone()
        cur.execute("SELECT Player_name,Is_captain,Is_vice_captain,Is_starting,Club,Market_cost,`Fitness Status` FROM PLAYS AS P1,PLAYER AS P2 WHERE Team_name='%s' AND P1.Player_name=P2.Name AND Gameweek_number=(SELECT MAX(Week_number) FROM GAMEWEEK);" % (Team))
        Squad = cur.fetchall()
        
        # Team details
        print('Team name:',Team,'     Manager name:',TeamDetails['Manager_First_name'],TeamDetails['Manager_Last_name'],'     Nationality:',TeamDetails['Nationality'],'     Total Points:',TeamDetails['Total Points'])
        print('Active Chip:',ActiveChip['Chip_name'],end='')
        print('     Chips left:',end=' ')
        for i in range(len(Chips)):
            print(Chips[i]['Chip_name'],end='')
            if i < len(Chips) - 1:
                print(',',end=' ')
        if len(Chips) == 0:
            print('No chips available')     

        # Squad details
        print('\n\nSquad lineup:-\n')
        for i in range(len(Squad)):
            print(Squad[i]['Player_name'],end=' ')
            if Squad[i]['Is_captain'] == 1:
                print('(C)')
            elif Squad[i]['Is_vice_captain'] == 1:
                print('(V)')
            elif Squad[i]['Is_starting'] == 0:
                print('(B)')
            else:
                print('')
            
        print('\nC - Captain    V - Vice-captain    B - Benched')
        print('Squad Value:',TeamDetails['Squad Value'],'million     Money left in bank:',TeamDetails['Money_left'],'million')

        # Check if gameweek deadline has been exceeded
        cur.execute('SELECT MAX(Week_number) AS GW FROM GAMEWEEK;')
        GW = int(cur.fetchone()['GW'])
        cur.execute('SELECT Year,Month,Day,Hours,Minutes FROM GAMEWEEK WHERE Week_number=%s' % (GW))
        Temp = cur.fetchone()
        Deadline = dt.datetime(Temp['Year'],Temp['Month'],Temp['Day'],Temp['Hours'],Temp['Minutes'])

        if dt.datetime.now() > Deadline:
            print('\nGameweek %s deadline has been exceeded, cannot make any changes' % (GW))
            input('Press any key to continue...')
            return
        else:
            print('\nGameweek',GW,'Deadline:',Deadline)

            # Prompt
            print('\nWhat would you like to do for the upcoming gameweek?')
            print('1. Play a chip')
            print('2. Make a transfer')
            print('3. Change the lineup')
            print('4. Go back')
            ch = int(input('Enter an option: '))

            if ch == 4:
                return
            elif ch == 1:
                playChip(db,cur,ActiveChip,Chips,Team,GW)
            elif ch == 2:
                makeTransfer(db,cur,Squad,TeamDetails,GW)
            elif ch == 3:
                changeLineup(db,cur,Team,GW) 
            else:
                sp.call('clear',shell=True)
                print('Please enter a valid option')
                input('Press any key to continue...')

