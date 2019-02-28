TITLE Copy_String_Reverse				(Copy_Str_Reverse.asm)
; Program:     Chapter 4, Problem 7 Modified
; Description: Copy a string from source to target, reversing the character order. 
;				This program uses the LOOP instruction with indirect operands.
; Student:     Jenny Nguyen
; Date:        09/17/15
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc

.data
source  byte  "This is the source string",0
target  byte  SIZEOF source DUP(1),0FFh
original byte "Original: ", 0
reversed byte "Reversed: ", 0


.code
mainb PROC
	mov  esi, [OFFSET source + LENGTHOF source - 2]		; index register
	mov  edi, OFFSET target
	mov  ecx, SIZEOF source								; loop counter
	mov  target[ecx-1], 0
L1:
	mov  al,[esi]			; get a character from source
	mov  [edi],al			; store it in the target
	dec  esi				; move to next character
	inc  edi
	loop L1					; repeat for entire string

	mov edx, OFFSET original
	call WriteString

	mov edx, OFFSET source
	call WriteString
	call Crlf

	mov edx, OFFSET reversed
	call WriteString

	mov edx, OFFSET target
	call WriteString
	call Crlf

	call WaitMsg

	exit
mainb ENDP

END ;mainb