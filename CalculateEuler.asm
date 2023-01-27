extern printf
global main

section .text
main:
    fldz                       ; intitalize FPU-R with 0
    fld1                       ; push 1 to FPU-R


loop:
    fadd    st1, st0           ; add the result of the last operation (first: 0+1)
    inc     DWORD [counter]    ; increase counter

    cmp     DWORD [counter], 5
    je      print

    fld1                       ; push 1 to FPU-R
    fidiv   DWORD [counter]    ; division by integer -> st0=1/n
    fmulp   st1, st0           ; multiply number of previous loop with 1/counter und throw away multiplicator -> 1/n!
    
    jmp     loop

    
print:
    FXCH                       ; switch st0 and st1
    sub     esp, 8             ; move stack pointer to make space to pop the result of the FPU-R 
    fstp    QWORD [esp]        ; pop result from st0 to the stack
    
    push    DWORD [counter]    ; push result to stack
    push    format
    call    printf


exit:
    mov     eax, 1
    mov     ebx, 0
    int     0x80

    
section .data
    counter dd 0
    format db 'After %d loops the result of the euler function yields %f', 0xa, 0
    
    
    
    
