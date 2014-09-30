
String[] chapters; // this is gonna be the whole book
int whichchapter = 1; // start with chapter 1

lukeTFIDF thestuff; // this loads everything and sets it up

float thresh = 0.2; // this is the cutoff for an "important" word

void setup()
{
  // load in our text file
  chapters = loadStrings("alice_cooked.txt");
  // println(chapters); // confirm!

  // create a TFIDF object and load the stuff
  thestuff = new lukeTFIDF(chapters);

  // tell the TFIDF to use chapter 1
  thestuff.setLine(whichchapter);
}

void draw()
{
}

void keyReleased()
{
  thestuff.setLine(whichchapter); // do a TFIDF on the current chapter
  String[] keys = thestuff.getKeys(); // copy over all the keys in that chapter
  int i = 0;
  println("DOING TFIDF FOR CHAPTER " + whichchapter);
  while (true)
  {
    float val = thestuff.getValue(keys[i]);
    if (val<thresh) break; // get out of while loop
    println(keys[i] + ": " + val);
    i++;
  }
  
  whichchapter = (whichchapter+1) % chapters.length;
}

