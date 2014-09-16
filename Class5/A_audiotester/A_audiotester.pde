import ddf.minim.*;
 
Minim minim;
AudioInput in;
 
void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
 
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
}
 
void draw()
{
  background(0);
  stroke(255);
 
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 );
  }
 
  String monitoringState = in.isMonitoring() ? "enabled" : "disabled";
  text( "Input monitoring is currently " + monitoringState + ".", 5, 15 );
}
 
void keyPressed()
{
  if ( key == 'm' || key == 'M' )
  {
    if ( in.isMonitoring() )
    {
      in.disableMonitoring();
    }
    else
    {
      in.enableMonitoring();
    }
  }
}
