
int i;

// this runs when you give power to the arduino
void setup()
{
  Serial.begin(9600); // starts the serial print system
}

// this happens over and over and over again
void loop()
{
  Serial.println(i);
  i++; // increment i
  
}
