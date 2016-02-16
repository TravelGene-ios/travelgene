/* 
 * RESTful API using Node.js to help IOS APP to connect MongoDB
 * Author: Tony
 * Date: Feb 11, 2016
 */



var express = require('express') 
var app = express()
var mongoose = require('mongoose');
console.log('Load complete');


var db = mongoose.createConnection('mongodb://127.0.0.1:27017/travelgene'); 
db.on('error', function(error) {
    console.log(error);
});

console.log('DB Connected');
var newyorkSchema = new mongoose.Schema({
    category    : {type : String},
    review_count      : {type : String},
    title      : {type : String},
    rating_string      : {type : String}

});

//Create search model to Collection "newyorks"
var mongooseModel = db.model('newyork', newyorkSchema);

//--------------------------------TEST ONLY-----------------------------------

//Restful Get Method, return all elements in newyorks collection TEST ONLY
app.get('/find',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    mongooseModel.find({}, function(err, docs) {
        if (!err){ 
            res.send(docs);
        } else {throw err;}
    });    
})

//Restful Get Method, return specific elements in newyorks collection  TEST ONLY
app.get('/find1',function(req, res){
    console.log('testaa')
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    mongooseModel.find({"review_count":"62084"}, function(err, docs) {
        if (!err){ 
            res.send(docs[0]);
        } else {throw err;}
    });    
})

//Format: /s?num = XX, retrun XX ^ 2   TEST ONLY
app.get('/s',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    var num = req.query['num'];
    var doc = "" + qnum * num
    res.send(doc);
    
})

//Restful Get Method, return specific elements based on the query in newyorks collection  TEST ONLY
app.get('/search',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'});  
    var count = req.query['count'];
    var category = req.query['category'];
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    mongooseModel.find({"review_count":count, "category":category }, function(err, docs) {
        if (!err){ 
            res.send(docs[0]);
        } else {throw err;}
    });

})

//--------------------------------PRODUCTION-----------------------------------

//Home page
app.get('/',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    var doc = "Welcome to TravelGene server, please use specific query"
    res.send(doc);
})

//Exit the app
app.get('/exit',function(req, res){ 
    console.log('Server is closing');
    process.exit();
})

/*
 * Query for Yancheng Liu to use
 * INPUT: City, Category, Count
 * OUTPUT: TOP count attractions of Category in CITY ranked by rating_score
 * EXAMPLE: http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchlyc?count=2&category=spot&city=newyork
 */
app.get('/searchlyc',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 

    var city = req.query['city'];
    var category = req.query['category'];
    var count = req.query['count'];

    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    mongooseModel.find({'category': category}, function(err, docs) {
        if (!err){
            docs = docs.sort(function(a, b){return b.rating_string - a.rating_string})
            var size = docs.length > count ? count : docs.length
            console.log(size);
            doc = [];
            for (i = 0; i < size; i++) {
                doc[i] = docs[i];
            }
            res.send(doc);
        } else {throw err;}
    });
})

console.log("Server is starting on port 8888");
app.listen(8888);
