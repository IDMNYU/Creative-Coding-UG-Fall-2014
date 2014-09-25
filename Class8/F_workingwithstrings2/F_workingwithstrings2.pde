import ddf.minim.*; // import an external library

Minim minim; // this is the audio engine
AudioInput in; // this is the audio input

float theamp; // this is how loud i'm being


float ny = 0;

PFont f1; // this is the data structure for a font in processing

String thesentence = "My dog has FLEAS!!!";
float[] thesizes = new float[thesentence.length()];

void setup()
{
  size(800, 600);

  minim = new Minim(this); // this starts the audio engine

  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();


  f1 = loadFont("GillSansShadowMTPro-48.vlw"); // this loads the font

  textFont(f1); // this tells processing which font to use
  textAlign(LEFT); // draw from left
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);

  float x = 100;
  float y = height/2;
  float nx = 55.5;
  
  theamp = computeAmp();

  textFont(f1);

  for (int i = 0; i<thesentence.length (); i++)
  {
    float n = map(noise(nx, ny), 0.0, 1.0, 9., 48.);
    println(n);
    textSize(n);
    text(thesentence.charAt(i), x, y);
    x+= textWidth(thesentence.charAt(i));
    nx+= 1;
  }
  
  ny += theamp;
}

void keyReleased()
{
}

void mousePressed()
{
}

void mouseReleased()
{
}

float computeAmp()
{
  float rawamp = 0.;

  // draw the waveforms so we can see what we are monitoring
  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    rawamp = rawamp + abs(in.left.get(i)); // add the abs value of the current sample to the amp
  }
  rawamp = rawamp / in.bufferSize();
  return(rawamp);
}

