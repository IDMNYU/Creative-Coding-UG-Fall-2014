// THIS HAPPENS WHEN THINGS HIT EACH OTHER
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  int boxhitsword = 0;
  if (o1.getClass() == lukeBox.class && o2.getClass() == lukeWord.class) boxhitsword = 1;
  if (o2.getClass() == lukeBox.class && o1.getClass() == lukeWord.class) boxhitsword = 2;

  if (boxhitsword==1)
  {
    lukeWord w = (lukeWord) o2;
    w.boink();
  } else if (boxhitsword==2)
  {
    lukeWord w = (lukeWord) o1;
    w.boink();
  }
}

// THIS HAPPENS WHEN THINGS STOP HITTING EACH OTHER
void endContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  int boxhitsword = 0;
  if (o1.getClass() == lukeBox.class && o2.getClass() == lukeWord.class) boxhitsword = 1;
  if (o2.getClass() == lukeBox.class && o1.getClass() == lukeWord.class) boxhitsword = 2;

  if (boxhitsword==1)
  {
    lukeWord w = (lukeWord) o2;
    w.unboink();
  } else if (boxhitsword==2)
  {
    lukeWord w = (lukeWord) o1;
    w.unboink();
  }
}

