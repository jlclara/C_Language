TITLE  Chapter 4, zd supplied (SwapValues.asm)

; Program:     Chapter 4, supplementary exercise
; Description: Swap four DWord values, e.g.: from 1, 2, 3, 4 to 2, 4, 1, 3
; Student:     Jenny Nguyen
; Date:        09/15/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
dwArray	DWORD 1000h, 2000h, 3000h, 4000h

.code
; Fill the requirement to swap DWORD elements in dwArray  
SwapValues PROC
    ; Show original data
    call Displaya

    mov eax, dwArray
	xchg eax, [dwArray+8]
	xchg eax, [dwArray+12]
	xchg eax, [dwArray+4]
	mov dwArray, eax

    ; Show swapped data
    call Displaya
    exit
SwapValues ENDP

; A procedure to show dwArray memory by calling DumpMem 
Displaya PROC
    mov esi, offset dwArray 
    mov ebx, type dwArray
    mov ecx, lengthof dwArray
    call DumpMem
    ret
Displaya ENDP
END ;SwapValues