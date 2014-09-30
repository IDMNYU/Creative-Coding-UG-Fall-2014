
String[] chapters; // this is gonna be the whole book
int whichchapter = 1; // start with chapter 1

lukeTFIDF thestuff; // this loads everything and sets it up

float thresh = 0.2; // this is the cutoff for an "important" word

PFont thefont; // this is our font

ArrayList<String> viswords; // these are the words we're currently showing
ArrayList<Float> xpos; // this is the x position of each word
ArrayList<Float> ypos; // this is the y position of each word

float noisecounter = random(100000000);

void setup()
{
  size(800, 600);

  // load in our text file
  chapters = loadStrings("alice_cooked.txt");
  // println(chapters); // confirm!

  // create a TFIDF object and load the stuff
  thestuff = new lukeTFIDF(chapters);

  // tell the TFIDF to use chapter 1
  thestuff.setLine(whichchapter);

  // load in the PFont and set up the stuff for writing
  thefont = loadFont("BaskervilleMTStd-Italic-48.vlw");
  textFont(thefont);
  textAlign(CENTER);

  // annihilate arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();
}

void draw()
{
  background(0);

  for (int i = 0; i<viswords.size (); i++)
  {
    String theword = viswords.get(i);
    float x = xpos.get(i);
    float y = ypos.get(i);
    
    textSize(48*thestuff.getValue(theword));
    text(theword, x, y);
    
    xpos.set(i, x+noise(noisecounter+i)-0.5);
    ypos.set(i, y+noise(noisecounter+i+1000)-0.5);
  }
    noisecounter+=0.001;    
}

void keyReleased()
{
  thestuff.setLine(whichchapter); // do a TFIDF on the current chapter
  String[] keys = thestuff.getKeys(); // copy over all the keys in that chapter

  // annihilate arraylists
  viswords = new ArrayList<String>();
  xpos = new ArrayList<Float>();
  ypos = new ArrayList<Float>();

  int i = 0;
  println("DOING TFIDF FOR CHAPTER " + whichchapter);
  while (true)
  {
    float val = thestuff.getValue(keys[i]);
    if (val<thresh) break; // get out of while loop

    viswords.add(keys[i]);
    xpos.add(random(0, width));
    ypos.add(random(0, height));

    println(keys[i] + ": " + val);
    i++;
  }

  whichchapter = (whichchapter+1) % chapters.length;
}

