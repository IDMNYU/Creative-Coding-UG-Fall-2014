// SPIROGRAPH
// http://en.wikipedia.org/wiki/Spirograph
// also (for inspiration):
// http://ensign.editme.com/t43dances
//
// this processing sketch uses simple OpenGL transformations to create a
// Spirograph-like effect with interlocking circles (called sines).  
// press the spacebar to switch between tracing and
// showing the underlying geometry.
//
// your tasks:
// (1) tweak the code to change the simulation so that it draws something you like.
// hint: you can change the underlying system, the way it gets traced when you hit the space bar,
// or both.  try to change *both*.  :)
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
FFT         fft; // this is an FFT

PShader blur; // this is the shader file


int NUMSINES = 100; // how many of these things can we do at once?
float[] sines = new float[NUMSINES]; // an array to hold all the current angles
float rad; // an initial radius value for the central sine
int i; // a counter variable

// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 1.; // what multiplier for speed is each additional sine?
int alpha = 50; // how opaque is the tracing system

// colors:
float r = 255;
float g = 128;
float b = 0;

boolean trace = false; // are we tracing?
boolean live = false; // are we live?

void setup()
{
  size(displayWidth, displayHeight, P3D);
  blur = loadShader("blur.glsl"); // load in shader file

  rad = height/4.; // compute radius for central circle
  background(255); // clear the screen

  // audio stuff:
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  fft = new FFT( in.bufferSize(), in.sampleRate() );

  for (int i = 0; i<sines.length; i++)
  {
    sines[i] = PI; // start EVERYBODY facing NORTH
  }
}

void draw()
{

  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( in.mix );

  if (!trace) background(255); // clear screen if showing geometry
  if (!trace) {
    stroke(0, 255); // black pen
    noFill(); // don't fill
  }  

  blur.set("scale", 1.); // # of pixels away to blur from
  filter(blur);

  // MAIN ACTION
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen

  for (i = 0; i< (float (mouseX)/width)*sines.length; i++) 
  {
    float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
    // setup tracing
    if (trace) {
      stroke(r*(float(i)/sines.length), g*(float(i)/sines.length), b*(float(i)/sines.length), alpha);
      fill(r, g, b, alpha/2);
      erad = 5.0*(1.0-float(i)/sines.length); // pen width will be related to which sine
    }
    float radius = rad/(i+1); // radius for circle itself
    rotateZ(sines[i]); // rotate circle
    if (!trace) ellipse(0, 0, radius*2, radius*2); // if we're simulating, draw the sine
    pushMatrix(); // go up one level
    translate(0, radius); // move to sine edge
    if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
    if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing
    popMatrix(); // go down one level
    translate(0, radius); // move into position for next sine
    fund = map(mouseY, 0, height, 0.01, 0.0001);
    if (live) sines[i] = (sines[i]+fund*fft.getBand(i+1))%TWO_PI;
    else sines[i] = (sines[i]+(fund+(fund*i*ratio)))%TWO_PI;
  }
  popMatrix(); // pop down final transformation
}

void keyReleased()
{
  if (key==' ') {
    trace = !trace; 
    background(255);
  }
  if (key=='l') {
    live = !live; 
    background(255);
  }
}

