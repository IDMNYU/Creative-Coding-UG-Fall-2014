
PImage inpic, outpic;
int w, h;
float r, g, b;

void setup()
{
  size(1024, 576);
  inpic = loadImage("sunrise.jpg");
  w = inpic.width;
  h = inpic.height;
  outpic = new PImage(w, h);
}

void draw()
{
  inpic.loadPixels(); // load pixels array from texture
  int howmanypixels = inpic.pixels.length;
  println(howmanypixels);
  for (int i = 0; i<h; i++) { // these are all the rows
    for (int j = 0; j<w; j++) { // these are all the columns
      int xpos = (j+mouseX)%w;
      int ypos = (i+mouseY)%h;
      
      color src = inpic.pixels[ypos*w + xpos]; // src pixel
      outpic.pixels[i*w + j] = src;
    }
  }
  outpic.updatePixels(); // update picture texture
  image(outpic, 0, 0); // show it
}

void keyReleased()
{
  inpic = loadImage("sunrise.jpg");
}

