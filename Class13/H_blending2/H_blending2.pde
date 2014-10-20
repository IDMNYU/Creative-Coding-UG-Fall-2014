
PImage thepicture, thebackground;
int w, h;
int whichway = 0;

void setup()
{
  size(1024, 667);
  background(0);
  thebackground = loadImage("beach.jpg");
  thepicture = loadImage("cat.png");
  thepicture.mask(thepicture); // use the alpha channel
  w = thepicture.width;
  h = thepicture.height;
  println("the image is: " + w + " by " + h);
}

void draw()
{

  background(thebackground);
  //BLEND, ADD, SUBTRACT, 
  //LIGHTEST, DARKEST, DIFFERENCE, 
  //EXCLUSION, MULTIPLY, SCREEN, 
  //OVERLAY, HARD_LIGHT, SOFT_LIGHT, 
  //DODGE, BURN
  blend(thepicture, 0, 0, w, h, mouseX, mouseY, w, h, BLEND);
}

void keyReleased()
{
  whichway = 1-whichway;
}

