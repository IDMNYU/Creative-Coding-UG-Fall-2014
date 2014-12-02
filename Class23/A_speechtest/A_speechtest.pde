// Processing Text to Speech
// Eric Mika, Winter 2010
// Tested on Max OS 10.6 only, possibly compatible with 10.5 (with modification)
// Adapted from code by Denis Meyer (CallToPower)
// Thanks to Mark Triant for the inspiring sample text

String script = "my dog has fleas";
int voiceIndex;
int voiceSpeed;

void setup() {
  size(500, 500);
}

void draw() {
  background(0);

  // set the voice based on mouse y
  voiceIndex = round(map(mouseY, 0, height, 0, TextToSpeech.voices.length - 1));

  //set the vooice speed based on mouse X
  voiceSpeed = mouseX;

  // help text
  fill(255);
  text("Click to hear " + TextToSpeech.voices[voiceIndex] + "\nsay \"" + script + "\"\nat speed " + mouseX, 10, 20);

  fill(128);
  text("Mouse X sets voice speed.\nMouse Y sets voice.", 10, 65);
}

void mousePressed() {
  // say something
  TextToSpeech.say(script, TextToSpeech.voices[voiceIndex], voiceSpeed);
}


// the text to speech class
import java.io.IOException;

static class TextToSpeech extends Object {

  // Store the voices, makes for nice auto-complete in Eclipse

  // male voices
  static final String ALEX = "Alex";
  static final String BRUCE = "Bruce";
  static final String FRED = "Fred";
  static final String JUNIOR = "Junior";
  static final String RALPH = "Ralph";

  // female voices
  static final String AGNES = "Agnes";
  static final String KATHY = "Kathy";
  static final String PRINCESS = "Princess";
  static final String VICKI = "Vicki";
  static final String VICTORIA = "Victoria";

  // novelty voices
  static final String ALBERT = "Albert";
  static final String BAD_NEWS = "Bad News";
  static final String BAHH = "Bahh";
  static final String BELLS = "Bells";
  static final String BOING = "Boing";
  static final String BUBBLES = "Bubbles";
  static final String CELLOS = "Cellos";
  static final String DERANGED = "Deranged";
  static final String GOOD_NEWS = "Good News";
  static final String HYSTERICAL = "Hysterical";
  static final String PIPE_ORGAN = "Pipe Organ";
  static final String TRINOIDS = "Trinoids";
  static final String WHISPER = "Whisper";
  static final String ZARVOX = "Zarvox";

  // throw them in an array so we can iterate over them / pick at random
  static String[] voices = {
    ALEX, BRUCE, FRED, JUNIOR, RALPH, AGNES, KATHY,
    PRINCESS, VICKI, VICTORIA, ALBERT, BAD_NEWS, BAHH,
    BELLS, BOING, BUBBLES, CELLOS, DERANGED, GOOD_NEWS,
    HYSTERICAL, PIPE_ORGAN, TRINOIDS, WHISPER, ZARVOX
  };

  // this sends the "say" command to the terminal with the appropriate args
  static void say(String script, String voice, int speed) {
    try {
      Runtime.getRuntime().exec(new String[] {"say", "-v", voice, "[[rate " + speed + "]]" + script});
    }
    catch (IOException e) {
      System.err.println("IOException");
    }
  }

  // Overload the say method so we can call it with fewer arguments and basic defaults
  static void say(String script) {
    // 200 seems like a resonable default speed
    say(script, ALEX, 200);
  }

}
