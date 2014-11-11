class lukeSpring {

  // This is the e object we need to create
  MouseJoint mouseJoint;

  lukeSpring() {
    // At first it doesn't exist
    mouseJoint = null;
  }

  // If it exists we set its target to the mouse location 
  void update(float x, float y) {
    if (mouseJoint != null) {
      // Always convert to world coordinates!
      Vec2 mouseWorld = e.coordPixelsToWorld(x,y);
      mouseJoint.setTarget(mouseWorld);
    }
  }

  void display() {
    if (mouseJoint != null) {
      // We can get the two anchor points
      Vec2 v1 = null;
      mouseJoint.getAnchorA(v1);
      Vec2 v2 = null;
      mouseJoint.getAnchorB(v2);
      // Convert them to screen coordinates
      v1 = e.coordWorldToPixels(v1);
      v2 = e.coordWorldToPixels(v2);
      // And just draw a line
      stroke(255);
      strokeWeight(1);
      line(v1.x,v1.y,v2.x,v2.y);
    }
  }


  // This is the key function where
  // we attach the spring to an x,y location
  // and the Box object's location
  void bind(float x, float y, lukeBox box) {
    // Define the joint
    MouseJointDef md = new MouseJointDef();
    
    // Body A is just a fake ground body for simplicity (there isn't anything at the mouse)
    md.bodyA = e.getGroundBody();
    // Body 2 is the box's boxy
    md.bodyB = box.body;
    // Get the mouse location in world coordinates
    Vec2 mp = e.coordPixelsToWorld(x,y);
    // And that's the target
    md.target.set(mp);
    // Some stuff about how strong and bouncy the spring should be
    md.maxForce = 1000.0f * box.body.m_mass;
    md.frequencyHz = 5.0f;
    md.dampingRatio = 0.9f;

    // Wake up body!
    //box.body.wakeUp();

    // Make the joint!
    mouseJoint = (MouseJoint) e.world.createJoint(md);
  }

  void destroy() {
    // We can get rid of the joint when the mouse is released
    if (mouseJoint != null) {
      e.world.destroyJoint(mouseJoint);
      mouseJoint = null;
    }
  }

}


