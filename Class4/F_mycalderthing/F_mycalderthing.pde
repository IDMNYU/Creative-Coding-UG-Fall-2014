int NUMSTARS = 100;

PShape thesun, mercury, venus, moon, star;


float[] thex = new float[NUMSTARS];
float[] they = new float[NUMSTARS];
float[] v = new float[NUMSTARS];
float[] t = new float[NUMSTARS];


float r1 = 0.;
float r2 = 0.;
float r3 = 0.;
float r4 = 0.;

int i; // the big counter


float xpos, ypos, zpos;
float xstep, ystep, zstep;
float masterrotate = 0.;
float mstep;

void setup()
{
  size(800, 600, OPENGL); // 3-D mode
  sphereDetail(30); // quality of sphere
  
  noFill();
  stroke(255);

  ypos = height/2;
  xpos = width/2;
  zpos = 0;

  makeTheShapes();
  
    for (i = 0; i < NUMSTARS; i++)
  {
    thex[i] = random(0, width);
    they[i] = random(0, height);

    v[i] = random(5, 20); // random velocity
    t[i] = random(0, TWO_PI); // random angle
  }

}

void draw()
{
  lights(); // gimme some lights
  background(0, 0, 0);

  //noFill();
  //noStroke();

  // CAMERA
  translate(xpos, ypos, zpos); // move center to center
  rotate(masterrotate, 0, 0, 1);
  

  for (i = 0; i<NUMSTARS; i++)
  {
    pushMatrix();
    translate(thex[i], they[i], -1000);
     scale(0.2);
    shape(star); 

    thex[i] = thex[i]+random(-20, 20);
    they[i] = they[i]+random(-20, 20);
    popMatrix();

  }


  // sun (CUSTOM SUN)
  pushMatrix();
  rotate(r4, 1, 0, 0);
  shape(thesun);
  popMatrix();

  // planet1
  pushMatrix(); // go up one level
  rotate(r1, 0, 1, 0); // spin around the y axis
  translate(100, 0); // offset by 100 points on the x
  scale(0.5);
  shape(mercury); // draw the sphere
  popMatrix(); // go down a level

  // planet2
  pushMatrix(); // go up one level
  rotate(r2, 0, 1, 0); // spin around the y axis
  translate(200, 0); // offset by 100 points on the x
  scale(0.5);
  shape(venus); // draw the sphere

  // moon
  pushMatrix(); // go up another level
  rotate(r3, 1, 0, 0); // spin around the x axis
  translate(0, 75);
  scale(0.25);
  shape(moon);
  popMatrix();

  popMatrix(); // go down a level

  r1 = r1 + 0.1;
  r2 = r2 - 0.0075;
  r3 = r3 + 0.275;
  r4 = r4 - 0.01;

  xpos+=xstep;
  ypos+=ystep;
  zpos+=zstep;
  masterrotate+=mstep;
}

void keyPressed()
{
  if (keyCode==UP) {
    ystep=-5;
  }
  if (keyCode==DOWN) {
    ystep=5;
  }
  if (keyCode==LEFT) {
    xstep=-5;
  }
  if (keyCode==RIGHT) {
    xstep=5;
  }
  if (key=='='||key=='+')
  {
    zstep=5;
  }
  if (key=='-')
  {
    zstep-=5;
  }
  if (key=='r')
  {
    xpos = width/2;
    ypos = height/2;
    zpos = 0;
    masterrotate = 0;
  }
  if (key=='s')
  {
    mstep = 0.1;
  }
  if (key=='n')
  {
    makeTheShapes();
  }
}


void keyReleased()
{
  if (keyCode==UP) {
    ystep=0;
  }
  if (keyCode==DOWN) {
    ystep=0;
  }
  if (keyCode==LEFT) {
    xstep=0;
  }
  if (keyCode==RIGHT) {
    xstep=0;
  }
  if (key=='='||key=='+')
  {
    zstep=0;
  }
  if (key=='-')
  {
    zstep=0;
  }
  if (key=='s')
  {
    mstep=0;
  }
}

void makeTheShapes()
{
  thesun = createShape();
  thesun.beginShape();
  for (i=0; i<random (4, 17); i++)
  {
    thesun.vertex(random(-50, 50), random(-50, 50), random(-50, 50));
  }
  thesun.endShape(CLOSE);

  mercury = createShape();
  mercury.beginShape();
  for (i=0; i<random (4, 17); i++)
  {
    mercury.vertex(random(-50, 50), random(-50, 50), random(-50, 50));
  }
  mercury.endShape(CLOSE);

  venus = createShape();
  venus.beginShape();
  for (i=0; i<random (4, 17); i++)
  {
    venus.vertex(random(-50, 50), random(-50, 50), random(-50, 50));
  }
  venus.endShape(CLOSE);
  
  moon = createShape();
  moon.beginShape();
  for (i=0; i<random (4, 17); i++)
  {
    moon.vertex(random(-50, 50), random(-50, 50), random(-50, 50));
  }
  moon.endShape(CLOSE);

  star = createShape();
  star.beginShape();
  for (i=0; i<random (4, 17); i++)
  {
    star.vertex(random(-50, 50), random(-50, 50), random(-50, 50));
  }
  star.endShape(CLOSE);

}

