import processing.video.*; // import the movie stuff

Movie mov; // this is the movie object

ArrayList<lukeClip> theclips;

int current = 0;
int frameclock = 0;
int cliplength = 30;

void setup() {
  size(640, 480); // the right size
  background(0); // we don't really have to do this

  loadclips(); // do the job of loading that file

  mov = new Movie(this, "gossip.mp4"); // duck and cover
  mov.play(); // start playing
  mov.jump(0); // rewind to the beginning
}

void draw() {

  if (frameclock==0) {
    mov.jump(theclips.get(current).start);
    mov.speed(theclips.get(current).speed);
    cliplength = int(theclips.get(current).duration*frameRate);
  }

  if (mov.available()) { // check to see if there's new video data
    mov.read(); // copy the current frame to an internal PImage
  }  

  //
  // process image HERE
  //
  float r, g, b;
  mov.loadPixels(); // load pixels array from texture
  int howmanypixels = mov.pixels.length;
  println(howmanypixels);
  for (int i = 0; i<howmanypixels; i++) {
    color src = mov.pixels[i]; // src pixel
    r = red(src) * (mouseX/float(width));
    g = green(src) * (mouseY/float(height));
    b = blue(src);
    mov.pixels[i] = color(r, g, b);
  }
  mov.updatePixels(); // update picture texture


  image(mov, 0, 0, width, height); // draw it to the screen

  text("current clip: " + current, 50, 30);
  text("frameclock: " + frameclock, 50, 50);

  frameclock = frameclock+1;
  if (frameclock==cliplength) {
    current = (current+1) % theclips.size();
    frameclock = 0;
  }
}

void keyReleased()
{
}

