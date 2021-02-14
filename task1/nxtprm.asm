%define n ecx                   ; number-to-test
%define d ebx                   ; divisor
    SECTION .data
	SECTION .text
    global nxtprm				;
nxtprm:
    mov n, edi				    ; save call argument
next:
    inc n                       ; N=N+1
	mov d, n                    ; set initial divisor as N/2
    shr d, 1                    ;
divide:
    cmp d, 1				    ; if divisor equals 1
    jle print					; then print found N
    xor edx, edx				; clear higher part of dividend
    mov eax, n				    ; set lower part of dividend as N
    div d						; divide N by divisor 
    cmp edx, 0					; if reminder equals 0 
    je next						; then jump to next number
    dec d						; decrement divisor
    jmp divide					; else check next divisor
print:
    mov eax, n                  ; return found N 
    ret