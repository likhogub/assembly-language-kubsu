global fcalc

segment .data
    X dq 0
    Xsqr dq 0
    exp dq 0
    half dq 0.5
SECTION .text

fcalc:
    finit                       ; init FPU
    movsd [X], xmm0             ; save call arg
    fld qword [half]            ; push 0.5
    fld qword [X]               ; push X
    fld st0                     ; push X
    fmulp                       ; ST0 = ST0*ST1 = X*X ; ST1 = ST2
    fmul                        ; ST0 = ST0*ST1 = X*0.5
    fst qword [Xsqr]            ; save Xsqr
    fldz                        ; push zero
    fsub st1                    ; ST0 = ST0-ST1 = 0-X*X = -X*X
    fldl2e                      ; push log2e
    fmul                        ; ST0 = ST1*ST0 = -X*X*log2e
    fld1                        ; push 1
    fld st1                     ; push -X*X*log2e
    fprem                       ; ST0 = (-X*X*log2e - Q*1) = q
    f2xm1                       ; ST0 = 2^q - 1
    faddp st1, st0              ; ST0 = 1 + (2^q - 1) = 2^q ; ST1 = ST2
    fscale                      ; ST0 = ST0*2^ST1 = 2^q * 2^Q
    fstp qword [exp]

    movsd xmm0, [exp]
ret