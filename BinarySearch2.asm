TITLE  Binary Search Procedure Mod       (BinarySearch2.asm)

; Program:     Chapter 9, Modified
; Description: Improvement of textbook BinarySearch without
;				using memory, push/pops 
; Student:     Jenny Nguyen
; Date:        10/29/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.code
;-------------------------------------------------------------
BinarySearch2 PROC USES ebx edx esi edi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD,			; array size
	searchVal:DWORD			; search value

; Search an array of signed integers for a single value.
; Receives: Pointer to array, array size, search value.
; Returns: If a match is found, EAX = the array position of the
; matching element; otherwise, EAX = -1.
;-------------------------------------------------------------
	mov	 ecx,0				; ECX = first = 0
	mov	 edx,Count			
	dec	 edx				; EDX = last = count -1
	mov	 edi,searchVal		; EDI = searchVal
	mov	 ebx,pArray			; EBX points to the array

L1:							; while first <= last
	cmp	 ecx,edx
	jg	 L5					; exit search
	mov  eax, ecx
	add  eax, edx			; EAX  = mid = (last + first) / 2 
	shr  eax, 1				

; ESI = values[mid]
	mov	 esi,[ebx+eax*4]	; scale by 4 for dword

; if ( ESI < searchVal (EDI) )
	cmp	 esi,edi
	jge	 L2
	mov	 ecx, eax 			; first = mid + 1
	inc	 ecx
	jmp	 L1
L2:							; else if( ESI > searchVal (EDI) )				
	je	 L9					; if ESI = EDI, done
	mov  edx, eax
	dec  edx				; last = mid - 1;
	jmp	 L1

L5:	mov	 eax,-1				; search failed
L9:	ret
BinarySearch2 ENDP
END