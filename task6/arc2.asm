section .text
global arc2


arc2:

mov ecx, esi
mov ebx, 1
shl ebx, cl
shr ebx, 1

xor rax, rax
A:
    mov rdx, [rdi]
    and edx, ebx
    cmp edx, 0
    je skip
    or rax, 1
skip:
    shr rbx, 1
    add rdi, 4
    loop A

ret