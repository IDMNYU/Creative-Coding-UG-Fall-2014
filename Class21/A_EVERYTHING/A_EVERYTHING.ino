//
// INTERNET OF PINGS
//
// light sensor:
// http://www.adafruit.com/products/1384
//
// sound sensor:
// http://www.adafruit.com/products/1713
//
// temp / humidity:
// http://www.adafruit.com/products/393
//
// motion sensor:
// http://www.adafruit.com/products/189


#include "DHT.h" // library for DHT (humidity, temp) chip

// PINSHIT:
#define LIGHTPIN A0
#define SOUNDPIN A1
#define DHTPIN 2
#define PIRPIN 4

#define DHTTYPE DHT22   // DHT 22  (AM2302)

// LIGHT SENSOR - Read on Analog Pin 0
float lightValue; // value of light sensor, in LUXs

// SOUND SENSOR - Read on Analog Pin 1
const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
double soundValue; // value of mic, in Volts

// DHT SENSOR (temp + humidity) - Interface on Digital Pin 2
DHT dht(DHTPIN, DHTTYPE);

// PROXIMITY SENSOR - Interface on Digital Pin 4
int proximityValue = 0; // value of PIR sensor (0 or 1)

// OTHER PROXIMITY SENSOR - Interface on Analog Pin 2
int otherProxValue;

void setup() {
  analogReference(EXTERNAL); // pull from 3.3V 
  pinMode(PIRPIN, INPUT); // set to read for proximity sensor
  Serial.begin(9600); // serial starter
  dht.begin(); // tell DHT to start
}
void loop() {
  // 1 - LIGHT SENSOR:
  lightValue = rawToLux(analogRead(LIGHTPIN)); 

  // 2 - SOUND SENSOR
  soundValue = readSound(SOUNDPIN, sampleWindow);

  // 3 - TEMP / HUMIDITY SENSOR
  float humidity = dht.readHumidity(); // pct humidity
  float celsius = dht.readTemperature(false); // deg C
  float fahrenheit = dht.readTemperature(true); // deg F
  // check for bogus reads
  if (isnan(humidity) || isnan(celsius) || isnan(fahrenheit)) {
    // borked!!!
    return;
  }
  float heatIndex = dht.computeHeatIndex(fahrenheit, humidity); // heat index

  // 4 - PIR SENSOR
  proximityValue = digitalRead(PIRPIN);  // read input value

  // PRINTING
  Serial.print(lightValue, 6); 
  Serial.print(" "); // space
  Serial.print(soundValue, 6);
  Serial.print(" "); // space
  Serial.print(humidity, 2);
  Serial.print(" "); // space
  Serial.print(celsius, 2);
  Serial.print(" "); // space
  Serial.print(fahrenheit, 2);
  Serial.print(" "); // space
  Serial.print(heatIndex, 2);
  Serial.print(" "); // space
  Serial.print(proximityValue);
  Serial.println();
  
  delay(10); // refractory period
}

// CONVERT LIGHT

float rawLightRange = 1024; // 3.3v
float logLightRange = 5.0; // 3.3v = 10^5 lux

float rawToLux(int raw) {
  float logLux = raw * logLightRange / rawLightRange;
  return pow(10, logLux); 
}

// COLLECT SOUND

unsigned int sample; // value for holding single sample

double readSound(int pin, int time)
{
  unsigned long startMillis= millis();  // Start of sample window
  unsigned int signalMax = 0;
  unsigned int signalMin = 1024;

  // collect data for 50 mS
  while (millis() - startMillis < time)
  {
    sample = analogRead(pin);
    if (sample < 1024)  // toss out spurious readings
    {
      if (sample > signalMax)
      {
        signalMax = sample;  // save just the max levels
      }
      else if (sample < signalMin)
      {
        signalMin = sample;  // save just the min levels
      }
    }
  }
  // MAX-MIN peak amp, converted to 0-10  scale :
  return(((signalMax - signalMin) * 10.) / 1024);  
}


