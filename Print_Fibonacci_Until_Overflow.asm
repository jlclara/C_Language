TITLE Chapter 6             (Print_Fibonacci_Until_Overflow.asm)
; Program:		Chapter 6 Print_Fibonacci_Until_Overflow.asm
; Description:  This program calculates the signed Fibonacci number sequence, 
; stopping only when the Overflow flag is set. This program calculates the 
; signed Fibonacci number sequence, stopping only when the Overflow flag is set
; Student:		Jenny Nguyen
; Date:			10/06/15
; Class:		CSCI 241
; Instructor:	Mr. Ding


INCLUDE Irvine32.inc

.data

.code
mainPrintFibOF PROC
   
   ; Calling generate_fibonacci
   call generate_fibonacci_while

   call WaitMsg
   exit
mainPrintFibOF ENDP

;------------------------------------------------------------------------------
generate_fibonacci_while PROC USES eax ebx ecx edx esi
;
; Generates fibonacci values until overflow flag is set. Print index and value
; of fibonacci values to console
; Receives: nothing
; Returns: nothing
;------------------------------------------------------------------------------
	mov ebx, 0					; fib1 
	mov edx, 1					; fib2
	mov ecx, 0					; clear accumulator 
	mov esi, 1					; index counter

top:
	mov ecx, edx
	mov edx, ebx					; f2 = f1
	add ecx, ebx
	
	jo	next						; if overflow flag set, go to next
	mov ebx, ecx					; f1 = f(n)

	mov eax, esi					; write counter to console
	call WriteDec
	add esi, 1						; increase count

	mov eax, ":"					; print ": "
	call WriteChar
	mov eax, " "
	call WriteChar

	mov eax, ecx					; put fib number in eax to write to console
	call WriteDec
	
	call Crlf
	jmp top							 
next:								
	ret
generate_fibonacci_while ENDP

END ;mainPrintFibOF
