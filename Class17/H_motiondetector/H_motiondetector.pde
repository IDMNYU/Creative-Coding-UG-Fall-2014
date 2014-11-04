import processing.video.*;  // this is the video library
import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave1, wave2, wave3, wave4; // this is an oscillator


Capture cam; // this represents a camera
PImage last;
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
    for (int i = 0; i<howmanypixels; i++) { // these are all the pixels
      float src = brightness(cam.pixels[i]);
      float lastsrc = brightness(last.pixels[i]);
      float diff = abs(src-lastsrc);
      if (diff>thresh) diff=255;
      average+=diff; // this is our running average
      cam.pixels[i] = color(diff, diff, diff);
      last.pixels[i] = color(src, src, src);
    }
    cam.updatePixels();
    last.updatePixels();
    image(cam, 0, 0, width, height);

    average = average / float(howmanypixels);
    if (average>30.)
    {
      if (on==0)
      {
        wave1.setFrequency(mtof(60+villain_offset));
        wave1.setFrequency(mtof(63+villain_offset));
        wave1.setFrequency(mtof(66+villain_offset));
        wave1.setFrequency(mtof(69+villain_offset));
        villain_offset = (villain_offset+3)%12;
      }
      wave1.setAmplitude(0.2);
      wave2.setAmplitude(0.2);
      wave3.setAmplitude(0.2);
      wave4.setAmplitude(0.2);
      on = 1;
    } else
    {
      wave1.setAmplitude(0);
      wave2.setAmplitude(0);
      wave3.setAmplitude(0);
      wave4.setAmplitude(0);
      on = 0;
    }
  }
} 



float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

