float i = 0;
float smoothi = 0.;

void draw()
{
  frameRate(1);
  smoothi = mysmooth(i, smoothi, 0.5);
  println(smoothi);
}

void mousePressed()
{
    i = 1;
}
void mouseReleased()
{
    i = 0;
}



float mysmooth(float x, float y, float a)
{
   return(a*y + (1.0-a)*x); 
}
