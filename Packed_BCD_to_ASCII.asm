TITLE Chapter 7 Exercise 3              (Packed_BCD_to_ASCII.asm)
; Program:     Packed BCD to ASCII
; Student:     Jenny Nguyen
; Date:        10/15/15
; Class:       CSCI 241
; Instructor:  Mr. Ding
Comment !
Description: Write a procedure named PackedToAsc that converts a
4-byte packed decimal number to a string of ASCII decimal digits.
Pass the packed number to the procedure in EAX, and pass a pointer
to a buffer that will hold the ASCII digits. Write a short test
program that demonstrates several conversions and displays the
converted numbers on the screen.
!

INCLUDE Irvine32.inc

.data
numbers DWORD 87654321h, 45346894h, 193492h, 123h, 3h
buffer BYTE 8 DUP(1), 0   ; 8 digits plus null character

.code
mainPackedBCDtoASCII PROC

   ; Prepare for LOOP
    mov   ecx, LENGTHOF numbers   
	mov   eax,  OFFSET numbers
	mov	  edx, OFFSET buffer
L1:
    
   ; Call _PackedToAsC to convert to ASCII digits
	push ecx
    call _PackedToAsc
	pop ecx

   ; Display string of digits
   mov	  edx,  OFFSET buffer
   call WriteString
   call Crlf

   ; Get next number
   add   eax, TYPE numbers
   loop L1

mainPackedBCDtoASCII ENDP

;----------------------------------------------------------------
_PackedToAsc PROC
;
; procedure that converts a 4-byte packed decimal number
; to a string of ASCII decimal digits
; Receives: EAX, packed decimal number
;           EDX, pointer to a buffer with ASCII returned
; Returns: String of ASCII digits in buffer pointed by EDX
;------------------------------------------------------------------

	mov ecx, 8
	mov ebx, [eax]
L2:
	rol   ebx, 4
	mov	  [eax], ebx
	and   bl, 0Fh
	or	  bl, 30h
 	mov   [edx], bl
	mov	  ebx, [eax]
	
	add	  edx, 1
	loop L2
	
	ret
_PackedToAsc ENDP

END; mainPackedBCDtoASCII
