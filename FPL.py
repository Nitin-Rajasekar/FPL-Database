import pymysql
import pymysql.cursors as cursors
import subprocess as sp
import insert as i
import team as t
import update as u
import misc as m
from getpass import getpass as gt

# Main driver function
def dispatch(ch):
    if ch == 1:
        i.scheduleGW(db,cur)
    elif ch == 2:
        i.createTeam(db,cur)
    elif ch == 3:
        i.createLeague(db,cur)
    elif ch == 4:
        t.manageTeam(db,cur)
    elif ch == 5:
        u.takeChoice(db,cur)
    elif ch == 6:
        m.misc(db,cur)


# Establish database connection
print('Welcome to Fantasy Premier League!!! Enter user credentials to login')
Username=input('Username: ')
Password=gt('Password: ')
db = pymysql.connect(host='localhost', port=3306, user=Username, password=Password, db='FPL', cursorclass=cursors.DictCursor)
if(db.open):
    print('Connected to FPL database')
    input('Press any key to continue...')
else:
    print('Could not establish connection')
    exit()

# Prompt
with db.cursor() as cur:
    while(1):
        tmp = sp.call('clear', shell=True)
        print('1. Schedule upcoming gameweek')
        print('2. Create a team')
        print('3. Create a league')
        print('4. Manage a team')
        print('5. Update details')
        print('6. Miscellaneous')
        print('7. Logout')
        ch=int(input('Enter your choice: '))
        tmp = sp.call('clear', shell=True)

        if ch == 7:
            exit()
        else:
            dispatch(ch)
