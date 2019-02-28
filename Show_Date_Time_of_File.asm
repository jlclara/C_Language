TITLE  Chapter 11, Problem 9
; Program:     Show_Date_Time_of_File
; Description: This procedure shows the day/time stamps for when
;				a user-specified file was created and last modified
; Student:     Jenny Nguyen
; Date:        11/24/2015
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
INCLUDE macros.inc

WriteDateTime PROTO, DateTime:SYSTEMTIME

SystemTimeToTzSpecificLocalTime PROTO,
    lpTimeZone:DWORD,    
    lpUniversalTime:PTR SYSTEMTIME,
    lpLocalTime:PTR SYSTEMTIME

.data
filename BYTE 80 DUP (?)
fileHandle HANDLE ?
sysTimeCreated SYSTEMTIME <>
sysTimeLastWritten SYSTEMTIME <>

.code
mainShowFileTime PROC
	mWrite "Input your file name: "
	mReadString filename

    mov	esi, OFFSET sysTimeCreated
    mov	edi, OFFSET sysTimeLastWritten
    call AccessFileDateTime
	jc done  ; carry flag set if file name is invalid

	; output to screen
	mWriteString filename
	mWrite " was created on: "
	INVOKE WriteDateTime, sysTimeCreated
	call Crlf
	mWrite "And it was last written on: "
	INVOKE WriteDateTime, sysTimeLastWritten

	done:
	call Crlf
	call WaitMsg
	exit
mainShowFileTime ENDP
;---------------------------------------------------------------------
; Receives: EDX offset of filename, 
;           ESI points to a SYSTEMTIME structure of sysTimeCreated
;           EDI points to a SYSTEMTIME structure of sysTimeLastWritten
; Returns:  If successful, CF=0 and two SYSTEMTIME structures contain 
;		    the file's date/time data.  If it fails, CF=1.
AccessFileDateTime PROC
	LOCAL whenCreated:SYSTEMTIME, lastWritten:SYSTEMTIME 

	mov edx, OFFSET filename		; open file
	call OpenInputFIle 
	mov fileHandle, eax
	cmp eax, INVALID_HANDLE_VALUE	; check for errros
	jne continue
	mWrite <"Cannot open file",0dh,0ah>
	stc
	jmp quit

continue:
	INVOKE GetFileTime, fileHandle, ADDR whenCreated, NULL, ADDR lastWritten

	mov eax, fileHandle				; close file
	call CloseFile

	; Convert the file created time to local time.
	INVOKE FileTimeToSystemTime, ADDR whenCreated, ESI
	INVOKE FileTimeToSystemTime, ADDR lastWritten, EDI
	INVOKE SystemTimeToTzSpecificLocalTime, NULL, ESI, ESI
	INVOKE SystemTimeToTzSpecificLocalTime, NULL, EDI, EDI
	
quit:
	ret 
AccessFileDateTime ENDP
;-------------------------------------------------------------------------
; This is a help procedure to output the date and time to screen
; Receives: DateTime 
; Returns:  nothing
WriteDateTime PROC, DateTime:SYSTEMTIME
	movzx eax, DateTime.wMonth
	call WriteDec
	mWrite "/"
	movzx eax, DateTime.wDay
	call WriteDec
	mWrite "/"
	movzx eax, DateTime.wYear
	call WriteDec

	mWriteSpace
	movzx eax, DateTime.wHour
	call WriteDec
	mWrite ":"
	movzx eax, DateTime.wMinute
	call WriteDec
	mWrite ":"
	movzx eax, DateTime.wSecond
	call WriteDec
	
	ret
WriteDateTime ENDP

END; mainShowFileTime