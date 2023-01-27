global main
extern scanf
extern printf

section .text
main:

    ; input
    push input
    push formatInput
    call scanf
    add esp, 8
    
    ; calculate real length
    mov eax, 0                          ; printf reads non-white-spaces so last will be null byte \0
    mov ecx, inputLen
    mov edi, input
    
    repne scasb
    
    sub ecx, inputLen
    neg ecx
    dec ecx
    mov [len], ecx
    
    ; print
    push DWORD [len]
    push input
    push formatOutput
    call printf
    
    ; exit
    mov eax, 1
    mov ebx, [len]
    int 0x80
    
    
section .data
    input times 30 db 0
    inputLen equ $-input
    len db 0
    
    formatInput db '%s', 0

    formatOutput db 'String %s at with length %d.', 0xA, 0 
