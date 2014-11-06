
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world
PFont thefont; // this is a font

float FRICTION = 0;

// these are some words
String[] s = {
  "now", "is", "the", "winter", "of", "our", "discontent"
};

ArrayList<lukeWord> thewords;

ArrayList<lukeWall> thewalls;

int i;

void setup()
{
  size(500, 500, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, -5); // this is gravity (x, y)

  thefont = loadFont("AmplitudeWide-Ultra-24.vlw");
  textFont(thefont); // this is what font to use
  textSize(24); // this is the size of the text
  textAlign(CENTER); // this puts it in the middle

  thewords = new ArrayList<lukeWord>();
  thewalls = new ArrayList<lukeWall>();
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame

  // fancy for loop shorthand (iterator)
  for(lukeWord w: thewords)
  {
     w.display(); 
  }
  for(lukeWall w: thewalls)
  {
     w.display(); 
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
  lukeWord p = new lukeWord(s[floor(random(0, s.length))], random(8, 32), mouseX, mouseY); 
  thewords.add(p);
}

