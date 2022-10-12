;
; estructuraGralASM.asm
;
; Created: 31/8/2022 19:57:47
; Author : spa20
;

.org 0

CONFIG: ; etiqueta de salto
	ldi R16, x00 ; x identifica HEXA, b identifica binario (ej.: b00000000), y sin prefijo es decimal (ej.: 0)
		   ; b00000000
		   ; 0
	out DDRB, R16; Data Direction Registry (podemos configurar la direccion de datos del registro, es decir cuales son las entradas y las salidas): un 0 significa input y un 1 output

MAIN:
	; codigo a utilizar
	rjmp main


; Replace with your application code
start:
    inc r16
    rjmp start
