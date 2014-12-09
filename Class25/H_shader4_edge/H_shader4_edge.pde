// edge detect the stuff

import processing.video.*;

Capture cam; // webcam

PShader blur; // this is the shader file

void setup() {
  size(1280, 720, P2D); // P2D -> OpenGL mode in 2D : fullscreen
  blur = loadShader("edge.glsl"); // load in shader file

  openCamera();

  rectMode(CENTER); // draw from center
}

void draw() {
  background(0);

  if (cam.available() == true) {
    cam.read();
  }

  float scale = map(mouseY, 0, height, 1., 30.); // # pixels away
  blur.set("scale", scale); // # of pixels away to blur from

  float thresh = mouseX/float(width); // edge threshold
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

