
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
FFT         fft; // this is an FFT

void setup()
{
  size(800, 600, P3D);

  // audio stuff:
  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  // start an FFT
  fft = new FFT( in.bufferSize(), in.sampleRate() );

}

void draw()
{
  background(255);
  // perform a forward FFT on the samples in jingle's mix buffer,
  // which contains the mix of both the left and right channels of the file
  fft.forward( in.mix );

  for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
  }
}

