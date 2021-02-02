; wsl nasm -f elf64 task1.asm -o task1.o && wsl gcc -no-pie task1.o -o task1 && wsl ./task1 5
; Find the next prime number from the given prime number
; Найти следующее простое число по заданному простому числу

extern printf		; C function


	SECTION .data
fmt: db "%d", 10, 0		;

	SECTION .text
	global main


main:
    pop rcx              ; set CX as args count
	pop rcx    
	xor rax, rax          ; set CX as first arg (prime number N) 
	xor rcx, rcx
	mov ecx, 5
	
setup:
	inc ecx              ; N=N+1
	xor ebx, ebx
	mov ebx, 1          ; set BX as 1 (initial divisor)

divide:
	inc ebx             ; increase divisor
	cmp ebx, ecx        ; print if divisor greater then number
	jnl print			; 
	mov eax, ecx		
	div bl				;
	cmp edx, 0			;
	je setup			; if (rest == zero) then check next number
	jmp divide 			; else check next divisor

print:
	push ax
	push dword fmt
	call printf

exit:
	mov eax, 1           ; 'exit' system call
	mov ebx, 0           ; exit with error code 0
	int 80h             ; call the kernel