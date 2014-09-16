import ddf.minim.*; // import an external library
 
Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
 
void setup()
{
  size(200, 512);
 
  minim = new Minim(this); // this starts the audio engine
 
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}
 
void draw()
{
  background(0);
  fill(255);
  noStroke();
  float amp = 0.;
 
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    amp = amp + abs(in.left.get(i)); // add the abs value of the current sample to the amp
  }
  amp = amp / in.bufferSize();
  
  rect(0, height-(height*amp), width, height*amp);
  
  String theamp = nf(amp, 0, 2);
  println(theamp);
 
}
 
void keyPressed()
{
}
