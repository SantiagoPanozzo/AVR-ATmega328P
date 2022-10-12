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

start: ; loop principal, tiempo de ejecucion: 12/16000000s (0,00000075 segundos)
    ldi r16,0b11111011; 
    out PORTB,r16;
	
	ldi r16,0b11110011;
	out PORTB,r16;

	ldi r16,0b11100011;
	out PORTB,r16;
	
	ldi r16,0b11000011;
	out PORTB,r16;

	ldi r16,0b11111111; 1 ciclo
	out PORTB,r16; 1 ciclo

    rjmp start; 2 ciclos


; Al ejecutar paso a paso podemos ver los leds encendiéndose y apagándose a pesar de que
; normalmente sea demasiado rápido el cambio como para apreciarlo.

; Viendo el I/O Viewer podemos ver como cambian los valores en el puerto B a medida que
; van siendo escritos en el mismo.