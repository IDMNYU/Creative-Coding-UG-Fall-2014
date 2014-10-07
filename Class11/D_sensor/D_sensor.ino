
int inpin = A0;
int outpin = 3;
int value;
int lightval;

// this runs when you give power to the arduino
void setup()
{
  pinMode(outpin, OUTPUT); // this is for our LED
  Serial.begin(9600); // starts the serial print system
}

// this happens over and over and over again
void loop()
{
 value = analogRead(inpin); 
 lightval = constrain(map(value, 75, 200, 0, 255), 0, 255);
 analogWrite(outpin, lightval);
 Serial.println(lightval);
 delay(50);
}
