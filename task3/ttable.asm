    SECTION .data
    SECTION .text
    global ttable

%define Fi di
%define Gi si
%define off bx

%define n rdx

%define F r8
%define G r9
%define H r10

ttable:

mov F, rdi
mov G, rsi
mov H, rdx

mov rcx, 1
shl ecx, dx


mov rax, rcx
ret