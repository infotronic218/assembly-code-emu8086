
data segment
     
    msg db "FACTORIEL $"
    enter_a db 10,13, "Entrer a $" 
    result db 10,13, "Le Factoriel du nombre est : $"
    
ends

stack segment 
    dw 128 dup(0)
ends

code segment 
start: 
     MOV AX, data
     MOV DS, AX
     MOV ES, AX  
     
     
     LEA DX, msg
     MOV AH, 9
     INT 21h   
     
     MOV CX, 0
     CALL INPUT_NUMBER 
     MOV CX, DX
     MOV DX, 1
     CALL FACTORIEL 
     PUSH DX
     
     LEA DX, result
     MOV AH , 9
     INT 21h
     
     POP DX
     
     CALL DISPLAY
     
     CALL EXIT  
     
INPUT_NUMBER:           
         MOV AH, 1
         INT 21h  
         MOV BX, 1 
         MOV DX,0
         CMP AL, 0dh
         JE FORM_NUMBER
         MOV AH, 0
         SUB AX, 30h
         PUSH AX
         INC CX
         JMP INPUT_NUMBER 
FORM_NUMBER:
         POP AX
         PUSH DX  
         MOV DX, 0
         MUL BX   
         POP DX
         ADD DX, AX
         PUSH DX
         MOV AX, BX
         MOV BX, 10
         MOV DX, 0
         MUL BX
         MOV BX, AX
         POP DX
         DEC CX
         CMP CX, 0
         JNE FORM_NUMBER
         RET
FACTORIEL: 
         CMP CX, 0
         JNE CALCUL
         MOV DX, 1
         RET 
         
         
CALCUL:
     MOV AX, DX
     MOV DX, 0
     MOV BX, CX
     MUL BX 
     MOV DX, AX
     DEC CX
     CMP CX, 0
     JNE CALCUL
     RET
DISPLAY:
      MOV CX, 10000
      CALL VIEW 
      RET
VIEW:
   MOV AX, DX
   MOV DX, 0
   DIV CX
   PUSH DX
   
   MOV AH, 0
   ADD AL, 30h
   MOV DX, AX
   MOV AH,2
   INT 21h
   
   MOV AX, CX
   MOV BX,10
   MOV DX, 0
   DIV BX
   MOV CX, AX
   
   POP DX
   CMP CX,0
   JNE VIEW
   RET   
                   
     
EXIT:
    MOV AH, 4ch
                 
    INT 21h
     
ends
end start