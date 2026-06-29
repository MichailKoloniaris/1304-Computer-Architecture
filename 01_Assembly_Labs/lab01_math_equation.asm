ASSUME CS:KODIKAS, DS:DATA   ; Leme ston assembler poioi kataxwrites deixnoun se poia tmimata (Segment)

DATA SEGMENT                 ; Arxi tis apothikis mas (.data)
    N DB 3                   ; Dilonoume ti metavliti N kai tis dinoume tin timi 3 (pianei 1 byte)
    msg DB 10, 13, 'To apotelesma einai: $' ; To minima mas. Ta 10,13 kanoun allagi grammis (Enter). To $ einai to telos.                   
DATA ENDS                    ; Telos tis apothikis

KODIKAS SEGMENT              ; Arxi tou kwdika mas (.code - edw mpenoun mono oi entoles)
MAIN:                        ; I etiketa pou deixnei apo pou ksekinaei na trexei to programma
    
    ; --- ARXIKOPOIHSI APOTHIKIS ---
    MOV AX, DATA             ; Pairnoume ti dieuthinsi tis apothikis (DATA)...
    MOV DS, AX               ; ...kai ti vazoume ston DS (Data Segment). Xwris auto den vriskei to N!
    
    ; --- YPOLOGISMOS N^2 ---
    MOV AL, N                ; Vazoume to N (to 3) ston AL (anagkastiko gia tin MUL)
    MOV BL, N                ; Vazoume to N kai ston BL
    MUL BL                   ; O 8086 kanei AL * BL (3*3). To apotelesma (9) paei aytomata ston AL.
    MOV CL, AL               ; Swnoume to apotelesma (9) ston CL gia na min to xasoume stis epomenes prakseis.
    
    ; --- YPOLOGISMOS 2*N ---
    MOV AL, 2                ; Vazoume to 2 ston AL
    MOV BL, N                ; Vazoume to N (to 3) ston BL
    MUL BL                   ; O 8086 kanei AL * BL (2*3). To apotelesma (6) paei aytomata ston AL.
    MOV CH, AL               ; Swnoume auto to apotelesma (6) ston CH.
    
    ; --- AFAIRESI & PROSTHESI (N^2 - 2*N + 1) ---
    SUB CL, CH               ; Kanoume CL = CL - CH (diladi 9 - 6 = 3). O CL exei pleon to 3.
    INC CL                   ; Ayksanoume ton CL kata 1 (diladi 3 + 1 = 4). O CL exei pleon to teliko apotelesma!
    
    ; --- EKTIPWSI MHNYMATOS ---
    LEA DX, msg              ; Fortwnoume ston DX ti dieuthinsi pou vrisketai to minima mas
    MOV AH, 09h              ; Zitaeme apo to DOS tin 9i klisi (Gia ektipwsi oloklirou string)
    INT 21h                  ; Ektelesi!
    
    ; --- EKTIPWSI ARITHMOU ---
    MOV DL, CL               ; To DOS thelei anagkastika ton xaraktira ston DL gia na ton tipwsei
    ADD DL, 30h              ; Sos: Prosthetoume 30h gia na ginei o arithmos 4 -> xaraktiras '4' (sto ASCII)
    MOV AH, 02h              ; Zitaeme apo to DOS ti 2i klisi (Gia ektipwsi ENOS xaraktira)
    INT 21h                  ; Ektelesi!
    
    ; --- TERMATISMOS ---
    MOV AH, 4CH              ; Leme sto DOS oti theloume na kleisoume to programma omla (Exit)
    INT 21h                  ; Ektelesi!
KODIKAS ENDS                 ; Telos tou tmimatos kwdika
END MAIN                     ; Dilwsi oti to programma teleiwnei edw kai ksekinaei na trexei apo to MAIN