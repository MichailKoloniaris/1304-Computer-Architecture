/* =========================================================
 * 1304 - Οργάνωση & Αρχιτεκτονική Υπολογιστικών Συστημάτων
 * Lab 04: Peripherals (HD44780 LCD & Ultrasonic)
 * =========================================================
 * Odigos Xrisis:
 * Allakse ton arithmo sto EXERCISE gia na trekseis tin 
 * antistoixi askisi tou ergastiriou.
 * ========================================================= */

#define EXERCISE 1   // <--- ALLAZEIS AUTO TO NOUMERO

// --- Vivliothikes & Metavlites ---
#include <LiquidCrystal.h> // Vivliothiki gia tin othoni LCD

// Arxikopoihsi twn pins tis othonis LCD (RS, E, D4, D5, D6, D7)
LiquidCrystal lcd(12, 11, 5, 4, 3, 2); 

// To keimeno pou tha kanei scroll (exei kena sto telos gia omai xwrismata)
String message = "Hello Arduino!  "; 

void setup() {
  
  #if EXERCISE == 1
    // Orismos twn sthlwn (16) kai grammwn (2) tis LCD othonis
    lcd.begin(16, 2);
  #endif
  
}

void loop() {
  
  // =========================================================
  // ASKISI 1: Kyliomeno Keimeno (Scrolling Text) stin LCD
  // =========================================================
  #if EXERCISE == 1
    
    // Epanalipsi gia kathe xaraktira tou minimatos
    for (int i = 0; i < message.length(); i++) {
      
      lcd.setCursor(0, 0); // Pame ton kersora stin panw aristera gwnia
      
      String textToShow = "";
      
      // Dimiourgia tou "parathyrou" 16 xaraktirwn gia to scrolling
      for (int j = 0; j < 16; j++) {
        // Xrisi tou modulo (%) gia na ksanapaei stin arxi otan ftasei sto telos
        int index = (i + j) % message.length();
        textToShow += message[index];
      }
      
      lcd.print(textToShow); // Typwma stin othoni
      
      delay(300); // Taxytita kylisis (300ms)
    }
    
  #endif
}