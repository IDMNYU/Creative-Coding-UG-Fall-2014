
// control P5
import controlP5.*; // there's a library

ControlP5 cp5; // there's a master object

CheckBox c; // this is a checkbox


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
          .setSpacingColumn(20)
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
  
  String[] thewords = {"my", "dog", "has", "fleas"};
  
  if (theEvent.isFrom(c)) { // did our checkbox do it?
    print("got an event from "+c.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(c.getArrayValue());
    for (int i=0;i<c.getArrayValue().length;i++) {
      int n = (int)c.getArrayValue()[i];
      
      if(n == 1) 
      {
       TextToSpeech.say(thewords[i], "Fred", 120); 
      }
      else if(n==0) 
      {
       //TextToSpeech.say(thewords[i], "Agnes", 120); 
      }
      print(n);
     }
    println();    
  }
}

void draw()
{
}

