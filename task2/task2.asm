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

%define i       r8
%define j       r9
%define k       r10
%define s       r11
%define Atmp   r12
%define Btmp   r13
%define Ctmp   r14
%define size    r15

%define Aini    rdi
%define Bini    rsi
%define Cini    rdx

setup:
    mov size, rcx               ; const size

    mov Atmp, Aini              ; A[0][0]
    mov Btmp, Bini              ; B[0][0]
    mov Ctmp, Cini              ; C[0][0]

    xor rax, rax

    xor i, i                    ; i = 0
loopI:
    cmp i, size                 ; while (i < size)
    jge endI

    mov Atmp, Aini

    xor j, j                    ; j = 0
    loopJ:
        cmp j, size             ; while (j < size)
        jge endJ

        xor s, s                ; S = 0

        xor k, k                ; k = 0
        loopK:
            cmp k, size         ; while (k < size)
            jge endK

            
            mov ax, [Btmp]
            mov bx, [Atmp]
            mul bx
            add s, rax


            inc Btmp
            inc Atmp

            inc k               ; k++
            jmp loopK
        endK:
        
        add [Ctmp], s

        inc Ctmp
        sub Btmp, size                
        
        inc j                   ; j++
        jmp loopJ
    endJ:
    
    add Btmp, size
    
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