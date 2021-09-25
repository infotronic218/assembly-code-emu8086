; multi-segment executable file template.

data segment
   msg db "Using Jump function : $"  
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
     
  mov ax, 10
  push ax 
  pop bx     
  
  mov al , 1
  int 21h
   
   
ends

end start ; set entry point and stop the assembler.
