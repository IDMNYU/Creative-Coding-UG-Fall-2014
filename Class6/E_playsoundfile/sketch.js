
var mysize = 40;
var thesound;

var playing = false;

function preload()
{
  thesound = loadSound('SJ.mp3');
}

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(640, 480); 
  rectMode(CENTER);

}

function draw() {
  // put drawing code here

 
  stroke(255, 0, 0);
  fill(0, 0, 255, 50);
  rect(mouseX, mouseY, mysize, mysize);
  mysize = mysize + 5;
  //println(mysize);
  if(mysize > 40) mysize=0;

}

function keyPressed()
{
  if(playing==false) {
    thesound.play();
    playing = true;
  }

}

function keyReleased()
{
  if(key==' ') background(255);
  if(playing==true) {
    thesound.stop();
    playing = false;
  }


}