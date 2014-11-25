
var light = 0;
var sound = 0;

var socket = io();
socket.on('light', function(msg){
  light = msg;
});
socket.on('sound', function(msg){
  sound = msg;
});
socket.on('humid', function(msg){
  $('#humid').html(msg);
});
socket.on('tempC', function(msg){
  $('#tempC').html(msg);
});
socket.on('tempF', function(msg){
  $('#tempF').html(msg);
});
socket.on('heatI', function(msg){
  $('#heatI').html(msg);
});
socket.on('proxi', function(msg){
  $('#proxi').html(msg);
});

function setup() {
  createCanvas(640, 480);
}

function draw() {
  background(255);
  var red = map(sound, 0, 10, 0, 255);
  fill(red, 0, 0);

  ellipse(mouseX, mouseY, light, light);
}


