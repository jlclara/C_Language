TITLE  Chapter 7, Problem 6 (Greatest_Common_Divisor.asm)
; Program:     Greatest Common Divisor
; Description: Find the GCD using  integer division
; Student:     Jenny Nguyen
; Date:        10/13/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
prompt   BYTE  "Enter a 32 bit number: ",0
gcdMsg   BYTE  "Greatest common divisor:  ",0
input	 DWORD  ?

.code
mainGcd PROC
	mov		eax, 0
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt
	cmp eax, 0
	jb done
	neg eax
	done:
	mov		ebx, eax		; stores divisor in EBX

	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt
	cmp eax, 0
	jb done2
	neg eax
	done2:
	call    CalcGcd

	mov		edx, OFFSET gcdMsg
	call	WriteString
	Call	WriteInt
	Call	Crlf

	call	WaitMsg

	exit
mainGcd ENDP

;-----------------------------------------------------
CalcGcd PROC
;
; Caluclates greatest common divisor of 2 32-bit integers. 
			; GCD is stored in EAX
; Receives: receives the dividend in EDX:EAX and divisor 
;			in EBX
; Returns: nothing
;-----------------------------------------------------
	L1:
		mov edx, 0
		div	ebx
		mov		eax, ebx
		mov		ebx, edx
		cmp		ebx, 0
		ja	L1
	
	ret
CalcGcd ENDP

END; mainGcd