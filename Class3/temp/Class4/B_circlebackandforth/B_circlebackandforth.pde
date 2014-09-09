
float thex;
float they;

float ix, iy; // position increment

boolean dx = true; // x direction
boolean dy = true; // y direction

void setup()
{
 size(800, 400);
 
 background(0);
 
 thex = 20;
 they = 200;
 
 ix = random(5, 20); // random x increment
 iy = random(5, 20); // random y increment
  
  
}

void draw()
{
  background(0);
  fill(255);
  
  ellipse(thex, they, 30, 30);
  
  if(dx==true)
  {
  thex=thex+ix;
  if(thex>width) dx=false;
  }
  if(dx==false)
  {
  thex=thex-ix;
  if(thex<0) dx=true;
  }
  
  if(dy==true)
  {
  they=they+iy;
  if(they>height) dy=false;
  }
  if(dy==false)
  {
  they=they-iy;
  if(they<0) dy=true;
  }
  
  
}
