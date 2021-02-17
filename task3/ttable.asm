    SECTION .data
    SECTION .text
    global ttable

%define i rdi
%define j rsi
%define off rbx

%define F r8
%define G r9
%define H r10
%define n r11

%define s r12
%define q r13


ttable:
mov F, rdi
mov G, rsi
mov H, rdx
mov n, rcx

mov rax, 1
xor i, i
pow:
    shl rax, 1
    inc i
    cmp i, n
    jl pow
mov s, rax
shr rax, 1
mov q, rax



xor rax, rax
xor i, i
loopI:


    xor j, j
    loopJ:
        inc rax
        inc j
        cmp j, q
        jl loopJ
    inc i
    cmp i, s
    jl loopI



ret