    extern printf
section .data
fmt:    db "%d", 10, 0		    ; format string

section .text
global main

%define i rax
%define n edi
%define c rbx
main:
    mov n, 16   
    xor i, i
    xor c, c
L1:
    cmp i, 32
    jge endL1
    bt n, eax
    jnc next
    inc c
next:

    inc i
    jmp L1
endL1:
    


print:
    mov rdi, fmt				; put format string to RDI
    mov rsi, c				; put found number to RSI
    mov rax, 0					; set no xmm registers
    call printf					; call C printf function
exit:
    mov rax, 1					; set 'normal' exit
    ret

    