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


%define size    r15
%define i       r8
%define j       r9
%define k       r10

%define Aini    rdi
%define Bini    rsi
%define Cini    rdx

%define Atmp   r12
%define Btmp   r13
%define Ctmp   r14

setup:
    mov size, rcx               ; const size

    mov Atmp, Aini              ; A[0][0]
    mov Btmp, Bini              ; B[0][0]
    mov Ctmp, Cini              ; C[0][0]

    ; Prepare i loop
    xor i, i                    ; i = 0
loopI:
    cmp i, size                 ; while (i < size)
    jge endI
    ; Prepare j loop
    xor j, j                    ; j = 0
    mov Atmp, Aini
    loopJ:
        cmp j, size             ; while (j < size)
        jge endJ
        ; Prepare k loop
        xor k, k                ; k = 0
        xor r11, r11            ; S = 0
        loopK:
            cmp k, size         ; while (k < size)
            jge endK

            ;xor rax, rax       ;
            ;mov eax, [Atmp]    ;
            ;mov ebx, [Btmp]    ;
            ;mul bx             ;
            mov rax, i
            mul size
            add rax, j
            add r11, rax          ;

            inc k               ; k++
            inc Atmp            ; A++
            inc Btmp            ; B++
            jmp loopK
        endK:
        add [Ctmp], r11         ; C[i][j] = S
        inc Ctmp                ; C++
        inc j                   ; j++
        sub Btmp, size          ; B-=size
        jmp loopJ
    endJ:
    inc i                       ; i++
    jmp loopI
endI:
    


mov rcx, rax

print:
    mov rdi, fmt				; put format string to RDI
    mov rsi, rcx				; put found number to RSI
    mov rax, 0					; set no xmm registers
    call printf					; call C printf function
exit:
    mov rax, 1					; set 'normal' exit
    ret