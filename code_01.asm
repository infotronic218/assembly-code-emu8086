; multi-segment executable file template.

data segment
   welcome db "WELCOME TO CALCULATOR"
   enter_a db 10,13, "ENTRER a"
   enter_b db 10,13,"ENTREZ b"
   result  db 10,13, "LE RESULTAT EST : "
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es , ax
    
    lea dx, welcome
    mov ah , 9
    int 21h 
    
    lea dx, enter_a
    mov ah , 9
    int 21h
    
    mov ah, 1
    int 21h
    
    mov bl, al  
    
    lea dx, enter_b
    mov ah , 9
    int 21h
              
    mov ah, 1
    int 21h
              
    add al, bl
    mov bl, al
    
    mov dh, 0
    mov dx, bx
    mov ah, 9
    int 21h
    
    mov ah, 4ch
    int 21h
    

ends

end start ; set entry point and stop the assembler.
