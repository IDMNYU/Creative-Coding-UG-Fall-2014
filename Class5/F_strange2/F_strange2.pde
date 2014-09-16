
float x, y;
float a, b, c, d;

float scale = 150.;

void setup()
{
  size(800, 800);
  background(0);
  
  reset();
}

void draw()
{
  if(mousePressed) {
    fill(0, 5);
    rect(0, 0, width, height);
  }
  noFill();
  stroke(255);
  
  float newX = sin(a*y) - cos(b*x);
  float newY = sin(c*x) - cos(d*y);

  float dist = distance(newX, newY, x, y);
  

  translate(width/2., height/2.);
  
  strokeWeight(5);
  stroke(dist*255, 0, 255, 50);
  line(x*scale, y*scale, newX*scale, newY*scale);
  stroke(dist*255, 0, 255, 255);
  ellipse(x*scale, y*scale, 5, 5);
  
  x = newX;
  y = newY;


  
}

void keyReleased()
{
   reset();
   background(0); 
}

float distance(float x1, float y1, float x2, float y2)
{
   return( sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)));
}

void reset()
{
   a = random(-3., 3.);
   b = random(-3., 3.);
   c = random(-3., 3.);
   d = random(-3., 3.);
   //a = -2.7;
   //b = -0.09;
   //c = -0.86;
   //d = -2.2;
   x = width/2;
   y = height/2;
}
