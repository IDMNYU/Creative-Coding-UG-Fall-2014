import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave1; // this is an oscillator

//int[] scale = {60, 62, 63, 65, 67, 68, 70, 72};
 int[] scale = {60, 63, 65, 72, 48, 67, 68, 63, 60, 58, 70, 72, 67, 62, 63, 60};
//int[] scale = {62, 62, 64, 62, 67, 66, 62, 62, 64, 62, 69, 67, 62, 62, 74, 71, 67, 66, 64, 72, 72, 71, 67, 69, 67};
//int[] scale = {60, 57, 53, 57, 60, 65, 69, 67, 65, 57, 59, 60};
int whichnote = 0;

lukeMarkov mc;

void setup()
{
  size(512, 512);
  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

  wave1 = new Oscil( 440., 0.5, Waves.SINE ); // this sets up the oscillator
  wave1.patch( out ); // this plugs into the speakers
  
  mc = new lukeMarkov(scale);
}

// draw is run many times
void draw()
{
  frameRate(4);
  int pitch1 = mc.current;
  wave1.setFrequency(mtof(pitch1));
  mc.tick();
}

float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

