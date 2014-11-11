
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
ArrayList<lukeWall> thewalls;

lukeBox thebox;

lukeSpring spring; // physics spring

int i;

int loadflicker = 0;

int WHICHSCENE = 0; // scene control
boolean firstframe = true; // first frame

int THESCORE = 0; // this is our total score
int SCENESCORE = 0; // this is the score for one scene
int THECLOCK = 0; // this is the clock for the scene
int SCENESTARTTIME = 0; // this is the millis() start for the scene
int SCENEDURATION = 15000; // this is how long a scene is

// what are the scene mechanics?
int NUMWORDS = 5; // how many initial words
int VELOCITY = 5; // the speed range of the words
int HARDFACTOR = 2; // words and speed doubles every time

void setup()
{
  size(800, 600, OPENGL);

  // FONT STUFF
  thefont = loadFont("AmplitudeWide-Ultra-24.vlw");
  textFont(thefont); // this is what font to use
  textSize(24); // this is the size of the text
  textAlign(CENTER); // this puts it in the middle

  //
  // PHYSICS STUFF
  //

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, 0); // this is gravity (x, y)

  // TURN ON COLLISION DETECTION!
  e.listenForCollisions();

  // WORDS AND WALLS
  thewords = new ArrayList<lukeWord>();
  thewalls = new ArrayList<lukeWall>();

  // make four walls
  lukeWall temp1 = new lukeWall(0, height/2, 30, height);
  thewalls.add(temp1);
  lukeWall temp2 = new lukeWall(width, height/2, 30, height);
  thewalls.add(temp2);
  lukeWall temp3 = new lukeWall(width/2, 0, width, 30);
  thewalls.add(temp3);
  lukeWall temp4 = new lukeWall(width/2, height, width, 30);
  thewalls.add(temp4);

  // CONTROLLER
  thebox = new lukeBox(width/2, height/2, 30, 30);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new lukeSpring();
  spring.bind(width/2, height/2, thebox);

  //
  // SOUND STUFF
  //
  
  minim = new Minim(this);

  for (int i = 0; i<groove.length; i++)
  {
    groove[i] = minim.loadFile("mitt.mp3", 2048);
  }
}

void draw()
{
  if (WHICHSCENE==0) drawscene0();
  else if (WHICHSCENE==1) drawscene1();
  else if (WHICHSCENE==2) drawscene2();
}

void keyReleased()
{
  if (WHICHSCENE==0) keyscene0();
  else if (WHICHSCENE==1) keyscene1();
  else if (WHICHSCENE==2) keyscene2();
}

void mouseDragged()
{
  if(WHICHSCENE==1) spring.update(mouseX, mouseY);
}



