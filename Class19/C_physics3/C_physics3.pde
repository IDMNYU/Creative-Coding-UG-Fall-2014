
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world

float FRICTION = 0;

ArrayList<lukeBox> theboxes;

lukeWall w;

int i;

void setup()
{
  size(500, 500, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, -10); // this is gravity (x, y)

  theboxes = new ArrayList<lukeBox>();
  
  w = new lukeWall(150, 400, 200, 20);
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame

  for (i=0; i<theboxes.size(); i++)
  {
    theboxes.get(i).display();
  }
  
  w.display();
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

