
$include(AT89S53.inc)

;main2:
;	call serinit
;	mov a,#55h
;	call serout
;	jnb ti,$
;	jmp main2

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
serinit:         
        MOV     TMOD, #20H   ; [GATE|C/T_|M1|M0|GATE|C/T_|M1|M0] #00100000B
        MOV     SCON, #52H     ; [SM0|SM1|SM2|REN|TB8|RB8|TI|RI] #01010010B
        MOV     A, PCON     
        SETB    ACC.7
        MOV     PCON, A      ; [SMOD|-|-|-|GF1|GF0|PD|IDL] SMOD=1
        MOV     TH1, #0F3H     ; 4800 baud
        SETB    TR1          
        RET   
	
	
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