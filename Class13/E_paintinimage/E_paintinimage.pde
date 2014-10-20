
PImage thepicture;
int w, h;

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
  blend(thepicture, mouseX, mouseY, 50, 50, mouseX, mouseY, 50, 50, BLEND); 
}
