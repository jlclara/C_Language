TITLE  Color_Matrix.asm (Chapter 5, Problem 7)

; Program:     Chapter 5, Problem 7
; Description: Write a program that displays a single character in all possible combinations 
;			   of foreground and background colors (16 x16 = 256) with AL: BKGD|FRGD. 
; Student:     Jenny Nguyen
; Date:        09/22/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
row word ?
col word ?

.code
mainRSL PROC

	call	GetMaxXY
	mov		row, eax
	mov		col, edx	
	call	RandomRange
	mov		bx, ax
	mov		eax, ecx
	call	RandomRange
	mov		cx, ax
	mov		dh, bh
	mov		dl, ch
	call Gotoxy
	mov		al, "A"
	call WriteChar
	mov		eax, 5
	call Delay

	exit
mainRSL ENDP

END ;mainRSL