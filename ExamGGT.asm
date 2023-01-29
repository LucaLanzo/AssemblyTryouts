extern printf
extern scanf

section .text
    global main
main:
    push request
    call printf
    add esp, 4
    
    push a
    push inputFormat
    call scanf
    add esp, 8
    
    push b
    push inputFormat
    call scanf
    add esp, 8
    
    mov ebx, [a]
    mov ecx, [b]
    
    
ggT:
    xor edx, edx
    xor eax, eax
    
    mov eax, ebx
    div ecx
    
    mov ebx, ecx                    ; a = b
    mov ecx, edx                    ; b = rest (edx)
    
    cmp ecx, 0
    jnz ggT
    
    
print:
    mov [a], ebx                    ; [a] = a aus loop
    push DWORD [a]
    push outputFormat
    call printf
    
    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    
section .data
    a times 4 db 0
    b times 4 db 0
    
    request db 'Please enter two numbers', 0xA, 0
    
    inputFormat db '%d', 0
    outputFormat db 'GgT ist %d.', 0xA, 0
