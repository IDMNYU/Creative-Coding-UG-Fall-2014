
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world

float FRICTION = 0;

ArrayList<lukeBox> theboxes;

ArrayList<lukeWall> thewalls;

int i;

void setup()
{
  size(500, 500, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, -5); // this is gravity (x, y)

  theboxes = new ArrayList<lukeBox>();
  thewalls = new ArrayList<lukeWall>();
}

void draw()
{
  background(0);
  rotateWall();
  e.step(); // advances the physics engine one frame

  for (i=0; i<theboxes.size (); i++)
  {
    theboxes.get(i).display();
  }

  for (i=0; i<thewalls.size (); i++)
  {
    thewalls.get(i).display();
  }
}

void rotateWall()
{
  if (thewalls.size()>0) {
    int choice = int(random(0, thewalls.size()));
    thewalls.get(choice).killBody();
    thewalls.remove(choice);
    int orientation = int(random(0, 2));
    float longway = random(100, 300);
    float shortway = random(2, 10);
    if (orientation==0) {
      lukeWall temp = new lukeWall(random(0, width), random(0, height), longway, shortway);
      thewalls.add(temp);
    } else 
    {
      lukeWall temp = new lukeWall(random(0, width), random(0, height), shortway, longway);
      thewalls.add(temp);
    }
  }
}

void keyReleased()
{
  int orientation = int(random(0, 2));
  float longway = random(100, 300);
  float shortway = random(2, 10);
  if (orientation==0) {
    lukeWall temp = new lukeWall(random(0, width), random(0, height), longway, shortway);
    thewalls.add(temp);
  } else 
  {
    lukeWall temp = new lukeWall(random(0, width), random(0, height), shortway, longway);
    thewalls.add(temp);
  }
}

void mouseDragged()
{
  lukeBox temp = new lukeBox(mouseX, mouseY, random(5, 30), random(5, 30));
  theboxes.add(temp);
}

