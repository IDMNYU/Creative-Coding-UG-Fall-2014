
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
  image(cat, mouseX,mouseY, w*s, h*s); // custom width and height
}
