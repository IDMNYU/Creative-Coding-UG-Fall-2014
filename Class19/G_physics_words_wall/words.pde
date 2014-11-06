
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

  lukeWord(String _thestring, float _ts, float x, float y)
  {
    ts = _ts;
    textSize(ts);
    thestring = _thestring;
    w = textWidth(thestring);
    h = textAscent() + textDescent();

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
  }

  void display()
  {
    Vec2 pos = e.getBodyPixelCoord(body); // find out where it is
    float a = body.getAngle();

    textSize(ts);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255, 128, 0);
    stroke(0);
    rectMode(CENTER);
    text(thestring, 0, 0);
    popMatrix();
  }
  void killBody()
  {
    e.destroyBody(body);
  }
}

