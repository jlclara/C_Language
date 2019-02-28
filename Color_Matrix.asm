TITLE  Color_Matrix.asm (Chapter 5, Problem 8)

; Program:     Chapter 5, Problem 8
; Description: Write a program that displays a single character in all possible combinations 
;			   of foreground and background colors (16 x16 = 256) with AL: BKGD|FRGD. 
; Student:     Jenny Nguyen
; Date:        09/22/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
count dword ?
.code
maina PROC
	mov		eax, 0
	mov		al, -1
	mov		ecx, 16

L1: 
	mov		count, ecx
	mov		ecx, 16
	L2: 
		add		al, 1
		Call	SetTextColor
		mov		bl, al
		mov		al, 'X'
		call	WriteChar
		mov		al, bl
		loop	L2

	;restore outer loop counter
	mov		ecx, count

	;move to next line
	call	Crlf
	loop	L1

	;restore default text color
	mov		al, 15
	Call	SetTextColor

	call	WaitMsg
	exit
maina ENDP

END; maina