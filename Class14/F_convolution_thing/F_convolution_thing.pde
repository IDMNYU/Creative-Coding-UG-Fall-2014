import processing.video.*; // import the movie stuff

String moviename = "duck.mp4"; // what movie are we playing
Movie mov; // this is the movie object
PImage processed; // this is the processed movie

// IMAGE PROCESSING STUFF:
// 9 pixels for the neighborhood (p[4] is center):
//  p[0]  p[1]  p[2]
//  p[3] *p[4]* p[5]
//  p[6]  p[7]  p[8]
color[] p = new color[9];
int w, h; // width and height

float amp = 1.0;

float[] gx_kernel = {
 -1, 0, 1, -2, 0, 2, -1, 0, 1
 };
 float[] gy_kernel = {
 1, 2, 1, 0, 0, 0, -1, -2, -1
 };



void setup() {
  size(640, 480); // the right size
  background(0); // we don't really have to do this

  mov = new Movie(this, moviename); // duck and cover
  mov.play(); // start playing
  mov.jump(0); // rewind to the beginning
}

void draw() {


  if (mov.available()) { // check to see if there's new video data
    mov.read(); // copy the current frame to an internal PImage
  }  

  //
  // process image HERE
  //
  mov.loadPixels(); // load pixels array from texture
  w = mov.width; // how wide?
  h = mov.height; // how tall?
  processed = createImage(w, h, RGB); // new output image
  processed.loadPixels(); // load up their pixels
  amp = map(mouseX, 0, width, -4., 4.);


    for (int i=0; i<h; i++) // these pixels are the rows
  {
    for (int j=0; j<w; j++) // these pixels are the columns
    {

      // top row
      p[0] = mov.pixels[((i-1+h)%h)*w + (j-1+w)%w]; // left pixel
      p[1] = mov.pixels[((i-1+h)%h)*w + j]; // center pixel
      p[2] = mov.pixels[((i-1+h)%h)*w + (j+1+w)%w]; // right pixel

      // center row
      p[3] = mov.pixels[i*w + (j-1+w)%w]; // left pixel
      p[4] = mov.pixels[i*w + j]; // center pixel
      p[5] = mov.pixels[i*w + (j+1+w)%w]; // right pixel

      // bottom row
      p[6] = mov.pixels[((i+1+h)%h)*w + (j-1+w)%w]; // left pixel
      p[7] = mov.pixels[((i+1+h)%h)*w + j]; // center pixel
      p[8] = mov.pixels[((i+1+h)%h)*w + (j+1+w)%w]; // right pixel

      // here's where we do the magic
      // this is a convolution for sobel edge detection
      float gx = 0; // store some stuff
      float gy = 0; // store some stuff
      for (int k = 0; k<p.length; k++)
      {
        gx+=green(p[k])*gx_kernel[k]*amp; 
        gy+=green(p[k])*gy_kernel[k]*amp;
      }
      float output = sqrt(gx*gx + gy*gy);

      processed.pixels[i*w + j] = color(output, output, output);
    }
  }
  processed.updatePixels(); // update picture texture

  image(processed, 0, 0, width, height); // draw it to the screen
}

void keyReleased()
{
}

