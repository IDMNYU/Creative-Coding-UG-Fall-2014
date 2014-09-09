
int NUMCIRCLES = 1000;


float[] thex = new float[NUMCIRCLES]; // x positions
float[] they = new float[NUMCIRCLES]; // y positions

float[] d  = new float[NUMCIRCLES]; // velocities
float[] t  = new float[NUMCIRCLES]; // angles

int i; // THE GREAT COUNTER VARIABLE

float dia = 15; // diameter of circle


void setup()
{
  size(1000, 800);

  background(0);

  for (i=0;i<NUMCIRCLES;i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    d[i] = random(5, 20); // random velocity
    t[i] = random(0, TWO_PI); // random angle
  }
}

void draw()
{
  //background(0);
  noStroke(); // this means no border
  fill(255, 0, 0, 255); // RGBA
  rect(0, 0, width, height);

  stroke(0);
  fill(255, 255, 255, 255);

  for (i=0;i<NUMCIRCLES;i++)
  {

    ellipse(thex[i], they[i], dia, dia);

    thex[i] = thex[i]+d[i]*cos(t[i]);
    they[i] = they[i]+d[i]*sin(t[i]);

    // let's make it wrap
    if (thex[i]>width) t[i]=PI-t[i];
    if (thex[i]<0) t[i]=PI-t[i];
    if (they[i]>height) t[i]=TWO_PI-t[i];
    if (they[i]<0) t[i]=TWO_PI-t[i];
  }
  
  //println(frameRate); // how fast is my sketch?
}

