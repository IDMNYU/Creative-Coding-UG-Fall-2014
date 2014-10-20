
PImage picture, destpicture;
int w, h;
float r, g, b;

void setup()
{
  size(1024, 576);
  picture = loadImage("sunrise.jpg");
  w = picture.width;
  h = picture.height;
  destpicture = new PImage(w, h);
}

void draw()
{
  picture.loadPixels(); // load pixels array from texture
  int howmanypixels = picture.pixels.length;
  println(howmanypixels);
  for (int i = 0; i<howmanypixels; i++) {
    color src = picture.pixels[i]; // src pixel
    r = red(src) * (mouseX/float(width));
    g = green(src) * (mouseY/float(height));
    b = blue(src);
    destpicture.pixels[i] = color(r, g, b);;
  }
  destpicture.updatePixels(); // update picture texture
  image(destpicture, 0, 0);
}

void keyReleased()
{
   picture = loadImage("sunrise.jpg"); 
}

