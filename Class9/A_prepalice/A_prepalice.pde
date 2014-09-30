
String[] alicelines;

void setup()
{
  // loads in the whole book as an array of strings:
  alicelines = loadStrings("aliceinwonderland.txt"); 
  // println(alicelines.length); // print out how many lines!
  
  String bigstring = ""; // the WHOLE BOOK in one HUGE STRING
  // concatenate whole book into one string:
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
  // println(bigstring);

  String[] chapters = bigstring.split("chapter [a-z]+");
  // how many chapters?
  // println(chapters.length);

  // step 4: output a "cooked" text file
  PrintWriter output = createWriter("alice_cooked.txt");
  
  // write line-by-line, trimming leading and trailing space
  for (int i = 0;i<chapters.length;i++)
  {
     output.println(chapters[i].trim()); 
  }
  
  output.flush(); // wait for file to finish reading
  output.close(); // close the file
  
  exit(); // kill program

}

void draw()
{
}

