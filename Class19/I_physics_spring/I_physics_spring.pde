
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


lukeBox thebox;

lukeSpring spring; // physics spring

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

  thebox = new lukeBox(width/2, height/2, 30, 30);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new lukeSpring();
  spring.bind(width/2, height/2, thebox);
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

  thebox.display();
  fill(255, 0, 255);
  textSize(24);
  text("words: " + thewords.size(), 80, 50);
}

void keyPressed()
{
  lukeWord p = new lukeWord(s[floor(random(0, s.length))], random(8, 32), random(0, width), random(0, height)); 
  thewords.add(p);
}

void mouseDragged()
{
  spring.update(mouseX, mouseY);
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
  int boxhitsword = 0;
  if (o1.getClass() == lukeBox.class && o2.getClass() == lukeWord.class) boxhitsword = 1;
  if (o2.getClass() == lukeBox.class && o1.getClass() == lukeWord.class) boxhitsword = 2;

  if (boxhitsword==1)
  {
    lukeWord w = (lukeWord) o2;
    w.boink();
  } else if (boxhitsword==2)
  {
    lukeWord w = (lukeWord) o1;
    w.boink();
  }
}

// THIS HAPPENS WHEN THINGS STOP HITTING EACH OTHER
void endContact(Contact cp) {
}

