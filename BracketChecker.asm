global main
extern printf

section .text
main:
    mov eax, 3                      ; system call sys_read
    mov ebx, 0                      ; file descriptor stdin
    mov ecx, userInput
    mov edx, userInputLen
    int 0x80
    
    ; eax now holds length of read string
    
    
closingBrackets:
    mov cl, byte [userInput+eax-1]  ; cl now holds an ASCII char -> 1 byte -> 8 bit = size of cl
                                    ; userInput+eax-1 = access last char of read input
    
    cmp cl, ')'                     ; cmp is possible with an ASCII char
    jne openingBrackets     ; if it is not a closing bracket, check if it is an opening bracket
    inc ebx                         ; if it is a closing bracket -> increase counter of closed brackets
    
    
openingBrackets:
    cmp cl, '('                     
    jne skip                        ; if it doesn't equal, then skip the char
    
    cmp ebx, 0
    jz errorExit                    ; if no closed bracket has been found before -> error out
    
    dec ebx                         ; if it is an opening bracket, it is matched -> decrease counter

    
    
skip:
    dec eax                         ; length - 1
    jnz closingBrackets             ; not finished -> check next char
    jmp exit                        ; finished -> every closed matches opened
    
    
exit:
    cmp ebx, 0                      ; check once again to see if any closing brackets are left over: (3))
    jnz errorExit

    push formatMatch
    call printf
    
    mov eax, 1
    ; mov ebx, 0                      ; not needed, ebx has to be zero
    int 0x80
    
    
errorExit:
    push formatError
    call printf

    mov eax, 1
    mov ebx, 1                      ; exit code 1 -> Error
    int 0x80
    

section .data
    userInput times 100 db 0
    userInputLen equ $-userInput
    
    formatMatch db 'Big brain time.', 0xA, 0
    formatError db 'You suck at math, you dildo.', 0xA, 0
