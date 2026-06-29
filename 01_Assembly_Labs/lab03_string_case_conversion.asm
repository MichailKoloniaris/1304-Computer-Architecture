ASSUME CS:KODIKAS, DS:DATA

DATA SEGMENT
    ; --- Dilosi Minimatwn kai Pinaka ---
    msg1 DB 10, 13, 'Eisagete keimeno: $'
    msg_teliko DB 10, 13, 'To keimeno meta tin metatropi: $'
    Buffer DB 40 dup(0)    ; Pinakas 40 thesewn gematos me midenika
DATA ENDS

KODIKAS SEGMENT
MAIN:

    ; --- Arxikopoihsi tou Data Segment ---
    MOV AX, DATA             
    MOV DS, AX
    
    ; 1. Typwma tou arxikou minimatos
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    
    ; 2. Proetoimasia twn deiktwn gia to diavasma
    LEA BX, Buffer         ; O BX deixnei sto prwto koutaki tou Buffer
    MOV CX, 0              ; O CX tha metraei posa egkyra grammata mpikan
    
    Diavasma:
        MOV AH, 01h        ; 1i klisi DOS: Diavazei KAI typwnei to gramma stin othoni
        INT 21h
        
        ; --- Elegxos Termatismou ---
        CMP AL, 13         ; Patise Enter (ASCII 13)?
        JE Telos_Diavasmatos ; An nai, telos i eisagwgi!
        
        ; --- Validation (Elegxos Egkyrotitas) ---
        CMP AL, ' '        ; Einai keno (space)?
        JE Apothikefsi     ; Pida stin apothikeysi
        
        CMP AL, '.'        ; Einai teleia?
        JE Apothikefsi     ; Pida stin apothikeysi
        
        CMP AL, 'A'
        JB Diavasma        ; An < 'A' (p.x. arithmos), lathos, ksanazita!
        
        CMP AL, 'Z'
        JBE Apothikefsi    ; An <= 'Z', einai Kefalaio. Pida stin apothikeysi
        
        CMP AL, 'a'
        JB Diavasma        ; An < 'a' (anamesa se Z kai a), lathos, ksanazita!
        
        CMP AL, 'z'
        JA Diavasma        ; An > 'z' (p.x. { } ), lathos, ksanazita!
        
        ; --- Apothikeysi ston Pinaka ---
        Apothikefsi:
            MOV [BX], AL   ; Vazei to swsto gramma MESA sto koutaki
            INC BX         ; Paei ton deikti sto epomeno koutaki
            INC CX         ; Ayksanei ton metriti twn swstwn grammatwn
            
            CMP CX, 40     ; Eftase ta 40 grammata?
            JE Telos_Diavasmatos ; An nai, stamata na zitas alla
            
            JMP Diavasma   ; Alliws, pane na zitiseis to epomeno
        
    Telos_Diavasmatos:    
        ; --- Elegxos Adeiou Keimenou ---
        JCXZ Termatismos   ; (Jump if CX is Zero): An de diavase tipota, termatise!
        
        JMP Fasi_2         ; Alliws, pame na ta metatrepsoume
    
    Fasi_2:
         ; Typwma tou minimatos apotelesmatos
         LEA DX, msg_teliko
         MOV AH, 09h
         INT 21h
         
         ; Ksana-arxikopoihsi tou deikti stin arxi tou pinaka
         LEA BX, Buffer
         ; O CX exei idi to swsto plithos grammatwn, ara einai etoimos gia ti LOOP!
         
    Epanalipsi_Ektiposis:
        
        MOV AL, [BX]       ; Pairnoume to gramma apo to koutaki
        
        ; --- Elegxoi kai Metatropes ---
        CMP AL, 32         ; Einai keno?
        JE Typwma          ; An nai, min to peirazeis, pida sto typwma
        
        CMP AL, '.'        ; Einai teleia? (SOS: Eileipe autos o elegxos!)
        JE Typwma          ; An nai, min to peirazeis
        
        CMP AL, 'Z'
        JBE Prosthese      ; An <= 'Z', einai kefalaio. Pame na to kanoume mikro
        
        Afairese:
            SUB AL, 32     ; Mikro -> Kefalaio
            JMP Typwma     ; Pida sto typwma gia na min ginei KAI i prosthesi
        
        Prosthese:
            ADD AL, 32     ; Kefalaio -> Mikro
                 
    Typwma:
        MOV DL, AL
        MOV AH, 02h        ; 2i klisi DOS: Typwma tou xaraktira stin othoni
        INT 21h
        
        INC BX             ; Deikse sto epomeno koutaki
        LOOP Epanalipsi_Ektiposis ; Meiwse ton CX. An CX != 0, ksanapane stin Epanalipsi
        
    Termatismos:
        MOV AH, 4Ch        ; Omali eksodos sto DOS
        INT 21h  
    
KODIKAS ENDS
END MAIN