;
; ParpadearLuz.asm
;
; Created: 16/9/2022 22:09:50
; Author : spa20
;


; Replace with your application code
setup:
	ldi r16,0b00111100
	out DDRB,r16
	ldi r16,0xFF
	out PORTB,r16

start:
	ldi r16,0b00111100
	out PORTB,r16
	call retardo1

	ldi r16,0b00011100
	out PORTB,r16
	call retardo2

	rjmp start

retardo1:
	          ldi  R17, $29
	WGLOOP0:  ldi  R18, $47
	WGLOOP1:  ldi  R19, $E4
	WGLOOP2:  dec  R19
			  brne WGLOOP2
			  dec  R18
			  brne WGLOOP1
			  dec  R17
			  brne WGLOOP0
			  ldi  R17, $05
	WGLOOP3:  dec  R17
			  brne WGLOOP3
			  nop
			  nop

retardo2:
	           ldi  R17, $29
	WGLOOP10:  ldi  R18, $47
	WGLOOP11:  ldi  R19, $E4
	WGLOOP12:  dec  R19
			   brne WGLOOP12
			   dec  R18
			   brne WGLOOP11
			   dec  R17
			   brne WGLOOP0
			   ldi  R17, $05
	WGLOOP13:  dec  R17
			   brne WGLOOP13
			   nop