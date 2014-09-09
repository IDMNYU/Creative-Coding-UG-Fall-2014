
int oldmX, oldmY;

boolean firstTime = true;

void setup()
{
  size(400, 400);
  background(0);
}

void draw()
{
  
  float circlesize = 0;
  
  if(mousePressed) {
  if(firstTime)
  {
     oldmX = mouseX;
     oldmY = mouseY;
     firstTime = false; 
  }
  
  // pythagorize me
  int xterm = (oldmX-mouseX)*(oldmX-mouseX);
  int yterm = (oldmY-mouseY)*(oldmY-mouseY);
  circlesize = sqrt(xterm + yterm);
  // scale it
  circlesize = circlesize*0.5;
  

  fill(255);
  stroke(0);
  strokeWeight(1);
  ellipse(mouseX, mouseY, circlesize, circlesize);

  stroke(255, 255, 0);
  strokeWeight(circlesize/5);
  line(oldmX, oldmY, mouseX, mouseY);

  }
  
  oldmX = mouseX;
  oldmY = mouseY;
  
  
}

void mouseClicked()
{
  
   firstTime = true; 
  
}

void keyPressed()
{
   background(0); 
  
}

