    section .data
    section .text
    global imgmir

%define A rdi
%define B rsi
%define H rdx
%define W rcx

%define r r8
%define c r9

%define new r11
%define row rbx

imgmir:
xor r, r                        ; r = 0
loopR:
    mov row, [A]                ; save A[i] as old row
    xor new, new                ; reset new row 
    xor c, c                    ; c = 0
    loopC:
        mov rax, row            ; 
        and rax, 1              ; get the least bit of old row
        shr row, 1              ; right shift old row
        shl new, 1              ; left shift new row
        add new, rax            ; 
        inc c                   ; c++
        cmp c, W                ; if (c < W)
        jl loopC                ; then loop C again
    mov [B], new                ; move new row to result array
    add A, 8                    ; A += 8 (next unsigned long long)
    add B, 8                    ; B += 8 (next unsigned long long)
    inc r                       ; r++
    cmp r, H                    ; if (r < H)
    jl loopR                    ; then loop R again

ret