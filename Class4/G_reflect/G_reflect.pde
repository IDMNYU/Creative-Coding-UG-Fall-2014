
int NUMCIRCLES = 1000;

float[] thex = new float[NUMCIRCLES];
float[] they = new float[NUMCIRCLES];
float[] v = new float[NUMCIRCLES];
float[] t = new float[NUMCIRCLES];

float[] hue = new float[NUMCIRCLES];

int i, j; // THE GREAT COUNTER VARIABLES

float dia = 5;

float decay = 0.99;

void setup()
{
  size(750, 750, OPENGL);
  background(0);
  noStroke();
  colorMode(HSB, 255);
  sphereDetail(10);

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
  lights();

  fill(255, 100);


  for (i = 0; i<NUMCIRCLES; i++)
  {
    fill(hue[i], 200, 200, 20);
    pushMatrix();
    translate(thex[i], they[i]);
    sphere(dia);
    popMatrix();


    float a = atan((mouseY-they[i])/(mouseX-thex[i]));
    if (mouseX<thex[i]) a+=PI;
    float distance = circleJam(thex[i], they[i], mouseX, mouseY);
    
    v[i] = constrain(1000-distance, 0, 1000);
    v[i] = v[i]*0.01;

    thex[i] = (thex[i] + v[i]*cos(a)+width)%width; 
    they[i] = (they[i] + v[i]*sin(a)+height)%height;


    thex[i] = thex[i]+v[i]*cos(t[i]);
    they[i] = they[i]+v[i]*sin(t[i]);

    // mouse vacuum
    float cj = circleJam(thex[i], they[i], mouseX, mouseY);
    v[i]+=(constrain(100.-cj, 0, 100))/100.;



    if (thex[i]>width) t[i] = PI - t[i];
    if (thex[i]<0) t[i] = PI - t[i];
    if (they[i]>height) t[i] = TWO_PI - t[i];
    if (they[i]<0) t[i] = TWO_PI - t[i];

    v[i]*=decay;
  }
}

void keyPressed()
{
  background(0);
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

