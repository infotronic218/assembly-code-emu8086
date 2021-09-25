; multi-segment executable file template.

data segment
    msg db 10,13,"1- ADD ",10,13, "2- SUB", 10,13, "3- DIV ", 10,13 ,"4- MUL $"
    error db 10,13, "Error Enter A valide Operation $"  
    enter_a db 10,13 ,"Enter N1 $"
    enter_b db 10,13, "Enter N2 $" 
    results db 10,13 ,"ANS  $" 
    thanks db 10,13 ,"Thanks For using our calculator $"
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
  MOV AX, data
  MOV DS, AX
  MOV ES , AX 
  
  lea dx, msg
  MOV AH, 9
  INT 21h
  
  ; Take first value
  MOV AH, 1
  INT 21h 
  

   
  CMP AL,31h
  JE ADDITION ;If  press 1  
  
  CMP AL, 32h
  JE  SUBSTRACT
  
  CMP AL, 33h
  JE  DIVIDE  
  
  CMP AL, 34h
  JE  MULTIPLY
  
  LEA DX , error
  MOV AH, 9
  INT 21h
  
  JMP start    
  
ADDITION: LEA DX, enter_a
          MOV AH, 9
          INT 21h
          
          MOV CX,0
          CALL InputNum
          PUSH DX
          
          LEA DX, enter_b  
          MOV AH,9
          INT 21h  
          MOV CX, 0
          CALL InputNum
          POP BX
          ADD DX, BX
          PUSH DX
          LEA dx , results
          MOV AH , 9
          INT 21h
          POP DX 
          MOV CX, 10000
          CALL View
          JMP Exit 
Exit :
     LEA DX, Thanks
     MOV Ah, 9
     INT 29h 
     MOV AH,0
     INT 16h
     
     MOV ah, 0
View    :
         MOV AX, DX
         MOV DX, 0
         DIV CX
         call ViewNum
         MOV AX, CX
         MOV CX, 10
         DIV CX 
         MOV DX, BX
         MOV CX,AX
         cmp AX, 0
                   
         JNE View
         RET
         
          

InputNum : MOV AH, 0
          INT 16h
          CMP AL, 0Dh
          JE FormNum
          SUB AX, 30h
          CALL ViewNum
          MOV AH,0
          PUSH AX
          INC CX
          JMP InputNum
FormNum : 
         POP AX
         PUSH DX
         MUL BX
        
         ADD DX, AX
         MOV AX, BX
         MOV BX, 10
         PUSH DX
         MUL BX
         POP DX
         MOV BX,AX
         DEC CX
         CMP CX,0
         jne FormNum
         RET

ViewNum :
         PUSH AX
         PUSH DX 
         MUL BX
         POP DX
         
         ADD DX, AX
    
         MOV AH, 2
         INT 21h
         POP DX
         POP AX 
         RET
          

        
        

SUBSTRACT:


DIVIDE:

MULTIPLY:

 
 

   
ends

end start ; set entry point and stop the assembler.
