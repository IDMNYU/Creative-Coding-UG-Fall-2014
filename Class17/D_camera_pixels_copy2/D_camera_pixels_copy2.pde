import processing.video.*;  // this is the video library

Capture cam; // this represents a camera
PImage destination; // this is what we're gonna write into
int w, h;
float r, g, b;
int firsttime = 1;

void setup() { 
  size(640, 360); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going
} 

void draw() { 
  if (cam.available()) { // is there a frame to be read
    cam.read(); // reads a frame
    if (firsttime==1) {
      w = cam.width;
      h = cam.height;
      destination = new PImage(w, h);
      firsttime = 0;
    }
  } 
  if (firsttime==0) {
    cam.loadPixels();
    int destpixels = destination.pixels.length;
    for (int i = 0; i<h; i++) { // these are all the rows
      for (int j = 0; j<w; j++) { // these are all the columns
        int xpos = (j+mouseX)%w;
        int ypos = (i+mouseY)%h;

        color src = cam.pixels[ypos*w + xpos]; // src pixel
        destination.pixels[i*w + j] = src;
      }
    }
    destination.updatePixels(); // update picture texture
    image(destination, 0, 0, 640, 360); // draw the frame
  }
} 

