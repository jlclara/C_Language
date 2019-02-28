TITLE Ch11 Linked List Insertion & Display		(Linked_List_Insertion_and_Display.asm)

Comment !
Description:	This program creates a dynamically allocated linked list. 
Student:		Jenny Nguyen
Date:			12/01/15
Class:			CSCI 241
Instructor:		Mr. Ding
!
INCLUDE Irvine32.inc
INCLUDE macros.inc

NODE STRUCT
    intVal SDWORD ?
    pNext DWORD ?
NODE ENDS
PNODE TYPEDEF PTR NODE

allocate_LL PROTO 
fill_LL PROTO
display_release_LL PROTO

.data
hHeap HANDLE ?
numOfNodes DWORD ?
head NODE <0,0> ; Dummy head
pTailNode PNODE ?
pCurrNode PNODE ?

.code
mainLLDynamic PROC

	INVOKE GetProcessHeap
	.IF eax == NULL ; heap not created
		call WriteWindowsMsg ; show error message
		jmp quit
	.ELSE
		mov hHeap,eax ; handle is OK
	.ENDIF

	mov pCurrNode, OFFSET head
	mov esi,pCurrNode ; point to the curr node
	;mov edi,pTailNode ; point to the tail node
	
	mWrite "Number of integers to enter? "
	Call ReadInt
	mov numOfNodes, eax
	
	.REPEAT
		mWrite "Signed integer node value? "
		call ReadInt
		call allocate_LL
		jnc LL_OK
		call Crlf
		jmp quit
	LL_OK:
		call fill_LL
		dec numOfNodes
	.UNTIL numOfNodes < 1

	call Crlf
	call display_release_LL

quit:
	call Crlf
	call WaitMsg
	exit
mainLLDynamic ENDP

;--------------------------------------------------------
allocate_LL PROC USES eax
;
; Dynamically allocates space for the array.
; Receives: EAX = handle to the program heap, ESI is a pointer
;			to pCurrNode
; Returns: CF = 0 if the memory allocation succeeds.
	;--------------------------------------------------------
	INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, SIZEOF NODE
	.IF eax == NULL
		stc ; return with CF = 1
	.ELSE
		mov (NODE PTR[esi]).pNext,eax ; save the pointer
		clc ; return with CF = 0
	.ENDIF
	ret
allocate_LL ENDP
;--------------------------------------------------------
fill_LL PROC
;
; Fills all array positions with a single character.
; Receives: ESI is a pointer to pCurrNode, 
;			EDI is a pointer to pTailNode
;			EAX = signed integer from user input
; Returns: nothing
;--------------------------------------------------------
	mov edi, (NODE PTR [esi]).pNext
	mov (NODE PTR [edi]).intVal, eax
	mov esi, edi
	ret
fill_LL ENDP

;--------------------------------------------------------
display_release_LL PROC
;
; Displays the list of nodes and releases all the heap
; memory created
; Receives: ESI is a pointer to pCurrNode, 
; Returns: Nothing
;--------------------------------------------------------
	mov esi, (NODE PTR[head]).pNext
	mWrite "Contents of linked list:"
	call Crlf
	mWrite "Dummy Head -> "

top:	
	mov  eax,(NODE PTR [esi]).pNext
	cmp  eax,NULL						; check for end of LL
	je   quit
	mov  eax, (NODE PTR [esi]).intVal
	call WriteInt
	mWrite " -> "
	mov  edi, (NODE PTR [esi]).pNext
	INVOKE HeapFree, hHeap, 0, esi
	mov esi, edi	
	jmp top

quit:
	mov  eax, (NODE PTR [esi]).intVal
	call WriteInt
	ret
display_release_LL ENDP

END; mainLLDynamic

