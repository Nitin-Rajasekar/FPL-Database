import pymysql
import pymysql.cursors as cursors
import subprocess as sp
import insert as i
import team as t

# Main driver function
def dispatch(ch):
    if ch == 1:
        i.scheduleGW(db,cur)
    elif ch == 2:
        t.manageTeam(db,cur)
    #elif ch == 3:


# Establish database connection
print('Welcome to Fantasy Premier League!!! Enter user credentials to login')
Username=input('Username: ')
Password=input('Password: ')
db = pymysql.connect(host='localhost', port=3306, user='FPLadmin', password='FPL@admin@123', db='FPL', cursorclass=cursors.DictCursor)
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
        print('2. Manage a team')
        print('3. Update details')
        print('4. Logout')
        ch=int(input('Enter your choice: '))
        tmp = sp.call('clear', shell=True)

        if ch == 4:
            exit()
        else:
            dispatch(ch)
