
// control P5
import controlP5.*; // there's a library

ControlP5 cp5; // there's a master object

Slider s; // this is a slider

float theval = 100; // this is the value of the slider

//float phasor = 0.; // this is a ramp

void setup()
{
  size(800, 600);
  background(0);

  // this makes a control central for all the widgets:
  cp5 = new ControlP5(this); 
  
  s = cp5.addSlider("theval");
  s.setPosition(width/2, height/2);
  s.setSize(200, 50);
  s.setRange(0, 255);
  s.setColorBackground(color(100, 0, 0));
  s.setColorForeground(color(255, 0, 0));
  s.setColorActive(color(255, 0, 100));
}

void draw()
{
  background(0, 0, theval);
  //theval = map(sin(phasor), -1., 1., 0, 255);
  //s.setValue(theval);
  
  //phasor = (phasor+0.1) % TWO_PI;
}

