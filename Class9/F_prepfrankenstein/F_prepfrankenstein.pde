
String[] lines;
String theinput = "frankenstein_raw.txt";
String theoutput = "frankenstein_cooked.txt";

void setup()
{
  // loads in the whole book as an array of strings:
  lines = loadStrings(theinput); 
  // println(alicelines.length); // print out how many lines!
  
  String bigstring = ""; // the WHOLE BOOK in one HUGE STRING
  // concatenate whole book into one string:
  for (int i = 0; i<lines.length; i++)
  {
    bigstring+=lines[i]+" ";
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

  String[] chapters = bigstring.split("(letter|chapter) [0-9]+");
  // how many chapters?
   println(chapters.length);

  // step 4: output a "cooked" text file
  PrintWriter output = createWriter(theoutput);
  
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

