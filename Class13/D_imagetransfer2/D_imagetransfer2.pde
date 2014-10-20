
PImage cat;
int w, h;

void setup()
{
  size(800, 600);
  background(0);
  cat = loadImage("cat.jpg");
  w = cat.width;
  h = cat.height;
  println("the image is: " + w + " by " + h);
}

void draw()
{
  blend(cat, 100, 50, 50, 50, mouseX, mouseY, 50, 50, BLEND); 
}
