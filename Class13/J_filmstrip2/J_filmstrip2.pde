
PImage thepicture, thebackground;
int w, h;
int bw, bh;
int whichframe = 0;
int nframes = 20; // how many frames in the strip?


void setup()
{
  frameRate(15);
  size(1024, 667);
  background(0);
  thepicture = loadImage("evilcatstrip.png");
  thebackground = loadImage("evilmilksaucer.png");
  //thepicture.mask(thepicture); // use the alpha channel
  w = thepicture.width/nframes;
  h = thepicture.height;
  bw = thebackground.width/nframes;
  bh = thebackground.height;  
  println("the image is: " + w + " by " + h);
}

void draw()
{

  //BLEND, ADD, SUBTRACT, 
  //LIGHTEST, DARKEST, DIFFERENCE, 
  //EXCLUSION, MULTIPLY, SCREEN, 
  //OVERLAY, HARD_LIGHT, SOFT_LIGHT, 
  //DODGE, BURN
  blend(thebackground, whichframe*bw, 0, bw, bh, 0, 0, width, height, BLEND);
  blend(thepicture, whichframe*w, 0, w, h, mouseX, mouseY, w, h, ADD);
  
  whichframe = (whichframe+1) % nframes;
}



