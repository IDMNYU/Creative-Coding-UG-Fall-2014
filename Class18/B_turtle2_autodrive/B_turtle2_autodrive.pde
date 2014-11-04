float x, y; // where is the turtle?
float step = 20; // how far does the turtle move?
float angle = 90; // how much does the turtle turn?
float currentangle = 270; // what's the initial heading?
float radius;

String thestring = "FFFF--FF+FFF--F-FF+";
int stringposition = 0;

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
  turtleize(thestring.charAt(stringposition));
  stringposition = (stringposition+1) % thestring.length();
}

void turtleize(char c)
{
  if (c == 'F')
  {
    float x1 = x + step*cos(radians(currentangle));
    float y1 = y + step*sin(radians(currentangle));
    line(x, y, x1, y1);
    x = x1;
    y = y1;
  } else if (c == '+')
  {
    currentangle+=angle;
  } else if (c == '-')
  {
    currentangle-=angle;
  } else if (c=='c')
  {
    background(255);
    x= width/2;
    y = height/2;
    currentangle = 270;
  }
}

void keyReleased()
{
  turtleize(key); // run the drawing function with the current key
}

