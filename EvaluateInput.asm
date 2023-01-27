global main
extern printf

section .text
main:

    mov eax, 3                          ; system call sys_read
    mov ebx, 0                          ; file descriptor stdin
    mov ecx, input                      ; save to input address [input] would be value
    mov edx, inputLen                   ; read length of input = 10 bytes
    int 0x80
    
    
    ; ###########
    mov edi, [input]                    
    mov [original], edi                 ; save the original
    
    mov ecx, eax                        ; actual length of read string is in eax -> ecx offset
    ; ###########
    
    
    dec eax
    mov byte [input+eax], 0             ; overwrite the line feed
    
    cmp ecx, 0
    je exit                             ; input is zero
    
    sub ecx, 2                          ; we start at last index, so length-2 (skip the line feed)
    
    
convert:
    cmp byte [input+ecx], 'a'           ; if char is < 65
    jb next                             ; than it is ok
    
    cmp byte [input+ecx], 'z'           ; if char is > 122
    ja next                             ; than it is also ok
    
                                        ; from now, the char will be inbetween a-z
                                        
    sub byte [input+ecx], 32            ; remove 32 -> not 26 as there are six symbols between 'Z' and 'a'
    
    
next:
    dec ecx
    jns convert 
    
    
print:
    push input                          ; second %s     - bottom
    push original                       ; first %s      - middle
    push format                         ; format        - top
    call printf
    
    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    
section .data
    input times 11 db 0                 ; 10 symbols and return sign
    inputLen equ $-input
    
    original times 11 db 0
    
    format db 'Original string %s changed to %s', 0xA, 0
