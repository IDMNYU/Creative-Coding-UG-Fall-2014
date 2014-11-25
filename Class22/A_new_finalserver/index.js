
//
// HTTP Portion
//

// the grand scheme of things
var http = require('http');
var httpServer = http.createServer(dothestuff);

// port mojo
httpServer.listen(5000);

//
// HTTP Portion - this deals with HTTP requests from everyone's browsers
//

var fs = require('fs'); // Using the filesystem module
var path = require('path'); // Use the path module

// this responds to browsers:
function dothestuff(request, response) {
    console.log('request starting...');

	var filePath = __dirname + request.url;
		console.log("has url:" + request.url);
	if (request.url == "/") {
		filePath = __dirname + "/index.html";
		console.log("providing default: " + filePath);
	}
	var extname = path.extname(filePath);
	var contentType = 'text/html';
	switch (extname) {
		case '.js':
			contentType = 'text/javascript';
			break;
		case '.css':
			contentType = 'text/css';
			break;
	}
	
	fs.exists(filePath, function(exists) {
	
		if (exists) {
			fs.readFile(filePath, function(error, content) {
				if (error) {
					response.writeHead(500);
					response.end();
				}
				else {
					response.writeHead(200, { 'Content-Type': contentType });
					response.end(content, 'utf-8');
				}
			});
		}
		else {
			response.writeHead(404);
			response.end();
		}
	});
}

//
// SOCKET STUFF - this responds to websocket data from the raspberry pi
//

var io = require('socket.io').listen(httpServer);

io.sockets.on('connection', 
	function (socket) {
	
		console.log("We have a new client: " + socket.id);


		socket.on('light', function(data) {
			io.emit('light', data);
		});
		socket.on('sound', function(data) {
			io.emit('sound', data);
		});
		socket.on('humid', function(data) {
			io.emit('humid', data);
		});
		socket.on('tempC', function(data) {
			io.emit('tempC', data);
		});
		socket.on('tempF', function(data) {
			io.emit('tempF', data);
		});
		socket.on('heatI', function(data) {
			io.emit('heatI', data);
		});
		socket.on('proxi', function(data) {
			io.emit('proxi', data);
		});


		socket.on('disconnect', function() {
			console.log("Client has disconnected " + socket.id);
		});
	}
);
