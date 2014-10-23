/**
 * Image Mask
 * 
 * Move the mouse to reveal the image through the dynamic mask.
 */

PShader maskShader;
PImage srcImage;
PGraphics maskImage;

float r, g, b;

void setup() {
  size(640, 360, P2D);
  srcImage = loadImage("leaves.jpg");
  maskImage = createGraphics(srcImage.width, srcImage.height, P2D);
  maskImage.noSmooth();
  maskShader = loadShader("mask.glsl");
  maskShader.set("mask", maskImage);
  background(255);
  r = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);

  clearScreen();
}

void draw() { 
  maskImage.beginDraw(); // start drawing into the offscreen
  maskImage.noStroke();
  maskImage.fill(r, g, b);
  maskImage.ellipse(mouseX, mouseY, 50, 50);
  maskImage.endDraw(); // stop drawing
  shader(maskShader);    
  image(srcImage, 0, 0, width, height);
  
  r = r+random(-20, 20);
  g = g+random(-20, 20);
  b = b+random(-20, 20);
  r = constrain(r, 0, 255);
  g = constrain(g, 0, 255);
  b = constrain(b, 0, 255);
}

void keyReleased()
{
  clearScreen();
}

void clearScreen()
{
  maskImage.beginDraw();
  maskImage.background(0);
  maskImage.endDraw();
}

