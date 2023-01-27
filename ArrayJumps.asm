global main
extern printf

section .text
main:
    xor ebx, ebx                    ; jump index
    xor ecx, ecx                    ; jump counter
    
    mov esi, bufferLen              ; quicker than always calling bufferLen
    
    
loop:
    inc ecx                         ; inc jump counter
    
    ; movsx edx, byte [buffer + ebx]  ; movsx = move with signed extend; movzx = move with zero extend
                                      ; extends the byte to the 32 bytes
    add bl, [buffer+ebx]            ; [buffer+ebx] returns one byte -> without movsx it needs to be placed in 8 bit bl

    cmp ebx, esi                    ; out of bounds > len
    jge outOfBounds
    
    cmp ebx, 0                      ; out of bounds < 0
    jl outOfBounds
    
    cmp ecx, esi                    ; jumped too often jumps == len
    je endlessLoop                  ; reached the len but is still not out of bounds -> visited all 
    
    jmp loop

    
endlessLoop:
    mov ecx, -1
    

outOfBounds:
    push ecx                        ; push ecx -> either jump counter or -1 from previous label
    push format
    call printf
    

exit:
    mov eax, 1                      ; system call sys_exit
    mov ebx, 0                      ; exit code 0
    int 0x80                        ; kernel call
    
    
section .data
    ;buffer db 2, 3, -1, 2, -1       ; ergebnis = 5
    ;buffer db 2, 3, -1, 2, -2       ; ergebnis = -1
    ;buffer db 1, 1, 1, 1, -5        ; ergebnis = 5
    buffer db 1, 1, 1, 1, -1        ; ergebnis = -1
    
    bufferLen equ $-buffer          ; maximum count of jumps (ecx <= bufferLen), or it will be an endless loop
    
    format db 'Result of the array jump: %d', 0xA, 0 ; always zero terminated
