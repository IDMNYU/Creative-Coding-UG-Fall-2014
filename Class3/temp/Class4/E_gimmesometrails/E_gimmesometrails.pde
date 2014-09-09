
float thex;
float they;

float d; // velocity
float t; // angle


void setup()
{
  size(800, 400);

  background(0);

  thex = 0;
  they = 50;

  d = random(5, 20); // random velocity
  t = random(0, TWO_PI); // random angle
}

void draw()
{
  //background(0);
  noStroke(); // this means no border
  fill(255, 0, 0, 5); // RGBA
  rect(0, 0, width, height);

  stroke(0);
  fill(255, 255, 255, 50);

  ellipse(thex, they, 30, 30);

  thex = thex+d*cos(t);
  they = they+d*sin(t);

  // let's make it wrap
  if (thex>width) t=PI-t;
  if (thex<0) t=PI-t;
  if (they>height) t=TWO_PI-t;
  if (they<0) t=TWO_PI-t;
}

