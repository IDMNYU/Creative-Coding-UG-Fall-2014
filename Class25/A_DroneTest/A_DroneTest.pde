/*
///    [ODC] Processing Example - DroneVideo - Tim Wood and Sterling Crispin 2013 - fishuyo@gmail.com || sterlingcrispin@gmail.com || http://fishuyo.com/ || http://www.sterlingcrispin.com
 ///    Press 'u' to takeoff and land
 ///    fly the drone in the X and Z directions by moving your mouse around in the draw window
 
 ///    if you've downloaded this code from the ODC github you may be missing the ODC processing libraries, please visit the ODC website to download them
 ///    http://www.opendronecontrol.org/
 */

import java.awt.image.BufferedImage;
import org.opendronecontrol.platforms.ardrone.ARDrone;
import org.opendronecontrol.spatial.Vec3;
import scala.collection.immutable.List;

ARDrone drone;  // this creates our drone class
BufferedImage bimg;  // a 2D image from JAVA returns current video frame

PImage img;
Vec3 gyro; // storing gyroscope data
boolean flying; // this is are we flying?

// these are the scary variables:
float droneX;
float droneY;
float droneZ;
float droneYaw;

void setup() {

  size(640, 480);
  drone = new ARDrone("192.168.1.1"); // default IP is 192.168.1.1
  drone.connect(); // this connects to the drone
  gyro = new Vec3(0.0, 0.0, 0.0); // vector of three numbers... ???
}

void draw() {

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
      img.resize(640, 480);
      image(img, 0, 0); // display the video frame
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
    droneX = 0;
    if (mouseX < width/3) droneX = 0.1;
    if (mouseX > width*2/3) droneX = -0.1;
    droneY = 0;
    if (mouseY < height/3) droneZ = 0.1;
    if (mouseY > height*2/3) droneZ = -0.1;
    println(droneX + " : " + droneZ);
    droneZ = 0;
    droneYaw = 0;
    drone.move(droneX, droneY, droneZ, droneYaw);
  }
}



void keyPressed() {
  if (key =='u') {
    if (flying==false) {
      drone.takeOff();
    } else {
      drone.land();
    }
  }
}

