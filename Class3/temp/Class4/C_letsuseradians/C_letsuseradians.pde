
float thex;
float they;

float d; // velocity
float t; // angle


void setup()
{
 size(800, 400);
 
 background(0);
 
 thex = 20;
 they = 200;
 
 d = random(5, 20); // random velocity
 t = random(0, TWO_PI); // random angle
  
  
}

void draw()
{
  background(0);
  fill(255);
  
  ellipse(thex, they, 30, 30);
 
   thex = thex+d*cos(t);
   they = they+d*sin(t);
   
   // let's make it wrap
   if(thex>width) thex=0;
   if(thex<0) thex=width;
   if(they>height) they=0;
   if(they<0) they=height;
  
  
}
