// box featuring mitt romney

class lukeBox
{
  PImage mitt;
  Body body; // this is the container for a body
  BodyDef bd; // this defines a type of physics body
  FixtureDef fd;
  float w, h; // the width and height i'm keeping
  float r, g, b, a;

  // this is the constructor for the class
  lukeBox(float x, float y, float _w, float _h)
  {
    mitt = loadImage("mitt.jpg");
    w = _w;
    h = _h;
    r = random(128, 255);
    g = random(128, 255);
    b = random(128, 255);
    a = 200;

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
    fd.friction = FRICTION;
    fd.restitution = 0.5;

    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(random(-15, 15), random(-15, -15)));
    body.setAngularVelocity(random(-1, 1));

    // you need this for collision detection!!!!
    body.setUserData(this); 
  }

  void display()
  {
    Vec2 pos = e.getBodyPixelCoord(body); // find out where it is
    float angle = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-angle);
    fill(r, g, b, a);
    stroke(0);
    rectMode(CENTER);
    //rect(0, 0, w, h);
    image(mitt, 0, 0, w, h);
    popMatrix();
  }

  void killBody()
  {
    e.destroyBody(body);
  }
}

