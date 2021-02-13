; Transitive closure
%define v rbx
%define i r8                
%define j r9
%define k r10
%define size r11
%define A r12
%define B r13
%define C r14
%define marker r15
    SECTION .data
    SECTION .text
    global tclsr

tclsr:

mov size, rdx                       ; save SIZE from call args

xor v, v                            ; v = 0
loopV:
    mov B, rsi                      ; reset B address to beginning
    mov C, rsi                      ; reset C address to beginning
    xor i, i                        ; i = 0
    loopI:
        mov A, rdi                  ; reset A address to beginning 
        mov marker, 1               ; set marker as 1
        mov rcx, size               ; prepare marker shift
        dec rcx                     ;
        shl marker, cl              ; shift marker to left by (size - 1)
        xor j, j                    ; j = 0
        loopJ:
            test [C], marker        ; if way already exists
            jnz skip                ; then skip
            mov rax, [A]            ; logical AND between A[j] and B[i] 
            and rax, [B]            ;
            cmp rax, 0              ; if (A[j] & B[i] == 0) 
            je skip                 ; then skip
            or [C], marker          ; else C[i][j] &= marker
        skip:
            shr marker, 1           ; shift marker to right by 1
            add A, 8                ; go to next A row
            inc j                   ; j++
            cmp j, size             ; if (j < size)
            jl loopJ                ; then go loopJ again
        add C, 8                    ; go to next C row
        add B, 8                    ; go to next B row
        inc i                       ; i++
        cmp i, size                 ; if (i < size)
        jl loopI                    ; then go loopI again
    inc v                           ; v++
    cmp v, size                     ; if (v < size)
    jl loopV                        ; then go loopV again
exit:
    mov rax, 1					; set 'normal' exit
    ret