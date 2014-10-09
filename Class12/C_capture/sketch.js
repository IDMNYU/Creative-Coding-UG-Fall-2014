
var isRecording = 0;
var isPlaying = 0;

var stuff = new Array();

var playpointer = 0;

// this holds a single frame of gesture
function Stuff(_x, _y, _c)
{
  this.x = _x;
  this.y = _y;
  this.c = _c;
}

function setup() {
  // put setup code here
  // this is the same as the size() command in processing:
  createCanvas(800, 600); 

  background(255); // set the background to white
}

function draw() {
  // put drawing code here

    stroke(0, 0, 255);
    fill(0, 0, 255);
    
    //recording mode - add to the stuff array
    if(isRecording) {
      if(mouseIsPressed)
      {
         line(pmouseX, pmouseY, mouseX, mouseY);
      }
      stuff.push(new Stuff(mouseX, mouseY, mouseIsPressed));
    }

    // playback mode - run through the stuff array
    if(isPlaying && playpointer<stuff.length-1) {
      if(stuff[playpointer].c) {
        line(stuff[playpointer-1].x, stuff[playpointer-1].y, stuff[playpointer].x, stuff[playpointer].y);
      }
      playpointer++;
    }

}

  function keyReleased()
  {
      if(key=='r')
      {
        isRecording = 1-isRecording;
        console.log("Recording: " + isRecording);
        if(isRecording==1) {
          stuff = new Array(); // erase everything
        }
        background(255);
      }
      if(key=='p')
      {
        isPlaying = 1-isPlaying;
        console.log("Playing: " + isPlaying);
        playpointer = 1;
        background(255);
      }
      if(key==' ')
      {
        background(255);
      }

  }
