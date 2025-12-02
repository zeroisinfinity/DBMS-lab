import mysql.connector

db = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root",
        database="connectMe"
        )
Cursor = db.cursor()

sqlin = "insert into students(name,roll) values('sahil',41)"
Cursor.execute(sqlin)
print(Cursor.rowcount)

sqlup = "update students set roll = 31 where roll=41"
Cursor.execute(sqlup)
print(Cursor.rowcount)

sqldel = "delete from students where roll != 31"
Cursor.execute(sqldel)
print(Cursor.rowcount)

db.commit();
Cursor.close()
db.close()
