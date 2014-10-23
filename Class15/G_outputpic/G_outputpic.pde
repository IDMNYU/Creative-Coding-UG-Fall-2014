import processing.video.*;

Capture cam; // webcam

PShader blur; // this is the shader file

int whichway = 0;

float camsize = 150.;

int isrecording = 0;

void setup() {
  size(1280, 720, P2D); // P2D -> OpenGL mode in 2D : fullscreen
  blur = loadShader("blur.glsl"); // load in shader file

  openCamera();

  stroke(255, 0, 0); // red
  rectMode(CENTER); // draw from center
}

void draw() {

  if (cam.available() == true) {
    cam.read();
  }

  float dist = sqrt((mouseX-(width/2))*(mouseX-(width/2)) + (mouseY-(height/2))*(mouseY-(height/2)));
  //  println(dist);
  blur.set("scale", dist); // # of pixels away to blur from
  if (whichway==0) filter(blur); // apply shader to entire screen
  image(cam, mouseX, mouseY, camsize, camsize*0.75);
  if (whichway==1) filter(blur); // apply shader to entire screen

  if(isrecording==1) saveFrame("./output/image-######.png");
}

void keyReleased()
{
  if(key=='w') {
  background(192); 
  whichway = 1-whichway;
  }
  if(key=='r') {
     isrecording = 1-isrecording; 
  }
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

