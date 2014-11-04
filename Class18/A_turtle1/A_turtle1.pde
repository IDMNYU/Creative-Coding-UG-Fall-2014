float x, y; // where is the turtle?
float step = 20; // how far does the turtle move?
float angle = 45; // how much does the turtle turn?
float currentangle = 270; // what's the initial heading?
float radius;

void setup()
{
  size(800, 600);
  x = width/2;
  y = height/2;
  background(255);
  stroke(0, 0, 0);
  noFill();
}

void draw()
{
  float r = random(128, 255);
  float g = random(0, 192);
  float b = random(0, 50);
  float a = random(50, 100);
  radius = random(0, step);
  fill(r, g, b, a);
  ellipse(x, y, radius, radius);
}

void keyReleased()
{
  if (key == 'F')
  {
    float x1 = x + step*cos(radians(currentangle));
    float y1 = y + step*sin(radians(currentangle));
    line(x, y, x1, y1);
    x = x1;
    y = y1;
  } else if (key == '+')
  {
    currentangle+=angle;
  } else if (key == '-')
  {
    currentangle-=angle;
  } else if (key=='c')
  {
    background(255);
    x= width/2;
    y = height/2;
    currentangle = 270;
  }
}

