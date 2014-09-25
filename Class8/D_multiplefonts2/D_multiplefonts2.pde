
PFont f1, f2; // this is the data structure for a font in processing

void setup()
{
  size(800, 600);
  
  f1 = loadFont("FagoCo-Expert-48.vlw"); // this loads the font
  f2 = loadFont("GillSansShadowMTPro-48.vlw"); // this loads the font

  textFont(f1); // this tells processing which font to use
  textAlign(LEFT); // draw from left
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);
  
  float s = float(mouseX)/width*48.0; // how big to draw the words
  
  float x = 20;
  float y = 50;
  
  textFont(f1);
  textSize(s);
  text("my", x, y);
  x+= textWidth("my ");

  textFont(f2);
  textSize(s);
  text("dog", x, y);
  x+= textWidth("dog ");

  textFont(f1);
  textSize(s);
  text("has", x, y);
  x+= textWidth("has ");

  textFont(f2);
  textSize(s);
  text("fleas", x, y);
  x+= textWidth("fleas");
  
  
}

void mousePressed()
{
  
}

void mouseReleased()
{
  
}
