import processing.video.*;  // this is the video library

Capture cam; // this represents a camera
 
void setup() { 
  size(640, 360); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going
} 
 
void draw() { 
  if (cam.available()) { // is there a frame to be read
    cam.read(); // reads a frame
  } 
  image(cam, 0, 0, 640, 360); // draw the frame
} 
 
