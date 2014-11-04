import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave; // this is an oscillator

String thestring = "A"; // this is our "axiom"
int stringposition = 0;

// this is gonna be how many times we run the L-system
int numloops = 5; 

void setup()
{
  frameRate(4);
  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

    wave = new Oscil( 440., 0., Waves.SINE ); // this sets up the oscillator
  wave.patch( out ); // this plugs into the speakers


  println("starting string: " + thestring);

  for (int i = 0; i<numloops; i++)
  {
    String outputstring = "";
    for (int j = 0; j<thestring.length (); j++)
    {
      if (thestring.charAt(j) == 'A')
      {
        outputstring+="AC";
      } else if (thestring.charAt(j) == 'B')
      {
        outputstring+="ABA";
      } else if (thestring.charAt(j) == 'C')
      {
        outputstring+="CBA";
      } else
      {
        outputstring+=thestring.charAt(j);
      }
    }
    thestring = outputstring;
    println("string at loop " + i + ": " + thestring);
  }
}

void draw()
{
  if (thestring.charAt(stringposition)=='A')
  {
    wave.setAmplitude(1.0);
    wave.setFrequency(220);
  } else if (thestring.charAt(stringposition)=='B')
  {
    wave.setAmplitude(0.5);
    wave.setFrequency(440);
  } else if (thestring.charAt(stringposition)=='C')
  {
    wave.setAmplitude(0.3);
    wave.setFrequency(660);
  }
  stringposition = (stringposition+1) % thestring.length();
}

