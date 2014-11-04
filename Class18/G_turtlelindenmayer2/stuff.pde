void makethestring()
{
  thestring = "FX";
  numloops = 10;
  therulez.put('X', "X+YF");
  therulez.put('Y', "FX−Y");
  
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

