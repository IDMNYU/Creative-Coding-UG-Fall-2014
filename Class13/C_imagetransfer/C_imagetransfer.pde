
PImage cat;
int w, h;
float s = 1.;

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
  // these two lines are the same:
  image(cat, mouseX, mouseY, w*s, h*s);
  blend(cat, 0, 0, w, h, mouseX, mouseY, int(w*s), int(h*s), BLEND); 
}
