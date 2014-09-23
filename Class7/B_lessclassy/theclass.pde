// this is our groovy class

class mySphere
{
  // properties
  float x; // my x position
  float y; // my y position
  float v = 5; // velocity
  float a = 0; // angle
  float d = 5; // diameter

  // constructor - this is the code that runs when you make it
  mySphere(float diameter)
  {
    d = diameter;
    x = random(0, width);
    y = random(0, height);
    a = random(0, TWO_PI);
    v = random(0.3, 4);
  }

  // methods
  void go() // this draws
  {
    fill(0);
    noStroke();
    ellipse(x, y, d, d);

  }
  
  void update(float tx, float ty) // this animates
  {
    a = atan((ty-y)/(tx-x));
    if(tx<x) a+=PI;
    float distance = sqrt((x-tx)*(x-tx) + (y-ty)*(y-ty));
    
    v = constrain(1000-distance, 0, 1000);
    v = v*0.001;
    
    x = (x + v*cos(a)+width)%width;
    y = (y + v*sin(a)+height)%height;
    
      
  }
}

