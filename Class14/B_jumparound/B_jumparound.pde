import processing.video.*; // import the movie stuff

Movie mov; // this is the movie object

void setup() {
  size(640, 480); // the right size
  background(0); // we don't really have to do this
  mov = new Movie(this, "gossip.mp4"); // duck and cover
  mov.play(); // start playing
  mov.jump(0); // rewind to the beginning
}

void draw() {
  if (mov.available()) { // check to see if there's new video data
    mov.read(); // copy the current frame to an internal PImage
  }  
  image(mov, 0, 0, width, height); // draw it to the screen
}

void keyReleased()
{
  if(key=='a') mov.jump(5);
  if(key=='s') mov.jump(32);
  if(key=='d') mov.jump(145);
  if(key=='f') mov.jump(237.5);
  if(key=='g') mov.jump(402.678);
  if(key=='h') mov.jump(386.1);
  if(key=='j') mov.jump(289.9);
  if(key=='k') mov.jump(55.2);
  if(key=='l') mov.jump(444);
  
}

