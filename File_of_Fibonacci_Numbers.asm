TITLE Chapter 5 Exercise 10              (File_of_Fibonacci_Numbers.asm)
; Program:		Chapter 5 Exercise 10 
; Description:  Write a program that generates the first 47 values in the 
;				Fibonacci series, stores them in an array of doublewords, 
;				and writes the doubleword array to a disk file.
; Student:		Jenny Nguyen
; Date:			09/17/15
; Class:		CSCI 241
; Instructor:	Mr. Ding


INCLUDE Irvine32.inc

FIB_COUNT = 47	; number of values to generate

.data
fileHandle DWORD ?
filename BYTE "fibonacci.bin",0
array DWORD FIB_COUNT DUP(?)

.code
main2sub PROC

; Generate the array of fib values
   ; Prepare your ESI and ECX 
   	mov ecx, 47					; set outer loop count
	mov ebx, 0					; fib1 
	mov edx, 1					; fib2
	mov eax, 0					; clear accumulator 
	mov esi, OFFSET array
   
   ; Calling generate_fibonacci
   call generate_fibonacci

; Create the file, call CreateOutputFile
	mov edx, OFFSET filename
	call CreateOutputFile
	mov fileHandle, eax

; Write the array to the file, call WriteToFile
	mov eax, fileHandle
	mov edx, OFFSET array
	mov ecx, 188
	call WriteToFile

; Close the file, call CloseFile	
	mov eax, fileHandle
	call CloseFile

	call WaitMsg
   exit
main2sub ENDP

;------------------------------------------------------------
generate_fibonacci PROC USES eax ebx ecx edx
;
; Generates fibonacci values and stores in an array.
; Receives: ESI points to the array, 
;           ECX = count
; Returns: nothing
;------------------------------------------------------------

L1:
	mov eax, edx
	mov edx, ebx					; f2 = f1
	add eax, ebx					
	mov ebx, eax					; f1 = f(n)
	mov [esi], eax
	call WriteDec
	call Crlf
	add esi, 4
	loop L1	; repeat the outer loop

   ret
generate_fibonacci ENDP

END; main2sub
