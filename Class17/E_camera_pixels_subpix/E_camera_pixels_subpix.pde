import processing.video.*;  // this is the video library

Capture cam; // this represents a camera
int w, h;
float r, g, b;
int firsttime = 1;

float average;

void setup() { 
  size(800, 450, P3D); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going
} 

void draw() { 
  background(0);
  
  if (cam.available()) { // is there a frame to be read
    cam.read(); // reads a frame
    if (firsttime==1) {
      w = cam.width;
      h = cam.height;
      firsttime = 0;
    }
  } 
  if (firsttime==0) {
    cam.loadPixels();
    for (int i = 0; i<h; i+=40) { // these are all the rows
      for (int j = 0; j<w; j+=40) { // these are all the columns
        int xpos = j%w;
        int ypos = i%h;
        color src = cam.pixels[ypos*w + xpos]; // src pixel
        float luma = brightness(src);
        float xout = map(j, 0, w, 0, width);
        float yout = map(i, 0, h, 0, height);
        float turn = map(luma, 0, 255, PI, 0);
        pushMatrix();
        translate(xout, yout);
        rotateX(turn);
        rect(0, 0, 15, 15);
        popMatrix();
      }
    }
  }
} 

