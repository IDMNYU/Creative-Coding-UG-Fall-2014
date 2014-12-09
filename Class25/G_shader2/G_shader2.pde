
PShader blur; // this is the shader file

int whichway = 0;

void setup() {
  size(640, 360, P2D); // P2D -> OpenGL mode in 2D
  blur = loadShader("luma.glsl"); // load in shader file
  stroke(255, 0, 0); // red
  rectMode(CENTER); // draw from center
}

void draw() {
  //background(255);
  if(whichway==0) filter(blur); // apply shader to entire screen
  rect(mouseX, mouseY, 150, 150); 
  ellipse(mouseX, mouseY, 100, 100);
  if(whichway==1) filter(blur); // apply shader to entire screen
}

void keyReleased()
{
   background(192); 
   whichway = 1-whichway;
}



