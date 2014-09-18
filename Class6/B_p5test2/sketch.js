

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(640, 480); 

}

function draw() {
  // put drawing code here
  stroke(255, 0, 0);
  fill(0, 0, 255, 50);
  rect(mouseX, mouseY, 20, 20);
}

function keyPressed()
{
	background(255);

}