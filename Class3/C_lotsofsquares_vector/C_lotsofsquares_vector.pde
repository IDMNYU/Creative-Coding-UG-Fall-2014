
int cols = 10;
int rows = 10;

float hue, saturation, brightness;

void setup()
{
  size(800, 800);
  frameRate(15); 
  
  colorMode(HSB, 255.);

  hue = 0;
  saturation = 128.;
  brightness = 192.;

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

  for (int i =0; i<cols*rows; i++)
  {
      fill(hue, saturation, brightness);
      rect((i%cols)*xstep+xstep/2, (i/cols)*ystep+ystep/2, xstep*0.8, ystep*0.8);
      println("column: " + i%cols + " row: " + i/cols);
      hue = (hue+random(-50, 50)+256)%255.;
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

