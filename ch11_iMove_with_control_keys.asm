;DrawChar PROC charToWrite:BYTE, x:BYTE, y:BYTE, clr:BYTE
; Draws a character at a given position. 
; Receives: charToWrite - the character used to represent
;           x, y - position at coordinate x, y (Col, Row)
;           clr - the color used to draw char

;DrawRectangle PROC
; Draws a boarder rectangle from MinX, MinY to MaxX MaxY. 
; Receives: Conctant symbils: MinX, MinY to MaxX MaxY

;ToggleHelp PROC
; Turns on/off the help text when F1 pressed

;ProcessKey PROC
; By reading a char, checks its scan code to recognize 
; Arrow, Control Arrow, Home, ESC, and F1 keys. Then take 
; the action accordingly
; Return: carry flage set if ESC pressed, else cleared


;INVOKE DrawChar, chToMove, dl, dh, clrToHide    ; previous 'I' at dx
;INVOKE DrawChar, chToMove, bl, bh, clrToShow    ; current  'I' at bx
END;