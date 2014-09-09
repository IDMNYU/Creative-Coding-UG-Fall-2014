
int NUMCIRCLES = 100;

float[] thex = new float[NUMCIRCLES];
float[] they = new float[NUMCIRCLES];
float[] v = new float[NUMCIRCLES];
float[] t = new float[NUMCIRCLES];

float[] hue = new float[NUMCIRCLES];

int i, j; // THE GREAT COUNTER VARIABLES

float dia = 30;

float decay = 0.99;

void setup()
{
  size(750, 750);
  background(0);
  colorMode(HSB, 255);

  for (i = 0; i < NUMCIRCLES; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    v[i] = random(5, 20); // random velocity
    t[i] = random(0, TWO_PI); // random angle

    hue[i] = random(0, 255); // random hue
  }
}

void draw()
{
  //background(0);

  fill(255, 100);

  float mj = mouseJam();
  mj = map(mj, 0, 50, 0., 1.);

  for (i = 0; i<NUMCIRCLES; i++)
  {
    fill(hue[i], 200, 200);
    ellipse(thex[i], they[i], dia, dia);


    thex[i] = thex[i]+v[i]*cos(t[i]);
    they[i] = they[i]+v[i]*sin(t[i]);

    // collision detect
    for (j = 0; j<NUMCIRCLES; j++)
    {
      float cj = circleJam(thex[i], they[i], thex[j], they[j]);
      if (i!=j && cj<dia/2) // they're touching
      {
        hue[i] = random(0, 255); // random hue
        hue[j] = random(0, 255); // random hue
        if (thex[i]>thex[j]) t[i] = PI - t[i];
        if (thex[i]<thex[j]) t[i] = PI - t[i];
        if (they[i]>they[j]) t[i] = TWO_PI - t[i];
        if (they[i]<they[j]) t[i] = TWO_PI - t[i];
        v[i]*=1.01;
      }
    }


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

float circleJam(float x1, float y1, float x2, float y2)
{
  return(sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)));
}

