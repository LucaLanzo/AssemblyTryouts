extern scanf
extern printf

section .text
    global main
main:
    push input
    push inputFormat
    call scanf
    
    add esp, 8
    
    xor ecx, ecx
    
    xor eax, eax
    mov al, BYTE [offset]
    
    xor ebx, ebx
    
loop: 
    inc ebx
    sub BYTE [input+ecx], al

    inc ecx                                         ; stop sleeping and check if i++ or i-- dimwit 
 
    cmp BYTE [input+ecx], 0 
    jnz loop 
    

print:
    push input
    push outputFormat
    call printf

    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    
    
section .data
    offset db 3
    input times 11 db 0             ; to hold 10 bytes plus null byte
    
    inputFormat db '%s', 0
    outputFormat db '... changed to "%s"', 0xA, 0
    
