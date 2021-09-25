data segment   
    msg db 10,13, "Faire un choix ",10,13, "1- ADD ", 10,13, "2- SUB",10, 13 ,"3- DIV", 10,13, "4- MUL  $"
    error db 10,13, "Erreur verifier votre choix   $"
    entrer_a db 10,13, "Entrer la valeur de A : $"
    entrer_b db 10,13, "Entrer la valeur de B : $" 
    result  db 10,13, "Le resultat est : $"
   
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
       MOV AX, data
       MOV DS , AX
       MOV ES , AX
       
       LEA DX, msg
       MOV AH, 9
       INT 21h
       
       
       ;Lire le choix de l'utilisateur
       
       MOV AH, 1
       INT 21h
       ; Cas de l'addition
       CMP AL, 31h
       JE ADDITION
       ; Cas de la soustraction
       CMP AL, 32h
       JE SOUSTRACTION 
       ; Cas de la division
       CMP AL, 33h
       JE DIVISION 
       ; Cas de la multiplication
       CMP AL , 34h
       JE MULTIPLICATION
       ; Cas d'erreur de choix
       LEA DX, error
       MOV AH, 9         
       INT 21h 
       JMP start
                      

 ADDITION:; realiser l'addition
          LEA DX, entrer_a
          MOV AH, 9
          INT 21h
              
          MOV CX, 0  
          
          CALL ENTRER_NOMBRE ; Saisir le premier nombre
          
          PUSH DX
          
          LEA DX , entrer_b
          MOV AH,9
          INT 21h
          
          MOV CX, 0
          
          CALL ENTRER_NOMBRE ; Saisir le deuxieme nombre
          
          MOV BX, DX
          
          POP AX
          
          ADD AX, BX ; Addition des deux nombres 
          PUSH AX
         
          LEA DX, result
          
          MOV AH , 9
          INT 21h
          
          MOV  CX,10000
          POP DX
          CALL AFFICHER ; Afficher le resultat
          JMP EXIT
          
MULTIPLICATION:; Realiser la multiplication
          LEA DX, entrer_a
          MOV AH, 9
          INT 21h    
          MOV CX, 0
          CALL ENTRER_NOMBRE ; Saisir le premier nombre
          
          PUSH DX
          LEA DX , entrer_b
          MOV AH,9
          INT 21h
          MOV CX, 0
          
          CALL ENTRER_NOMBRE ; Saisir le deuxieme nombre
          
          MOV BX, DX
          
          POP AX
          MUL BX  ; Multiplication des deux nombres 
          PUSH AX
          PUSH DX
          LEA DX, result
          MOV AH , 9
          INT 21h
          POP DX   
          POP AX
          CALL DISPLAY32 ; Afficher le resultat de 32 bits 
          JMP EXIT          
          
SOUSTRACTION: ; Realiser la soustraction
           LEA DX, entrer_a
           MOV AH , 9
           INT 21h  
           
           MOV CX, 0
           CALL ENTRER_NOMBRE ; Saisir le premier nombre
           PUSH DX
           
           LEA DX, entrer_b
           MOV AH, 9
           INT 21h
           
           MOV CX, 0
           CALL ENTRER_NOMBRE   ; Saisir le deuxième nombre nombre
           
           MOV BX, DX
           POP AX 
           
           PUSH AX
           
           CMP BX,AX
           JNL B_PLUS_GRAND_A ; Quand B Superieur a A
            
           
           SUB AX, BX; Soustraire le deuxieme nombre aux premier
           
           PUSH AX
           
           LEA DX , result
           MOV AH, 9
           INT 21h
           
           MOV CX, 10000
           POP DX
           CALL AFFICHER ; Afficher le resultat
           
           JMP EXIT
            
B_PLUS_GRAND_A: ; Le cas de le premier nombre est inferieur au deuxieme
        
        SUB BX, AX
        PUSH BX
        
        LEA DX, result
        MOV AH, 9
        INT 21h
        
        MOV AX, 240 ; Afficher le signe negatif
        MOV DX, AX
        MOV AH, 2
        INT 21h
        
        MOV CX, 10000
        POP DX
        CALL AFFICHER ; Afficher le resultat
        JMP EXIT    
  
 DIVISION: ; Realiser la division  
           LEA DX, entrer_a
           MOV AH, 9
           INT 21h
           MOV CX, 0
           CALL ENTRER_NOMBRE ; Entrer le premier nombre
           PUSH DX
           
           LEA DX, entrer_b
           MOV AH, 9
           INT 21h
           
           MOV CX, 0
           CALL ENTRER_NOMBRE ; Entrer le deuxieme nombre
           MOV AX, DX 
           
           POP BX   
           MOV AX, BX
           
           MOV CX, DX 
           MOV DX, 0
           MOV BX, 0  
           
           DIV CX    ; Diviser le premier nombre par le deuxieme 
           MOV BX, DX 
           MOV DX,  AX 
           PUSH BX
           PUSH DX
           LEA DX, result
           MOV AH, 9
           INT 21h
           
           MOV CX ,10000
           POP DX
           CALL AFFICHER ; Afficher le resultat
           JMP EXIT  
           
ENTRER_NOMBRE: ; Lire les touches saisi
            MOV AH, 1
            INT 21h    
            
            MOV BX, 1 
            MOV DX, 0  
            
            CMP AL, 0dh ; Comparer le caractere avec la touche entree
            JE FORMER_NOMBRE ; Aller construire le nombre decimal
            SUB AL, 30h
            MOV AH, 0
            PUSH AX ; Stocker le caractere dans la pile
            INC CX 
            JMP ENTRER_NOMBRE; Demander la saisi d'un caractere

FORMER_NOMBRE: ; Conversion du nombre saisi en decimal 
           POP AX  
           PUSH DX 
           
           MUL BX
           
           POP DX
           ADD DX, AX
           MOV AX, BX 
           
           
           MOV BX,  10  
           PUSH DX 
           
           MUL BX 
           
           POP DX
           MOV BX , AX
           
           
           DEC CX
           
           CMP CX ,0
           JNE FORMER_NOMBRE
           RET    

          
          
AFFICHER: ;Afficher le nombre avec le code asci      
          MOV AX, DX
          MOV DX, 0
          DIV CX
          CALL AFFICHER_NOMBRE
          MOV BX, DX 
          MOV DX, 0  
          MOV AX, CX
          MOV CX, 10
          DIV CX
          MOV DX, BX
          MOV CX, AX
          CMP AX, 0
          JNE AFFICHER
          RET   
          
AFFICHER_NOMBRE: ; Afficher un nombre a en ajoutant le code asci de 0  
           PUSH AX
           PUSH DX
           MOV DX, AX
           ADD DL, 30h
           MOV AH, 2
           INT 21h
           POP DX
           POP AX     
           RET  
           
              
DISPLAY32:  ;Affiche un nombre de 32bits stocke dans AX, 
            MOV BX, 10
            PUSH BX ; Limite des resultats stockes dans la pile
     DIVIDE:MOV CX, AX 
            MOV AX,DX
            MOV DX, 0        
            DIV BX
            XCHG AX, CX        
            DIV BX        
            PUSH DX ; Le resultat total de la division
            MOV DX, CX        
            OR CX, AX 
            JNE DIVIDE
            POP DX
    DISPLAY:ADD DX, 30h
            MOV AH,2 
            INT 21h
            POP DX
            CMP DX, BX
            JNE DISPLAY ; Tant qu'on a pas atteint la limite on continu l'affifchage
            RET
 
          
EXIT:
         MOV AH, 4ch
         INT 21h
    
code ends

end start ; set entry point and stop the assembler.
