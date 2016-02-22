from flask import Flask, render_template, session, redirect, url_for, escape, request
from flask.ext.cors import CORS

from flask.ext.pymongo import PyMongo
app = Flask(__name__)
mongo = PyMongo(app)
# mongolocal=PyMongo(app)

import backend