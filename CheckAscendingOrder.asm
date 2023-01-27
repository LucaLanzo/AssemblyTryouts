extern scanf

section .text
global main
main:
    xor edi, edi
    mov esi, 10
    
loop:
    push input
    push inputFormat
    call scanf
    add esp, 8
    
    ; check aufsteigend
    cmp DWORD [input], edi
    jle exitWrong
    
    mov edi, [input]
    
    dec esi
    cmp esi, 0
    je exitGood
    
    jmp loop
    
exitWrong:
    mov eax, 1
    mov ebx, 1
    int 0x80
    
exitGood:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
section .data
    input times 1 dd 0                  ; db byte 1 BYTE, dw word 2 BYTE, dd doubleword 4 DWORD
    inputFormat db '%d', 0
