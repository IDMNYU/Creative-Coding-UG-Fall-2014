
// this thing physic-ifies a word
class lukeWord
{
  // this is all the physics crap
  Body body;
  BodyDef bd;
  FixtureDef fd;

  // this is all i need to know about the word
  float w, h; // its size?
  String thestring; // what is it?
  float ts; // how big is the FONT?

  float red, green, blue;

  int destroyme;
  int beenhit;
  int isboink;
  
  int vrange;

  lukeWord(String _thestring, float _ts, float x, float y, int _vrange)
  {
    ts = _ts;
    textSize(ts);
    thestring = _thestring;
    w = textWidth(thestring);
    h = textAscent() + textDescent();

    vrange = _vrange;
    red = 255;
    green = 128;
    blue = 0;
    isboink = 0;
    destroyme = 0;
    beenhit = 0;

    // make me a new body
    bd = new BodyDef();
    bd.type = BodyType.DYNAMIC; // it's gonna move
    bd.position.set(e.coordPixelsToWorld(x, y)); // this is where it starts
    body = e.createBody(bd); // registers it with the physics engine

    // this describes the shape of the thing
    PolygonShape ps = new PolygonShape();
    float box2dW = e.scalarPixelsToWorld(w/2);
    float box2dH = e.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    // this makes the fixture
    fd = new FixtureDef();
    fd.shape = ps; // assigns the shape to the fixture

    // some parameters
    fd.density = 1.;
    fd.friction = 0.3;
    fd.restitution = 1.;

    body.createFixture(fd);
    body.setLinearVelocity(new Vec2(random(-vrange, vrange), random(-vrange, vrange)));
    body.setAngularVelocity(random(-1, 1));

    // you need this for collision detection!!!!
    body.setUserData(this);
  }

  void display()
  {
    Vec2 pos = e.getBodyPixelCoord(body); // find out where it is

    if (pos.x>width+(max(w, h)) || pos.x<0-(max(w, h)) || pos.y>height+(max(w, h)) || pos.y<0-(max(w, h))) // out of bounds
    { 
      destroyme=1;
    }

    float a = body.getAngle();

    textSize(ts);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(red, green, blue);
    stroke(0);
    rectMode(CENTER);
    text(thestring, 0, 0);
    popMatrix();
  }
  void killBody()
  {
    e.destroyBody(body);
  }

  void unboink()
  {
    isboink = 0;
  }

  void boink()
  {
    if (isboink==0) // new hit
    {
      red = 0;
      green = 255;
      blue = 255;
      playhalf();
      //destroyme=1;
      if (beenhit==0) {
        THESCORE++;
        SCENESCORE++;
        beenhit = 1;
      }
      else if (beenhit==1) {
        THESCORE++;
        SCENESCORE++;
        destroyme = 1;
      }
      isboink=1;
    }
  }
}

