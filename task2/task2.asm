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
setup:
    xor r8, r8                  ; R8 -> i = 0
    xor r9, r9                  ; R9 -> i_row_index = 0
    xor r10, rsi                ; R10 -> B[i*size+k] = B[0][0]
    xor r11, r11                ; R11 -> j = 0
    xor r12, r12                ; R12 -> j_row_index = 0
    mov r13, rdi                ; R13 -> A[j*size+k] = A[0][0]
    mov r14, rcx                ; R14 -> size
    mov rbx, rdx                ; RBX -> C[0][0]

loopA:
    cmp r8, r14                 ; while (i < size)
    jge endA
    add r9, r14                 ; i_row_index += size
    loopB:
        cmp r11, r14            ; while (j < size)
        jge endB
        add r12, r14            ; j_row_index += size
        inc rbx                 ; C address += 1
        mov rcx, r14            ; k = size
        mov r13, r12            ; A[j][0]
        mov r10, r9             ; B[i][0]
        xor rax, rax            ; set RAX as accumulator
        loopC:
            push rcx
            mov rdi, fmt				; put format string to RDI
            mov rsi, r9				; put found number to RSI
            mov rax, 0					; set no xmm registers
            call printf
            pop rcx					; call C printf function
        loop loopC
        inc r11                 ; j++
        jmp loopB
    endB:
    inc r8                      ; i++
    jmp loopA
endA:
    

jmp exit

print:
    mov rdi, fmt				; put format string to RDI
    mov rsi, rcx				; put found number to RSI
    mov rax, 0					; set no xmm registers
    call printf					; call C printf function
exit:
    mov rax, 1					; set 'normal' exit
    ret