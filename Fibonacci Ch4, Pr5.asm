TITLE  Chapter 4, Problem 5 (Fibonacci.asm)
; Program:     Chapter 4,  Problem 5
; Description: Calculates the first 12 values in the Fibonacci number sequence with a loop.
; Student:     Jenny Nguyen
; Date:        09/15/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
byteArray BYTE 1,1,10 DUP(0)

.code
main PROC
	mov ecx, 10					; set outer loop count
	mov bl, 1					; fib1 
	mov dl, 1					; fib2
	mov eax, 0					; clear accumulator 
	mov esi, 2
L1:
	mov al, dl
	mov dl, bl					; f2 = f1
	add al, bl					
	mov bl, al					; f1 = f(n)
	mov [byteArray+esi], al
	inc esi
	loop L1	; repeat the outer loop

Display PROC
    mov esi, offset byteArray 
    mov ebx, type byteArray
    mov ecx, lengthof byteArray
    call DumpMem
    ret
Display ENDP

main ENDP
END ;main

