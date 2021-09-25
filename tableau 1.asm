data segment 
    msg db "Les elements du tableau sont : $"  
    msg_somme db 10,13, "La somme est : $"
    tab db 2,3,4,5,6, 7, 8 
    
    size dw 7    
    somme dw 0 
    max db 0
    min db 0
    
    
ends


stack segment
ends
code segment
start:
        
     MOV AX, data
     MOV DS, AX
     MOV ES, AX   
      
     
     
      
     LEA DX, msg
     MOV AH, 9
     INT 21h
     
     MOV SI, 0 
     CALL DISPLAY_TAB 
     
     LEA DX, msg_somme
     MOV AH, 9
     INT 21h 
      
     MOV SI, 0
     CALL SOMME_TAB
     
     MOV DX, somme
     
     CALL VIEW
     
     
 
     CALL EXIT 
     

SOMME_TAB: ; PUT IN SI 0 Before using this function
       
       MOV AX, somme
      
       MOV BL , tab[SI]
       MOV BH,0 
       ADD AX, BX
         
       MOV somme, AX 
       INC SI
       CMP SI, size
       JNE SOMME_TAB
       RET 
       
MAX_AND_MIN: ; Put in cx before calling this function
       CMP SI, 0
       JE INITIATE 
       MOV AL, tab[SI]
       
       CMP AL, min 
       JL NEW_MIN 
       CMP AL, max
       JNL NEW_MAX
       INC SI
       CMP SI, size
       JNE MAX_AND_MIN
       RET
        
INITIATE: 
       MOV AL, tab[0]
       MOV min , AL
       MOV max,  AL 
       RET
NEW_MIN: 
      MOV AL, tab[SI]
      MOV min, AL
      RET

NEW_MAX:
       MOV AL, tab[SI]
       MOV max, AL
       RET  
         
     

DISPLAY_TAB:            
        MOV DL, tab[SI]  
        ADD DL, 30h
        MOV DH, 0
        INC SI
        MOV AH, 2
        INT 21h   
        
        MOV DX, 2Ch
        MOV AH, 2
        INT 21h 
        
        CMP SI , size
        JNE DISPLAY_TAB
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
          
          ADD AX, 30h
          MOV DX, AX
          MOV AH, 2
          INT 21h
          
          MOV AX, CX
          MOV BX, 10 
          MOV DX,0
          DIV BX   
          
          POP DX
          
          MOV CX, AX
          CMP CX, 0
          JNE VIEW_NUMBER
          RET
          
              
     
EXIT:
    MOV AH, 4ch
    INT 21h 
    
ends  
end start
