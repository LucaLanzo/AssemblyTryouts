global main
extern scanf
extern printf

section .text
main:
    push input
    push inputFormat
    call scanf
    
    mov eax, 0                      ; char to look for -> null byte as scanf reads until non-white-space
    mov ecx, inputLen               ; full length
    mov edi, input                  ; string to search
    
    repne scasb                     ; count down from inputLen while not equal the line feed char -> count updated in ecx
       
    sub ecx, inputLen  
    neg ecx
    dec ecx                         ; essentially does ecx = inputLen - ecx as neg will "switch" the sub
    mov [len], ecx                  ; real input length of scanf string is now stored here
    

loop:
    xor eax, eax
    
    mov al, BYTE [input+ecx]
    
    cmp al, 'z'
    jg next
    
    cmp al, 'A'
    jl next
    
    cmp al, 'a'
    jge lower
    
    cmp al, 'Z'
    jle capital
    
    ; in between Z and a
    jmp next
    
    
lower:
    cmp al, 'x'
    jge moveOffset
    
    jmp add
    
    
capital:    
    cmp al, 'X'
    jge moveOffset
    
    jmp add
    
    
moveOffset:
    sub BYTE [input+ecx], 26
    
    
add:
    add BYTE [input+ecx], 3
    
    
next:
    dec ecx
    cmp ecx, 0
    jge loop
    

print:
    push input
    push outputFormat
    call printf

    
exit:
    mov eax, 1
    mov ebx, [len]
    int 0x80
    
    
section .data
    input times 100 db 0
    inputLen equ $-input
    len db 0
    
    inputFormat db '%s', 0
    outputFormat db '... changed to "%s".', 0xA, 0
    
