global main

section .text
main:
    mov eax, 4                      ; system call sys_write
    mov ebx, 1                      ; file descriptor stdout
    mov ecx, mymsg                  ; message to write
    mov edx, mylen                  ; message length
    int 0x80                        ; call kernel
    
    
    inc byte [count]                ; decrement counter
                                    ; [xxx] = Inhalt von Speicherzelle mit der Adresse count
                                    ; 'byte' will nasm wissen, weil sonst nicht klar ist, welcher Datentyp gemeint ist
                                    
    cmp byte [count], 10
    jne main                        ; jump while not 10 to main
    
    mov eax, 1                      ; system call sys_exit
    mov ebx, [count]                ; exit with error code
    int 0x80                        ; call kernel
    
    
section .data
    count db 0                      ; db = define byte
    mymsg db 'Happy World!', 0xA
    mylen equ $-mymsg
