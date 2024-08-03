#ifndef CONFIG_H
#define CONFIG_H

#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif

#include <Firebase_ESP_Client.h>
// Provide the token generation process info.
#include "addons/TokenHelper.h"
// Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"
// WiFi config
#include <WiFiManager.h>

// Insert Firebase project API Key
#define API_KEY "******"
// Insert RTDB URL
#define DATABASE_URL "https://demometter-default-rtdb.asia-southeast1.firebasedatabase.app/"

// Define pin usage
#define RsBttForEner D0
#define RsBttForWiFi D1
#define ledRSPre D2
#define ledRS D3
#define LED_PIN1 D8

// Firebase Data object and auth config
extern FirebaseData fbdo;
extern FirebaseAuth auth;
extern FirebaseConfig config;
extern FirebaseJson json;
extern WiFiManager wifiManager;

// Variables
extern bool wat_err;
extern int count_mss;
extern float volt, ampe, PF, wat, Frequency, Energy;
extern float sTimeSend, dur, eTimeSend;
extern unsigned long sendDataPrevMillis, getButtonData, sendStartTime;
extern bool signupOK;
extern unsigned int flagForRsWifi, flagForRsPower, flagSendData, wifiStatusFlag, checkWifiFlag;
extern String Path, espID, savedSsid;
extern char esp_ID_toChar[100];
extern unsigned int wifi_status, countErr, countTimeConWifi, wat_max;
extern const char* pass_to_char;
extern const char* ssid_to_char;
extern const unsigned long sendTimeout;

// Function declarations
void resetEneryByBtt();
void resetWifiByBtt();
bool isSavedNetworkFound(String ssid);
void fbErr(int getFlag);
void wat_err_alert(int current_wat);
int readRsBtt(float press_button_duration, int button_status_will_get);
int readRsBttForWifi(float press_button_duration, int button_status_will_get);

#endif // 
