
// control P5
import controlP5.*; // there's a library

ControlP5 cp5; // there's a master object

CheckBox c; // this is a slider


void setup()
{
  size(800, 600);
  background(0);

  // this makes a control central for all the widgets:
  cp5 = new ControlP5(this); 

  c = cp5.addCheckBox("thebox")
    .setPosition(100, 100)
      .setSize(200, 200)
        .setItemsPerRow(2)
          .setSpacingColumn(30)
            .setSpacingRow(20)
              .setColorBackground(color(100, 0, 0))
                .setColorForeground(color(255, 0, 0))
                  .setColorActive(color(255, 0, 100));

  c.addItem("my", 0);
  c.addItem("dog", 1);
  c.addItem("has", 2);
  c.addItem("fleas", 3);
}

// this runs when you touch something in controlP5
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(c)) { // did our checkbox do it?
    print("got an event from "+c.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(c.getArrayValue());
    for (int i=0;i<c.getArrayValue().length;i++) {
      int n = (int)c.getArrayValue()[i];
      if(n == 1) 
      {
        String word= "";
        if(i==0) word = "my";
        if(i==1) word = "dog";
        if(i==2) word = "has";
        if(i==3) word = "fleas";
       TextToSpeech.say(word, "Fred", 120); 
      }
      print(n);
     }
    println();    
  }
}

void draw()
{
}

