TITLE Chap 11 Random_Color_Char_Screen_Fill		(Ch11_Random_Color_Char_Screen_Fill.asm)

Comment !
Description:	This program fills each screen cell with a random character
				in a random color. There is a 50% probability that the color
				of any character will be red, 25% green and 25% yellow.
				Displays 50 random chars a line and 20 rows.

Student:		Jenny Nguyen
Date:			11/19/15
Class:			CSCI 241
Instructor:		Mr. Ding
!

INCLUDE Irvine32.inc
MAXCOL = 50

ChooseColor PROTO
ChooseChar PROTO
.data
outHandle HANDLE ?
cellsWritten DWORD ?
xyPos COORD <0,0>

; Array of char codes:
bufChar BYTE 50 DUP(?)
; Array of attributes (color codes):
bufColor WORD 50 DUP(?)

.code
mainCh11Pr4 PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov outHandle, eax
	mov ecx, 20
	outerLoop:
	push ecx
	mov esi, 0
	mov edi, 0
	mov ecx, 50

	L1: 
		call ChooseColor
		mov bufColor[esi], ax
		call ChooseCharacter
		mov bufChar[edi], al
		add esi, TYPE WORD
		add edi, TYPE BYTE
	loop L1
	
	INVOKE WriteConsoleOutputAttribute, outHandle, ADDR bufColor, MAXCOL, xyPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, outHandle, ADDR bufChar, MAXCOL, xyPos, ADDR cellsWritten
	inc COORD PTR xyPos.Y
	pop ecx
	loop outerLoop
	INVOKE SetConsoleCursorPosition, outHandle, xyPos
	call WaitMsg
	exit
mainCh11Pr4 ENDP

; --------------------------------------------------------------------------------
; Selects a color with a 50% probability of red, a 25% of green and 25% of yellow
; Receives: nothing
; Returns:  EAX = randomly selected color
ChooseColor PROC
	mov	  eax,4			
	call  RandomRange
	.IF eax == 0 || eax == 3		; red
	  mov ax, 04h
	.ELSEIF eax == 1	; green
	  mov ax, 02h
	.ELSEIF eax == 2	; yellow
	  mov ax, 0Eh
	.ENDIF
	ret
ChooseColor ENDP
; --------------------------------------------------------------------------------
; --------------------------------------------------------------------------------
; Randomly selects an ASCII character
; Receives: nothing
; Returns:  AL = randomly selected character, from ASCII code 20h to 07Ah 
ChooseCharacter PROC
	mov	  eax,5Ah		
	call  RandomRange
	add	eax, 20h
	ret
ChooseCharacter ENDP
; --------------------------------------------------------------------------------
END; mainCh11Pr4