
int i;
int t;
int ledPin1 = 2;
int ledPin2 = 9;

// this runs when you give power to the arduino
void setup()
{
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  Serial.begin(9600); // starts the serial print system
  
  t = 1000;
}

// this happens over and over and over again
void loop()
{
  Serial.println(i);

  digitalWrite(ledPin1, i);
  int brightness = map(t, 0, 1000, 255, 100);
  analogWrite(ledPin2, brightness);
  i = 1 - i; // increment i
  delay(t); // delay
  
  t = t*0.9;
  if(t<1) t = 1000;
  
}
