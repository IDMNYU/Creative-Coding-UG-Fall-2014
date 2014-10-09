
var leap; // this represents the Leap

var myFrame; // this represents all the crap in the current frame

      var o = new p5.Oscillator('sine');
      o.freq(200.);
      o.amp(0.1);
      o.start();
      



function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(800, 600); 

  leap = new Leap.Controller(); // this creats a Leap object
  leap.connect(); // this connects
  // this says what function to run when a frame happens:
  leap.on('frame', onFrame); 

  background(255); // set the background to white
}

function draw() {
  // put drawing code here

    noStroke();
    fill(0, 0, 255, 20);
    for(var i = 0;i<myFrame.pointables.length;i++)
    {
        if(myFrame.pointables[i].type==1) {
        var finger = myFrame.pointables[i];
        var x = map(finger.tipPosition[0], -500, 500, 0, width);
        var y = map(finger.tipPosition[2], -500, 500, 0, height);
        var z = map(finger.tipPosition[1], -500, 500, 1, 8);
        ellipse(x, y, z, z);
        o.freq(map(finger.tipPosition[2], -500, 500, 100, 1000));

      }
    }




  }

// this fires when the Leap fires
function onFrame(frame)
{
    myFrame = frame;
}
