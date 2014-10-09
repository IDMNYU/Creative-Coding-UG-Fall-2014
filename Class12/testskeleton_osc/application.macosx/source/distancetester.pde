// DISCRETE

class DTrigger
{
  float dt_timestamp = 0.;
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

  void test(int userId)
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


  float getDistance(PVector a, PVector b)
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
  float dt_timestamp = 0.;
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

  void test(int userId)
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


  float getDistance(PVector a, PVector b)
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

  void test(int userId)
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

    themessage.add(constrain(map(d, tmin, tmax, 0., 1.), 0., 1.));

    whereimlistening.send(themessage, whereimsending);
  }


  float getDistance(PVector a, PVector b)
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

  void test(int userId)
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

    themessage.add(constrain(map(d, tmin, tmax, 0., 1.), 0., 1.));

    whereimlistening.send(themessage, whereimsending);
  }


  float getDistance(PVector a, PVector b)
  {
    float d = (a.x-b.x)*(a.x-b.x); 
    d += (a.y-b.y)*(a.y-b.y); 
    d += (a.z-b.z)*(a.z-b.z); 
    d = sqrt(d);
    //println("getting distance... " + d);
    return(d);
  }
}


void checkforturn(int userId)
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
  if (abs(t.x)<1500.) {
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


