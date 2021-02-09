; Task
; 	Find the next prime number from the given prime number
; 	Найти следующее простое число по заданному простому числу
; Execution
; 	nasm -f elf64 task1.asm -o task1.o 
; 	gcc -no-pie arg.c task1.o -o task1
; 	./task1 <N>

    extern printf				; define external C function

    SECTION .data
fmt:    db "%d", 10, 0		    ; format string
    
	SECTION .text
    global func					;
func:
    mov rcx, rdi				; move argument (N) to RCX
next:
    inc rcx                     ; N=N+1
	mov rbx, 1                  ; set RBX as 1 (initial divisor)
divide:
    inc rbx						; increment divisor
    cmp rbx, rcx				; if divisor greater then dividend
    jnl print					; then print found N
    xor edx, edx				; clear higher part of dividend
    mov eax, ecx				; set lower part of dividend as N
    div ebx						; divide N by divisor 
    cmp edx, 0					; if reminder equals 0 
    je next						; then jump to next number
    jmp divide					; else check next divisor
print:
    mov rdi, fmt				; put format string to RDI
    mov rsi, rcx				; put found number to RSI
    mov rax, 0					; set no xmm registers
    call printf					; call C printf function
exit:
    mov rax, 1					; set 'normal' exit
    ret