TITLE Chap 10 Linked List Fibonacci		(ch10_Linked_List_Fibon.asm)

Comment !
Description:	This program shows how the STRUC directive
				and the REPT directive can be combined to
				create a linked list at assembly time.
				A macro is used to fill the linked list
				with Fibonacci numbers.

Student:		Jenny Nguyen
Date:			11/17/15
Class:			CSCI 241
Instructor:		Mr. Ding
!
INCLUDE Irvine32.inc
INCLUDE macros.inc

ListNode STRUCT
  NodeData DWORD ?
  NextPtr  DWORD ?
ListNode ENDS

TotalNodeCount = 14		; 14 Nodes + 1 tail node = 15 nodes
NULL = 0
Counter = 0
val1  = 0
val2  = 1
val3 = 0

mFib MACRO
	val1 = val2
	val2 = val3
	val3 = val1 + val2  
ENDM

writeNode PROTO

.data
LinkedList LABEL PTR ListNode
REPT TotalNodeCount
	mFib
	Counter = Counter + 1
	ListNode <val3, ($ + Counter * SIZEOF ListNode)>
ENDM

mFib
ListNode <val3,0>	; fill tail node

.code
mainLL PROC
	mov esi, OFFSET LinkedList

NextNode:
	; Check for the tail node.
	mov  eax,(ListNode PTR [esi]).NextPtr
	cmp  eax,NULL
	je   quit
	
	call writeNode

	; Get pointer to next node.
	mov  esi, (ListNode PTR [esi]).NextPtr
	jmp  NextNode

quit:
	call writeNode	; display last node
	call Crlf
	call WaitMsg
	exit
mainLL ENDP

writeNode PROC
	mov  eax, (ListNode PTR [esi]).NodeData
	call WriteDec
	mWriteSpace
	ret
writeNode ENDP

END ;mainLL

