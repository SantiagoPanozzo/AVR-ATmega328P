;
; encendidoLED.asm
;
; Created: 24/8/2022 20:57:25
; Author : spa20
;

.include "./m328Pdef.inc"
.org 0x00
; Replace with your application code
setup:
	ldi r16,0b00111100; establece el numero binario al registro 16
	out DDRB,r16; transfiere lo que esta en el registro 16 al DDRB que es el registro del puerto B (los bits que son 0 son entrada y los 1 salida) los puertos son entrada entrada salida salida salida...
	; el led D1 es BB2 (el tercer digito del binario dos lineas arriba), D2 es BB3, ...
	ldi r16,0xFF; valor FF, que es 11111111, todos encendidos
	out PORTB,r16; transferimos eso directamente al puerto B
start:

    ldi r16,0b11000011;
	out PORTB,r16;
	call retardo

	ldi r16,0b11000111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11001111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11011111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11111111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11011111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11001111;
	out PORTB,r16;
	call retardo

	ldi r16,0b11000111;
	out PORTB,r16;
	call retardo

    rjmp start

retardo:	LDI R17,050
loop3:		LDI R18,250
loop2:		LDI R19,213
loop1:		DEC R19
			BRNE loop1; compara si es 0, si es cero continua el codigo
			DEC R18
			BRNE loop2
			DEC R17
			BRNE loop3
			RET

			; 1MHz entonces 1/16000, por lo que cada instruccion tarda 0,0000000625

