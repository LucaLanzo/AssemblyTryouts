global main
extern printf                   ; assembly directive: global, extern

section .text
main:
    
    push integer                ; address of integer
    push format
    call printf
    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    
    
section .data
    format db 'address %d', 0xA, 0          ; %d is placeholder for double
    
    integer times 4 db 12            ; 4 byte integer -> 32 bits -> fucking huge
    
