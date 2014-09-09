
int NUMCIRCLES = 1000;

float[] thex = new float[NUMCIRCLES];
float[] they = new float[NUMCIRCLES];
float[] v = new float[NUMCIRCLES];
float[] t = new float[NUMCIRCLES];

int i; // THE GREAT COUNTER VARIABLE

float dia = 15;

float decay = 0.99;

void setup()
{
  size(1000, 800);
  background(0);

  for (i = 0; i < NUMCIRCLES; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    v[i] = random(5, 20); // random velocity
    t[i] = random(0, TWO_PI); // random angle
  }
}

void draw()
{
  background(0);
  fill(255, 100);
  
  float mj = mouseJam();
  mj = map(mj, 0, 50, 0., 1.);

  for (i = 0; i<NUMCIRCLES; i++)
  {
    ellipse(thex[i], they[i], dia, dia);

    thex[i] = thex[i]+v[i]*cos(t[i]);
    they[i] = they[i]+v[i]*sin(t[i]);

    if (thex[i]>width) t[i] = PI - t[i];
    if (thex[i]<0) t[i] = PI - t[i];
    if (they[i]>height) t[i] = TWO_PI - t[i];
    if (they[i]<0) t[i] = TWO_PI - t[i];
    
    v[i]*=decay;
    v[i]+=mj;
   
    
  }
}

void keyPressed()
{
  for (i = 0; i < NUMCIRCLES; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    v[i] = random(5, 20); // random velocity
    t[i] = random(0, TWO_PI); // random angle
  }
}

float mouseJam()
{
   return(sqrt((pmouseX-mouseX)*(pmouseX-mouseX) + (pmouseY-mouseY)*(pmouseY-mouseY)));
}

