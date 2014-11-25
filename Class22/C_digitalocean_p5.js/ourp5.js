
var socket = io();
socket.on('light', function(msg){
  $('#light').html(msg);
});
socket.on('sound', function(msg){
  $('#sound').html(msg);
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
  if (mouseIsPressed) {
    fill(0);
  } else {
    fill(255);
  }
  ellipse(mouseX, mouseY, 80, 80);
}


