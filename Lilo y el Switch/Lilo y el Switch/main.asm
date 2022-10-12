;
; Lilo y el Switch.asm
;
; Created: 7/9/2022 21:54:26
; Author : spa20
;


.include "./m328Pdef.inc"
.org 0x00

setup:
	ldi r16,0b00111100
	out DDRB,r16
	ldi r16,0xFF
	out PORTB,r16;
	ldi r17, 0x01

LOOP:

	CPI r17, 0x01
	BREQ CASE1
	
	CPI r17, 0x02
	BREQ CASE2
	
	CPI r17, 0x03
	BREQ CASE3
	
	CPI r17, 0x04
	BREQ CASE4

	DEFAULT:
		ldi r17, 0x01
		ldi r16, 0b11111111
		out PORTB,r16
		RJMP DONE

	CASE1:
		ldi r16,0b11011111;
		out PORTB,r16;
		call retardo
		ldi r17, 0x02
		RJMP DONE

	CASE2:
		ldi r16,0b11101111;
		out PORTB,r16;
		call retardo
		ldi r17, 0x03
		RJMP DONE

	CASE3:
		ldi r16,0b11110111;
		out PORTB,r16;
		call retardo
		ldi r17, 0x04
		RJMP DONE

	CASE4:
		ldi r16,0b11111011;
		out PORTB,r16;
		call retardo
		ldi r17, 0x01
		RJMP DONE

	DONE:
		RJMP LOOP

retardo:	LDI R17,100 
loop3:		LDI R18,250
loop2:		LDI R19,213
loop1:		DEC R19
			BRNE loop1 
			DEC R18
			BRNE loop2
			DEC R17
			BRNE loop3
			RET 