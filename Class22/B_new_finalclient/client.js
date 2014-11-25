
// web stuff (for later)
var servername = 'http://104.236.36.66:5000'; // digital ocean

//
// serial stuff - read from arduino
//
var portname = '/dev/ttyACM0'; // luke's arduino
var com = require('serialport'); // this is the serial object

var serialPort = new com.SerialPort(portname, {
	baudrate: 9600,
	parser: com.parsers.readline('\r\n')
});

// start cookin'
serialPort.on('open', function() {
	console.log('SERIAL PORT OPENED!!!!!');
});

// data is coming in
serialPort.on('data', function(data) {
	parseData(data);
});

function parseData(d)
{
//	console.log(d); // this our feel good move

	// parse the crap
	var elements = d.split(" "); // split up the data
	// send stuff over the web socket to the server:
	socket.emit('light', elements[0]);
	socket.emit('sound', elements[1]);
	socket.emit('humid', elements[2]);
	socket.emit('tempC', elements[3]);
	socket.emit('tempF', elements[4]);
	socket.emit('heatI', elements[5]);
	socket.emit('proxi', elements[6]);

	sio.emit('light', elements[0]);
	sio.emit('sound', elements[1]);
	sio.emit('humid', elements[2]);
	sio.emit('tempC', elements[3]);
	sio.emit('tempF', elements[4]);
	sio.emit('heatI', elements[5]);
	sio.emit('proxi', elements[6]);

}

//
// networking stuff - socket.io
//

// get the server up and running:
var io = require('socket.io-client');
var socket = io.connect(servername);
// this runs when we connect:
socket.on('connect', function() {
	// test message - hello
	console.log('WE HAVE A CONNECTION');
	socket.emit('hello', 12345678910);
});

//
//
// local web server
//
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
var path = require('path');

// this responds to browsers:
function dothestuff(request, response) {
    console.log('request starting...');

	var filePath = __dirname + request.url;
		console.log("explicit url:" + request.url);
	if (request.url == "/") {
		filePath = __dirname + "/index.html";
		console.log("default url: " + filePath);
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

var sio = require('socket.io').listen(httpServer);

sio.sockets.on('connection', 
	function (socket) {
	
		console.log("We have a new client: " + socket.id);

		socket.on('disconnect', function() {
			console.log("Client has disconnected " + socket.id);
		});
	}
);


