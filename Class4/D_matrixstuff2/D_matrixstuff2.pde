
float r1 = 0.;
float r2 = 0.;
float r3 = 0.;


float xpos, ypos, zpos;
float xstep, ystep, zstep;
float masterrotate = 0.;
float mstep;

void setup()
{
  size(800, 600, OPENGL); // 3-D mode
  sphereDetail(30); // quality of sphere

  ypos = height/2;
  xpos = width/2;
  zpos = 0;
}

void draw()
{
  lights(); // gimme some lights
  background(255, 0, 0);

  //noFill();
  //noStroke();

  // CAMERA
  translate(xpos, ypos, zpos); // move center to where my mouse is
  rotate(masterrotate, 0, 0, 1);

    // sun
//  sphere(50); // draw big sphere
  ellipse(0, 0, 50, 50);
  
  // planet1
  pushMatrix(); // go up one level
  rotate(r1, 0, 1, 0); // spin around the y axis
  translate(100, 0); // offset by 100 points on the x
//  sphere(20); // draw the sphere
  ellipse(0, 0, 20, 20);
  popMatrix(); // go down a level

  // planet2
  pushMatrix(); // go up one level
  rotate(r2, 0, 1, 0); // spin around the y axis
  translate(200, 0); // offset by 100 points on the x
  //sphere(20); // draw the sphere
  ellipse(0, 0, 20, 20);

  // moon
  pushMatrix(); // go up another level
  rotate(r3, 1, 0, 0); // spin around the x axis
  translate(0, 75);
  //sphere(10);
  ellipse(0, 0, 10, 10);
  popMatrix();

  popMatrix(); // go down a level

  r1 = r1 + 0.1;
  r2 = r2 - 0.0075;
  r3 = r3 + 0.275;

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

