
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;
AudioPlayer groove;
FFT         fft; // this is an FFT
Oscil[]       wave = new Oscil[20]; // 

float fund = 500.;


void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  groove = minim.loadFile("SJ.mp3", 2048);
  groove.loop();
  groove.mute();
  // start an FFT
  fft = new FFT( groove.bufferSize(), groove.sampleRate() );

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  for (int i = 0; i<wave.length; i++)
  {
    wave[i] = new Oscil( fund*(i+1), 0.01f, Waves.SINE );
    wave[i].patch( out );
  }
}


void draw()
{
  background(0);

  fft.forward(groove.mix);

  stroke(255);

  for (int i = 0; i < groove.bufferSize () - 1; i++)
  {
    line(i, 50  + groove.left.get(i)*50, i+1, 50  + groove.left.get(i+1)*50);
    line(i, 150 + groove.right.get(i)*50, i+1, 150 + groove.right.get(i+1)*50);
  }

  for (int i = 0; i < fft.specSize (); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
  }
  
    for (int i = 0; i<wave.length; i++)
  {
    float amp = fft.getFreq(fund*(i+1))/200.;
    wave[i].setAmplitude(amp);
  }

}

void keyPressed()
{
  
}

