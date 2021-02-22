global fcalc
segment .data
    X dq 0.0
    Xsqr dq 0.0
    exp dq 0.0
    two dq 2.0
    half dq 0.5
    zero dq 0.0

SECTION .text

fcalc:
    movsd [X], xmm0             ; save call arg
    finit                       ; init FPU
    fld qword [half]            ; push 0.5
    fld qword [X]               ; push X
    fld st0                     ; push X
    fmulp                       ; ST0 = ST0*ST1 = X*X ; ST1 = ST2 = 2
    fst qword [Xsqr]            ; save X*X
    fmulp st1                   ; ST0 = ST0*ST1 = X*X*0.5
    fchs                        ; ST0 = -ST0 = -X*X/2
    fldl2e                      ; push log2e
    fmul                        ; ST0 = ST1*ST0 = -X*X*log2e
    fld1                        ; push 1
    fld st1                     ; push -X*X*log2e
    fprem                       ; ST0 = (-X*X*log2e - Q*1) = q
    f2xm1                       ; ST0 = 2^q - 1
    faddp st1, st0              ; ST0 = 1 + (2^q - 1) = 2^q ; ST1 = ST2
    fscale                      ; ST0 = ST0*2^ST1 = 2^q * 2^Q = e^(-X*X/2)
    fld qword [two]             ; push 2
    fldpi                       ; push pi
    fmulp                       ; ST0 = ST0*ST1 = 2*pi ; ST1 = ST2
    fsqrt                       ; ST0 = sqrt(ST0) = sqrt(2*pi)
    fdivr st1                   ; ST0 = ST1/ST0 = e^(-X*X/2)/sqrt(2*pi)    
    fld qword [X]               ; sum = X
    fld1                        ; push 1 as initial divisor
    fld qword [X]               ; push X as last summand
ll:
    fld qword [Xsqr]            ; push X*X
    fmulp st1                   ; multiply last summand by X*X
    fld qword [two]             ; push 2
    faddp st2                   ; divisor = divisor + 2 
    fdiv st1                    ; summand /= divisor
    fadd st2, st0               ; sum += summand
    fldz                        ; push zero 
    fcomip st1                  ; if (summand != 0)
    jne ll                      ; then go next summand
    fincstp                     ; pop last summand
    fincstp                     ; pop divisor
    fmulp st1                   ; ST0 = e^(-X*X/2)/sqrt(2*pi)*(x+(x^3)/3+...)
    fld qword [half]            ; push 0.5
    faddp st1                   ; ST0=0.5+e^(-X*X/2)/sqrt(2*pi)*(x+(x^3)/3+...)
    fstp qword [exp]            ; save result to memory
    movsd xmm0, [exp]           ; move result to return
ret