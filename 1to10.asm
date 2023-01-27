global main

section .text
main:
    xor eax, eax
    
    .addition:                      ; no ret in local labels!
        inc eax                     ; increment eax one step
        add [count], eax            ; add 1..10 to the count
    
        cmp eax, 10                 ; if the last number (10) has been added ...
        jne .addition                ; ... stop repeating
    
    
    mov eax, 1                  ; system call sys_exit
    mov ebx, [count]            ; set count to exit code
    int 0x80                    ; kernel call

    
section .data
    count db 0                  ; define byte
