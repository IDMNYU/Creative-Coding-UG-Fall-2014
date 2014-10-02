
PFont thefont;
lukeMarkov mc;

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

  int[] s1 = {62, 62, 64, 62, 67, 66, 62, 62,
                        64, 62, 69, 67, 62, 62, 74, 71,
                        67, 66, 64, 72, 72, 71, 67, 69, 67}; // hbd

  int[] s2 = {64, 66, 71, 73, 74, 66, 64, 73, 71, 66, 74, 73}; // pianophase
  
  int[] s3 = {60, 57, 53, 57, 60, 65, 69, 67, 65, 57, 59, 60}; // ssb

  mc = new lukeMarkov(s1);

  background(0);
}


void draw()
{
  // background(0);
  fill(random(128, 255), random(128, 255), random(128, 255));
  mc.tick();
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
}

