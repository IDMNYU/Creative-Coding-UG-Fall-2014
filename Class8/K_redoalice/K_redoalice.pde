
String[] alicelines;

void setup()
{
  alicelines = loadStrings("aliceinwonderland.txt");
  println(alicelines.length);
  String bigstring = "";
  for (int i = 0; i<alicelines.length; i++)
  {
    bigstring+=alicelines[i]+" ";
  }
  // this is how this works:
  // bigstring = bigstring.replaceAll("rabbit", "fox");
  
  // strip all punctuation (regex)
  bigstring = bigstring.replaceAll("[^a-zA-Z0-9' ]", " ");

  // fix apostrophe catastrophe
  bigstring = bigstring.replaceAll(" '", " ");
  bigstring = bigstring.replaceAll("' ", " ");
  
  // move to lowercase
  bigstring = bigstring.toLowerCase();
  
  // strip extra whitespace (regex)
  bigstring = bigstring.trim().replaceAll(" +", " ");

  // view:
  println(bigstring);

  String[] chapters = bigstring.split("chapter ");
  // how many chapters?
  println(chapters.length);


  exit();
}

void draw()
{
}

