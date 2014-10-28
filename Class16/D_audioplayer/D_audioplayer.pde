
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer groove;
FFT         fft; // this is an FFT



void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  groove = minim.loadFile("SJ.mp3", 2048);
  groove.loop();
    // start an FFT
  fft = new FFT( groove.bufferSize(), groove.sampleRate() );

}


void draw()
{
  background(0);
  
  fft.forward(groove.mix);
  
  stroke(255);
  
  for(int i = 0; i < groove.bufferSize() - 1; i++)
  {
    line(i, 50  + groove.left.get(i)*50,  i+1, 50  + groove.left.get(i+1)*50);
    line(i, 150 + groove.right.get(i)*50, i+1, 150 + groove.right.get(i+1)*50);
  }
  
    for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i, scaling it up a bit so we can see it
    line( i, height, i, height - fft.getBand(i)*8 );
  }
  
  //float foo = fft.getFreq(200.);
  println(foo);

}

void keyPressed()
{
}
