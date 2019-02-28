TITLE Chapter 6 Exercise 6              (Boolean_Calculator.asm)

Comment !
Program:		Boolean_Calculator.asm
Description:	Continue the solution program from the preceding
				exercise by implementing the following procedures:

- AND_op: Prompt the user for two hexadecimal integers. AND them
  together and display the result in hexadecimal.
- OR_op: Prompt the user for two hexadecimal integers. OR them
  together and display the result in hexadecimal.
- NOT_op: Prompt the user for a hexadecimal integer. NOT the
  integer and display the result in hexadecimal.
- XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR
  them together and display the result in hexadecimal.

Student:		Jenny Nguyen
Date:			10/06/15
Class:			CSCI 241
Instructor:		Mr. Ding
!

INCLUDE Irvine32.inc

.data
msgMenu BYTE "---- Boolean Calculator ----------",0dh,0ah
   BYTE 0dh,0ah
   BYTE "1. x AND y"     ,0dh,0ah
   BYTE "2. x OR y"      ,0dh,0ah
   BYTE "3. NOT x"       ,0dh,0ah
   BYTE "4. x XOR y"     ,0dh,0ah
   BYTE "5. Exit program",0

msgAND BYTE "Boolean AND",0
msgOR  BYTE "Boolean OR",0
msgNOT BYTE "Boolean NOT",0
msgXOR BYTE "Boolean XOR",0

msgOperand1 BYTE "Input the first 32-bit hexadecimal operand:  ",0
msgOperand2 BYTE "Input the second 32-bit hexadecimal operand: ",0
msgResult   BYTE "The 32-bit hexadecimal result is:            ",0

caseTable BYTE '1'   ; lookup value
	DWORD _AND_op	; address of procedure
	EntrySize = ($ - CaseTable)
	BYTE '2'
	DWORD _OR_op
	BYTE '3'
	DWORD _NOT_op
	BYTE '4'
	DWORD _XOR_op
	BYTE '5'
	DWORD _ExitProgram

NumberOfEntries = ($ - caseTable) / EntrySize

.code
main08stub PROC

   ; Show menu in a loop
Menu:
	mov		edx, OFFSET msgMenu
	call	WriteString
	call	Crlf

L1:   
   ; Call ReadChar to get the input
	call ReadChar
   ; verify the input
	cmp		al, '1'
	jb		L1
	cmp		al, '5'
	ja		L1

   ; Call ChooseProcedure
   call		_ChooseProcedure

   ; if CF set, exit
   jnc Menu
   exit
main08stub ENDP

;------------------------------------------------
_ChooseProcedure PROC
;
; Selects a procedure from the caseTable
; Receives: AL is the number of operation the user entered
; Returns: if CF set, exit; else continue 
;------------------------------------------------
	mov  ebx,OFFSET caseTable	; point EBX to the table
	mov  ecx,NumberOfEntries 	; loop counter
L1:
	cmp		al,[ebx]			; match found?
	jne		L2					; no: continue
	call	Crlf
	call	NEAR PTR [ebx + 1]	; yes: call the procedure
	jmp		L3					; exit the search
L2:
	add		ebx, EntrySize		; point to the next entry
	loop	L1					; repeat until ECX = 0
L3:
	ret
_ChooseProcedure ENDP

;------------------------------------------------
inputPrompt1 PROC
;
; Prompts user to enter first hexadecimal integer
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	call	Crlf
	call	Crlf
	mov		edx, OFFSET msgOperand1
	call	WriteString
	call	ReadHex
	ret
inputPrompt1 ENDP

;------------------------------------------------
inputPrompt2 PROC
;
; Prompts user to enter second hexadecimal integer
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	mov		edx, OFFSET msgOperand2
	call	WriteString
	call	ReadHex
	ret
inputPrompt2 ENDP

;------------------------------------------------
displayResult PROC
;
; Displays the result
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	mov		edx, OFFSET msgResult
	call	WriteString
	call	WriteHex
	call	Crlf
	call	Crlf
	ret
displayResult ENDP

;------------------------------------------------
_AND_op PROC
;
; Performs a boolean AND operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	mov		edx, OFFSET msgAnd
	call	WriteString
	call	inputPrompt1
	mov		ebx, eax
	call	inputPrompt2
	and		eax, ebx
	call	displayResult
	ret
_AND_op ENDP

;------------------------------------------------
_OR_op PROC
;
; Performs a boolean OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov		edx, OFFSET msgOR
	call	WriteString
	call	inputPrompt1
	mov		ebx, eax
	call	inputPrompt2
	or		eax, ebx
	call	displayResult
	ret

_OR_op ENDP

;------------------------------------------------
_NOT_op PROC
;
; Performs a boolean NOT operation.
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov		edx, OFFSET msgNOT
	call	WriteString
	call	inputPrompt1
	NOT		eax
	call	displayResult
	ret

_NOT_op ENDP

;------------------------------------------------
_XOR_op PROC
;
; Performs an Exclusive-OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------

	mov		edx, OFFSET msgXOR
	call	WriteString
	call	inputPrompt1
	mov		ebx, eax
	call	inputPrompt2
	xor		eax, ebx
	call	displayResult
	ret
_XOR_op ENDP

;------------------------------------------------
_ExitProgram PROC
;
; Receives: Nothing
; Returns: Sets CF = 1 to signal end of program
;------------------------------------------------
	stc			; set carry flag
	ret
_ExitProgram ENDP

END ;main08stub
