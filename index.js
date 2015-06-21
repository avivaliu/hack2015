var express = require('express');
var fs = require('fs');
var bodyParser = require('body-parser');
var fileHandler = require('./fileHandler.js');

var app = express();
var newsfeed, details;
//data
fs.readFile('data/newsfeed.json','utf8',function(err, data){
	if(err){
		return console.log(err);
	}newsfeed = JSON.parse(data);
});
fs.readFile('data/detail_hk01.json','utf8',function(err, data){
	if(err){
		return console.log(err);
	}details = JSON.parse(data);
});
 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

//app
app.get('/newsfeed', function(req, res) {
    res.json(newsfeed);
});
app.get('/details/:id', function(req, res) {
    res.json(details);
});
app.post('/composer/:tripname', function(req, res){
	res.json(req.body);
});

app.listen(3000);
