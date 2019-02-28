TITLE  Chapter 7, zd supplied (DOS_file_time.asm)
; Program:     DOS File Time
; Description: Using Shift left and Shift right to display DOS
;				file time from a 16-bit hexadecimal.
; Student:     Jenny Nguyen
; Date:        10/08/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
prompt   BYTE  "Please enter 16-bit hexadecimal (4-digit, e.g., 1207): ",0
binMsg   BYTE  "Your equivalent binary is ",0
DOSMsg   BYTE  "Your DOS file time is ",0

.code
mainFileTime PROC
	mov		eax, 0
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadHex

	mov		edx, OFFSET binMsg
	call	WriteString
	mov		ebx, TYPE WORD
	call	WriteBinB
	Call	Crlf

	call	ShowFileTime
	Call	Crlf
	call	WaitMsg

	exit
mainFileTime ENDP

;-----------------------------------------------------
ShowFileTime PROC
;
; Displays the time in hh:mm:ss format.
; Receives: binary file time value in AX register
; Returns: nothing
;-----------------------------------------------------

	mov	edx, OFFSET DOSMsg
	Call WriteString

	mov bx,ax			; make a copy of AX
	shr ax,11			; shift right 5 bits
	and al,00011111b	; clear bits 
	Call InsertLeadZero
	Call WriteDec
	mov	al, ':'
	call WriteChar

	mov ax, bx			; make a copy of AX
	shr ax,5			; shift right 5 bits
	and al,00111111b	; clear bits 
	movzx eax, al		; clear out AH register
	Call InsertLeadZero
	Call WriteDec
	mov	al, ':'
	call WriteChar

	mov ax, bx			; make a copy of AX
	and al,00011111b	; clear bits
	movzx eax, al		; clear out AH register
	shl al, 1			; multiply bx by 2
	Call InsertLeadZero
	Call WriteDec

	ret
ShowFileTime ENDP

;-----------------------------------------------------
InsertLeadZero PROC
;
; Inserts a leading zero if value in al is less than 10
; Receives: time value in AL register
; Returns: nothing
;-----------------------------------------------------
	
	cmp al, 10
	ja	next
	mov ecx, eax		; save eax 
	mov al, '0'
	call WriteChar
	mov	eax, ecx		; restore eax if 0 is inserted
	next:
	ret
InsertLeadZero ENDP

END; mainFileTime