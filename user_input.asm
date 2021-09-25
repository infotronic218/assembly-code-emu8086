data segment 
    welcome db "Welcome $"
    enter_a db 10,13,"Enter A : $"
    enter_b db 10,13,"Enter B : $" 
    result db 10,13,"ANS : $"
    
    
ends

stack segment
    
    
ends




code segment
start:
    MOV AX, data
    MOV DS, AX
    MOV ES, AX
    
    LEA DX, welcome
    MOV AH, 9
    INT 21h  
    
    LEA DX, enter_a
    MOV AH, 9
    INT 21h
    
    MOV CX, 0
    
    CALL INPUT_NUMBER
    PUSH DX
    
    LEA DX, enter_b
    MOV AH, 9
    INT 21h
    
    MOV CX, 0
    CALL INPUT_NUMBER
    
    POP AX
    ADD AX, DX
    
    PUSH AX
    LEA DX ,result
    MOV AH , 9
    INT 21h  
    
    POP DX
    CALL VIEW
    
    CALL EXIT
    
    
    
INPUT_NUMBER:
      MOV AH,1
      INT 21h
      MOV BX, 1
      MOV DX, 0
      CMP AL, 0dh
      JE FORM_NUMBER
      SUB AL ,30h
      MOV AH, 0
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
      MOV DX,0
      MUL BX
      MOV BX, AX 
      POP DX
      
      DEC CX
      CMP CX,0
      JNE FORM_NUMBER
      RET
VIEW:
      MOV CX, 10000
      CALL VIEW_NUMBER
      RET
VIEW_NUMBER:
      MOV AX, DX
      MOV DX, 0
      DIV CX
      PUSH DX
      ADD AL, 30h
      MOV AH, 0
      MOV DX, AX
      MOV AH, 2
      INT 21h
      
      MOV AX, CX
      MOV BX, 10
      MOV DX, 0
      DIV BX
      POP DX
      MOV CX, AX
      CMP CX, 0
      JNE VIEW_NUMBER
      RET      
      
EXIT:
MOV AH , 4ch
INT 21h      
     
    
    
    
 
code ends

end start
