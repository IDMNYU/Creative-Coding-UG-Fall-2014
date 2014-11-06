
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world

ArrayList<lukeBox> theboxes;

int i;

void setup()
{
  size(500, 500, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, -10); // this is gravity (x, y)

  theboxes = new ArrayList<lukeBox>();
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame

  for (i=0; i<theboxes.size(); i++)
  {
    theboxes.get(i).display();
  }
}

void keyReleased()
{
  background(0);
  
}

void mouseDragged()
{
  lukeBox temp = new lukeBox(mouseX, mouseY, random(5, 30), random(5, 30));
  theboxes.add(temp);
}

