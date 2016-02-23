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
    name      : {type : String},
    rating_string      : {type : String}

});
var reviewSchema = new mongoose.Schema({
    city    : {type : String},
    spot      : {type : String},
    name      : {type : String},
    content      : {type : String}

});
var EmptySchema = new mongoose.Schema({
    title      : {type : String}
});


var mongooseModel = db.model('newyork', EmptySchema);
var newyorkModel = db.model('newyork', EmptySchema);
var hotelModel = db.model('newyorkhotel', EmptySchema);
var reviewModel = db.model('review', newyorkSchema);
var reviewtestModel = db.model('reviewtest', reviewSchema);



console.log("test");
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
//Restful Get Method, return specific elements based on the query in newyorks collection  TEST ONLY
app.get('/testjson',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 

    var city = req.query['city'];
    var category = req.query['category'];
    var count = req.query['count'];

    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    mongooseModel.find({'category': category},'-_id', function(err, docs) {
        if (!err){
            docs = docs.sort(function(a, b){return b.rating_string - a.rating_string})
            var size = docs.length > count ? count : docs.length
            console.log(size);
            doc = [];
            for (i = 0; i < size; i++) {
                doc[i] = docs[i];
            }
            obj = new Object;
            obj ={"result":doc}
            res.send(obj);
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


//-------------------------- Queries for Yancheng Liu to use  -------------------
/*
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
    mongooseModel.find({'category': category},'-_id', function(err, docs) {
        if (!err){
            docs = docs.sort(function(a, b){return b.rating_string - a.rating_string})
            var size = docs.length > count ? count : docs.length
            console.log(size);
            doc = [];
            for (i = 0; i < size; i++) {
                doc[i] = docs[i];
                console.log(docs[i].rating_string);
            }
            obj = new Object;
            obj ={"result":doc}
            res.send(obj);
        } else {throw err;}
    });
})




//-------------------------- Queries for Chenyang Ran to use  -------------------
/*
 * INPUT: City, Category, Count
 * OUTPUT: TOP count attractions of Category in CITY ranked by rating_score
 * EXAMPLE: http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchlyc?count=2&category=spot&city=newyork
 */
app.get('/searchreviews',function(req, res){

    var spot = req.query['spot'];
    var count = req.query['count'];
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    reviewtestModel.find({'spot': spot},'-_id', function(err, docs) {
        if (!err){           
            var size = docs.length > count ? count : docs.length
            console.log(size);
            doc = [];
            for (i = 0; i < size; i++) {
                doc[i] = docs[i];       
            }
            obj = new Object;
            obj ={"result":doc}
            res.send(obj);
            //res.send(doc);
        } else {throw err;}
    });
})

/*
 * INPUT: City, Category, Count
 * OUTPUT: TOP count attractions of Category in CITY ranked by rating_score
 * EXAMPLE: http://ec2-52-90-95-189.compute-1.amazonaws.com:8080/insertreview?count=1&spot=card2&city=newyork&name=peter&content=jajajaja
 */
app.get('/insertreview',function(req, res){

    var spot = req.query['spot'];
    var city = req.query['city'];
    var name = req.query['name'];
    var content = req.query['content'];

    var thor = new reviewtestModel({
        spot: spot,
        city: city, 
        name: name,
        content: content
    });

    thor.save(function(err, thor) {
        if (err) return console.error(err);
        console.log(thor);
    });
    console.log("ok");
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    res.send("ok");
})



//-------------------------- Queries for Zhiyue Liu to use  -------------------
/*
 * INPUT: City, Count
 * OUTPUT: TOP count  in CITY ranked by rating_score
 * EXAMPLE: http://ec2-52-90-95-189.compute-1.amazonaws.com:8888/searchlyc?count=2&city=newyork
 */
app.get('/searchhotel',function(req, res){
    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 

    var city = req.query['city'];
    var category = 'hotel';
    var count = req.query['count'];

    res.set({'Content-Type':'text/json', 'Encodeing':'utf8'}); 
    hotelModel.find({'category': category},'-_id', function(err, docs) {
        if (!err){
            docs = docs.sort(function(a, b){return parseFloat(b.rating_string) - parseFloat(a.rating_string)})
            var size = docs.length > count ? count : docs.length
            console.log(size);
            doc = [];
            for (i = 0; i < size; i++) {
                doc[i] = docs[i];
                console.log(docs[i].rating_string);
            }
            obj = new Object;
            obj ={"result":doc}
            res.send(obj);
        } else {throw err;}
    });
})









console.log("Server is starting on port 8080");
app.listen(8080);
