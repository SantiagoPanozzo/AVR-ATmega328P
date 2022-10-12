;
; AssemblerApplication6.asm
;
; Created: 31/8/2021 15:27:54
; Author : Administrador
;
.include "./m328Pdef.inc"
.org 0x00 ;aca arranca el programa
; Replace with your application code
setup: ; configuro los puerto y pongo valores incinales
	ldi r16,0b00111100; 
	out DDRB,r16; configuro el puerto para para que los pines 5 al 2 sean salida
	ldi r16, 0xFF;
	out PORTB,r16;
start:
    ldi r16,0b11110111; 
    out PORTB,r16; prendo el pin 2 del puerto B.
	call retardo;
	ldi r16,0b11111111;
	out PORTB,r16;
	call retardo;
    rjmp start


retardo:	LDI R17,050
loop3:		LDI R18,250
loop2:		LDI R19,213
loop1:		DEC R19
			BRNE loop1
			DEC R18
			BRNE loop2
			DEC R17
			BRNE loop3
			RET