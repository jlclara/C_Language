TITLE  Chapter 9, Problem 2 (Str_concat.asm)
; Program:     Str_concat.asm
; Description: Concatenate two strings
; Student:     Jenny Nguyen
; Date:        10/27/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

Str_concat PROTO, 
	targetStr:PTR BYTE, sourceStr:PTR BYTE
BUFMAX = 128

.data
prompt   BYTE  "Enter a string: ",0
resultMsg   BYTE  "The string concatenated:  ",0
input1	 BYTE	BUFMAX+1 DUP(1)
input2	 BYTE	BUFMAX+1 DUP(1)


.code
mainStrConCat PROC
	mov		edx, OFFSET prompt
	call	WriteString
	mov		ecx,BUFMAX				; maximum character count
	mov		edx, OFFSET input1		; point to the buffer
	call	ReadString         		; input the string

	mov		edx, OFFSET prompt
	call	WriteString
	mov		ecx,BUFMAX				; maximum character count
	mov		edx, OFFSET input2		; point to the buffer
	call	ReadString         		; input the string

	INVOKE Str_concat, ADDR input1, ADDR input2

	mov		edx, OFFSET resultMsg
	call	WriteString
	mov		edx, OFFSET input1
	call	WriteString
	call	Crlf

	call WaitMsg
	exit
mainStrConCat ENDP

;-----------------------------------------------------
Str_concat PROC, 
	targetStr:PTR BYTE, sourceStr:PTR BYTE

; Concatenates a source string to the end of a target
; string
; Requires: the target string must contain enough space
;	 to hold the concatenated result. 
; Returns: Nothing
;-----------------------------------------------------
	INVOKE Str_length, sourceStr
	mov ecx, eax
	INVOKE Str_length, targetStr
	mov  esi, sourceStr
	mov  edi, targetStr
	add  edi, eax
	cld
	rep movsb
	mov  BYTE PTR [edi], 0
	
	ret
Str_concat ENDP

END ;mainStrConCat