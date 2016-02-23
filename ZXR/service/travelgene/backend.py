from travelgene import mongo
from flask import Flask, render_template, session, redirect, url_for, escape, request, jsonify
import json
import flask_debugtoolbar
from travelgene import app
from flask_debugtoolbar import DebugToolbarExtension
from flask.ext.cors import CORS
from bson import json_util
import json

import monkapi
import testmonk



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

@app.route('/mongodb_connection_test',methods=['GET'])
def connect_mongodb_test():
    # print app.name

    city = request.args.get('city')

    category = request.args.get('category')
    count = request.args.get('count')
    print city, category, count

    # zhe = mongo.db['newyorks'].find_one()
    # print zhe
    result_dict = mongo.db[city].find({'category' : category})[0 : int(count)]


    # result_json = jsonify(serialize(result))



    for item in result_dict:
        result_dict.append(json.dumps(item, default=json_util.default))

    return '{"result" :[' + result_dict.join(",") + "]}"


# Author: Qiankun
@app.route('/testmonk', methods=['POST'])
def monktest():
    monkapi.init_monk()

    monkapi.init_database()

    title = request.form['title']
    entity_id = request.form['entity_id']
    value = request.form['value']

    entity_id = "56ba83ba768b7d425adc9969"
    monkapi.add_label("56ba83ba768b7d425adc9969", "likeTravel", "Y")
    newlist = monkapi.update_recommended_place(title, entity_id, value)
    for i in newlist:
        print newlist

    # monkapi.add_label(monkapi.get_entity_id("newyorks","Seattle_00000002"), "likeTravel", "Y")
    # monkapi.add_label(monkapi.get_entity_id("newyorks","Seattle_00000003"), "likeTravel", "Y")

    return







