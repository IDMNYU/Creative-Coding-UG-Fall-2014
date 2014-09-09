
float thex, they;
float v; // velocity
float t; // angle

void setup()
{
  size(800, 400);
  background(0);

  thex = random(0, width);
  they = random(0, height);

  v = random(5, 20); // random velocity
  t = random(0, TWO_PI); // random angle
}

void draw()
{
  background(0);
  fill(255);
  ellipse(thex, they, 30, 30);

  thex = thex+v*cos(t);
  they = they+v*sin(t);
  
  if(thex>width) t = PI - t;
  if(thex<0) t = PI -t;
  if(they>height) t = TWO_PI - t;
  if(they<0) t = TWO_PI - t;
  
}

void keyPressed()
{


  thex = random(0, width);
  they = random(0, height);

  v = random(5, 20); // random velocity
  t = random(0, TWO_PI); // random angle
}

