global main
extern scanf
extern printf

section .text
main:
    push input
    push inputFormat
    call scanf
    
    add esp, 8
    
    ; find out real length by scanning the input string for null byte
    mov eax, 0                                      ; null byte to look for
    mov ecx, 11                                     ; count down from the length of the input (11) until null byte (eax)
    mov edi, input                                  ; string address to check
    repne scasb                                     ; scan byte string and look for eax char
    
    
    sub ecx, 10                                     ; ecx = full length of string (10) - count from full length (ecx)
    neg ecx                                         ; negate to flip the subtraction
    dec ecx                                         ; ecx holds length so ecx-- to get last element
    
    
    xor eax, eax
    mov al, BYTE [offset]
    
    
loop: 
    
    sub BYTE [input+ecx], al

    dec ecx                                         ; stop sleeping and check if i++ or i-- dimwit 
 
    cmp ecx, 0 

    jge loop 
    

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
    outputFormat db '... changed to "%s".', 0xA, 0
    
