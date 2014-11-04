import processing.video.*;  // this is the video library
import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave; // this is an oscillator


Capture cam; // this represents a camera
PImage last;
int w, h;
float r, g, b;
int firsttime = 1;

float thresh = 30.;

float average;

void setup() { 
  size(800, 450, P3D); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going


  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

    wave = new Oscil( 440., 0.7, Waves.SINE ); // this sets up the oscillator
  wave.patch( out ); // this plugs into the speakers
} 

void draw() { 
  if (cam.available()) { // is there a frame to be read
    background(0);
    cam.read(); // reads a frame
    if (firsttime==1) {
      w = cam.width;
      h = cam.height;
      firsttime = 0;
      last = new PImage(w, h);
    }

    cam.loadPixels();
    last.loadPixels(); // this holds the previous frame
    int howmanypixels = cam.pixels.length;
    average = 0;
    for (int i = 0; i<howmanypixels; i++) { // these are all the pixels
      float src = brightness(cam.pixels[i]);
      float lastsrc = brightness(last.pixels[i]);
      float diff = abs(src-lastsrc);
      if(diff>thresh) diff=255;
      average+=diff; // this is our running average
      cam.pixels[i] = color(diff, diff, diff);
      last.pixels[i] = color(src, src, src);
    }
    cam.updatePixels();
    last.updatePixels();
    image(cam, 0, 0, width, height);

    average = average / float(howmanypixels);
    float freq = map(average, 0., 255., 200., 1000.);
    wave.setFrequency(freq);
  }
} 

