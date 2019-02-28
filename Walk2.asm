TITLE Drunkard's Walk 					(Walk2.asm)

; Drunkard's walk program. The professor starts at 
; coordinates 39,10 and wanders around the immediate area.

INCLUDE Irvine32.inc
WalkMax = 35
StartX = 39
StartY = 10

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition2 PROTO currX:WORD, currY:WORD

.data
aWalk DrunkardWalk <>
prompt BYTE "How many steps the Drunkard to move (max 35): ",0

.code
mainDW PROC
	mov	esi,OFFSET aWalk
	top:
	mov edx,OFFSET prompt
	call	WriteString
	call	ReadInt
	cmp		eax, WalkMax
	ja	top
	mov (DrunkardWalk PTR [esi]).pathsUsed, ax
	call	TakeDrunkenWalk2
	call	Crlf
	call	WaitMsg
	call	ShowPath
	call	WaitMsg
	exit
mainDW ENDP

;-------------------------------------------------------
TakeDrunkenWalk2 PROC
	;LOCAL currX:WORD, currY:WORD
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad

; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	movzx	ecx,(DrunkardWalk PTR [esi]).pathsUsed			; loop counter
	mov	bx,StartX		; current X-location
	mov	dx,StartY		; current Y-location

Again:
	; Insert current location in array.
	mov	(COORD PTR [edi]).X,bx
	mov	(COORD PTR [edi]).Y,dx

	INVOKE DisplayPosition2, bx, dx
	top:
	mov	  eax,4			; choose a direction (0-3)
	call  RandomRange
	.IF eax == 0		; North
	  dec dx
	.ELSEIF eax == 1	; South
	  inc dx
	.ELSEIF eax == 2	; West
	  dec bx
	.ELSE			; East (EAX = 3)
	  inc bx
	.ENDIF
	.IF bx == StartX && dx == StartY  ; does not allow going back to starting
		mov bx, (COORD PTR [edi]).X
		mov dx, (COORD PTR [edi]).Y
	    jmp top
	.ENDIF
	add	edi,TYPE COORD		; point to next COORD
	loop	Again

Finish:
	popad
	ret
TakeDrunkenWalk2 ENDP

;-------------------------------------------------------
DisplayPosition2 PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr BYTE ",",0
closeParen BYTE ") ",0
.code
	pushad
	mov al, "("
	call WriteChar
	movzx eax,currX			; current X position
	call	 WriteDec
	mov	 edx,OFFSET commaStr	; "," string
	call	 WriteString
	movzx eax,currY			; current Y position
	call	 WriteDec
	mov edx,OFFSET closeParen
	call	WriteString
	popad
	ret
DisplayPosition2 ENDP
;-------------------------------------------------------
ShowPath PROC 
; Shows the path the drunkard took 
;-------------------------------------------------------
	mov edi, OFFSET aWalk
	movzx ecx, (DrunkardWalk PTR [edi]).pathsUsed
	showPathLoop:
		Call GetTextColor
		push eax
		ror  al, 4
		call SetTextColor
		mov dh, BYTE PTR (COORD PTR [edi]).Y
		mov dl, BYTE PTR (COORD PTR [edi]).X
		call Gotoxy
		.IF dh == StartY && dl == StartX
			mov al, "O"
		.ELSE
			mov al, "*"
		.ENDIF
		mov bl, al
		call WriteChar
		pop eax
		call SetTextColor
		mov eax, 250
		call Delay
		call Gotoxy				; overwrite with gray on black background
		mov al, bl				; restore char to write
		call WriteChar
		add	edi,TYPE COORD		; point to next COORD
	loop showPathLoop
	call Crlf
	ret
ShowPath ENDP
END ;mainDW