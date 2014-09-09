
int cols = 50;
int rows = 50;

float red, green, blue;

void setup()
{
  size(800, 800);
  frameRate(15); 

  red = random(0, 255);
  green = random(0, 255);
  blue = random(0, 255);

  drawEverything();
}

void draw()
{
  drawEverything();
}

void keyPressed()
{
  drawEverything();
}

void drawEverything()
{
  background(255);

  float xstep = width/cols;
  float ystep = height/rows;

  for (int i =0; i<cols; i++)
  {
    for (int j =0; j<rows; j++)
    {
      fill(red, green, blue);
      rect(i*xstep+xstep/2, j*ystep+ystep/2, xstep*0.8, ystep*0.8);
      //println("column: " + i + " row: " + j);
      red = clamp(red+random(-10, 10), 0, 255);
      green = clamp(green+random(-10, 10), 0, 255);
      blue = clamp(blue+random(-10, 10), 0, 255);
    }
  }
}

// this function keeps things in range
float clamp(float thingie, float themin, float themax)
{
  // this fixes it if i screw up and make themin higher than themax:
  float realmin = min(themin, themax);
  float realmax = max(themin, themax);
  // figure it out:
  thingie = min(thingie, realmax);
  thingie = max(thingie, realmin);
  return(thingie);
}

