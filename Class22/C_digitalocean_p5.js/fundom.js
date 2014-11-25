
var light = 0;
var sound = 0;

var lightangle = 0.;
var soundangle = 3.14159265358979323846;

var socket = io();
socket.on('light', function(msg){
  light = msg;
});
socket.on('sound', function(msg){
  sound = msg;
});

var socketback = io.connect('http://lukepi.magnet.nyu.edu:5000/');
socketback.on('connect', function() {
  console.log("Connected back");
});



var lightdiv, sounddiv;

var button;

function setup() {
  lightdiv = createDiv("hi there");
  sounddiv = createDiv("it's me");

  button = createButton('BLINK!');
  button.position(320, 240);
  button.mousePressed(doblink);

}

function draw() {

  var lightsize = Math.floor(light)+"px";
  lightdiv.style("font-size", lightsize);
  var soundsize = Math.floor(sound*10.)+"px";
  sounddiv.style("font-size", soundsize);

  lightdiv.position(winMouseX+50*cos(lightangle), winMouseY+50*sin(lightangle));
  lightdiv.html(light);
  sounddiv.position(winMouseX+50*cos(soundangle), winMouseY+50*sin(soundangle));
  sounddiv.html(sound);

  lightangle = (lightangle + (light/100.))%(2*3.14159265358979323846);
  soundangle = (soundangle - (sound/10.))%(2*3.14159265358979323846);
}

function doblink()
{
  console.log("blinked!!!!");
  socketback.emit('blink', 12345);

}


