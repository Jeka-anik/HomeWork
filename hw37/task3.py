import json
import mysql.connector
from mysql.connector import Error

myfile = open('users.json', mode='r', encoding='Latin-1')
json_data = json.load(myfile)
# print(json_data)
user1 = json_data["userList"]["users"][0]["userName"]
user2 = json_data["userList"]["users"][1]["userName"]

print(user1, user2)


def connect():
    """ Connect to MySQL database """
    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='shop',
                                       user='god',
                                       password='123')
        if conn.is_connected():
            print('Connected to MySQL database')
        cur = conn.cursor()
        # cur.execute("select * from cart")
        # cur.execute("select price from cart where name=%s", (user2,))
        # cur.execute("select price from cart where name=%s", (user1,))
        table = cur.execute("select * from cart")
        # print(table)
        print(type(table))
        for line in cur.fetchall():
            if line[1] == user1:
                print(str(user1) + " potracheno: " + str(line[3]))
            elif line[1] == user2:
                print(str(user2) + " potracheno: " + str(line[3]))
            else :
                print("ololo")
           
    except Error as e:
        print(e)

    finally:
        conn.close()

if __name__ == '__main__':
    connect()
    
