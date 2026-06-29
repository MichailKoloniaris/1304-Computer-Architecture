/* =========================================================
 * 1304 - Οργάνωση & Αρχιτεκτονική Υπολογιστικών Συστημάτων
 * Lab 01: Pins, Buttons & Potentiometers
 * =========================================================
 * Odigos Xrisis:
 * Allakse ton arithmo sto EXERCISE gia na trekseis tin 
 * antistoixi askisi tou ergastiriou (1, 2, i 3).
 * ========================================================= */

#define EXERCISE 1   // <--- ALLAZEIS AUTO TO NOUMERO (1, 2, i 3)

// --- Koines Metavlites gia oles tis askiseis ---
int buttonPin = 2;
int firstLedPin = 6;
int secondLedPin = 3;
int potPin = A0;
int potValue;

void setup() {
  // Setup gia ola ta pins pou xrisimopoiountai sto Lab 1
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(firstLedPin, OUTPUT);
  pinMode(secondLedPin, OUTPUT);
  
  // To koumpi xrisimopoiei thn eswteriki antistasi tou Arduino
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  
  // =========================================================
  // ASKISI 1: Statheros fwtismos LED
  // =========================================================
  #if EXERCISE == 1
    
    digitalWrite(firstLedPin, HIGH);
    analogWrite(secondLedPin, 102);

  // =========================================================
  // ASKISI 2: Xrisi Koumpiou (Button)
  // =========================================================
  #elif EXERCISE == 2
    
    int buttonState = digitalRead(buttonPin);
    
    if (buttonState == LOW) {
      digitalWrite(firstLedPin, HIGH);
      analogWrite(secondLedPin, 204);
    } else {
      digitalWrite(firstLedPin, LOW);
      analogWrite(secondLedPin, 102);
    }

  // =========================================================
  // ASKISI 3: Koumpi kai Potensiometro (Potentiometer)
  // =========================================================
  #elif EXERCISE == 3
    
    int buttonState = digitalRead(buttonPin);
    potValue = analogRead(potPin);
    
    // (potValue / 4) metatrepei eukola to 0-1023 se 0-255 gia to PWM
    analogWrite(secondLedPin, (potValue / 4));
    
    if (buttonState == LOW) {
      digitalWrite(firstLedPin, HIGH);
    } else {
      digitalWrite(firstLedPin, LOW);
    }
    
  #endif
}