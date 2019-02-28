TITLE Chapter 8            (ch08_fact_stub.asm)

Comment !
Description: Write a nonrecursive version of the Factorial procedure
(Section 8.5.2) that uses a loop. Write a short program that
interactively tests your Factorial procedure. Let the user enter
the value of n. Display the calculated factorial.
!

INCLUDE Irvine32.inc

.data
msgInput BYTE "Enter the value of n to calculate " 
   BYTE "the factorial (-1 to quit): ",0
msgOutput BYTE "The factorial is: ",0
factorialError  BYTE "Error: Result does not fit "
   BYTE "in 32 bits.",0

.code
main3stub PROC

L1:
   ; message to display
   mov  edx, OFFSET msgInput
   call WriteString
   
   ; get an integer n from the user
   call ReadInt  
   
   ; if n is -1, go quit
   cmp eax, -1
   je quit

   ; EAX = factorial(n)
   call _FactorialIterative	
   
   ; if error, show factorialError message
   cmp edx, 0
   jnz errorMsg

   ; if OK, display factorial
	mov edx, OFFSET msgOutput
	call WriteString
	call WriteInt
	jmp  Done

	errorMsg:
		mov edx, OFFSET factorialError
		call WriteString
Done:
   ; go back to L1
   call Crlf
   call Crlf
   jmp L1

quit: 
	exit

main3stub ENDP

;---------------------------------------------------
_FactorialIterative PROC USES ecx 
;
; Calculates a factorial nonrecursively
; Receives: eax = value of n to calculate factorial
; Returns: eax = calculated factorial
;---------------------------------------------------
.code

   ; deal with base case 
   mov  ecx, eax
   xor  edx, edx
   cmp  eax, 1
   ja   Factorial_loop
   mov  eax, 1
   jmp end_factorial

Factorial_loop:
   mov  ebx, ecx	
   dec  ebx		; n - 1
   mul  ebx		; n * (n - 1) 
   
   ; if out of range occurs
   cmp  edx, 0
   jnz  end_factorial

   ; if counter > 1, go Factorial_loop
   dec  ecx
   cmp  ecx, 1
   ja   Factorial_loop	
   jmp  end_factorial 

;out_of_range: mov eax, 0
end_factorial: ret 

_FactorialIterative ENDP

END; main3stub

