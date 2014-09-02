
// myfirstsketch : draw a white square where my mouse is
// groovy

// at the top of the sketch
float r, g, b, w, h; // GLOBAL variables

// this runs when i hit play
void setup()
{
  size(800, 600); // sets up the size of the canvas
  
  background(255, 192, 0);
  
  // draw rectangles where coordinates are the center, not the edge:
  rectMode(CENTER); 
  
}

// this runs every frame
void draw()
{
    
    
  // these are variables:
  r = random(128, 255);
  g = random(0, 192);
  b = 0;
  
  w = random(5, 200);
  h = random(5, 200);
  
  // set a more interesting color
  fill(r, g, b, 25); // Red, Green, Blue, (Alpha)
  stroke(0, 0, 0, 25);

  rect(mouseX, mouseY, w, h); // x, y, w, h
}

// this runs when i pick up a key on the keyboard
void keyReleased()
{
  if(key==' ') background(255, 192, 0);
  
}

