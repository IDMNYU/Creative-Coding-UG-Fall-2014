// edge detect the stuff

// drone library stuff
import java.awt.image.BufferedImage;
import org.opendronecontrol.platforms.ardrone.ARDrone;
import org.opendronecontrol.spatial.Vec3;
import scala.collection.immutable.List;


// drone objects (controller + image):
ARDrone drone;  // this creates our drone class
BufferedImage bimg;  // a 2D image from JAVA returns current video frame

// drone variables:
PImage img;
Vec3 gyro; // storing gyroscope data
boolean flying; // this is are we flying?

// these are the scary variables:
float droneX;
float droneY;
float droneZ;
float droneYaw;

int xpos = 0;
int ypos = 0;


// control P5
import controlP5.*;

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

  drone = new ARDrone("192.168.1.1"); // default IP is 192.168.1.1
  drone.connect(); // this connects to the drone
  gyro = new Vec3(0.0, 0.0, 0.0); // vector of three numbers... ???

  // ui crap:

  // this makes a control central for all the widgets:
  cp5 = new ControlP5(this); 
  cp5.setControlFont(createFont("Georgia", 20));


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

  cp5.addBang("drone_forward")
    .setPosition(width/2, 250)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("forward")
              ;
  cp5.addBang("drone_backward")
    .setPosition(width/2, height-250)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("backward")
              ;

  cp5.addBang("drone_left")
    .setPosition(width/3, height/2)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("left")
              ;
  cp5.addBang("drone_right")
    .setPosition(width*2/3, height/2)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("right")
              ;

  cp5.addBang("drone_up")
    .setPosition(100, 350)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("up")
              ;
  cp5.addBang("drone_down")
    .setPosition(100, 450)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("down")
              ;

  cp5.addBang("drone_ccw")
    .setPosition(200, 400)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("ccw")
              ;
  cp5.addBang("drone_cw")
    .setPosition(300, 400)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("cw")
              ;

  cp5.addBang("drone_stop")
    .setPosition(width/2, height/2)
      .setSize(50, 50)
        .setColorBackground(color(0, 100, 0))
          .setColorForeground(color(0, 255, 0))
            .setLabel("stop")
              ;
}

public void drone_stop()
{
  droneX = 0;
  droneZ = 0;
  droneY = 0;
  droneYaw = 0.;
}

public void drone_up() {
  droneY = 0.1;
}
public void drone_down() {
  droneY = -0.1;
}
public void drone_left() {
  droneX = -0.1;
}
public void drone_right() {
  droneX = 0.1;
}
public void drone_forward() {
  droneZ = -0.1;
}
public void drone_backward() {
  droneZ = 0.1;
}
public void drone_cw() {
  droneYaw = 0.1;
}
public void drone_ccw() {
  droneYaw = -0.1;
}


void draw() {
  background(0);

  // ask the drone if it's flying...
  if (drone.hasSensors()) {
    flying = drone.sensors().get("flying").bool();
  }

  // do you have video???
  if ( drone.hasVideo()) {

    bimg = drone.video().getFrame(); // on each draw call get the current video frame

      if ( bimg != null ) {
      img = new PImage(bimg.getWidth(), bimg.getHeight(), PConstants.ARGB); // create a new processing image to hold the current video frame
      bimg.getRGB(0, 0, img.width, img.height, img.pixels, 0, img.width); // fill the img with buffered frame data from drone
      img.updatePixels();
      img.resize(width, height);
      image(img, 0, 0, width, height); // display the video frame

      // DO THE BLUR
      blur.set("scale", scale); // # of pixels away to blur from
      blur.set("thresh", thresh); // edge threshold
      filter(blur); // apply shader to entire screen
    }
  }

  // copy over the state of the gyroscope
  if ( drone.hasSensors()) {
    gyro = drone.sensors().get("gyroscope").vec();
  }

  stroke(255);
  line(width/3, 0, width/3, height);
  line(width*2/3, 0, width*2/3, height);
  line(0, height/3, width, height/3);
  line(0, height*2/3, width, height*2/3);

  // this draws that weird thing on the screen
  //fill((gyro.y()+180)/360*255,0,255);
  //ellipse(gyro.z()*10 + width/2, gyro.x()*10 + height/2, 80, 80);

  // this is what tells it to fly
  if (flying==true) {
  }

  println(droneX + " : " + droneZ);

  drone.move(droneX, droneY, droneZ, droneYaw);
}

void keyReleased() {
  if (key =='u') {
    if (flying==false) {
      drone.takeOff();
    } else {
      drone.land();
    }
  }
}


