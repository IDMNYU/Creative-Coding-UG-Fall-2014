
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world

lukeBox[] theboxes = new lukeBox[100];

int i;

void setup()
{
  size(500, 500, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, -10); // this is gravity (x, y)

  for (i = 0; i<theboxes.length; i++)
  {
    theboxes[i] = new lukeBox(random(0, width), random(0, height), random(5, 30), random(5, 30));
  }
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame

  for (i=0; i<theboxes.length; i++)
  {
    theboxes[i].display();
  }
}

void keyReleased()
{
  for (i=0; i<theboxes.length; i++)
  {
    theboxes[i].killBody(); 
    theboxes[i] = new lukeBox(random(0, width), random(0, height), random(5, 30), random(5, 30));
  }
}

