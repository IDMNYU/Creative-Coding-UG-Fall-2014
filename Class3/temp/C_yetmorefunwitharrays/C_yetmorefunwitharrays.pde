
int NUMCOLS = 25;
int NUMROWS = 35;

int sqsz = 10; // size of the square

int NUMCOLORS = NUMROWS*NUMCOLS;

int[] reds = new int[NUMCOLORS];
int[] greens = new int[NUMCOLORS];
int[] blues = new int[NUMCOLORS];

int themode = 0;
int keylock = 0;

void setup()
{
  size(400, 400);
  frameRate(30); // this sets the frame rate

  for (int i = 0;i<NUMCOLORS;i++)
  {
    reds[i] = int(random(0, 255)); 
    greens[i] = int(random(0, 255)); 
    blues[i] = int(random(0, 255));
  }
}

void draw()
{ 
    background(0);
    
    float colstep = width/NUMCOLS; // how many pixels is a column width???
    float rowstep = height/NUMROWS; // how many pixels is a row height???
    
    for (int i=0;i<NUMCOLS;i++)
    {
      for(int j=0;j<NUMROWS;j++)
      {
        int colorpointer = i*NUMROWS+j;
        //println(colorpointer);
 
        fill(reds[colorpointer], greens[colorpointer], blues[colorpointer]);

        float x = float(i)*colstep;
        float y = float(j)*rowstep;

        rect(x-sqsz/2+(colstep/2), y-sqsz/2+(rowstep/2), sqsz, sqsz);
      
      }
    }
}



void keyPressed()
{  
    if (key=='m'&&keylock==0)
    {
      themode = 1-themode;
      keylock=1;
      println("WE JUST PRESSED THE KEY!!!!!!!!!!");
    }  
}

void keyReleased()
{
      keylock = 0;
      println("WE JUST RELEASED THE KEY!!!!!!!!!!");
  
  
}








