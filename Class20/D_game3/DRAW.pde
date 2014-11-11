
void drawscene0()
{
  if (firstframe) {
    //playscene0();
    firstframe=false;
  }
  background(0);
  if (loadflicker<15) {
    fill(255, 0, 255);
    textSize(24);
    text("PRESS ANY KEY TO PLAY", width/2, height/2);
  }

  loadflicker = (loadflicker+1) %30;
}

void drawscene1()
{
  if (firstframe==true)
  {
    SCENESCORE = 0;
    SCENESTARTTIME = millis();
    THECLOCK = millis()-SCENESTARTTIME;
    for (int i = 0; i<NUMWORDS; i++)
    {
      lukeWord p = new lukeWord(s[floor(random(0, s.length))], random(8, 32), random(0, width), random(0, height), VELOCITY); 
      thewords.add(p);
    }
    firstframe=false;
  } else
  {
    THECLOCK = millis()-SCENESTARTTIME;
  }


  background(0);
  e.step(); // advances the physics engine one frame

  thebox.display();

  for (lukeWall w : thewalls)
  {
    w.display();
  }


  for (i = 0; i<thewords.size (); i++)
  {
    if (thewords.get(i).destroyme == 1)
    {
      thewords.get(i).killBody();
      thewords.remove(i);
    } else
    {
      thewords.get(i).display();
    }
  }

  // COUNTDOWN TIMER
  fill(255, 0, 255);
  textAlign(LEFT);
  textSize(24);
  text("SCORE: " + THESCORE, 20, 50);
  float timeremaining = (SCENEDURATION-THECLOCK)/1000.;
  if(timeremaining<5.0 && loadflicker<15)
  {
  }
  else
  {
  text("TIME: " + ((SCENEDURATION-THECLOCK)/1000.), 20, 80);
  }
  loadflicker = (loadflicker+1) %30;

  if (THECLOCK>SCENEDURATION || thewords.size()<1) {
    WHICHSCENE=2;
    firstframe = true;
  }
}


void drawscene2()
{
  if (firstframe) {
    // delete anything still kickin' around:
    for (i = 0; i<thewords.size (); i++)
    {
      thewords.get(i).killBody();
      thewords.remove(i);
    }
    firstframe=false;
  }
  background(0);
  if (loadflicker<15) {
    fill(255, 0, 255);
    textSize(24);
    if (SCENESCORE>=NUMWORDS*2) {
      text("YOU WON", width/2, height/2);
    } else
    {
      text("YOU LOSE", width/2, height/2);
    }
  }

  loadflicker = (loadflicker+1) %30;
}

