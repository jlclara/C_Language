TITLE  Text_Constants.asm (Chapter 3, Pr 2 and 4)

; Program:     Chapter 3, Problem 4
; Description: Program demonstrates the use of symbolic names for string literals
; Student:     Jenny Nguyen
; Date:        09/08/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

; Symbolic constant definitions using TEXTEQU directions for string literals
Message1 TEXTEQU <"Message1: Welcome to CSCI 241", 0dh, 0ah, 0>
Message2 TEXTEQU <"Message2: This is a warm-up exercise", 0dh, 0ah, 0>
Message3 TEXTEQU <"Message3: Generic message", 0dh, 0ah, 0>

.data
prompt1 BYTE Message1
prompt2 BYTE Message2
prompt3 BYTE Message3

.code
main2 proc
; watch the strings in memory

   invoke ExitProcess,0
main2 endp
end ;main2