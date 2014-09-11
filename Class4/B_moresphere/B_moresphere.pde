
float r = 0.;
int[] raxis = {1, 0, 0};

void setup()
{
  size(800, 600, OPENGL); // 3-D mode
  sphereDetail(30); // quality of sphere
  
  raxis[0] = 1;
  raxis[1] = 0;
  raxis[2] = 0;
}

void draw()
{
  lights(); // gimme some lights
  background(255, 0, 0);
  
  //noFill();
  //noStroke();
  
  // usually you translate, rotate, scale
  translate(mouseX, mouseY);
  rotate(r, raxis[0], raxis[1], raxis[2]); 
  scale(0.5);
  sphere(100);
  
  r = r + 0.1;
}

void keyPressed()
{
   if(key=='x') {
     raxis[0] = 1; 
     raxis[1] = 0; 
     raxis[2] = 0; 
   }
   if(key=='y') {
     raxis[0] = 0; 
     raxis[1] = 1; 
     raxis[2] = 0; 
   }
   if(key=='z') {
     raxis[0] = 0; 
     raxis[1] = 0; 
     raxis[2] = 1; 
   }
   
}



