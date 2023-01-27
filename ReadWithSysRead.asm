; ### Select this for Kate external tool input: hallo

global main

section .text
main:
    mov eax, 3                  ; system call sys_read
    mov ebx, 0                  ; file descriptor stdin
    mov ecx, userInput          ; put ADDRESS where input should be written to into ecx
    mov edx, userInputLen                 ; 40 Bytes einlesen
    int 0x80
    
    
    mov edx, eax                ; length of read string is put into eax -> to print put it into edx
    
    
    mov eax, 4                  ; system call sys_write
    mov ebx, 1                  ; file descriptor stdout
    ; mov ecx, userInput          ; already done
    ; mov edx, length           ; already done
    int 0x80
    
    
    cmp edx, 0                  ; if read input length is zero, exit with code 1
    je exitWrong
    jmp exit

    
exitWrong:
    mov eax, 1
    mov ebx, 1
    int 0x80
    
    
exit:
    mov eax, 1                  ; system call sys_exit
    mov ebx, 0
    int 0x80                    

section .data
    userInput times 40 db 0
    userInputLen equ $-userInput
