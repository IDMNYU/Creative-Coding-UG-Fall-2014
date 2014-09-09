
int NUMCIRCLES = 1000;


float[] thex = new float[NUMCIRCLES]; // x positions
float[] they = new float[NUMCIRCLES]; // y positions

float[] d  = new float[NUMCIRCLES]; // velocities
float[] t  = new float[NUMCIRCLES]; // angles

int i; // THE GREAT COUNTER VARIABLE

float dia = 15; // diameter of circle

float decay = 0.1; // decay amount

int oldmX, oldmY;


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

  
  // pythagorize me
  int xterm = (oldmX-mouseX)*(oldmX-mouseX);
  int yterm = (oldmY-mouseY)*(oldmY-mouseY);
  float velocityadd = sqrt(xterm + yterm);
  // angle
  float riserun = 0;
  float mouseangle = 0;
  if(xterm>0)
  {
     riserun = (oldmY-mouseY)/(oldmX-mouseX);
     //riserun = constrain(riserun, -1., 1.);
     mouseangle = atan(riserun);
     //println(mouseangle);
  }
  
  
  oldmX = mouseX;
  oldmY = mouseY;

  noStroke(); // this means no border
  fill(255, 0, 0, 255); // RGBA
  rect(0, 0, width, height);

  velocityadd = velocityadd * 0.003; // scale this

  stroke(0);

  for (i=0;i<NUMCIRCLES;i++)
  {

    fill(255, 255, 255, d[i]*30);
    ellipse(thex[i], they[i], dia, dia);

    thex[i] = thex[i]+d[i]*cos(t[i]);
    they[i] = they[i]+d[i]*sin(t[i]);

    // let's make it wrap
    if (thex[i]>width) t[i]=PI-t[i];
    if (thex[i]<0) t[i]=PI-t[i];
    if (they[i]>height) t[i]=TWO_PI-t[i];
    if (they[i]<0) t[i]=TWO_PI-t[i];
    
    d[i] = d[i]-decay;
    if(d[i]<0) d[i] = 0;
    d[i] = d[i] + velocityadd;
    t[i]+=mouseangle;
    
  }

  //println(frameRate); // how fast is my sketch?
}

