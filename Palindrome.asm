global main
extern printf

section .text
main:

    mov eax, 3                          ; system call sys_read
    mov ebx, 0                          ; file descriptor stdin
    mov ecx, input                      ; write to address at input
    mov edx, 20                         ; length 20
    int 0x80
    
    mov ebx, 1
    cmp eax, 0                          ; is the given string zero?
    je exit
    
    mov BYTE [input+eax-1], 0           ; clear line feed?
    dec eax                             ; dec by one for the removed line feed
    
    mov edx, eax                        ; counter backwards: length of read input is stored in eax
    dec edx                             ; to access last index decrease by 1 for length 
    xor ecx, ecx                        ; counter forwards
    

; ### will reverse the input string and save the reversed to memory ###
reverse:
    xor ebx, ebx                        ;  can't move between memory directly, put it in registers for the swap
    mov bl, BYTE [input+edx]
    mov BYTE [backwards+ecx], bl
    
    dec edx
    inc ecx
    
    cmp edx, 0
    jnl reverse                         ; not at the last symbol at index 0 yet
    
    ; jmp evaluate2                       ; built in NASM string checker repe cmpsb repeat string operation compare string byte
    xor edx, edx                        ; reset to be able to use it as an increment counter in the next step
    
    
; ### checks whether the reversed strings is equal to the input string ###
; ### if yes -> palindrome ###
evaluate:
    ; actually only needs to check to len/2 as the strings are flipped
    xor ebx, ebx                        ; again, no direct comparison, intermediate assignment
    mov bl, BYTE [backwards+edx]
    cmp bl, BYTE [input+edx]
    jne printFalse                      ; if the two chars don't match print false
    
    inc edx
    
    cmp edx, eax                        ; check if the full length of the input has been checked
    je printTrue                        ; if yes, the strings match -> palindrome
    
    jmp evaluate                        ; repeat if the end hasn't been reached

    
evaluate2:
    mov ecx, eax
    mov esi, input
    mov edi, backwards
    
    repe cmpsb
    
    je printTrue
    jmp printFalse

printTrue:
    push yes
    push backwards
    push input
    push format
    call printf

    mov ebx, 0

    jmp exit
    

printFalse:
    push no
    push backwards
    push input
    push format
    call printf

    mov ebx, 1
    

exit:
    mov eax, 1                          ; system call sys_exit
    ; mov ebx, ...
    int 0x80                            ; kernel call
    

section .data
    input times 20 db 0
    backwards times 20 db 0
    
    format db '%s backwards reads %s. Is it a palindrome? %s.', 0xA, 0
    yes db 'Yes', 0
    no db 'No', 0
    
