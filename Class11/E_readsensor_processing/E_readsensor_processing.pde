
import processing.serial.*; // this is a library to use serial

int whichport = 5; // change to your serial port

Serial myPort;      // The serial port
String inPut = "";    // Incoming (string) serial data
int val = 0; // stash *actual* serial data

void setup() {
  size(400, 300);
  // create a font with the third font available to the system:
  PFont myFont = createFont(PFont.list()[2], 14);
  textFont(myFont);

  // List all the available serial ports:
  println(Serial.list());

  // open the serial port to the arduino
  String portName = Serial.list()[whichport];
  myPort = new Serial(this, portName, 9600);
}

void draw() {

  if ( myPort.available() > 0) {  // If data is available,
    inPut = myPort.readStringUntil('\n');
    if (inPut!=null) { // only run if not bogus
      inPut = trim(inPut); // gets rid of white space
      val = parseInt(inPut); // interpret as an integer
      println(val);
    }
  }

  background(map(val, 70, 500, 0, 255));
  text("Last Received: " + inPut, 10, 130);
}

