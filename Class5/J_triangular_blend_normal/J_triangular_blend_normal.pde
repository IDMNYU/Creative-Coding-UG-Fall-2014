// draw this:
//x = 2 sin(3 u) / (2 + cos(v))
//y = 2 (sin(u) + 2 sin(2 u)) / (2 + cos(v + 2 pi / 3))
//
//z = (cos(u) - 2 cos(2 u)) (2 + cos(v)) (2 + cos(v + 2 pi / 3)) / 4
//
//-pi <= u <= pi
//-pi <= v <= pi

import ddf.minim.*; // import an external library

// audio stuff
Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
float theamp; // this is how loud i'm being

int NUMPOINTS = 50; // resolution of shape - more points = slower
float r = 0.; // rotation angle

PShape s; // this is my cool shape
PImage img; // this is my cool image

void setup()
{
  size(800, 800, OPENGL); // 3D mode
  
  img = loadImage("map.jpg"); // load in mitt romney
  textureMode(NORMAL); // express uvw in normal coordinates (0-1)
  textureWrap(REPEAT); // make the texture wrap
  // audio shit
  minim = new Minim(this); // this starts the audio engine
  in = minim.getLineIn(); // opens audio input
  
}

void draw()
{
  doaudiostuff(); // figure out "theamp"
  
  background(0);
  lights();
  fill(255);
  noStroke();
  
  fillShape(); // fill up our shape
  
  translate(mouseX, mouseY);
  rotate(r, -0.235, 0.3143, 0.451);
  scale(0.1);
  shape(s, 0, 0);
  r= r+theamp;
  
}

void fillShape()
{
  
  s = createShape();
  s.beginShape();
  s.texture(img);
  
   for(int i = 0;i<NUMPOINTS;i++)
   {
      for(int j = 0;j<NUMPOINTS;j++)
     {
       float u = map(i, 0, NUMPOINTS, -PI, PI);
       float v = map(j, 0, NUMPOINTS, -PI, PI);
       float x = 2.0*sin(3.0*u) / (2.0 + cos(v));
       float y = 2.0*(sin(u) + 2.0*sin(2*u)) / (2.0 + cos(v + 2.0*PI / 3.0));
       float z = (cos(u) - 2.0*cos(2.0*u))*(2.0 + cos(v))*(2.0 + cos(v + 2.0*PI / 3.0)) / 4.0;       

        // interpolate based on volume between plane and shape
        x = lerp(u, x, theamp*2.);
        y = lerp(v, y, theamp*2.);
        z = lerp(0, z, theamp*2.);
        s.vertex(x*width+width, y*width+width, z*width+width, float(i)/NUMPOINTS, float(j)/NUMPOINTS);
     } 
   }
   
     s.endShape(CLOSE);

}

// make a smoothed value for "theamp"
void doaudiostuff()
{
  float rawamp = 0.;

  for (int i = 0; i < in.bufferSize () - 1; i++)
  {
    rawamp = rawamp + abs(in.left.get(i)); // add the abs value of the current sample to the amp
  }
  rawamp = rawamp / in.bufferSize();

  theamp = mysmooth(rawamp, theamp, 0.25);

}

// y(n) = a*y(n-1) + (1.0-a)*x(n)
float mysmooth(float x, float y, float a)
{
  return(a*y + (1.0-a)*x);
}

