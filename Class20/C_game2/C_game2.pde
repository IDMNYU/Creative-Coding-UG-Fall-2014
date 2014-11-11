
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

// this is the junk we need to play sound
import ddf.minim.*;

Box2DProcessing e; // this is our world
PFont thefont; // this is a font

Minim minim; // audio engine
AudioPlayer[] groove = new AudioPlayer[16];

float FRICTION = 0;

// these are some words
String[] s = {
  "now", "is", "the", "winter", "of", "our", "discontent"
};

ArrayList<lukeWord> thewords;


lukeBox thebox;

lukeSpring spring; // physics spring

int i;

int loadflicker = 0;

int WHICHSCENE = 0; // scene control
boolean firstframe = true; // first frame

int THESCORE = 0;
int THECLOCK = 0;
int SCENESTARTTIME = 0;
int SCENEDURATION = 15000;

int NUMWORDS1 = 30;

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

  // SOUND STUFF
  minim = new Minim(this);

  for(int i = 0;i<groove.length;i++)
  {
    groove[i] = minim.loadFile("mitt.mp3", 2048);
  }


}

void draw()
{
  if(WHICHSCENE==0) drawscene0();
  else if(WHICHSCENE==1) drawscene1();
  else if(WHICHSCENE==2) drawscene2();
}

void keyPressed()
{
  if(WHICHSCENE==0) keyscene0();
  else if(WHICHSCENE==1) keyscene1();
  else if(WHICHSCENE==2) keyscene2();
}

void mouseDragged()
{
  if(WHICHSCENE==0) mousescene0();
  else if(WHICHSCENE==1) mousescene1();
  else if(WHICHSCENE==2) mousescene2();
}


// THIS HAPPENS WHEN THINGS HIT EACH OTHER
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

