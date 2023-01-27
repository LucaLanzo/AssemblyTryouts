global  main

section .text
main:

    mov esi, 10

    call print
    
    mov eax, 1              ; system call number (sys_exit)
    mov ebx, 0              ; exit with error code 0
    int 80h                 ; call kernel

print:
    mov eax, 4              ; system call number (sys_write)
    mov ebx, 1              ; file descriptor (st_dout)
    mov ecx, mymsg          ; message to write
    mov edx, mylen          ; message length
    int 0x80                ; call kernel
    
    dec esi
    jnz print               ; Kein cmp esi, 0 weil jnz einfach das Zero-Flag der letzten op untersucht (dec)
    
    ret
    
    
section .data
    mymsg db 'Hello World!' , 0xa
    mylen equ $-mymsg
