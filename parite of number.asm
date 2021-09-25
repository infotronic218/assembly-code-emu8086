data segment 
    welcome db "PARITY OF NUMBER $"
    enter_a db 10,13,"Enter le nombre : $"
    impair db 10,13,"Le nombre saisi est impair   $" 
    pair db 10,13,"Le nombre saisi est pair   $" 
    
    number dw , 0
    
    
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
    MOV number, DX
    CALL CHECK_PARITY
    
    
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
CHECK_PARITY: 
      MOV DX, 0
      MOV AX, number
      MOV BX,2
      DIV BX
      CMP DX,0
      JE IS_PAIR
      CALL IS_IMPAIR
      
      RET  
IS_PAIR:
     LEA DX, pair
     MOV AH, 9
     INT 21h
     RET
IS_IMPAIR:
     LEA DX, impair
     MOV AH, 9
     INT 21h
     RET
      
EXIT:
MOV AH , 4ch
INT 21h      
     
    
    
    
 
code ends

end start
