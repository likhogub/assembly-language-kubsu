    extern printf
    SECTION .data
fmt:    db "%d", 10, 0		    ; format string
    SECTION .text
    global func					
func:
                                ; RCX -> size (k)
                                ; RDX -> C
                                ; RSI -> B
                                ; RDI -> A
%define i r8
%define j r9
%define k r10
%define size r11

%define A r12
%define B r13
%define C r14
%define s r15

mov A, rdi
mov B, rsi
mov C, rdx
mov size, rcx

xor rax, rax

xor i, i
loopI:
    
    mov A, rdi
    mov s, 1
    xor j, j
    loopJ:
        mov rax, [A]
        and rax, [B]
        
        cmp rax, 0
        je nextJ
        
        or [C], s
    nextJ:
        shl s, 1
        add A, 8

        inc j
        cmp j, size
        jl loopJ

    add C, 8
    add B, 8

    inc i
    cmp i, size
    jl loopI


mov rcx, rbx

print:
    mov rdi, fmt				; put format string to RDI
    mov rsi, rcx				; put found number to RSI
    mov rax, 0					; set no xmm registers
    call printf					; call C printf function
exit:
    mov rax, 1					; set 'normal' exit
    ret