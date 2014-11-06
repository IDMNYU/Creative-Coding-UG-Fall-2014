
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing e; // this is our world
PFont thefont; // this is a font

ArrayList<lukeWord> thewords;

int i;

// these are some words
String[] s = {"my", "dog", "has", "procrastination", "issues"};

void setup()
{
  size(500, 500, OPENGL);
    thefont = loadFont("CharcoalCY-48.vlw");
    textFont(thefont); // this is what font to use
    textSize(24); // this is the size of the text
    textAlign(CENTER); // this puts it in the middle
  
  thewords = new ArrayList<lukeWord>();
  
  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this);
  e.createWorld();
  e.setGravity(0, -10);
    
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame
  
  if(mousePressed)
  {
    lukeWord p = new lukeWord(s[floor(random(0,s.length))],random(8, 32),mouseX,mouseY); 
    thewords.add(p);
    
  }

  
  for(lukeWord w: thewords)
  {
     w.display(); 
  }
  
}

