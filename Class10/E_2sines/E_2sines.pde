import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave1, wave2; // this is an oscillator

//int[] scale = {60, 62, 63, 65, 67, 68, 70, 72};
int[] scale = {60, 63, 65, 72, 48, 67, 68, 63, 60, 58, 70, 72, 67, 62, 63, 60};
int whichnote = 0;

void setup()
{
  size(512, 512);
  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

  wave1 = new Oscil( 440., 0.3, Waves.SINE ); // this sets up the oscillator
  wave2 = new Oscil( 440., 0.3, Waves.SINE ); // this sets up the oscillator
  wave1.patch( out ); // this plugs into the speakers
  wave2.patch( out ); // this plugs into the speakers
}

// draw is run many times
void draw()
{
  frameRate(4);
  //wave.setFrequency( map(mouseX, 0, width, 100, 1000) );
  int pitch1 = scale[whichnote];
//  int pitch2 = scale[(whichnote+7) % scale.length];
  int pitch2 = scale[int(random(scale.length))];
  wave1.setFrequency(mtof(pitch1));
  wave2.setFrequency(mtof(pitch2)*2.);
  //wave.setAmplitude( map(mouseY, 0, height, 1., 0.) );
  
  whichnote = (whichnote+1) % scale.length;
}

float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

