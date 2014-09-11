
void setup()
{
  size(800, 600, OPENGL);
}

void draw()
{
  background(255, 0, 0);
    translate(mouseX, mouseY);
    sphereDetail(30);
    sphere(100);
  
}
