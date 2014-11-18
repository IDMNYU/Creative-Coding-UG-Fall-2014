
// web stuff (for later)
var servername = 'http://localhost:5000'; // this is our server name


//
// networking stuff - socket.io
//

var io = require('socket.io-client');
var socket = io.connect(servername);
// this runs when we connect:
socket.on('connect', function() {
	console.log('WE HAVE A CONNECTION');
	socket.emit('hello', 12345678910);

});
