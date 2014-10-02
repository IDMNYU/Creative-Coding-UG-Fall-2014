
// make me a class for a markov chain
class lukeMarkov
{
  int current; // this is the current value in the chain
  private HashMap<Integer, ArrayList> hm = new HashMap<Integer, ArrayList>();

  // constructor with a integer list
  lukeMarkov(int[] sequence)
  {
    chain(sequence); // make the probability table
    rand(); // start at a random value
  }

  // chain:
  private void chain(int[] s)
  {
    for (int i = 0; i<s.length-1; i++)
    {
      ArrayList<Integer> temp = new ArrayList<Integer>(); // temporary
      // look for if the value is already in the HashMap
      if (hm.containsKey(s[i])) temp = hm.get(s[i]); // this is a match
      temp.add(s[i+1]);
      println("key for " + s[i] + " is now: " + temp);
      hm.put(s[i], temp);
    }
    println(hm);
  }

  // rand:
  void rand()
  {
    ArrayList<Integer> s = new ArrayList<Integer>(hm.keySet());
    current = s.get(int(random(s.size())));
  }

  // tick:
  void tick()
  {
    // find current word
    if (hm.containsKey(current))
    {
      ArrayList<Integer> s = new ArrayList<Integer>(hm.get(current));
      current = s.get(int(random(s.size())));
    } else
    {
      rand();
    }
  }
}

