from flask import Flask
from database.MonsterDB import Monster, MonsterDB

app = Flask(__name__)

MDB = MonsterDB()

@app.route("/")
def hello():
    return "This is the Monster Flask."

@app.route('/database/<monsterName>')
def monster(monsterName):
    return str(MDB.search(monsterName))


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)