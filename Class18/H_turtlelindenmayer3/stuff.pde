void makethestring()
{
  thestring = "A";
  numloops = 5;
  therulez.put('A', "-BF+AFA+FB-");
  therulez.put('B', "+AF-BFB-FA+");
  
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

