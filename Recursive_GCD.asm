TITLE  Chapter 8, Problem 7 (Recursive_GCD.asm)
; Program:     Recursive Greatest Common Divisor
; Description: Find the GCD using  integer division
; Student:     Jenny Nguyen
; Date:        10/22/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

CalcRecGcd PROTO, int1:DWORD, int2:DWORD
;---------------------------------------------------
; Calculate the greatest common divisor, of 
;     two nonnegative integers in recursion.
; Receives: int1, int2 
; Returns:  EAX = Greatest common divisor

ShowResult PROTO, int1:DWORD, int2:DWORD, gcd:DWORD
;---------------------------------------------------
; Show calculated GCD result as 
;      "GCD of 5 and 20 is 5"
; Receives: int1, int2, gcd 

.data
array  DWORD 5,20, 24,18, 11,7, 438,226, 26,13
numOfPairs DWORD [LENGTHOF array]/2

.code
mainRecursiveGcd PROC

	mov		ecx, numOfPairs
	xor		esi, esi
	L1:
	invoke  CalcRecGcd, [array+esi], [array+esi+4]
	invoke	ShowResult, [array+esi], [array+esi+4], eax
	add		esi, 8
	loop L1
	call	WaitMsg

	exit
mainRecursiveGcd ENDP

;--------------------------------------------------
CalcRecGcd PROC, int1:DWORD, int2:DWORD

; Calculate the greatest common divisor, of 
;     two nonnegative integers in recursion.
; Receives: int1, int2 
; Returns:  EAX = Greatest common divisor
	
		xor		edx, edx
		mov		eax, int1
		div		int2
		mov		eax, int2
		cmp		edx, 0
		je	    Done
		INVOKE  CalcRecGcd, eax, edx
	Done:
	ret
CalcRecGcd ENDP
;---------------------------------------------------

ShowResult PROC, int1:DWORD, int2:DWORD, gcd:DWORD
;---------------------------------------------------
; Show calculated GCD result as 
;      "GCD of 5 and 20 is 5"
; Receives: int1, int2, gcd 

.data
gcdOf byte "GCD of ",0
andString byte " and ",0
isString byte " is ", 0

.code
mov  edx, OFFSET gcdOf
call WriteString
mov  eax, int1
call WriteDec

mov  edx, OFFSET andString
call WriteString
mov  eax, int2
call WriteDec

mov  edx, OFFSET isString
call WriteString
mov  eax, gcd
call WriteDec
call Crlf

ret
ShowResult ENDP
;---------------------------------------------------

END; mainRecursiveGcd