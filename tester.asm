; Creating a Linked List            (List.asm)

; This program shows how the STRUC directive
; and the REPT directive can be combined to
; create a linked list at assembly time.

INCLUDE Irvine32.inc

Rental STRUCT
	invoiceNum BYTE 5 dup(' ')
	dailyprice word ?
	daysrented word ?
Rental ENDS

.data
march Rental <'12345', 10, 0>

.code 
mainTester PROC



quit:
	call WaitMsg
	exit
mainTester ENDP


END mainTester