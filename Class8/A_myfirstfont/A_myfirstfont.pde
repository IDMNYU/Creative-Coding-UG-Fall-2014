
PFont thefont; // this is the data structure for a font in processing


void setup()
{
  size(800, 600);
  
  thefont = loadFont("FagoCo-Expert-48.vlw"); // this loads the font
  textFont(thefont); // this tells processing which font to use
  textAlign(CENTER); // draw from center
  textSize(48); // how big to draw words
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);
  
  text("my dog has fleas", width/2, height/2);
  
}
