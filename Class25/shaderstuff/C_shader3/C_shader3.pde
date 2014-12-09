// edge detect the stuff

import processing.video.*;

Capture cam; // webcam

PShader blur; // this is the shader file

int whichway = 0;

float camsize = 150.;

void setup() {
  size(displayWidth, displayHeight, P2D); // P2D -> OpenGL mode in 2D : fullscreen
  blur = loadShader("blur.glsl"); // load in shader file

  openCamera();

  rectMode(CENTER); // draw from center
}

void draw() {
  background(0);

  if (cam.available() == true) {
    cam.read();
  }

  float scale = map(mouseY, 0, height, 1., 30.);
  float dist = 1.;
  blur.set("scale", scale); // # of pixels away to blur from
  blur.set("thresh", mouseX/float(width)); // edge threshold
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

