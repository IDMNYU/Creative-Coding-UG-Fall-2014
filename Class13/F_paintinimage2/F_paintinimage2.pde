
PImage thepicture;
int w, h;
int whichway = 0;

void setup()
{
  size(800, 600);
  background(0);
  thepicture = loadImage("beach.jpg");
  w = thepicture.width;
  h = thepicture.height;
  println("the image is: " + w + " by " + h);
}

void draw()
{
  //BLEND, ADD, SUBTRACT, 
  //LIGHTEST, DARKEST, DIFFERENCE, 
  //EXCLUSION, MULTIPLY, SCREEN, 
  //OVERLAY, HARD_LIGHT, SOFT_LIGHT, 
  //DODGE, BURN
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);

  if(whichway==0) {
    int picwidth = constrain(mouseY, 0, w-mouseX); // keep in range
    blend(thepicture, mouseX, 0, picwidth, height, mouseX, 0, picwidth, height, BLEND); 
  }
  else if(whichway==1) {
    int picheight = constrain(mouseX, 0, h-mouseY); // keep in range
    blend(thepicture, 0, mouseY, width, picheight, 0, mouseY, width, picheight, BLEND); 
  }
}

void keyReleased()
{
   whichway = 1-whichway; 
}
