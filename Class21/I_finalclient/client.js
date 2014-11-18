
// web stuff (for later)
//var servername = 'http://localhost:5000'; // this is our server name
var servername = 'http://104.236.36.66:5000'; // digital ocean

//
// serial stuff - read from arduino
//
var portname = '/dev/tty.usbmodem1411'; // luke's arduino
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
	console.log(d); // this our feel good move

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
