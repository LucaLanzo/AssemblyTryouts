; ### Checks if input number is result of the exponentiation with the base 2 -> powers of 2 ###
; # 2^n -> n is natural numbers #
; # this is easy, as the powers of 2 in binary always end on 0. The are actually just... #
; # 1, 10, 100, 1000, 1000 -> special case is 0 as  #

global main
extern printf

section .text
main:
    mov eax, 4
    mov ecx, eax                    ; for printf
    
    
    cmp eax, 0                      ; 0 case has to be manually exited -> check would result in loooop
    je exit                         ; every other numbers has at least 1 in it
    
    
check:
    bt eax, 0                       ; checks if LSB is 1 -> if yes, the carry bit is set
    jc output                       ; jump if carry=1 -> LSB=1
    shr eax, 1                      ; shift it right and check again
    jmp check
    
    
output:
    shr eax, 1                      ; checks if ended. If the 1 was found only at the MSB
                                    ; with a SHR now at the end -> 0000 -> zero flag set
    setz bl                         ; if end of string has not been reached, zero flag 1 -> bl
    mov eax, [formatNo, ebx]        ; if bl=1 -> the format will point to the zero behind it
    
    push eax                        ; eax will either be s or 0
    push ecx                        ; push original number
    push format                    
    call printf
    
    
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80
    

section .text    
    format db '%d as your choice for a power of 2 was %chit.', 0xA, 0
    formatNo db 's', 0
    
    
