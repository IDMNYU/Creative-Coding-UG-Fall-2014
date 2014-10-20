
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
  int ncols = int(map(mouseX, 0, width, 1, 32));
  int nrows = int(map(mouseY, 0, height, 1, 32));
  for (int i = 0; i<h; i++) { // these are all the rows
    for (int j = 0; j<w; j++) { // these are all the columns
      int xpos = (j*ncols)%w;
      int ypos = (i*nrows)%h;
      
      color src = inpic.pixels[ypos*w + xpos]; // src pixel
      color src2 = inpic.pixels[i*w + j]; // other src pixel (straight up)
      r = (green(src) + red(src2))/2;
      g = (green(src) + green(src2))/2;
      b = (green(src) + blue(src2))/2;
      outpic.pixels[i*w + j] = color(r, g, b);
    }
  }
  outpic.updatePixels(); // update picture texture
  image(outpic, 0, 0); // show it
}

void keyReleased()
{
  inpic = loadImage("sunrise.jpg");
}

