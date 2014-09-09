// check this out:
// http://numeral.com/agents/gateFiles/


void setup()
{
    size(800, 600);
    background(0);
}


void draw()
{
  if(mousePressed)
  {
    float d = sqrt((pmouseX-mouseX)*(pmouseX-mouseX) + (pmouseY-mouseY)*(pmouseY-mouseY));
    d = d*0.5;
    
    fill(255);
    stroke(0);
    strokeWeight(1);
    ellipse(mouseX, mouseY, d, d);
    
    stroke(255, 255, 0);
    strokeWeight(d/5);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

void keyPressed()
{
   background(0); 
}

