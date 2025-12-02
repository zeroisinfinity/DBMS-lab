from pymongo import MongoClient

client = MongoClient("mongodb://127.0.0.1:27017")
database = client.connetme
col = database.trial

col.insert_one({"roll" : "21" , "name" : "sahil"})
print("inserted")
col.update_one({"roll" : "21" } , {"$set" : { "name" : "rohit"}}) 
print("updated")
col.delete_one({"roll" : "21"})
print("delete")

client.close()
