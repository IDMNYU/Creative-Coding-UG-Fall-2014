
PFont f1, f2; // this is the data structure for a font in processing


void setup()
{
  size(800, 600);
  
  f1 = loadFont("FagoCo-Expert-48.vlw"); // this loads the font
  f2 = loadFont("GillSansShadowMTPro-48.vlw"); // this loads the font
  textFont(f1); // this tells processing which font to use
  textAlign(CENTER); // draw from center
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);
  textSize(float(mouseX)/width*48.0); // how big to draw words
  
  text("my dog has fleas", width/2, height/2);
  
}

void mousePressed()
{
  textFont(f2); // this tells processing which font to use
  
}

void mouseReleased()
{
  textFont(f1); // this tells processing which font to use
  
}
