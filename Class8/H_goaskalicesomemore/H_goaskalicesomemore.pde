import ddf.minim.*; // import an external library

Minim minim; // this is the audio engine
AudioInput in; // this is the audio input

float theamp; // this is how loud i'm being

float ny = 0; // where is our y offset into the perlin noise
int whichline = 0; // which line are we showing
int whichframe = 0;

PFont f1; // this is the data structure for a font in processing

String[] alicelines;

void setup()
{
  size(800, 600);

  // audio stuff
  minim = new Minim(this); // this starts the audio engine
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();

  // type stuff
  f1 = loadFont("KannadaMN-Bold-255.vlw"); // this loads the font
  textFont(f1); // this tells processing which font to use
  textAlign(LEFT); // draw from left

  alicelines = loadStrings("aliceinwonderland.txt");
  println(alicelines.length);
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);


  float y = height/2;
  float nx = 55.5;

  theamp = computeAmp();

  textFont(f1);

  float[] charsize = new float[alicelines[whichline].length()];

  float x = 0;
  for (int i = 0; i<alicelines[whichline].length (); i++)
  {
    float n = map(noise(nx, ny), 0.0, 1.0, 9., 48.);
    textSize(n);
    charsize[i] = n;
    // text(alicelines[whichline].charAt(i), x, y);
    x+= textWidth(alicelines[whichline].charAt(i));
    nx+= 1;
  }
  float thescale = width/x;
  x = 0;
  for (int i = 0; i<alicelines[whichline].length (); i++)
  {
    textSize(charsize[i]*thescale);
    text(alicelines[whichline].charAt(i), x, y);
    x+= textWidth(alicelines[whichline].charAt(i));
  }


  ny += theamp;

  whichframe++;
  if (whichframe > 60)
  {
    whichline = picknewline();

    while (alicelines[whichline].length ()<1)
    {
      whichline = picknewline();
    }

    whichframe = 0;
  }
}

int picknewline()
{
  return(int(random(0, alicelines.length)));
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

