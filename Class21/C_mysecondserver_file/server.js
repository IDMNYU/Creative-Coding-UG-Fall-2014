// includes the http node library and makes an object using it:
var http = require('http'); 

// includes the filesystem node library and makes an object using it:
var fs = require('fs');

// this creates the server - when stuff comes in call dothestuff()
// listen on port 1337 on the localhost
http.createServer(dothestuff).listen(1337, '127.0.0.1');

// this runs when you do the stuff
function dothestuff(req, res)
{
	fs.readFile(__dirname + '/index.html',
		function(err, data) {
			if(err) { // this means we screwed up
				res.writeHead(500); // bad mojo
				return res.end('oops!');
			}
			res.writeHead(200, {'Content-Type': 'text/html'});
		  	res.end(data);
		});

}

// print out that we're up and running:
console.log('Server running at http://127.0.0.1:1337/ !!!!!');