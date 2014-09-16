import ddf.minim.*; // import an external library

// audio stuff
Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
float theamp; // this is how loud i'm being

PShape s; // this is my cool shape
PImage img; // this is my cool image

void setup()
{
  size(800, 800, OPENGL);
  
  img = loadImage("mitt.jpg"); // load in mitt romney
  textureMode(NORMAL); // express uvw in normal coordinates (0-1)
  
  // audio shit
  minim = new Minim(this); // this starts the audio engine
  in = minim.getLineIn();
}

void draw()
{
  doaudiostuff();
  background(0);
  
  float samp = map(theamp, 0., 1., 1., 20);

  s = createShape();
  s.beginShape();
  s.texture(img);
  s.vertex(-50*samp, -50*samp, 0, 0);
  s.vertex(-50, 50, 0, 1);
  s.vertex(50*samp, 50*samp, 1, 1);
  s.vertex(50, -50, 1, 0);
  s.endShape(CLOSE);

  shape(s, mouseX, mouseY);
}

void doaudiostuff()
{
  float rawamp = 0.;

  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    rawamp = rawamp + abs(in.left.get(i)); // add the abs value of the current sample to the amp
  }
  rawamp = rawamp / in.bufferSize();

  theamp = mysmooth(rawamp, theamp, 0.9);

}

// y(n) = a*y(n-1) + (1.0-a)*x(n)
float mysmooth(float x, float y, float a)
{
  return(a*y + (1.0-a)*x);
}

