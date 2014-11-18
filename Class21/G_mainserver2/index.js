
// SOME VARIABLES TO HOLD THINGS
var lightValue = 0;
var soundValue = 0;
var humidity = 0;
var celsius = 0;
var fahrenheit = 0;
var heatIndex = 0;
var proximityValue = 0;

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

	var data = '';
	data+='<html><body>';

	data+='Light: ';
	data+=lightValue;
	data+='<br>';

	data+='Sound: ';
	data+=soundValue;
	data+='<br>';

	data+='Humidity: ';
	data+=humidity;
	data+='<br>';

	data+='Temp (C): ';
	data+=celsius;
	data+='<br>';

	data+='Temp (F): ';
	data+=fahrenheit;
	data+='<br>';

	data+='Heat Index: ';
	data+=heatIndex;
	data+='<br>';

	data+='Proximity Sensor: ';
	data+=proximityValue;
	data+='<br>';

	data+='</body></html>';

	res.end(data);
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


		socket.on('light', function(data) {
			lightValue = data;
		});
		socket.on('sound', function(data) {
			soundValue = data;
		});
		socket.on('humid', function(data) {
			humidity = data;
		});
		socket.on('tempC', function(data) {
			celsius = data;
		});
		socket.on('tempF', function(data) {
			fahrenheit = data;
		});
		socket.on('heatI', function(data) {
			heatIndex = data;
		});
		socket.on('proxi', function(data) {
			proximityValue = data;
		});

		socket.on('disconnect', function() {
			console.log("CLIENT DEAD: " + socket.id);
		});


});

