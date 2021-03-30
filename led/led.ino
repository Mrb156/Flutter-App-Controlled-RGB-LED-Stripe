//alapkönyvtárak
#include "FirebaseESP8266.h"
#define FASTLED_ALLOW_INTERRUPTS 0
#include <FastLED.h>
#include <ESP8266WiFi.h>

//led inicializálás
#define NUM_LEDS 60
#define LED_PIN 4

//hálózat beállítása
const char* ssid = "YOUR_SSID";
const char* password = "YOUR_PASSWORD";
FirebaseData firebaseData;

//sftw led beállítás
CRGB leds [NUM_LEDS];

//alap változók
uint8_t redValue = 0;
uint8_t greenValue = 0;
uint8_t blueValue = 0;
uint8_t Br = 10;
uint8_t hue = 0;
uint8_t paletteIndex = 0;
String value = "";
String state = "";

//palette beállítása
DEFINE_GRADIENT_PALETTE (g1) {
  0,  153, 0, 120,  //hely, R, G, B
  128,  153, 0, 3,
  255,  0, 141, 153,
};
CRGBPalette16 myPal = g1;

DEFINE_GRADIENT_PALETTE( g2 ) {
  0,    0,  0,    0,     //green
  85,    255,  0,  0,     //bluegreen
  170,  255,  255,  0,     //gray
  255,  255,   255,    255,     //brown
};
CRGBPalette16 g_w_p = g2;

unsigned long sendDataPrevMillis1;

void setup() {
  Serial.begin(115200);
  connectWifi();
  //firebase databse URL (without https://) + secret key
  Firebase.begin("URL", "SECRET");
  FastLED.addLeds<WS2812B, LED_PIN, GRB>(leds, NUM_LEDS);
  FastLED.setMaxRefreshRate(100);
}

String setups[4];
void loop() {
  //adatbázisból adatlekérés x ms-onként
  if (millis() - sendDataPrevMillis1 > 5000)
  {

    sendDataPrevMillis1 = millis();
    value = getData("/SetUp");

    for (int i = 0; i < 4; i++) {
      if (setups[i] != getValue(value, ' ', i)) {
        setups[i] = getValue(value, ' ', i);
      }
    }
    if (Br != getDataInt("/Br")) {
      Br = getDataInt("/Br");
    }
  }

  if (setups[0] == "rainbow") {
    rainbow();
  }
  else if (setups[0] == "u_rainbow") {
    u_rainbow();
  }
  else if (setups[0] == "pat")
  {
    pat();
  }
  else if (setups[0] == "odavissza") {
    if (redValue != setups[1].toInt()) {
      redValue = setups[1].toInt();
    }
    if (greenValue != setups[2].toInt()) {
      greenValue = setups[2].toInt();
    }
    if (blueValue != setups[3].toInt()) {
      blueValue = setups[3].toInt();
    }
    odavissza();
  }
  else if (setups[0] == "g_wave") {
    g_wave();
  }
  else if (setups[0] == "szín") {
    Change();
  }

}


//programok
//fade into another color
void rainbow()
{

  FastLED.setBrightness(Br);
  for (int i = 0; i < NUM_LEDS; i++)
  {
    // hue, saturation, value
    leds[i] = CHSV(hue, 255, 255);
    EVERY_N_MILLISECONDS(15)
    {
      hue++;
    }
  }
  FastLED.show();
}

//a szivárvány végigfut a szalagon
void u_rainbow()
{
  FastLED.setBrightness(Br);
  for (int i = 0; i < NUM_LEDS; i++)
  {
    leds[i] = CHSV(hue + (i * 10), 255, 255);
  }
  EVERY_N_MILLISECONDS(10)
  {
    hue++;
  }
  FastLED.show();

}

//pattern function színátmenet
void pat()
{
  fill_palette(leds, NUM_LEDS, paletteIndex, 1, myPal, 255, LINEARBLEND);
  FastLED.setBrightness(Br);
  FastLED.show();
}

void odavissza()
{
  uint16_t sinBeat = beatsin16(10, 0, NUM_LEDS, 0, 0);
  leds[sinBeat] = CRGB(redValue, greenValue, blueValue);
  fadeToBlackBy(leds, NUM_LEDS, 20);
  FastLED.setBrightness(Br);
  FastLED.show();
}

void g_wave()
{
  int16_t beatA = beatsin16(30, 0, 255);
  uint16_t beatB = beatsin16(20, 0, 255);
  fill_palette(leds, NUM_LEDS, (beatA + beatB) / 2, 10, g_w_p, 255, LINEARBLEND);
  FastLED.setBrightness(Br);
  FastLED.show();

}

void setLedColor() {
  FastLED.setBrightness(Br);
  
  
  for (int i = 0; i < NUM_LEDS; i++)
  {
    leds[i] = CRGB(redValue, greenValue, blueValue);
    
  }
  FastLED.show();
}

//wifi csatlakozás
void connectWifi() {
  // Let us connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");

  }
  //Serial.println(".......");
  //Serial.println("WiFi Connected....IP Address:");
  //Serial.println(WiFi.localIP());
  Serial.println("Connected");
}

//adatkérés az adatbázistól
int getDataInt(String path) {
  Firebase.getInt(firebaseData, path);
  return firebaseData.intData();
}
String getData(String path) {
  Firebase.getString(firebaseData, path);
  return firebaseData.stringData();
}

//sztring szétördelése
String getValue(String data, char separator, int index)
{
  int found = 0;
  int strIndex[] = {0, -1};
  int maxIndex = data.length() - 1;

  for (int i = 0; i <= maxIndex && found <= index; i++) {
    if (data.charAt(i) == separator || i == maxIndex) {
      found++;
      strIndex[0] = strIndex[1] + 1;
      strIndex[1] = (i == maxIndex) ? i + 1 : i;
    }
  }

  return found > index ? data.substring(strIndex[0], strIndex[1]) : "";
}

//alapszín váltás
void Change() {
  delay(5000);
  if (Firebase.getInt(firebaseData, "red") != redValue) {
    redValue = firebaseData.intData();
    setLedColor();
  }
  if (Firebase.getInt(firebaseData, "green") != greenValue) {
    greenValue = firebaseData.intData();
    setLedColor();
  }


  if (Firebase.getInt(firebaseData, "blue") != blueValue) {
    blueValue = firebaseData.intData();
    setLedColor();
  }
}
