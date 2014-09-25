
PFont f1; // this is the data structure for a font in processing

String thesentence = "My dog has FLEAS!!!";
float[] thesizes = new float[thesentence.length()];

void setup()
{
  size(800, 600);
  
  f1 = loadFont("GillSansShadowMTPro-48.vlw"); // this loads the font

  textFont(f1); // this tells processing which font to use
  textAlign(LEFT); // draw from left
}

void draw()
{
  background(0);
  fill(255);
  stroke(255);
    
  float x = 20;
  float y = 50;

  textFont(f1);

  for(int i = 0;i<thesentence.length();i++)
  {
    textSize(thesizes[i]);
    text(thesentence.charAt(i), x, y);
    x+= textWidth(thesentence.charAt(i));
  }

}

void keyReleased()
{
    for(int i = 0;i<thesizes.length;i++)
  {
    thesizes[i] = random(9, 48);
  }
  
}

void mousePressed()
{
  
}

void mouseReleased()
{
  
}
