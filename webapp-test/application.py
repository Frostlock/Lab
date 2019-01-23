from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Frostlocks Github!<br>This is a simple Flask web app from a subfolder in my Github repository.<br>V3.0"
