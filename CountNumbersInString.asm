global main
section .text
main:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 20
    
    int 0x80                            ; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    mov edi, eax
    dec edi
    xor ecx, ecx
    
loop:
    cmp byte [input+edi], 48
    jl next
    
    cmp byte [input+edi], 57
    jg next
    
    inc ecx
    jmp next
    
next:
    dec edi
    cmp edi, 0
    jge loop
    
exit:
    mov eax, 1
    mov ebx, ecx                       ; well shit! wrong count -> ecx holds count; edi now holds 255 because of dec O
    int 0x80
    
section .data
    input times 20 db 0
