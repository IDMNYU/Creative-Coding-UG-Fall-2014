
// myfirstsketch : draw a white square where my mouse is
// groovy

// this runs when i hit play
void setup()
{
  size(800, 600); // sets up the size of the canvas
  
  // draw rectangles where coordinates are the center, not the edge:
  rectMode(CENTER); 
  
  // set a more interesting color
  fill(255, 0, 0, 2); // Red, Green, Blue, (Alpha)
  stroke(0, 0, 255, 10);
}

// this runs every frame
void draw()
{
  rect(mouseX, mouseY, 100, 100); // x, y, w, h
}

