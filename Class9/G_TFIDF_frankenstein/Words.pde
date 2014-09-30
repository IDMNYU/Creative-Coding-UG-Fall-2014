// lukeWords - a bunch of words that can float
class lukeWord
{
  String word;
  float x;
  float y;

  lukeWord(String s)
  {
    word = s;
    x = random(0, width);
    y = random(0, height);
  }

  void go()
  {

    float thevalue = thestuff.getValue(word); // grab 0-1 out of TFIDF for that word

    float xthresh = float(mouseX)/(width-50);
    float ythresh = float(height-mouseY)/(height-50);
    if (ythresh <= thevalue && xthresh >= thevalue) {
      int whichfont = int(map(thevalue, 0.2, 1., 0, 4));
      textFont(f[whichfont]);
      textSize(48*thevalue);
      fill(255*thevalue, 200, 200);
      text(word, x, y);
    }
  }
  
  void animate(float n)
  {
     x = x+noise(n)-0.5;
     y = y+noise(n+1000)-0.5;
 
  }
}

