import subprocess as sp
import datetime as dt

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
    cur.execute("DELETE FROM HAS_ACTIVE WHERE Team_name='%s' AND Chip_name='%s'" % (Team,Chips[ch]['Chip_name']))
    db.commit()

    print('\n'+Chips[ch]['Chip_name'],'has been activated')
    input('Press any key to continue...')

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
        cur.execute("SELECT * FROM PLAYS WHERE Team_name='%s' AND Gameweek_number=(SELECT MAX(Week_number) FROM GAMEWEEK);" % (Team))
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
        print('\n\nSquad:-\n')
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
        print('\nC - Captain    V - Vice-captain    B : Benched')
        print('Squad Value:',TeamDetails['Squad Value'],'     Money left in bank:',TeamDetails['Money_left'],'million')

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
            # elif ch == 2:

            # elif ch == 3:

            else:
                sp.call('clear',shell=True)
                print('Please enter a valid option')
                input('Press any key to continue...')

