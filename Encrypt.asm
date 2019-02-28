; Encryption Program               (Encrypt.asm)

; This program demonstrates simple symmetric
; encryption using the XOR instruction.

INCLUDE Irvine32.inc
KEY = 239     		; any value between 1-255
BUFMAX = 128     	; maximum buffer size

.data
prompt1  BYTE  "Enter the plain text: ",0
prompt2	 BYTE  "Enter the encryption key: ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0

buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?
keyStr	 BYTE	BUFMAX+1 DUP(0)
keySize	 DWORD ?

.code
mainEn PROC
	mov		edx, OFFSET prompt1
	mov		ebx, OFFSET buffer
	call	InputTheString		; input the plain text
	mov		bufSize, eax

	mov		edx, OFFSET prompt2
	mov		ebx, OFFSET keyStr
	call	InputTheString
	mov		keySize, eax

	call	TranslateBuffer		; encrypt the buffer

	mov		edx,OFFSET sEncrypt	; display encrypted message
	call	DisplayMessage

	call	TranslateBuffer  	; decrypt the buffer

	mov		edx,OFFSET sDecrypt	; display decrypted message
	call	DisplayMessage

	call	WaitMsg

	exit
mainEn ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	call	WriteString
	mov		ecx,BUFMAX			; maximum character count
	mov		edx, ebx			; point to the buffer
	call	ReadString         	; input the string
	ret
InputTheString ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov		edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	ecx,bufSize			; loop counter
	mov esi, OFFSET buffer
	mov	edi, 0
L1:
	mov	al, BYTE PTR [keyStr + edi]
	xor	[esi], al	; translate a byte
	inc esi					; point to next byte
	add edi, 1
	cmp edi, keySize
	jnz next
	xor edi, edi
	next:
	loop	L1
	popad
	ret
TranslateBuffer ENDP
END ;mainEn