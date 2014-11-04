
// L-system stuff:
HashMap<Character, String> therulez = new HashMap<Character, String>();
String thestring; // this is our "axiom"
int stringposition = 0;
// this is gonna be how many times we run the L-system
int numloops; 

// turtle stuff:
int MAXSTACK = 256;
float[] x = new float[MAXSTACK];
float[] y = new float[MAXSTACK];
float[] currentangle = new float[MAXSTACK];
int curstack = 0;
float step = 20; // how far does the turtle move?
float angle = 90; // how much does the turtle turn?
float radius;

int isplaying = 0;

void setup()
{
  println("starting string: " + thestring);
  makethestring();
  
  size(800, 600);
  stroke(0, 128, 0);
  noFill();
  turtleize('c');
}

void draw()
{
  float r = random(128, 255);
  float g = random(0, 192);
  float b = random(0, 50);
  float a = random(50, 100);
  radius = random(0, step);
  fill(r, g, b, a);
  ellipse(x[curstack], y[curstack], radius, radius);
  if (isplaying==1) {
    turtleize(thestring.charAt(stringposition));
    stringposition = (stringposition+1) % thestring.length();
  }
}

void turtleize(char c)
{
  if (c == 'F')
  {
    float x1 = x[curstack]+step*cos(radians(currentangle[curstack]));
    float y1 = y[curstack]+step*sin(radians(currentangle[curstack]));
    line(x[curstack], y[curstack], x1, y1);
    x[curstack] = x1;
    y[curstack] = y1;
  } else if (c == '+')
  {
    currentangle[curstack]+=angle;
  } else if (c == '-')
  {
    currentangle[curstack]-=angle;
  } else if (c == '[')
  {
    curstack = curstack + 1;
    x[curstack] = x[curstack-1];
    y[curstack] = y[curstack-1];
    currentangle[curstack] = currentangle[curstack-1];
    if (curstack >= MAXSTACK) println("AAAAAAAH!!!!");
  } else if (c == ']')
  {
    curstack = curstack - 1;
    if (curstack < 0) println("EEEEEEEEEEEEEEEH!!!!!");
  } 
  else if (c=='T')
  {
     rect(x[curstack], y[curstack], radius*3., radius*3.); 
  }
  
  
  
  // non-graphics commands
  else if (c=='c')
  {
    background(255);
    x[0] = width/8;
    y[0] = height/2;
    currentangle[curstack] = 270;
    stringposition = 0;
    curstack = 0;
  } else if (c=='p')
  {
    isplaying = 1;
  } else if (c=='s')
  {
    isplaying = 0;
  }
}

void keyReleased()
{
  turtleize(key); // run the drawing function with the current key
}

