SECTION .DATA
	initval:     db 0, 10
SECTION .TEXT
	GLOBAL _start 

_start1:
	mov eax,4            ; 'write' system call = 4
	mov ebx,1            ; file descriptor 1 = STDOUT
	mov ecx,hello        ; string to write
	mov edx,helloLen     ; length of string to write
	int 80h              ; call the kernel

	; Terminate program
	mov eax,1            ; 'exit' system call
	mov ebx,0            ; exit with error code 0
	int 80h              ; call the kernel

_start:
    pop ecx              ; pop argc to ecx
	pop ecx              ; pop args[0] (prime number) to ecx
	inc ecx              ; set check number  



