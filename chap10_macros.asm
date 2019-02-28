TITLE mReadInt_mWriteInt_Macro.asm


; Student:     Jenny Nguyen
; Date:        11/12/15
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
INCLUDE macros.inc

mReadInt MACRO intVal:REQ
	IF ((TYPE intVal) EQ 4)
		call ReadInt
		mov intVal, eax
	ELSEIF ((TYPE intVal) EQ 2)
		call ReadInt
		mov intVal, ax
	ELSE
		ECHO error : *****************************************************************
		ECHO error : Argument &intVal passed to mReadInt must be either 16 or 32 bits.
		ECHO error : &intVal must be of 16 or 32-bit data type. 
		ECHO error : *****************************************************************
	ENDIF

ENDM

mWriteInt MACRO value
	IF ((TYPE value) EQ 4) 
		mov eax, value
	ELSEIF ((TYPE value) EQ 2)
		movsx eax, value
	ELSEIF ((TYPE value) EQ 1)
		movsx eax, value
	ELSE
		ECHO error : *****************************************************************
		ECHO error : Argument &value passed to mWriteInt must be 8, 16, or 32 bits.
		ECHO error : *****************************************************************
		EXITM
	ENDIF
	mWrite "&value = "
	Call WriteInt
	Call Crlf
	
ENDM

.data
bVal SBYTE -2
wVal SWORD -122
dVal DWORD 1234567
qVal QWORD 11

.code
mainMacro PROC
  
	mWrite "Enter a 32-bit integer: "
	mReadInt dVal
	mWriteInt dVal
	mWrite "Enter a 16-bit integer: "
	mReadInt BX
	mWriteInt BX

	mWrite "Testing out mWriteInt"
	call Crlf
	mWriteInt bVal
    mWriteInt wVal
	mWriteInt dVal
	mWriteInt AX
    mWriteInt ebx

	call Crlf
	call WaitMsg
   
	exit
mainMacro ENDP

END ;mainMacro

