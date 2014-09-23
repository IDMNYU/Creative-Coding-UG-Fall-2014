
int NUMSPHERES = 500; // how many spheres do i want?

// creating an array of our class
mySphere s[] = new mySphere[NUMSPHERES];

void setup()
{
  size(800, 600);
  background(0);
  fill(255);
  for (int i = 0; i<NUMSPHERES; i++)
  {
    s[i] = new mySphere(random(1, 20));
  }
}

void draw()
{
  background(255);

  for (int i = 0; i<NUMSPHERES; i++)
  {
    s[i].go();
    s[i].update(mouseX, mouseY);
  }
}

void keyReleased()
{
  for (int i = 0; i<NUMSPHERES; i++)
  {
    s[i] = new mySphere(random(1, 20));
  }
}

