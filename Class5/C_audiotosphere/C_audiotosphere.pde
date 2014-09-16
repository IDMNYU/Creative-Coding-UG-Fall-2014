import ddf.minim.*; // import an external library
 
Minim minim; // this is the audio engine
AudioInput in; // this is the audio input

float theamp; // this is how loud i'm being
 
void setup()
{
  size(512, 512, OPENGL);
 
  minim = new Minim(this); // this starts the audio engine
 
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}
 
void draw()
{
  background(0);
  fill(255);
  noStroke();
  lights();
  float rawamp = 0.;
 
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    rawamp = rawamp + abs(in.left.get(i)); // add the abs value of the current sample to the amp
  }
  rawamp = rawamp / in.bufferSize();
  
  pushMatrix();  
  translate(width/2, height*(1.0/3.0));
  sphere(height*rawamp);
  popMatrix();

  theamp = mysmooth(rawamp, theamp, 0.9);

  pushMatrix();  
  translate(width/2, height*(2.0/3.0));
  sphere(height*theamp);
  popMatrix();
 
}
 
void keyPressed()
{
}

// y(n) = a*y(n-1) + (1.0-a)*x(n)
float mysmooth(float x, float y, float a)
{
   return(a*y + (1.0-a)*x); 
}
