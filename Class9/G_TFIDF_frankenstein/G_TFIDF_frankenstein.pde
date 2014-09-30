String thebook = "frankenstein_cooked.txt"; // what book?

String[] chapters; // this is gonna be the whole book
int whichchapter = 1; // start with chapter 1

lukeTFIDF thestuff; // this loads everything and sets it up

float thresh = 0.2; // this is the cutoff for an "important" word

PFont[] f = new PFont[5]; // these are our fonts

ArrayList<lukeWord> viswords; // these are the words we're currently showing

float noisecounter = random(100000000); // starting point for the noise

void setup()
{
  size(displayWidth, displayHeight);

  // load in our text file
  chapters = loadStrings(thebook);
  // println(chapters); // confirm!

  // create a TFIDF object and load the stuff
  thestuff = new lukeTFIDF(chapters);

  // tell the TFIDF to use chapter 1
  thestuff.setLine(whichchapter);

  // load in the PFont and set up the stuff for writing
  f[0] = loadFont("BaskervilleMTStd-Italic-48.vlw");
  f[1] = loadFont("AvenirNext-UltraLight-48.vlw");
  f[2] = loadFont("FagoEx-Italic-48.vlw");
  f[3] = loadFont("GaramondPremrPro-MedItSubh-48.vlw");
  f[4] = loadFont("HouseGothicHG23Cond-BOLD4-48.vlw");
  textFont(f[0]);
  textAlign(CENTER);
  colorMode(HSB);

  // annihilate arraylist
  viswords = new ArrayList<lukeWord>();
}

void draw()
{
  background(0);

  for (int i = 0; i<viswords.size (); i++)
  {
    viswords.get(i).go();
    viswords.get(i).animate(noisecounter+i);
  }
  noisecounter+=0.01;
}

void keyReleased()
{
  thestuff.setLine(whichchapter); // do a TFIDF on the current chapter
  String[] keys = thestuff.getKeys(); // copy over all the keys in that chapter

  // annihilate arraylist
  viswords = new ArrayList<lukeWord>();

  int i = 0;
  println("DOING TFIDF FOR CHAPTER " + whichchapter);
  while (true)
  {
    float val = thestuff.getValue(keys[i]);
    if (val<thresh) break; // get out of while loop

    viswords.add(new lukeWord(keys[i]));

    println(keys[i] + ": " + val);
    i++;
  }

  whichchapter = (whichchapter+1) % chapters.length;
}

