#!/bin/python3

from flask import Flask
from flask import render_template
from flask import request
import requests
import json
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)

@app.route("/hello")
def hello_world():
    return "<p>Hello, World!</p>"

def get_api_external():
    url = "https://v2.jokeapi.dev/joke/Programming?safe-mode&type=single"
    response = json.loads(requests.request("GET", url).text)
    value = response["joke"]
    value2 = response["category"]
    return value, value2

@app.route("/")
def api_external_page():
    val, val2 = get_api_external()
    ip = request.remote_addr
    header_host = request.headers.get('Host')
    return render_template("external_api.html", val=val, val2=val2, ip=ip, header_host=header_host)

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)

if __name__ == '__main__':
    app.run("127.0.0.1", port=5000)
