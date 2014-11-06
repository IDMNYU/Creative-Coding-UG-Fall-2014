
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

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
  size(800, 600, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, 0); // this is gravity (x, y)

  // TURN ON COLLISION DETECTION!
  e.listenForCollisions();


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


  for (i = 0; i<thewords.size (); i++)
  {
    if (thewords.get(i).destroyme == 1)
    {
      thewords.get(i).killBody();
      thewords.remove(i);
    } else
    {
      thewords.get(i).display();
    }
  }

  // fancy for loop shorthand (iterator)
  for (lukeWall w : thewalls)
  {
    w.display();
  }
  fill(255, 0, 255);
  textSize(24);
  text("words: " + thewords.size(), 80, 50);
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


// THIS HAPPENS WHEN THIS HIT EACH OTHER
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  int wallhitsword = 0;
  if (o1.getClass() == lukeWall.class && o2.getClass() == lukeWord.class) wallhitsword = 1;
  if (o2.getClass() == lukeWall.class && o1.getClass() == lukeWord.class) wallhitsword = 2;

  if (wallhitsword==1)
  {
    lukeWord w = (lukeWord) o2;
    w.boink();
  }
  else if(wallhitsword==2)
  {
    lukeWord w = (lukeWord) o1;
    w.boink();    
  }
}

// THIS HAPPENS WHEN THINGS STOP HITTING EACH OTHER
void endContact(Contact cp) {
  
}

