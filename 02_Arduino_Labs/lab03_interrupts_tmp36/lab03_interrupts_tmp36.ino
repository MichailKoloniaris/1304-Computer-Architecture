/* =========================================================
 * 1304 - Οργάνωση & Αρχιτεκτονική Υπολογιστικών Συστημάτων
 * Lab 03: Interrupts & Peripherals (TMP36)
 * =========================================================
 * Odigos Xrisis:
 * Allakse ton arithmo sto EXERCISE gia na trekseis tin 
 * antistoixi askisi tou ergastiriou (1, 2, i 3).
 * ========================================================= */

#define EXERCISE 1   // <--- ALLAZEIS AUTO TO NOUMERO (1, 2, i 3)

// --- Koines Metavlites (Pins) ---
const int redPin = 11;
const int greenPin = 10;
const int bluePin = 9;

const int tempPin = A3;
const byte interruptPin = 2;

// --- Metavlites gia ta Interrupts (PREPEI na einai volatile) ---
volatile int redState = 255;
volatile int greenState = 255;
volatile int blueState = 0;

volatile bool buttonPressed = false; // Flag gia to interrupt tis Askisis 3

// --- Metavlites Xronou ---
unsigned long lastMillis = 0;
unsigned long currentMillis = 0;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  
  Serial.begin(9600);

  // Analoga me tin askisi, kanoume attach to antistoixo interrupt
  #if EXERCISE == 1
    attachInterrupt(digitalPinToInterrupt(interruptPin), toggleColor_ISR, CHANGE);
  #elif EXERCISE == 3
    attachInterrupt(digitalPinToInterrupt(interruptPin), buttonPress_ISR, RISING);
  #endif
}

void loop() {
  
  // =========================================================
  // ASKISI 1: RGB State Change me Interrupt
  // =========================================================
  #if EXERCISE == 1
    
    // H loop apla grafei ta states sto LED. Ta states allazoun astrapiaia mesw tou ISR.
    analogWrite(redPin, redState);
    analogWrite(greenPin, greenState);
    analogWrite(bluePin, blueState);  

  // =========================================================
  // ASKISI 2: TMP36 Sensor me millis()
  // =========================================================
  #elif EXERCISE == 2
    
    currentMillis = millis();
    if (currentMillis - lastMillis >= 2500) {
      lastMillis = currentMillis;
      readTempAndUpdateLED(); // Kaloume ti voitthitiki synartisi mas
    }

  // =========================================================
  // ASKISI 3: TMP36 Sensor me millis() KAI Interrupt 
  // =========================================================
  #elif EXERCISE == 3
    
    currentMillis = millis();
    
    // H loop trexei EITE an perasan 2.5 deyterolepta EITE an patithike to koumpi
    if (currentMillis - lastMillis >= 2500 || buttonPressed == true) {
      lastMillis = currentMillis; // Ksanarxizei to xronometro
      buttonPressed = false;      // Katevazoume to flag tou koumpiou
      
      readTempAndUpdateLED();     // Kaloume ti voitthitiki synartisi mas
    }
    
  #endif
}

// =========================================================
// VOITHITIKES SYNARTISEIS (Gia katharo kwdika)
// =========================================================

#if EXERCISE == 2 || EXERCISE == 3
void readTempAndUpdateLED() {
  int reading = analogRead(tempPin);
  float voltage = (reading * 5.0) / 1024.0;
  float temp = (voltage - 0.5) * 100.0;
  
  Serial.print("Temp: ");
  Serial.println(temp);
  
  if (temp > 25.0) {
    analogWrite(redPin, 255);
    analogWrite(greenPin, 0);
    analogWrite(bluePin, 0);
  }
  else if (temp < 5.0) {
    analogWrite(redPin, 0);
    analogWrite(greenPin, 0);
    analogWrite(bluePin, 255);
  }
  else {
    analogWrite(redPin, 255);
    analogWrite(greenPin, 255);
    analogWrite(bluePin, 0);
  }
}
#endif

// =========================================================
// ROUTINES DIAKOPIS (Interrupt Service Routines - ISR)
// =========================================================

#if EXERCISE == 1
void toggleColor_ISR() {
  if (redState == 255 && greenState == 255 && blueState == 0) {
    redState = 168;
    greenState = 0;
    blueState = 255;
  } else {
    redState = 255;
    greenState = 255;
    blueState = 0;
  }
}
#endif

#if EXERCISE == 3
void buttonPress_ISR() {
  // To monadiko pragma pou kanei to interrupt einai na sikwsei to flag!
  // I pragmatiki douleia (Serial.print, analogRead) ginetai me asfaleia sti loop.
  buttonPressed = true; 
}
#endif
