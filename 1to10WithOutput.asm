; ### Adds numbers from 1-10 and prints result ###
;
; Stack View
; |     |
; |  5  |
; |  5  |   <- the smaller one
; | 0xA |
; |  0  |
; |_____|



global main

section .text
main:
    xor eax, eax            ; set start value of sum to 0
    mov ecx, 10             ; set counter to 10 -> counts from 10 to 0 -> easier -> just check zero-flag

    
; ### calculates the sum from 1-10 ###
; ### will add 0 (termination) and 0xA (line feed) to the bottom of the stack ###
sum:
    add eax, ecx            ; add current counter to sum
    dec ecx
    jnz sum                 ; repeat the addition
    
    push 0                  ; once done push 0 as a terminator I'LL BE BACK
    push 0xA                ; push 0xA=10 as a line feed
    mov ecx, 10             ; set divisor to 10 to shift -> now program will go to loop
    
    jmp loop
    
    
; ### will grab the numbers one by one (by dividing by 10) and push them to the stack ### 
; ### stops when the number equals 0 (all numbers consumed) ###
loop:
    mov edx, 0              ; set remainder to 0
    div ecx                 ; get the first number from our sum (eax) by dividing by 10 (ecx) -> eax contains quotient, edx contains remainder
    
    add edx, 48             ; add ASCII offset to our number
    push edx                ; push our number to the stack to save it
    
    cmp eax, 0              ; check if the whole number is consumed ...
    jnz loop                ; ... repeat, if no
    
    jmp print_next          ; ... jump to print_next, if yes
    

print_next:
    pop esi                 ; save the number (in ascii format) to esi
    cmp esi, 0              
    jz exit                 ; check if the last number has been printed already -> 0-terminator at bottom of stack 
    
    mov [output], esi       ; put ascii to output
    mov eax, 4              ; system call sys_write
    mov ebx, 1              ; file descriptor stdout
    mov ecx, output         ; string to sys_write
    mov edx, 1              ; print only one char
    int 0x80                ; kernel call
    
    jmp print_next          ; repeat until terminator
    
    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    

section .data
    output db 0             ; reserve space for printable char
