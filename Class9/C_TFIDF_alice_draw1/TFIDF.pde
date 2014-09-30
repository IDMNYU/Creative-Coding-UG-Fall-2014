// lukeTFIDF - a groovy TFIDF generator based on a corpus (string array)
class lukeTFIDF
{
  private FloatDict df; // document (corpus) frequency
  FloatDict tfidf; // term frequency for specific line in corpus
  int line = 1; // current line
  String[] lines; // internal array containing the entire book

  // constructor : runs when ya make it
  lukeTFIDF(String[] l) // you give it a string of lines, e.g. a whole book
  {
    lines = l; // copy over the whole thing
    df = new FloatDict(); // blank out the document freq. dictionary
    tfidf = new FloatDict(); // blank out the term dictionary

    // create document frequency array of entire corpus
    for (int i = 0; i<lines.length; i++)
    {
      String[] words = lines[i].split(" ");
      // println("chapter " + i + " has " + words.length + " words."); 

      // add words to dictionary
      for (int j = 0; j<words.length; j++)
      {
        String currentword = words[j];
        if (df.hasKey(currentword)) // word exists in dictionary
        {
          df.add(currentword, 1); // add 1 to value of existing key
        } else // new word, add '1' for initial value
        {
          df.set(currentword, 1);
        }
      }
    }
    // sort dictionary in reverse order
    df.sortValuesReverse();
    // println(df);
  }
  
  void setLine(int i)
  {
    line = i;
    tfidf = doTFIDF(lines[line], df);
    // println(tfidf);

  }
  
  int getLine()
  {
     return(line); 
  }
  
  // utility to get value out of tfidf FloatDict
  float getValue(String w)
  {
    return(tfidf.get(w));
  }
  
  // utility to get key array out of FloatDict
  String[] getKeys()
  {
     return(tfidf.keyArray()); 
  }

  private FloatDict doTFIDF(String s, FloatDict d)
  {
    FloatDict t = new FloatDict();
    String[] words = s.split(" ");

    // add words to dictionary
    for (int i = 0; i<words.length; i++)
    {
      String currentword = words[i];
      if (t.hasKey(currentword)) // word exists in dictionary
      {
        t.add(currentword, 1);
      } else // new word, add '1' for initial value
      {
        t.set(currentword, 1);
      }
    }

    // divide by master dictionary
    String[] keys = t.keyArray(); // copy keylist into an array
    for (int i = 0; i<keys.length; i++)
    {
      float docfreq = d.get(keys[i]);
      t.div(keys[i], docfreq);
    }

    // sort dictionary
    t.sortValuesReverse();

    // return the TFIDF for this string
    return(t);
  }

  // end lukeTFIDF
}


