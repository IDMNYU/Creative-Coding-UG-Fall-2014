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
    int howmanypixels = cam.pixels.length;
    int destpixels = destination.pixels.length;
    destination.loadPixels();
    for (int i = 0; i<howmanypixels; i++) {
      int srcpos = constrain(i + int(random(-80, 80)), 0, howmanypixels-1);
      color src = cam.pixels[srcpos]; // pick a random src pixel
      destination.pixels[i] = src;
    }
    destination.updatePixels(); // update picture texture
    image(destination, 0, 0, 640, 360); // draw the frame
  }
} 

