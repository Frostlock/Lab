from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Frostlocks Github!<br> This is a subfolder :) <br> V2.2"
