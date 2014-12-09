// edge detect the stuff

// video library
import processing.video.*;

// control P5
import controlP5.*;

Capture cam; // webcam

// UI stuff:
ControlP5 cp5; // there's a master object
Slider scaleSlider, threshSlider; // these are the sliders

PShader blur; // this is the shader file

// default shader values (also double as UI names)
float scale = 15;
float thresh = 0.5;

void setup() {
  size(displayWidth, displayHeight, P2D); // P2D -> OpenGL mode in 2D : fullscreen
  blur = loadShader("edge.glsl"); // load in shader file

  openCamera();

  rectMode(CENTER); // draw from center
  
  // ui crap:
  
  // this makes a control central for all the widgets:
  cp5 = new ControlP5(this); 
  cp5.setControlFont(createFont("Georgia",20));

  
  scaleSlider = cp5.addSlider("scale") // why are these in quotes?
  .setPosition(100, 100)
  .setSize(200, 50)
  .setRange(1.0, 30.) // min and max
  .setColorBackground(color(100, 0, 0))
  .setColorForeground(color(255, 0, 0))
  .setColorActive(color(255, 0, 100));

  threshSlider = cp5.addSlider("thresh")
  .setPosition(100, 200)
  .setSize(200, 50)
  .setRange(0.0, 1.0) // min and max
  .setColorBackground(color(0, 100, 0))
  .setColorForeground(color(0, 255, 0))
  .setColorActive(color(0, 255, 100));

}

void draw() {
  background(0);

  if (cam.available() == true) {
    cam.read();
  }

  blur.set("scale", scale); // # of pixels away to blur from
  blur.set("thresh", thresh); // edge threshold
  image(cam, 0, 0, width, height);
  filter(blur); // apply shader to entire screen
}

void keyReleased()
{
}

void openCamera()
{
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

