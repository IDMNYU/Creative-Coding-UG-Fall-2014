import processing.video.*;  // this is the video library

Capture cam; // this represents a camera
 float r, g, b;
void setup() { 
  size(640, 360); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going
} 
 
void draw() { 
  if (cam.available()) { // is there a frame to be read
    cam.read(); // reads a frame
  } 
  cam.loadPixels();
  for(int i = 0;i<cam.pixels.length;i++)
  {
    r = red(cam.pixels[i]);
    g = red(cam.pixels[i]);
    b = red(cam.pixels[i]);
    cam.pixels[i] = color(g, g, g);
  }
  cam.updatePixels();
  image(cam, 0, 0, 640, 360); // draw the frame
} 
 
