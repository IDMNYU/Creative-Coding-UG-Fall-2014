
HashMap<Character, String> therulez = new HashMap<Character, String>();
String thestring = "A"; // this is our "axiom"
int stringposition = 0;
// this is gonna be how many times we run the L-system
int numloops = 5; 

void setup()
{
  frameRate(4);

  println("starting string: " + thestring);

  makethestring();
}

void draw()
{
  if (thestring.charAt(stringposition)=='A')
  {
  } else if (thestring.charAt(stringposition)=='B')
  {
  } else if (thestring.charAt(stringposition)=='C')
  {
  }
  stringposition = (stringposition+1) % thestring.length();
}

void makethestring()
{
  therulez.put('A', "AC");
  therulez.put('B', "ABA");
  therulez.put('C', "CBA");
  for (int i = 0; i<numloops; i++)
  {
    thestring = lindenmayer(thestring);
    println("string at loop " + i + ": " + thestring);
  }
}

String lindenmayer(String s)
{
  String outputstring = "";
  for (int j = 0; j<s.length (); j++)
  {
    if (therulez.containsKey(s.charAt(j)))
    {
      outputstring+=therulez.get(s.charAt(j));
    } else
    {
      outputstring+=s.charAt(j);
    }
  }
  return(outputstring);
}

