import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import SimpleOpenNI.*; 
import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class testskeleton_osc extends PApplet {

// do this first: 
// http://code.google.com/p/simple-openni/wiki/Installation
// http://www.sojamo.de/libraries/oscP5/





OscP5 whereimlistening; // equivalent to [udpreceive] in max, e.g. it's listening
NetAddress whereimsending; // equivalent to [udpsend] in max - it's sending
String messageselector;

ArrayList triggers;
ArrayList controllers;
ArrayList motions;
ArrayList toggles;

SimpleOpenNI  c; // this represents the kinect

PFont f;

int i;

public void setup()
{

  f = loadFont("Monospaced-48.vlw");
  textFont(f);
  textSize(24);
  textAlign(LEFT);

  c = new SimpleOpenNI(this);
  if(c.isInit() == false) // start the kinect
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // set mirror
  c.setMirror(true);

  // enable depthMap generation 
  c.enableDepth();
   
  // enable skeleton generation for all joints
  c.enableUser();

  // set the size to both
  size(c.depthWidth(), c.depthHeight());

  // do the OSC setup stuff
  whereimlistening = new OscP5(this, 12000);
  whereimsending = new NetAddress("127.0.0.1", 8000); // hostname, port

  parseinstructions();
}

public void draw()
{
  // get a new frame
  c.update();

  background(0, 0, 0);

  // draw depthImageMap
  tint(255, 0, 0);
  image(c.depthImage(), 0, 0);
  noTint();

  // draw the skeleton if it's available
  int[] userList = c.getUsers();
  for (int i=0;i<userList.length;i++)
  {
    if (c.isTrackingSkeleton(userList[i]))
    {
      drawSkeleton(userList[i]);
      checkEverything(userList[i]);
    }
  }
}

public void checkEverything(int userId)
{

  for (int i =0;i<triggers.size();i++)
  {
    DTrigger t = (DTrigger) triggers.get(i);
    t.test(userId);
  }

  for (int i =0;i<controllers.size();i++)
  {
    DController c = (DController) controllers.get(i);
    c.test(userId);
  }

  for (int i =0;i<motions.size();i++)
  {
    DMotion m = (DMotion) motions.get(i);
    m.test(userId);
  }

  for (int i =0;i<toggles.size();i++)
  {
    DToggle g = (DToggle) toggles.get(i);
    g.test(userId);
  }

  checkforturn(userId);
}

// draw the skeleton with the selected joints
public void drawSkeleton(int userId)
{

  stroke(0, 0, 255);
  noFill();
  strokeWeight(2);
  // to get the 3d joint data
  PVector temp = new PVector(0, 0, 0);

  // draw head and hands
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 50, 50);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 10, 10);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 10, 10);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, temp);
  c.convertRealWorldToProjective(temp, temp);
  ellipse(temp.x, temp.y, 20, 20);

  c.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  c.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);

  c.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);

  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);

  c.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  c.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);

  c.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  c.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);

}

// these are the SKELETON CALLBACKS

// user steps in
public void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);

  curContext.startTrackingSkeleton(userId);
}

// user gets lost
public void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

// user walks out
public void onExitUser(int userId)
{
  println("onExitUser - userId: " + userId);
}

// SAME user comes back in
public void onReEnterUser(int userId)
{
  println("onReEnterUser - userId: " + userId);
}

// calibration
public void onStartCalibration(int userId)
{
  println("onStartCalibration - userId: " + userId);
}

public void onEndCalibration(int userId, boolean successfull)
{
  println("onEndCalibration - userId: " + userId + ", successfull: " + successfull);

  if (successfull) 
  { 
    println("  User calibrated !!!");
    c.startTrackingSkeleton(userId); // start tracking
  } 
  else 
  { 
    println("  Failed to calibrate user !!!");
  }
}

public float getDistance(PVector a, PVector b)
{
  float d = (a.x-b.x)*(a.x-b.x); 
  d += (a.y-b.y)*(a.y-b.y); 
  d += (a.z-b.z)*(a.z-b.z); 
  d = sqrt(d);
  //println("getting distance... " + d);
  return(d);
}

public void keyPressed()
{
   parseinstructions();
 
}


public void parseinstructions()
{
  
 triggers = new ArrayList();
 toggles = new ArrayList();
 controllers = new ArrayList();
 motions = new ArrayList();
 
 println("parsing instructions...");
 String cmds[] = loadStrings("setup.txt");
 for(int i = 0;i<cmds.length;i++)
 {
    println(cmds[i]); 
    String[] t = splitTokens(cmds[i]);
    if(t[0].equals("TRIGGER")) {
      println("trigger");
      triggers.add(new DTrigger(mapnames(t[1]), mapnames(t[2]), Integer.parseInt(t[3]), Float.parseFloat(t[4]), Float.parseFloat(t[5]), t[6], Integer.parseInt(t[7])==1));
    }
    if(t[0].equals("TOGGLE")) {
      println("toggle");
      toggles.add(new DToggle(mapnames(t[1]), mapnames(t[2]), Integer.parseInt(t[3]), Float.parseFloat(t[4]), t[5], Integer.parseInt(t[6])==1));
    }
    if(t[0].equals("CONTROLLER")) {
      println("controller");
      controllers.add(new DController(mapnames(t[1]), mapnames(t[2]), Float.parseFloat(t[3]), Float.parseFloat(t[4]), Integer.parseInt(t[5]), Integer.parseInt(t[6])==1, t[7], Integer.parseInt(t[8])==1));
    }
    if(t[0].equals("MOTION")) {
      println("motion");
      motions.add(new DMotion(mapnames(t[1]), Float.parseFloat(t[2]), Float.parseFloat(t[3]), t[4], Integer.parseInt(t[5])==1));
    }
 }

  // constructor: joint1, joint2, direction, thresh, timing, label, debug
  //triggers.add(new DTrigger(SimpleOpenNI.SKEL_RIGHT_HAND, SimpleOpenNI.SKEL_LEFT_SHOULDER, 0, 200.,1000.,"handshoulder", false));
  // constructor: joint1, joint2, direction, thresh, label, debug
  //toggles.add(new DToggle(SimpleOpenNI.SKEL_LEFT_HAND, SimpleOpenNI.SKEL_RIGHT_HAND, 0, 200.,"handtouch", false));
  // constructor: joint1, joint2, min, max, axis, absflag, label, debug
  //controllers.add(new DController(SimpleOpenNI.SKEL_LEFT_HAND, SimpleOpenNI.SKEL_RIGHT_HAND, 0., 1000., -1, false, "handdistance", true));
  // constructor: joint1, min, max, label, debug
  //motions.add(new DMotion(SimpleOpenNI.SKEL_LEFT_HAND, 0., 80., "lefthand", false));
 
}

public int mapnames(String f)
{
  int out = 0;
   if(f.equals("HEAD")) out = SimpleOpenNI.SKEL_HEAD;
   if(f.equals("NECK")) out = SimpleOpenNI.SKEL_NECK;
   if(f.equals("TORSO")) out = SimpleOpenNI.SKEL_TORSO;
   if(f.equals("LEFTHAND")) out = SimpleOpenNI.SKEL_LEFT_HAND;
   if(f.equals("RIGHTHAND")) out = SimpleOpenNI.SKEL_RIGHT_HAND;
   if(f.equals("LEFTELBOW")) out = SimpleOpenNI.SKEL_LEFT_ELBOW;
   if(f.equals("RIGHTELBOW")) out = SimpleOpenNI.SKEL_RIGHT_ELBOW;
   if(f.equals("LEFTSHOULDER")) out = SimpleOpenNI.SKEL_LEFT_SHOULDER;
   if(f.equals("RIGHTSHOULDER")) out = SimpleOpenNI.SKEL_RIGHT_SHOULDER;
   if(f.equals("LEFTHIP")) out = SimpleOpenNI.SKEL_LEFT_HIP;
   if(f.equals("RIGHTHIP")) out = SimpleOpenNI.SKEL_RIGHT_HIP;
   if(f.equals("LEFTKNEE")) out = SimpleOpenNI.SKEL_LEFT_KNEE;
   if(f.equals("RIGHTKNEE")) out = SimpleOpenNI.SKEL_RIGHT_KNEE;
   if(f.equals("LEFTFOOT")) out = SimpleOpenNI.SKEL_LEFT_FOOT;
   if(f.equals("RIGHTFOOT")) out = SimpleOpenNI.SKEL_RIGHT_FOOT;
   return(out);


}

// DISCRETE

class DTrigger
{
  float dt_timestamp = 0.f;
  float dt_time;
  float dt_thresh;
  boolean dt_d = false;
  boolean going = false;
  int j1;
  int j2;
  String label;
  int direction;
  boolean debug = false;

  // constructor: joint1, joint2, direction, thresh, timing, label, debug
  DTrigger(int _j1, int _j2, int _d, float _t, float _m, String _l, boolean _b)
  {
    j1 = _j1;
    j2 = _j2;
    dt_thresh = _t;
    dt_time = _m;
    label = _l;
    direction = _d;
    debug = _b;
  } 

  public void test(int userId)
  {

    // distance of hands
    PVector h1 = new PVector(0, 0, 0);
    PVector h2 = new PVector(0, 0, 0);
    c.getJointPositionSkeleton(userId, j1, h1);
    c.getJointPositionSkeleton(userId, j2, h2);
    float d = getDistance(h1, h2);
    PVector temp = new PVector(0, 0, 0);
    PVector temp2 = new PVector(0, 0, 0);
    c.convertRealWorldToProjective(h1, temp);
    c.convertRealWorldToProjective(h2, temp2);
    //println(label + " " + d);

    float NOW = millis();
    OscMessage themessage = new OscMessage(label);
    boolean ismatch = false;

    if (debug)
    {
      stroke(0, 255, 255);
      line(temp.x, temp.y, temp2.x, temp2.y);
      text(d, (temp.x+temp2.x)/2, (temp.y+temp2.y)/2 );
    }

    if (d<dt_thresh && direction==0)
    {
      ismatch=true;
      if (going==false)
      {
        dt_timestamp = NOW;
        whereimlistening.send(themessage, whereimsending);
        going=true;
        stroke(0, 255, 0);
        ellipse(temp.x-15, temp.y-15, 30, 30);
      }
      stroke(255, 255, 255);
      text(label, temp.x, temp.y);
    }
    if (d>dt_thresh && direction==1)
    {
      ismatch=true;
      if (going==false)
      {
        dt_timestamp = NOW;
        whereimlistening.send(themessage, whereimsending);
        going=true;
        stroke(0, 255, 0);
        ellipse(temp.x-15, temp.y-15, 30, 30);
      }
      stroke(255, 255, 255);
      text(label, temp.x, temp.y);
    }

    if ((NOW-dt_timestamp>=dt_time)&&ismatch==false) going=false;
  }


  public float getDistance(PVector a, PVector b)
  {
    float d = (a.x-b.x)*(a.x-b.x); 
    d += (a.y-b.y)*(a.y-b.y); 
    d += (a.z-b.z)*(a.z-b.z); 
    d = sqrt(d);
    //println("getting distance... " + d);
    return(d);
  }
}

// TOGGLE

class DToggle
{
  float dt_timestamp = 0.f;
  float dt_time;
  float dt_thresh;
  boolean dt_d = false;
  boolean going = false;
  int j1;
  int j2;
  String label;
  int direction;
  boolean debug = false;

  // constructor: joint1, joint2, direction, thresh, label, debug
  DToggle(int _j1, int _j2, int _d, float _t, String _l, boolean _b)
  {
    j1 = _j1;
    j2 = _j2;
    dt_thresh = _t;
    label = _l;
    direction = _d;
    debug = _b;
  } 

  public void test(int userId)
  {

    // distance of hands
    PVector h1 = new PVector(0, 0, 0);
    PVector h2 = new PVector(0, 0, 0);
    c.getJointPositionSkeleton(userId, j1, h1);
    c.getJointPositionSkeleton(userId, j2, h2);
    float d = getDistance(h1, h2);
    PVector temp = new PVector(0, 0, 0);
    PVector temp2 = new PVector(0, 0, 0);
    c.convertRealWorldToProjective(h1, temp);
    c.convertRealWorldToProjective(h2, temp2);
    //println(label + " " + d);
    int messtosend = 0;

    float NOW = millis();
    OscMessage themessage = new OscMessage(label);
    boolean ismatch = false;

    if (debug)
    {
      stroke(0, 255, 255);
      line(temp.x, temp.y, temp2.x, temp2.y);
      text(d, (temp.x+temp2.x)/2, (temp.y+temp2.y)/2 );
    }

    if (d<dt_thresh && direction==0)
    {
      ismatch=true;
      messtosend=1;
      stroke(0, 255, 0);
      ellipse(temp.x-15, temp.y-15, 30, 30);
      stroke(255, 255, 255);
      text(label, temp.x, temp.y);
    }
    if (d>dt_thresh && direction==1)
    {
      ismatch=true;
      messtosend=1;
      stroke(0, 255, 0);
      ellipse(temp.x-15, temp.y-15, 30, 30);
      stroke(255, 255, 255);
      text(label, temp.x, temp.y);
    }

    themessage.add(messtosend);
    whereimlistening.send(themessage, whereimsending);
  }


  public float getDistance(PVector a, PVector b)
  {
    float d = (a.x-b.x)*(a.x-b.x); 
    d += (a.y-b.y)*(a.y-b.y); 
    d += (a.z-b.z)*(a.z-b.z); 
    d = sqrt(d);
    //println("getting distance... " + d);
    return(d);
  }
}


// CONTINUOUS

class DController
{
  int j1;
  int j2;
  float tmin;
  float tmax;
  int axis;
  boolean a = false;
  String label;
  boolean debug = false;

  // constructor: joint1, joint2, min, max, axis, absflag, label, debug
  DController(int _j1, int _j2, float _min, float _max, int _axis, boolean _a, String _l, boolean _b)
  {
    j1 = _j1;
    j2 = _j2;
    tmin = _min;
    tmax = _max;
    axis = _axis;
    a = _a;
    label = _l;
    debug = _b;
    a = _a;
  } 

  public void test(int userId)
  {

    // distance of hands
    PVector h1 = new PVector(0, 0, 0);
    PVector h2 = new PVector(0, 0, 0);
    c.getJointPositionSkeleton(userId, j1, h1);
    c.getJointPositionSkeleton(userId, j2, h2);
    float d = 0;
    if(axis==-1) d = getDistance(h1, h2);
    if(axis==0) d = h1.x-h2.x;
    if(axis==1) d = h1.y-h2.y;
    if(axis==2) d = h1.z-h2.z;
    if(a) d = abs(d);
    PVector temp = new PVector(0, 0, 0);
    PVector temp2 = new PVector(0, 0, 0);
    c.convertRealWorldToProjective(h1, temp);
    c.convertRealWorldToProjective(h2, temp2);
    //println(label + " " + d);

    OscMessage themessage = new OscMessage(label);

    if (debug)
    {
      stroke(0, 255, 255);
      line(temp.x, temp.y, temp2.x, temp2.y);
      text(d, (temp.x+temp2.x)/2, (temp.y+temp2.y)/2 );
    }

    themessage.add(constrain(map(d, tmin, tmax, 0.f, 1.f), 0.f, 1.f));

    whereimlistening.send(themessage, whereimsending);
  }


  public float getDistance(PVector a, PVector b)
  {
    float d = (a.x-b.x)*(a.x-b.x); 
    d += (a.y-b.y)*(a.y-b.y); 
    d += (a.z-b.z)*(a.z-b.z); 
    d = sqrt(d);
    //println("getting distance... " + d);
    return(d);
  }
}

// MOTION

class DMotion
{
  int j1;
  float tmin;
  float tmax;
  String label;
  boolean debug = false;
  PVector ph1 = new PVector(0, 0, 0);
  boolean first = true;

  // constructor: joint1, min, max, label, debug
  DMotion(int _j1, float _min, float _max, String _l, boolean _b)
  {
    j1 = _j1;
    tmin = _min;
    tmax = _max;
    label = _l;
    debug = _b;
  } 

  public void test(int userId)
  {

    // distance of hands
    PVector h1 = new PVector(0, 0, 0);
    c.getJointPositionSkeleton(userId, j1, h1);
    if (first)
    {
      c.getJointPositionSkeleton(userId, j1, ph1);      
      first=false;
    }
    float d = getDistance(h1, ph1);
    PVector temp = new PVector(0, 0, 0);
    PVector temp2 = new PVector(0, 0, 0);
    c.convertRealWorldToProjective(h1, temp);
    c.convertRealWorldToProjective(ph1, temp2);
    //println(label + " " + d);
    c.getJointPositionSkeleton(userId, j1, ph1);      

    OscMessage themessage = new OscMessage(label);

    if (debug)
    {
      stroke(0, 255, 255);
      line(temp.x, temp.y, temp2.x, temp2.y);
      text(d, (temp.x+temp2.x)/2, (temp.y+temp2.y)/2 );
    }

    themessage.add(constrain(map(d, tmin, tmax, 0.f, 1.f), 0.f, 1.f));

    whereimlistening.send(themessage, whereimsending);
  }


  public float getDistance(PVector a, PVector b)
  {
    float d = (a.x-b.x)*(a.x-b.x); 
    d += (a.y-b.y)*(a.y-b.y); 
    d += (a.z-b.z)*(a.z-b.z); 
    d = sqrt(d);
    //println("getting distance... " + d);
    return(d);
  }
}


public void checkforturn(int userId)
{
  // check shoulder orientation
  OscMessage themessage = new OscMessage("/facing");
  String flabel="";
  int fpos = 0;
  PVector s1 = new PVector(0, 0, 0);
  PVector s2 = new PVector(0, 0, 0);
  PVector t = new PVector(0, 0, 0);
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, s1);
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, s2);
  c.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, t);
  // only send spin mid-space
  if (abs(t.x)<1500.f) {
    if (s1.x<s2.x) 
    { 
       flabel = "FRONT"; 
       fpos = 1;
    }
    else 
    {
      flabel = "BACK";
      fpos = 0;
    }
    text(flabel, 20, 20);
    themessage.add(fpos);
    whereimlistening.send(themessage, whereimsending);
  }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "testskeleton_osc" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
