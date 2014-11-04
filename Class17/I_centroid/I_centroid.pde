import processing.video.*;  // this is the video library
import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave1, wave2, wave3, wave4; // this is an oscillator


Capture cam; // this represents a camera
PImage last;
float sumx, sumy;
int w, h;
float r, g, b;
int firsttime = 1;

float thresh = 30.;

float average;

int on = 0;
int villain_offset = 0;

void setup() { 
  size(800, 450, P3D); // WIDESCREEN
  cam = new Capture(this); // this makes a new camera object
  cam.start(); // this starts the camera going


  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

    wave1 = new Oscil( mtof(60), 0.0, Waves.SAW ); // this sets up the oscillator
  wave2 = new Oscil( mtof(63), 0.0, Waves.SAW ); // this sets up the oscillator
  wave3 = new Oscil( mtof(66), 0.0, Waves.SAW ); // this sets up the oscillator
  wave4 = new Oscil( mtof(69), 0.0, Waves.SAW ); // this sets up the oscillator
  wave1.patch( out ); // this plugs into the speakers
  wave2.patch( out ); // this plugs into the speakers
  wave3.patch( out ); // this plugs into the speakers
  wave4.patch( out ); // this plugs into the speakers
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
    sumx = 0;
    sumy = 0;
    for (int i = 0; i<howmanypixels; i++) { // these are all the pixels
      int xpos = i%w;
      int ypos = i/w;
      float src = brightness(cam.pixels[i]);
      float lastsrc = brightness(last.pixels[i]);
      float diff = abs(src-lastsrc);
      if (diff>thresh) {
        diff=255;
        sumx += xpos;
        sumy += ypos;
        average+=1.; // this is our running average
      } else
      {
        // do nothing
      }
      cam.pixels[i] = color(diff, diff, diff);
      last.pixels[i] = color(src, src, src);
    }

    cam.updatePixels();
    last.updatePixels();
    image(cam, 0, 0, width, height);

    average = average / float(howmanypixels);
    sumx = sumx / float(howmanypixels);
    sumy = sumy / float(howmanypixels);

    float centroid_x = sumx/average;
    float centroid_y = sumy/average;
    println(centroid_x + ": " + centroid_y);
    fill(255, 0, 0);
    centroid_x = map(centroid_x, 0, w, 0, width);
    centroid_y = map(centroid_y, 0, h, 0, height);
    ellipse(centroid_x, centroid_y, 50, 50);
  }
} 



float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

