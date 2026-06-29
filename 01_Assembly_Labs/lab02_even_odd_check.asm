ASSUME CS:KODIKAS, DS:DATA

DATA SEGMENT
    ; --- Ta minimata mas (10, 13 gia allagi grammis, $ gia telos) ---
    msg1 DB 10, 13, 'Doste ena noumero: $'
    msg2 DB 10, 13, 'O Arithmos einai Peritos$' 
    msg3 DB 10, 13, 'O Arithmos einai Artios$'
    msg4 DB 10, 13, 'O Arithmos einai 0$'          
DATA ENDS

KODIKAS SEGMENT
MAIN:    
    ; --- Arxikopoihsi tis apothikis (DS) ---
    MOV AX, DATA             
    MOV DS, AX    
    
    ; --- SETUP TIS LOUPAS ---
    MOV CX, 5               ; Vazoume to 5 ston CX. I LOOP tha ginei 5 fores.
    
    Arxi_Epanalipsis:       ; Edw tha ksanagyrnaei to programma se kathe kyklo
    
        Zita_Xaraktira:     ; Etiketa gia na gyrname edw an dwsei lathos xaraktira
        
            ; 1. Typwma tou minimatos protropis
            LEA DX, msg1
            MOV AH, 09h
            INT 21h
        
            ; 2. Kryfi eisagwgi xaraktira apo ton xristi (8i klisi)
            MOV AH, 08h
            INT 21h         ; O xaraktiras pou patithike paei ston AL
            
            ; 3. Elegxos (Validation) an einai apo 0 ews 9
            CMP AL, '0'     ; Sygkrinoume ton AL me to '0'
            JB Zita_Xaraktira ; Jump if Below: An einai mikrotero, pane pisw!
            
            CMP AL, '9'     ; Sygkrinoume ton AL me to '9'
            JA Zita_Xaraktira ; Jump if Above: An einai megalytero, pane pisw!
            
            ; 4. Afou einai swstos (0-9), ton typwnoume na fanei stin othoni
            MOV DL, AL      ; To DOS thelei ton xaraktira panta ston DL
            MOV AH, 02h     ; 2i klisi gia typwma enos xaraktira
            INT 21h
            
            ; 5. Elegxos an o arithmos einai to Miden
            CMP AL, '0'     
            JE Miden        ; Jump if Equal: An AL == '0', pane stin etiketa Miden
            
            ; 6. Proetoimasia gia diairesi (SOS vima)
            MOV AH, 0       ; Katharizoume ta "skoupidia" apo to panw miso tou AX
            MOV BL, 2       ; Vazoume ton diaireti (to 2) ston BL
            
            ; 7. Diairesi gia na vroume an einai Artios i Perittos
            DIV BL          ; O 8086 kanei AX / BL. To YPOLOIPO paei aytomata ston AH!
            
            CMP AH, 0       ; Elegxoume an to ypoloipo (AH) einai 0
            JE Artios       ; An einai 0, o arithmos einai Artios. Pane stin etiketa Artios.
            
            ; --- BLOCK EKTELESIS GIA PERITTO ---
            Peritos:        ; An den ekane kanena JUMP, o arithmos einai Perittos
                LEA DX, msg2
                MOV AH, 09h
                INT 21h
                JMP Telos   ; SOS: Pida sto telos gia na min typwsei KAI ta apo katw minimata!
            
            ; --- BLOCK EKTELESIS GIA ARTIO ---
            Artios:
                LEA DX, msg3
                MOV AH, 09h
                INT 21h
                JMP Telos   ; SOS: Pida sto telos gia na min typwsei KAI to miden!
            
            ; --- BLOCK EKTELESIS GIA MIDEN ---
            Miden:
                LEA DX, msg4
                MOV AH, 09h
                INT 21h
                        
            ; --- KIKLOS KAI TERMATISMOS ---
            Telos:
                LOOP Arxi_Epanalipsis ; Meiwnei ton CX kata 1. An CX!=0, paei sto Arxi_Epanalipsis
                
                MOV AH, 4Ch           ; An CX==0, bgainei apo ti loupa kai kleinei to programma!
                INT 21h                             
KODIKAS ENDS
END MAIN