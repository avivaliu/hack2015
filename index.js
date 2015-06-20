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
	}newsfeed = data;
});
fs.readFile('data/detail_hk01.json','utf8',function(err, data){
	if(err){
		return console.log(err);
	}details = data;
});
 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

//app
app.get('/newsfeed', function(req, res) {
    res.send(newsfeed);
});
app.get('/details/:id', function(req, res) {
    res.send(details);
});
app.post('/composer/:tripname', function(req, res){
	fileHandler.write(req.body, req.params.tripname)
	res.json(req.body);
});

app.listen(3000);
