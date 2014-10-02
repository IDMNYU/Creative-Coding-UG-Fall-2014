// lukeMarkov - a simple first-order markov implementation for string keys
class lukeMarkov
{
  String current;
  private HashMap<String, ArrayList> hm = new HashMap<String, ArrayList>();

  // constructor with a string
  lukeMarkov(String lines)
  {
    chain(lines);
    rand(); // start with a random key
  }
  // constructor with an array of strings
  lukeMarkov(String[] lines)
  {
    for (int i=0; i < lines.length; i++) {
      chain(lines[i]);
    }
    rand(); // start with a random key
  }

  // chain: append a string to existing markov chain
  private void chain(String s)
  {
    String[] words = s.split(" "); // split the string into an array of words

    // go through all the words in the string
    for (int j=0; j<words.length-1; j++)
    {
      ArrayList<String> temp = new ArrayList<String>(); // temporary array of strings

      if (hm.containsKey(words[j])) temp = hm.get(words[j]); // match - copy existing

      // add new word to chain
      temp.add(words[j+1]);
      hm.put(words[j], temp);
    }
  }

  // rand: pick a random initial key
  void rand()
  {
    ArrayList<String> words = new ArrayList<String>(hm.keySet());
    current = words.get(int(random(words.size())));
  }

  // tick: go one step through chain and set new key
  void tick()
  {
    String newword = "";
    // find current word
    if (hm.containsKey(current)) // match
    {

      ArrayList<String> words = new ArrayList<String>(hm.get(current));
      current = words.get(int(random(words.size())));
    } else
    {
      rand();
    }
  }

  // end class lukeMarkov
}

