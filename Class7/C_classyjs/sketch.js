
var NUMSPHERES = 500; // how many spheres do i want?

// creating an array of our class
var s = new Array(NUMSPHERES); // parens, not brackets

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(800, 600); 
  background(0);
  fill(255);
  for (var i = 0; i<NUMSPHERES; i++)
  {
    s[i] = new mySphere(random(1, 20));
  }
}

function draw() {
  // put drawing code here
  background(255);

  for (var i = 0; i<NUMSPHERES; i++)
  {
    s[i].go();
    s[i].update(mouseX, mouseY);
  }
}

function keyPressed()
{
  for (var i = 0; i<NUMSPHERES; i++)
  {
    s[i] = new mySphere(random(1, 20));
  }
}

function mySphere(diameter)
{
	this.d = diameter;
	this.x = random(0, width);
	this.y = random(0, height);
	this.a = random(0, TWO_PI);
	this.v = random(0.3, 4);

	this.go = function()
	{
	    fill(0);
	    noStroke();
	    ellipse(this.x, this.y, this.d, this.d);
	}

	this.update = function(tx, ty)
	{
	    this.a = atan((ty-this.y)/(tx-this.x));
	    if(tx<this.x) this.a+=PI;
	    var distance = sqrt((this.x-tx)*(this.x-tx) + (this.y-ty)*(this.y-ty));
	    
	    this.v = constrain(1000-distance, 0, 1000);
	    this.v = this.v*0.001;
	    
	    this.x = (this.x + this.v*cos(this.a)+width)%width;
	    this.y = (this.y + this.v*sin(this.a)+height)%height;  
	}
}


