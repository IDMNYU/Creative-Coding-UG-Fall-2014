
float x, y, z;
float A, B, C, D, E;

void setup()
{
  size(500, 500, OPENGL);
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
  stroke(255, 50);
  
  float newX = sin(A*y)-z*cos(B*x);
  float newY = z*sin(C*x)-cos(D*y);
  float newZ = E*sin(x);
  translate(width/2, height/2);
  line(x, y, z, newX, newY, newZ);
  translate(newX, newY, newZ);
  sphere(10);
  
  x = newX;
  y = newY;
  z = newZ;

  
}

void keyReleased()
{
   reset();
   background(0); 
}

void reset()
{
   A = random(0, width);
   B = random(0, width);
   C = random(0, width);
   D = random(0, width);
   E = random(0, width);
   x = width/2;
   y = height/2;
   z = 0.;
  
}
