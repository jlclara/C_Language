TITLE  Color_Matrix.asm (Chapter 6, Supplied)

; Program:     Chapter 6, Supplied
; Description: Write a program that displays a single character in all possible combinations 
;			   of foreground and background colors (16 x16 = 256) with AL: BKGD|FRGD. 
; Student:     Jenny Nguyen
; Date:        09/24/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

.code
mainCM2 PROC
	mov		eax, 0
	mov		al, 0
	mov		ecx, 256

L1: 	
	Call	SetTextColor
	mov		bl, al
	mov		al, 'X'
	call	WriteChar
	mov		al, bl	
	add		al, 1
	test	al, 00001111b
	jnz		next
	call Crlf
next:	
	loop	L1

	; restore default text color
	mov		al, 15
	Call	SetTextColor
	call	WaitMsg
	
	exit
mainCM2 ENDP

END ;mainCM2