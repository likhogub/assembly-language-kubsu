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
%define Ftmp r14
%define s r12
%define q r13
%define l rax

ttable:                         ; save call args
mov F, rdi
mov G, rsi
mov H, rdx
mov n, rcx

mov rax, 1                      ; setup required variables
xor i, i
pow:
    shl rax, 1
    inc i
    cmp i, n
    jl pow
mov s, rax                      ; s = 2^n
shr rax, 1                      ;
mov q, rax                      ; q = 2^(n-1)

xor l, l                        ; line number = 0
xor i, i                        ; i = 0
loopI:
    mov Ftmp, F                 ; set Ftmp address as F[0]
    mov rcx, [G]                ; move G[i] to RCX          
    and rcx, 1                  ; get the least bit
    cmp rcx, 1                  ; if (bit != 1)
    jne skip                    ; then skip Ftmp offset increasing
    mov off, q                  ; offset = 2^(n-1)
    shl off, 3                  ; offest *= 3
    add Ftmp, off               ; Ftmp += offest
skip:
    xor j, j                    ; j = 0
    loopJ:
        shl l, 1                ; set H[i*j] as (line number)*2 with zero least bit
        mov [H], l              ; 
        shr l, 1                ; 

        mov rcx, [Ftmp]         ; get the least bit from F[j] = f(x1, ..., xn)
        and rcx, 1              ;
        add [H], rcx            ; add the least bit of F[j] to H[i*j]

        add Ftmp, 8             ; F[j++]
        add H, 8                ; H[j++]
        inc l                   ; l++
        inc j                   ; j++
        cmp j, q                ; if (j < 2^(n-1))
        jl loopJ                ; then loop j again
    inc i                       ; i++
    add G, 8                    ; G[i++]
    cmp i, s                    ; if (i < 2^n)
    jl loopI                    ; then loop i again

ret