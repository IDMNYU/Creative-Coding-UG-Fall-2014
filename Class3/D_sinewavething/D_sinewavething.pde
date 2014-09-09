
float thex, they;
float c; // cosine value
float incr; // increment


void setup()
{
  size(800, 400);
  background(0);

  thex = 0;
  they = height/2;

  c = 0.; // random velocity
  incr = 0.1;
}

void draw()
{
  //background(0);
  fill(255);
  ellipse(thex, they, 10, 10);
  
  incr = map(mouseX, 0, width-1, 0., 0.25);
  
  c = (c+incr) % TWO_PI;
  println(c);

  thex = thex+1; // increment the x value
  if(thex>width)
  {
     thex = 0;
     background(0); 
  }
  // map is your best friend:
  
  float theamp = mouseY/2;
  
  they = map(sin(c), -1., 1., 0+theamp, height-theamp);
  
}

void keyPressed()
{
}

