
PFont thefont;
lukeMarkov mc;

//String thebook = "frankenstein_cooked.txt";
String thebook = "alice_cooked.txt";


float x, y;

void setup()
{
  size(800, 600);
  frameRate(15);
  thefont = loadFont("AmplitudeWide-Light-48.vlw");
  textFont(thefont);
  textSize(36);
  textAlign(LEFT);
  x = 20;
  y = 30;

  String chapters[] = loadStrings(thebook);
  mc = new lukeMarkov(chapters);

  background(0);
}


void draw()
{
  // background(0);
  fill(random(128, 255), random(128, 255), random(128, 255));
  println(mc.current);
  float tw = textWidth(mc.current+" ");
  if (x+tw>width)
  {
    x = 20;
    y+=36;
  }
  text(mc.current, x, y);
  x+=tw;
  if(y>height)
  {
     x = 20;
     y = 30;
     background(0); 
  }
  mc.tick();
}

