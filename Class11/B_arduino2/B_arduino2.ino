
int i;
int t;
int ledPin = 2;

// this runs when you give power to the arduino
void setup()
{
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600); // starts the serial print system
  
  t = 1000;
}

// this happens over and over and over again
void loop()
{
  Serial.println(i);

  if(i==1) digitalWrite(ledPin, HIGH);
  else if(i==0) digitalWrite(ledPin, LOW);
  i = 1 - i; // increment i
  delay(t); // delay
  
  t = t*0.9;
  if(t<1) t = 1000;
  
}
