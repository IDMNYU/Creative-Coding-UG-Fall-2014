
var mysize = 40;
var bd, sd, oh, ch, steve;

var bd_playing, sd_playing, oh_playing, ch_playing, steve_playing;


function preload()
{
  bd = loadSound('BD.mp3');
  sd = loadSound('SD.mp3');
  oh = loadSound('OH.mp3');
  ch = loadSound('CH.mp3');
  steve = loadSound('SJ.mp3');
}

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(640, 480); 
  rectMode(CENTER);

  bd_playing = false;
  sd_playing = false;
  oh_playing = false;
  ch_playing = false;
  steve_playing = false;

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
  if(key=='A' && bd_playing==false) {
    bd.play();
    bd_playing = true;
  }
  else if(key=='D' && sd_playing==false) {
    sd.play();
    sd_playing = true;
  }
  else if(key=='S' && ch_playing==false) {
    ch.play();
    ch_playing = true;
  }
  else if(key=='F' && oh_playing==false) {
    oh.play();
    oh_playing = true;
  }
  else if(key=='J' && steve_playing==false) {
    println("PLAYING");
    steve.play();
    steve_playing = true;
  }

}

function keyReleased()
{
  if(key==' ') background(255);
  else if(key=='a' && bd_playing==true) {
    bd.stop();
    bd_playing = false;
  }
  else if(key=='d' && sd_playing==true) {
    sd.stop();
    sd_playing = false;
  }
  else if(key=='s' && ch_playing==true) {
    ch.stop();
    ch_playing = false;
  }
  else if(key=='f' && oh_playing==true) {
    oh.stop();
    oh_playing = false;
  }
  else if(key=='j' && steve_playing==true) {
    steve.stop();
    steve_playing = false;
  }



}