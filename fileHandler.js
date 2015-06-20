'use strict';
var fs = require('fs');
var crypto = require('crypto');
var mkdirp = require('mkdirp');
module.exports = {
	write: function(content, tripname) {
		mkdirp('data/'+ tripname, function(err) { 
		});
		var filename  = crypto.randomBytes(20).toString('hex');
		fs.writeFile('data/'+tripname +'/'+ filename + '.json', JSON.stringify(content, null, 4), function(err) {
		    if(err) {
		      console.log(err); 
		    } else {
		     console.log("JSON saved to " + filename);
		    }
		}); 
	}
}