void makethestring()
{
  thestring = "X";
  numloops = 6;
  therulez.put('X', "F-[[X]+XT]+F[+FX]-X");
  therulez.put('F', "FF");
  
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

