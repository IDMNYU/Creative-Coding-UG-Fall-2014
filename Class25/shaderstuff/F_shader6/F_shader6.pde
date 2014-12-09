int NUMSINES = 20; // how many of these things can we do at once?
float[] sines = new float[NUMSINES]; // an array to hold all the current angles
float rad; // an initial radius value for the central sine
int i; // a counter variable

// play with these to get a sense of what's going on:
float fund = 0.01; // the speed of the central sine
float ratio = 1.; // what multiplier for speed is each additional sine?
int alpha = 50; // how opaque is the tracing system

boolean trace = false; // are we tracing?

PShader blur; // this is the shader file

void setup() {
  size(800, 600, P3D); // OpenGL mode

  rad = height/4.; // compute radius for central circle
  background(255); // clear the screen

  for (int i = 0; i<sines.length; i++)
  {
    sines[i] = PI; // start EVERYBODY facing NORTH
  }

  blur = loadShader("blur.glsl"); // load in shader file
}

void draw() {
  float dist = sqrt((mouseX-(width/2))*(mouseX-(width/2)) + (mouseY-(height/2))*(mouseY-(height/2)));
  //  println(dist);
  blur.set("scale", dist); // # of pixels away to blur from


  if (!trace) background(255); // clear screen if showing geometry
  if (!trace) {
    stroke(0, 255); // black pen
    noFill(); // don't fill
  }  

  // MAIN ACTION
  pushMatrix(); // start a transformation matrix
  translate(width/2, height/2); // move to middle of screen

  for (i = 0; i<sines.length; i++) // go through all the sines
  {
    float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
    // setup tracing
    if (trace) {
      stroke(0, 0, 255*(float(i)/sines.length), alpha); // blue
      fill(0, 0, 255, alpha/2); // also, um, blue
      erad = 5.0*(1.0-float(i)/sines.length); // pen width will be related to which sine
    }
    float radius = rad/(i+1); // radius for circle itself
    rotateZ(sines[i]); // rotate circle
    if (!trace) ellipse(0, 0, radius*2, radius*2); // if we're simulating, draw the sine
    pushMatrix(); // go up one level
    translate(0, radius); // move to sine edge
    if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
    if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing
    popMatrix(); // go down one level
    translate(0, radius); // move into position for next sine
    sines[i] = (sines[i]+(fund+(fund*i*ratio)))%TWO_PI; // update angle based on fundamental
  }
  popMatrix(); // pop down final transformation



  filter(blur); // apply shader to entire screen
}

void keyReleased()
{
  if (key==' ') {
    trace = !trace; 
    background(255);
  }
}

