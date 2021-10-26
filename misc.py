import subprocess as sp








import time
def sponsorDetails(db,cur):
    print("OH")
    query='SELECT * FROM CATEGORY'
    cur.execute(query)
    db.commit()

    dict = cur.fetchall()

    for row in dict:
        print(row)
        
    time.sleep(10)



def viewForm(db,cur):
    player_name = input('Enter the name of the player whose form is to be viewed: ')
    #query='SELECT Shots_on_target FROM FORWARD WHERE FORWARD.Player_name= %s UNION SELECT `Chances Created` FROM MIDFIELDER WHERE MIDFIELDER.Player_name= %s UNION SELECT Tackles FROM DEFENDER WHERE DEFENDER.Player_name= %s UNION SELECT Saves FROM KEEPER WHERE KEEPER.Player_name= %s;' % (player_name, player_name,player_name,player_name)
    query = 'SELECT Shots_on_target FROM FORWARD WHERE FORWARD.Player_name=  "%s" UNION SELECT `Chances Created` FROM MIDFIELDER WHERE MIDFIELDER.Player_name= "%s" UNION SELECT Tackles FROM DEFENDER WHERE DEFENDER.Player_name= "%s" UNION SELECT Saves FROM KEEPER WHERE KEEPER.Player_name= "%s";' % (player_name, player_name, player_name, player_name)

    cur.execute(query)
    db.commit()

    dict=cur.fetchall()

    for row in dict:
        print(" Form indicator ", dict[0] )
    time.sleep(10)
        



def deleteSponsor(db,cur):
    player_name = input('Enter the name of the sponsor to be deleted: ')
    
    query_1='DELETE FROM CATEGORY WHERE `Partner_name` = %s' % (partner_name)
    cur.execute(query)
    db.commit()
    query_2='DELETE FROM SPONSORS WHERE `Partner_name` = %s' % (partner_name)
    cur.execute(query_2)
    db.commit()
    query_3='DELETE FROM PARTNER1 WHERE `Name` = %s' % (partner_name)
    cur.execute(query_3)
    db.commit()



def misc(db,cur):
    print('1. Obtain sponsor details')
    print('2. View Player`s form')
    print('3. Delete a sponsor')
    



    choice=int(input('Enter your choicee: '))
    if choice == 1:
        print("OH")
        sponsorDetails(db,cur)
    elif choice == 2:
        viewForm(db,cur)
    elif choice == 3:
        deleteSponsor(db,cur)
    
