
float thex;
float they;

void setup()
{
 size(800, 400);
 
 background(0);
 
 thex = 20;
 they = 200;
  
  
}

void draw()
{
  background(0);
  fill(255);
  
  ellipse(thex, they, 30, 30);
  
  thex=thex+5;
  
  if(thex>width) thex=0;
  
  
}
