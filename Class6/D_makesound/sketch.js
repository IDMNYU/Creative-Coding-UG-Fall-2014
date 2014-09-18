
var mysize = 40;
var thesound;
var playing;

function preload()
{

}

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(640, 480); 
  rectMode(CENTER);
  thesound = new p5.Oscillator('sine');
  thesound.freq(440.);
  thesound.amp(1.);
  thesound.start();
  playing = false;

}

function draw() {
  // put drawing code here

  // fix the sound
  thesound.amp(1.0-mouseY/height);
  thesound.freq(500+mouseX/width*1000.);


  stroke(255, 0, 0);
  fill(0, 0, 255, 50);
  rect(mouseX, mouseY, mysize, mysize);
  mysize = mysize + 5;
  //println(mysize);
  if(mysize > 40) mysize=0;

}

function keyReleased()
{
  if(key==' ') background(255);
  else if(key=='s') {
    playing = !playing;
    if(playing) thesound.connect();
    else thesound.disconnect();
  }


}