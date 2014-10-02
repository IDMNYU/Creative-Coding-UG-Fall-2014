// lukeMarkov - a simple first-order markov implementation for string keys
class lukeMarkov
{
  int current;
  private HashMap<Integer, ArrayList> hm = new HashMap<Integer, ArrayList>();

  // constructor with a string
  lukeMarkov(int[] sequence)
  {
    chain(sequence);
    rand(); // start with a random key
  }

  // chain: append a string to existing markov chain
  private void chain(int[] s)
  {
    ArrayList<Integer> temp = new ArrayList<Integer>(); // temporary array of strings

    // go through all the words in the string
    for (int j=0; j<s.length-1; j++)
    {
      // look for words already there
      int match = 0;

      if (hm.containsKey(s[j])) temp = hm.get(s[j]); // match - copy existing

      // add new word to chain
      temp.add(s[j+1]);
      hm.put(s[j], temp);
    }
  }

  // rand: pick a random initial key
  void rand()
  {
    ArrayList<Integer> s = new ArrayList<Integer>(hm.keySet());
    current = s.get(int(random(s.size())));
  }

  // tick: go one step through chain and set new key
  void tick()
  {
    // find current word
    if (hm.containsKey(current)) // match
    {

      ArrayList<Integer> s = new ArrayList<Integer>(hm.get(current));
      current = s.get(int(random(s.size())));
    } else
    {
      rand();
    }
  }

  // end class lukeMarkov
}

