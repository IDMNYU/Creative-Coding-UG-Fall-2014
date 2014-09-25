import ddf.minim.*; // import an external library

// audio shit
Minim minim; // this is the audio engine
AudioInput in; // this is the audio input
float theamp; // this is how loud i'm being

// text stuff
PFont f1; // this is the data structure for a font in processing
String[] alicelines;
int whichline = 0; // which line are we showing
float[] chary; // this is the y positions of all the characters
float ny = 0; // where is our y offset into the perlin noise

// application runner
int whichframe = 0; // this is which frame we're on

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

  // load the text file and pick a starting line
  alicelines = loadStrings("aliceinwonderland.txt");
  // println(alicelines.length);
  picknewline();
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);

  float nx = 55.5; // initialize the perlin noise X position

  // how load are we?
  theamp = computeAmp();

  // stash how big the letters are gonna be in this frame
  float[] charsize = new float[alicelines[whichline].length()];

  float x = 0; // starting x position
  
  // do loop twice... first with default size to figure out line size
  for (int i = 0; i<alicelines[whichline].length(); i++)
  {
    float n = map(noise(nx, ny), 0.0, 1.0, 9., 48.);
    textSize(n);
    charsize[i] = n;
    // text(alicelines[whichline].charAt(i), x, y);
    x+= textWidth(alicelines[whichline].charAt(i));
    nx+= 1;
  }
  // compute a scale for the whole darn thing:
  float thescale = width/x;
  x = 0; // reset the x position
  
  // go through the loop again and actually draw this time
  for (int i = 0; i<alicelines[whichline].length (); i++)
  {
    textSize(charsize[i]*thescale);
    text(alicelines[whichline].charAt(i), x, chary[i]);
    x+= textWidth(alicelines[whichline].charAt(i));
    chary[i]+=random(1, 5); // make the letters fall
  }


  ny += theamp; // increment Y position of the perlin noise to get variation

  whichframe++;
  if (whichframe > 60)
  {
    picknewline();
    whichframe = 0;
  }
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

// this picks a new line and ensures it has a non-zero length
void picknewline()
{
  // pick a new line
  whichline = int(random(0, alicelines.length));

  // blows out the y position array for the letters
  chary = new float[alicelines[whichline].length ()];
  for (int i = 0; i<chary.length; i++)
  {
    chary[i] = 50;
  }
  
  // ensures non-zero length
  while (alicelines[whichline].length ()<1)
  {
    picknewline(); // recurse
  }
}

// this was a good idea: figure out how loud i'm being and return the value
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

