
var leap; // this represents the Leap

var myFrame; // this represents all the crap in the current frame

      var o = new Array(2);
      for(var i = 0;i<2;i++) 
      {
      o[i] = new p5.Oscillator('sine');
      o[i].freq(200.);
      o[i].amp(0.1);
      o[i].start();
      }



function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(800, 600); 

  leap = new Leap.Controller(); // this creats a Leap object
  leap.connect(); // this connects
  // this says what function to run when a frame happens:
  leap.on('frame', onFrame); 
}

function draw() {
  // put drawing code here
  background(255); // set the background to white

    fill(255, 0, 0); // set the color to red
    for(var i = 0;i<myFrame.hands.length;i++)
    {
      var hand = myFrame.hands[i]; // pass by reference
      var x = map(hand.palmPosition[0], -500, 500, 0, width);
      var y = map(hand.palmPosition[2], -500, 500, 0, height);
      var z = map(hand.palmPosition[1], -250, 250, 5, 40);
      ellipse(x, y, z, z);
      o[i].freq(map(hand.palmPosition[1], -500, 500, 1000, 100));

    }

    fill(0, 0, 255);
    for(var i = 0;i<myFrame.pointables.length;i++)
    {
      var pointable = myFrame.pointables[i];
      var x = map(pointable.tipPosition[0], -500, 500, 0, width);
      var y = map(pointable.tipPosition[2], -500, 500, 0, height);
      var z = map(pointable.tipPosition[1], -500, 500, 1, 8);
      ellipse(x, y, z, z);
    }




  }

// this fires when the Leap fires
function onFrame(frame)
{
    myFrame = frame;
}
