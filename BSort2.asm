TITLE  BubbleSort2 Procedure                (BSort2.asm)

; Program:     Chapter 9, Modified
; Description: Improvement of textbook BubbleSort procedure 
;				using a register as an exchange flag 
; Student:     Jenny Nguyen
; Date:        10/27/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.code
;----------------------------------------------------------
BubbleSort2 PROC USES eax ecx esi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD				; array size
;
; Sort an array of 32-bit signed integers in ascending order
; using the bubble sort algorithm.
; Receives: pointer to array, array size
; Returns: nothing
;-----------------------------------------------------------

	mov ecx,Count
	dec ecx				; decrement count by 1

L1:	mov edx,ecx		; save outer loop count
	mov esi,pArray		; point to first value
	mov ebx, 0			; ebx = exchange flag

L2:	mov eax,[esi]		; get array value
	cmp [esi+4],eax		; compare a pair of values
	jge L3				; if [esi] <= [edi], don't exch
	mov ebx, 1
	xchg eax,[esi+4]	; exchange the pair
	mov [esi],eax

L3:	add esi,4			; move both pointers forward
	loop L2				; inner loop
	cmp ebx,0
	je L4

	mov ecx,edx 		; retrieve outer loop count
	loop L1				; else repeat outer loop

L4:	ret
BubbleSort2 ENDP

END 
