
var mysize = 40;
var thesound = new Array(4);

var playing = false;

function preload()
{
  for(var i = 0;i<thesound.length;i++)
  {
    thesound[i] = loadSound('SJ.mp3');
  }

}

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(640, 480); 
  rectMode(CENTER);

  for(var i = 0;i<thesound.length;i++)
  {
   thesound[i].setVolume(0.25);
  }

}

function draw() {
  // put drawing code here

 
  stroke(255, 0, 0);
  fill(0, 0, 255, 50);
  rect(mouseX, mouseY, mysize, mysize);
  mysize = mysize + 5;
  //println(mysize);
  if(mysize > 40) mysize=0;
  var rate;
  for(var i = 0;i<thesound.length;i++)
  {
    rate = map(mouseX, 0, width, -(i+1), i+1);
    thesound[i].rate(rate);

  }
}

function keyPressed()
{
}

function keyReleased()
{
  if(key==' ') background(255);
  if(playing==true) {
  for(var i = 0;i<thesound.length;i++)
  {
    thesound[i].pause();
  }
    playing = false;
  }
  else if(playing==false) {
  for(var i = 0;i<thesound.length;i++)
  {
    thesound[i].play();
  }
    playing = true;
  }




}