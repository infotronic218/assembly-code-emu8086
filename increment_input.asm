; multi-segment executable file template.

data segment
   msg db "Enter n : $"  
   result db 10 , 13 , "La valeur inc est : $"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
     
    mov ax, data
    mov ds, ax
    mov es , ax
    
    lea dx, msg
    mov ah , 9
    int 21h
    
    mov ah, 1
    int 21h
    
    sub al, 30h
    
    inc al
    
    add al,30h
    mov bl, al
                
    
   
    
    lea dx, result
    mov ah, 9
    int 21h
    
    mov dx, 0
    mov dl, bl
    mov ah, 2h
    int 21h
    
    mov ah, 4ch
    int 21h
ends

end start ; set entry point and stop the assembler.
