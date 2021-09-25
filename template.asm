data segment 
    msg db "Les elements du tableau sont : $"
    tab db 2,3,4,5,6, 7, 8 
    
    size dw 7    
    somme dw 0
    
    
ends


stack segment
ends
code segment
start:
   MOV AX, 92E1h 
   MOV DX, 05F5h
     
    
DisplayNumber32:
    mov     bx,10          ;CONST
    push    bx             ;Sentinel
a:  mov     cx,ax          ;Temporarily store LowDividend in CX
    mov     ax,dx          ;First divide the HighDividend
    MOV DX, 0;xor     dx,dx          ;Setup for division DX:AX / BX
    div     bx             ; -> AX is HighQuotient, Remainder is re-used
    xchg    ax,cx          ;Temporarily move it to CX restoring LowDividend
    div     bx             ; -> AX is LowQuotient, Remainder DX=[0,9]
    push    dx             ;(1) Save remainder for now
    mov     dx,cx          ;Build true 32-bit quotient in DX:AX
    or      cx,ax          ;Is the true 32-bit quotient zero?
    jnz     a             ;No, use as next dividend
    pop     dx             ;(1a) First pop (Is digit for sure)
b:  add     dl,"0"         ;Turn into character [0,9] -> ["0","9"]
    mov     ah,02h         ;DOS.DisplayCharacter
    int     21h            ; -> AL
    pop     dx             ;(1b) All remaining pops
    cmp     dx,bx          ;Was it the sentinel?
    jb      b             ;Not yet              
                                   
DISPLAY32:
    MOV BX, 10  
    
 a: MOV CX, AX 
    MOV AX, DX
    MOV DX, 0
    DIV BX 
    XCHG AX, CX
    DIV BX
    PUSH DX
    MOV DX, CX
    OR CX, AX
    JNZ a 
    
    MOV CX, 
EXIT:
    MOV AH, 4ch
    INT 21h 
    
ends  
end start
