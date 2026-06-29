ASSUME CS:KODIKAS, DS:DATA

DATA SEGMENT
    Buffer DB 80 dup(0)
    msg1 DB 10, 13, 'Eisagete keimeno: $'
    msg2 DB 10, 13, 'Eisagete Enan xaraktira: $'
    msg3 DB 10, 13, 'O xaraktiras den vrethike$' ; 
    newline DB 10, 13, '$'                       ; 
    SearchChar DB 0
DATA ENDS

KODIKAS SEGMENT
MAIN:
    ; --- Arxikopoihsi Data Segment ---
    MOV AX, DATA             
    MOV DS, AX
    
    ; --- Typwma Arxikou Minimatos ---
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    
    ; --- Proetoimasia gia diavasma ---
    LEA BX, Buffer
    MOV CX, 0
    
    Diavasma:
        MOV AH, 01h
        INT 21h
        
        CMP AL, '#'
        JE Telos_Diavasmatos
        
        Apothikeysi:
            MOV [BX], AL
            INC BX
            INC CX
            
            CMP CX, 80
            JE Telos_Diavasmatos
            
            JMP Diavasma
        
    Telos_Diavasmatos:
        JCXZ Telos          ; 
        CALL SEARCH_PROC
        
    ; --- TERMATISMOS MAIN ---
    Telos:
        MOV AH, 4Ch
        INT 21h
            
; =========================================================
; --- TO YPOPROGRAMMA (SEARCH_PROC) ---
; =========================================================
SEARCH_PROC PROC
    
    ; 1. Zitaei ton xaraktira apo ton xristi
    LEA DX, msg2
    MOV AH, 09h
    INT 21h
    
    ; 2. Diavazei ton xaraktira
    MOV AH, 01h
    INT 21h
    MOV SearchChar, AL      ; Apothikefsi sti mnimi
    MOV DH, AL              ; [DIORTHWSI]: Metafora ston DH gia na ginei i sygkrisi stin loupa
    
    ; 3. Setup tis Loupas
    MOV DL, 0               ; [DIORTHWSI]: Midenizoume ton metriti DL EDW (gia na min xalasei apo to LEA DX pio panw)
    LEA BX, Buffer          ; Deiktis stin arxi tou pinaka
    
    Sarwsi_Loop:
        CMP DH, [BX]        ; Sygkrisi: Eimai sto swsto gramma?
        JNE Epomeno_Koutaki ; An oxi, pida tin ayksisi
        
        INC DL              ; An nai, ayksise ton metriti!
        
    Epomeno_Koutaki:
        INC BX              ; Pame sto epomeno rafi
        LOOP Sarwsi_Loop    ; Meiwse ton CX. An CX!=0, ksanapame panw
        
    ; --- ALLAGI GRAMMIS (Gia na min kollisoun ta apotelesmata) ---
    MOV CL, DL              ; Swzoume ton metriti (DL) ston CL proswrina gia na min diagraftei!
    LEA DX, newline         ; Typwnoume to Enter
    MOV AH, 09h
    INT 21h
    MOV DL, CL              ; Epanaferoume ton metriti mas ston DL gia na ginoun oi elegxoi
    
    ; --- ELEGXOI APOTELESMATWN ---
    CMP DL, 0
    JE Miden
    
    CMP DL, 9
    JBE Monopsifios
    
    JMP Dipsifios
    
    ; --- PERIPTWSI 1: Miden (0) ---
    Miden:
        LEA DX, msg3
        MOV AH, 09h
        INT 21h
        JMP Telos_Ypoprogramatos    
       
    ; --- PERIPTWSI 2: Monopsifios (1 ews 9) ---
    Monopsifios:
        ADD DL, 30h         ; Metatropi se ASCII
        MOV AH, 02h
        INT 21h
        JMP Telos_Ypoprogramatos
        
    ; --- PERIPTWSI 3: Dipsifios (10+) ---
    Dipsifios:
        MOV AL, DL          ; Vazei ton metriti ston AL gia ti diairesi
        MOV AH, 0           ; Katharizei ta skoupidia apo ton AH
        MOV BL, 10          ; Diairetis to 10
        
        DIV BL              ; Diairesi! O AL exei ti dekada, o AH ti monada
        MOV BH, AH          ; Kryvoume ti monada ston BH proswrina
        
        ; Typwma Dekadas (vrisketai ston AL)
        MOV DL, AL
        ADD DL, 30h
        MOV AH, 02h
        INT 21h
        
        ; Typwma Monadas (tin kropsame ston BH)
        MOV DL, BH
        ADD DL, 30h
        MOV AH, 02h
        INT 21h
        
    Telos_Ypoprogramatos:
        RET
SEARCH_PROC ENDP            
                                  
KODIKAS ENDS
END MAIN