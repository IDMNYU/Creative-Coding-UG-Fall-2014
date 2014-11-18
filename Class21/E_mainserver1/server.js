
//
// THIS IS THE WEB SERVICE
//

var http = require('http');

// this is the GUTS of the server:
var httpServer = http.createServer(dothestuff);

// process.env.PORT is some heroku magic crap
httpServer.listen(5000);


function dothestuff(req, res)
{
	console.log("GOT WEB REQUEST!!!");
	// this is the HTTP header block (200 is all is good):
	res.writeHead(200, {'Content-Type': 'text/html'}); 
	res.end('<html><body><b>AWESOME</b> <i>GROOVINESS</i></body></html>');
}

console.log('Server is running.  Long live the server.');

//
// THIS IS THE SOCKET SERVICE
//

var io = require('socket.io').listen(httpServer);

io.sockets.on('connection',
	function(socket) {
		console.log("WE GOT A CLIENT REQUEST!!!!" + socket.id);
		socket.on('hello', function(data) {
			console.log("hello back: " + data);
		});

		socket.on('disconnect', function() {
			console.log("CLIENT DEAD: " + socket.id);
		});


});

