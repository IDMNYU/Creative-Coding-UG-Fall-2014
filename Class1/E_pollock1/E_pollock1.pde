
// myfirstsketch : draw a white square where my mouse is
// groovy

// at the top of the sketch
float r, g, b, x1, y1, x2, y2; // GLOBAL variables

// this runs when i hit play
void setup()
{
  size(800, 600); // sets up the size of the canvas
  
  background(255, 205, 205);
  
  x1 = width/2;
  y1 = height/2;
  
}

// this runs every frame
void draw()
{
    
    
  // these are variables:
  r = 192;
  g = 50;
  b = 255;
  
  x2 = x1+random(-20, 20);
  y2 = y1+random(-20, 20);
  
  // set a more interesting color
  noFill(); // don't draw a fill
  stroke(r, g, b, 100); // set the stroke to the nice purple
  line(x1, y1, x2, y2); // x1, y1, x2, y2
  
  fill(255, 192, 0, 100); // set the fill to yellow
  ellipse(x2, y2, 10, 10); // draw a circle
  
  // stash our new x and y for the next round
  x1 = x2;
  y1 = y2;
  
  // checking the boundaries
  if(x1>width) x1 = 0;
  if(x1<0) x1 = width;
  if(y1>height) y1 = 0;
  if(y1<0) y1 = height;
  
}

// this runs when i pick up a key on the keyboard
void keyReleased()
{
  if(key==' ') background(255, 192, 0);
  
}

