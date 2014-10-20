
PImage picture;
int w, h;
float r, g, b;

void setup()
{
  size(1024, 576);
  picture = loadImage("sunrise.jpg");
  w = picture.width;
  h = picture.height;
}

void draw()
{
  picture.loadPixels(); // load pixels array from texture
  int howmanypixels = picture.pixels.length;
  println(howmanypixels);
  for (int i = 0; i<howmanypixels; i++) {
    color src = picture.pixels[int(random(0, howmanypixels))]; // pick a random src pixel
    picture.pixels[i] = src;
  }
  picture.updatePixels(); // update picture texture
  image(picture, 0, 0);
}

