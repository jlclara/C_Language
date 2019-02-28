TITLE  Symbolic_Integer.asm (Chapter 3, Pr 2 and 4)

; Program:     Chapter 3, Problem 2 
; Description: Program demonstrates the use of symbolic names for integers
; Student:     Jenny Nguyen
; Date:        09/08/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
; Symbolic constant definitions using equal-sign directives
Sunday = 0
Monday = 1
Tuesday = 2
Wednesday = 3
Thursday = 4
Friday = 5
Saturday = 6

.data
listWeek BYTE Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
ListSize = ($-listWeek)

.code
main1 proc
; watch the array count with a register
	mov	eax,ListSize
   invoke ExitProcess,0
main1 endp
end ;main1