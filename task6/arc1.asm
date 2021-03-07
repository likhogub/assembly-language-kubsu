section .text
global arc1
%define size rsi
arc1:
xor rax, rax
xor r10, r10
A:
    mov rcx, size
    mov r9, [rdi] 
    B:
        mov rbx, r9
        and rbx, 1
        add rax, rbx
        shr r9, 1
        loop B
    inc r10
    add rdi, 4
    cmp r10, size
    jne A


ret