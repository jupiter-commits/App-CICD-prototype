#!/bin/python3

from flask import Flask
from flask import render_template
from flask import request
import requests
import json

app = Flask(__name__)

@app.route("/hello")
def hello_world():
    return "<p>Hello, World!</p>"
