/* =========================================================
 * 1304 - Οργάνωση & Αρχιτεκτονική Υπολογιστικών Συστημάτων
 * Lab 02: Serial Communication & Timing (millis vs delay)
 * =========================================================
 * Odigos Xrisis:
 * Allakse ton arithmo sto EXERCISE gia na trekseis tin 
 * antistoixi askisi tou ergastiriou (1, 2, i 3).
 * ========================================================= */

#define EXERCISE 1   // <--- ALLAZEIS AUTO TO NOUMERO (1, 2, i 3)

// --- Koines Metavlites (Pins) ---

// Gia to RGB LED (Askisi 1) 
int redPin = 11;
int greenPin = 10;
int bluePin = 9;

// Gia ta aples Askhseis 2 & 3 
int ledPin1 = 13;
int ledPin2 = 11;

// Metavlites xronou gia tin Askisi 3 (millis)
unsigned long lastMillis1 = 0;
unsigned long lastMillis2 = 0;

void setup() {
  // Setup gia ola ta pins tou Lab 2
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
  
  pinMode(ledPin1, OUTPUT);
  pinMode(ledPin2, OUTPUT);
  
  Serial.begin(9600);
}

void loop() {
  
  // =========================================================
  // ASKISI 1: RGB LED mesw Serial Monitor 
  // =========================================================
  #if EXERCISE == 1
    
    if(Serial.available() > 0) {
      String input = Serial.readString();
      input.trim(); // SOS: Katharizei ta Enter (\n) pou stelnei to Serial Monitor!
      
      if (input == "kitrino") {
        analogWrite(redPin, 255);
        analogWrite(greenPin, 255);
        analogWrite(bluePin, 0);
      }
      else if (input == "mov") {
        analogWrite(redPin, 168);
        analogWrite(greenPin, 0);
        analogWrite(bluePin, 255);
      }
      else {
        Serial.println("Lathos xroma");
      } 
    }

  // =========================================================
  // ASKISI 2: Aplo Blink me delay() 
  // =========================================================
  #elif EXERCISE == 2
    
    digitalWrite(ledPin1, HIGH);
    delay(500); 
    digitalWrite(ledPin1, LOW);
    delay(500); 

  // =========================================================
  // ASKISI 3: Taytoxrono Blink dyo LED me millis() 
  // =========================================================
  #elif EXERCISE == 3
    
    unsigned long currentMillis = millis();
    
    // Elegxos gia to 1o LED (Kathe 300ms)
    if (currentMillis - lastMillis1 >= 300) {
      lastMillis1 = currentMillis;
      // Diavazei tin twrini katastasi kai tin antistrefei (Toggle)
      int currentState1 = digitalRead(ledPin1);
      digitalWrite(ledPin1, !currentState1); 
    }
    
    // Elegxos gia to 2o LED (Kathe 1000ms)
    if (currentMillis - lastMillis2 >= 1000) {
      lastMillis2 = currentMillis;
      // Diavazei tin twrini katastasi kai tin antistrefei (Toggle)
      int currentState2 = digitalRead(ledPin2);
      digitalWrite(ledPin2, !currentState2);
    }
    
  #endif
}
