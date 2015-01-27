
$include(AT89S53.inc)

main:
	call serinit
	mov a,#'H'
	call serout 
	mov a,#'e'
	call serout 
	mov a,#'l'
	call serout 
	mov a,#'l'
	call serout 
	mov a,#'o'
	call serout 
	mov a,#' '
	call serout 
	mov a,#'W'
	call serout 
	mov a,#'o'
	call serout 
	mov a,#'r'
	call serout 
	mov a,#'l'
	call serout 
	mov a,#'d'
	call serout 
	mov a,#'!'
	call serout 
	jnb ti,$
	jmp main


;initializes serial interface with a
; 9600 BAUD, 8 databits, 1 stopbit and no paritybit
serinit:  
	mov srelh,#0FFh   	; baud-rate counter high-byte
	mov srell,#0D9h   	; baud-rate counter low-byte
	orl pcon,#10000000b ;Setze SMOD-Bit im Register PCON
						;(verdoppelt Baud-Rate). 
	setb bd     		;sets BD-bit ir register ADCON0
						;(Baud rate generator enable). 
	mov scon,#01010010b ;sets bits in register SCON
						;(from left to right): 
						 ;SM0=0, SM1=1, SM2=0:
						   ;  serial mode 1, as 8-bit-UART
						   ;  with variable baud-rate,
						   ;  with a start and a stopbit
						 ;REN=1: Receiver enable.
						 ;TB8=0: not used (only needed in modes 2 and 3)
						 ;RB8=0: not used (only needed in modes 2 and 3)
						 ;TI=1: Transmitter-Interrupt-Flag.
						 ;RI=0: Receiver-Interrupt-Flag. 
	
	ret 	
	
	
serin:
	jnb ri, $   ; Warte auf Eingabe 
	clr ri ; Lösche das Eingabe-Flag
	mov a,sbuf  ; Lesen des Eingabezeichen aus dem Buffer 
	ret 	
	
serout:
	jnb ti,$
	clr ti
	mov sbuf,a
	ret
	
end