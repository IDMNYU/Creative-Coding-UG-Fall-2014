// import the TUIO library
import TUIO.*;
import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

// audio stuff!
Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave; // this is an oscillator

// declare a TuioProcessing client
TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  // GUI setup
  noCursor();
  size(640, 480);
  noStroke();
  fill(0);

  // periodic updates
  if (!callback) {
    frameRate(60); //<>//
    loop();
  } else noLoop(); // or callback updates 

  font = createFont("Georgia", 40);
  scale_factor = height/table_size;

  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);


  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

    wave = new Oscil( 440., 0.6, Waves.SQUARE ); // this sets up the oscillator
  wave.patch( out ); // this plugs into the speakers
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
  textFont(font, 40);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size (); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    stroke(0);
    fill(0, 0, 0);
    pushMatrix();
    translate(tobj.getScreenX(width), tobj.getScreenY(height));
    rotate(tobj.getAngle());
    rect(-obj_size/2, -obj_size/2, obj_size, obj_size);
    popMatrix();
    fill(255, 0, 0);
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));

    wave.setFrequency( map(tobj.getScreenX(width), 0, width, 100, 1000) );
    wave.setAmplitude( map(tobj.getScreenY(height), 0, height, 1., 0.) );
  }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}


// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}

