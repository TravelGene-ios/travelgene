from travelgene import mongo
from flask import Flask, render_template, session, redirect, url_for, escape, request, jsonify
import json
import flask_debugtoolbar
from travelgene import app
from flask_debugtoolbar import DebugToolbarExtension
from flask.ext.cors import CORS

# import monkapi
# import testmonk



cors = CORS(app)

from flask_oauth import OAuth




@app.route('/',methods=['GET'])
def root():
    print "root"
    return "yeah"

@app.route('/test',methods=['POST'])
def hello_world():
    city = request.form['city']
    category = request.form['category']
    count = request.form['count']

    print city

    print app.name
    # print mongo.db.Seattle.find_one()
    return "abc"

@app.route('/mongodb_connection_test',methods=['POST'])
def connect_mongodb_test():
    # print app.name

    city = request.form['city']
    category = request.form['category']
    count = request.form['count']


    result = mongo.db['newyorks'].find_one({'category' : category, 'city' : city, 'count' : count})

    return result


# Author: Qiankun
# @app.route('/testmonk.html')
# def monktest():
#     monkapi.init_monk()
#
#     monkapi.init_database()
#
#     monkapi.add_label(monkapi.get_entity_id("Kirkland","Kirkland_00000000"), "place_type", "restaurant")
#
#     return
#




