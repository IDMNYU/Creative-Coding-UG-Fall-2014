// CONWAY'S GAME OF LIFE
// http://en.wikipedia.org/wiki/Conway's_Game_of_Life
//
// this processing sketch implements John Conway's Game of Life simulation
// as an image-processing system... it looks at pixels in a processing PImage
// and treats them as cells in a version of Conway's simulation.
//
// your tasks:
// (1) make this thing look more interesting... 
// hint: you don't have to display the image directly to the screen.
// another hint: the double for() loop can be used to draw other things (shapes, text, etc.)
// as a proxy for the pixels in the simulation.
// (2) the RULES in the draw() loop determine how the simulation decides to keep a pixel
// alive or generate a new one from a dead pixel.  this rule set is sometimes referred to as
// B3/S23 (a pixel is "Born" with 3 neighbors and "Stays Alive" with 2 or 3 neighbors.
// tweak these rules and see if you can find other interesting (or self-sustaining) systems.
//


PImage c[] = new PImage[2]; // input image

int[] livemask = {0, 0, 1, 1, 0, 0, 0, 0, 0};
int[] deathmask = {0, 0, 0, 1, 0, 0, 0, 0, 0};

int w, h; // width and height

int i, j; // counter variables

int center; // is the pixel alive or dead?
int sum; // how many neighbors are alive?

int which = 0; // which image are we working on

// 9 pixels for the neighborhood (p4 is center):
//  p0  p1  p2
//  p3 *p4* p5
//  p6  p7  p8
color p0, p1, p2, p3, p4, p5, p6, p7, p8; 

void setup()
{
  size(800, 800); // make the screen square
  rectMode(CENTER);
  noStroke();
  fill(255, 0, 0);

  // create two blank images to work with for the game
  c[0] = createImage(width/8, height/8, RGB);
  c[1] = createImage(width/8, height/8, RGB);
  w = c[0].width; // width
  h = c[0].height; // height

    // fill our first image with random stuff:
  fillRandom();
}

void draw()
{
  background(0);

  c[which].loadPixels(); // load up the pixels array for input

  // step 1 - add pixels where mouse is
  if (mousePressed)
  {
    int mx = constrain(int(mouseX*(w/float(width))), 0, width-1);
    int my = constrain(int(mouseY*(h/float(height))), 0, height-1);
    c[which].pixels[my*w + mx] = color(255, 255, 255);
  }

  // step 2 - get the values for the "neighborhood" around each pixel
  for (i=0; i<h; i++) // these pixels are the rows
  {
    for (j=0; j<w; j++) // thise pixels are the columns
    {

      // top row
      p0 = c[which].pixels[((i-1+h)%h)*w + (j-1+w)%w]; // left pixel
      p1 = c[which].pixels[((i-1+h)%h)*w + j]; // center pixel
      p2 = c[which].pixels[((i-1+h)%h)*w + (j+1+w)%w]; // left pixel

      // center row
      p3 = c[which].pixels[i*w + (j-1+w)%w]; // left pixel
      p4 = c[which].pixels[i*w + j]; // center pixel
      p5 = c[which].pixels[i*w + (j+1+w)%w]; // left pixel

      // bottom row
      p6 = c[which].pixels[((i+1+h)%h)*w + (j-1+w)%w]; // left pixel
      p7 = c[which].pixels[((i+1+h)%h)*w + j]; // center pixel
      p8 = c[which].pixels[((i+1+h)%h)*w + (j+1+w)%w]; // left pixel

      // compute the sum: use the green channel for simplicity
      sum = 0; // start blank
      sum+= int(green(p0)>0.) + int(green(p1)>0.) + int(green(p2)>0.); // top neighbors
      sum+= int(green(p3)>0.) + int(green(p5)>0.); // left and right neighbors
      sum+= int(green(p6)>0.) + int(green(p7)>0.) + int(green(p8)>0.); // bottom neighbors

      center = int(green(p4)>0.); // is the center pixel alive?

      //
      // RULES: PLAY WITH THESE
      //
      if (center==1 && livemask[sum]==1) // alive... stay alive
      {
        int temp = int(green(c[1-which].pixels[i*w + j]))+1;
        c[1-which].pixels[i*w + j] = color(temp, temp, temp);
        ellipse(i*(width/w),j*(height/h), temp, temp);
      } 
      else if (center==0 && deathmask[sum]==1) // dead... become alive
      {
        c[1-which].pixels[i*w + j] = color(1, 1, 1);
        ellipse(i*(width/w),j*(height/h), 1, 1);
      } else // die (or stay dead)
      {   
        c[1-which].pixels[i*w + j] = color(0, 0, 0);
      }
    }
  }

  c[1-which].updatePixels(); // restore the pixels array

  //image(c[1-which], 0, 0, width, height); // draw to screen

  which = 1-which; // swap image buffer
}

void keyPressed()
{
  fillRandom(); // add random noise to image when you press any key
}

void fillRandom()
{
  // fill our current image with random stuff
  c[which].loadPixels();
  for (i=0; i<c[which].pixels.length; i++)
  {
    float rand = random(1000);
    if (rand>900) // 10% alive
    {
      c[which].pixels[i] = color(255, 255, 255);
    }
  }
  c[which].updatePixels();
}

