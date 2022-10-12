;
; AssemblerApplication8.asm
;
; Created: 1/9/2021 18:40:54
; Author : Administrador
;
.include "./m328Pdef.inc"
.org 0x00 ;aca arranca el programa
; Replace with your application code
setup: ; configuro los puerto y pongo valores incinales
ldi r16,0b00111100; 
out DDRB,r16; configuro el puerto para para que los pines 5 al 2 sean salida
ldi r16,0b11111011; ;
out PORTB,r16;

start: 
	ldi r17,0xFF; cargo valor para delay0
	ldi r18,0xFF; cargo valor para delay1
	ldi r19,0x05; cargo valor para delay2

delay0:
	dec r17
	brne delay0; se queda en delay0 hasta que r17 da cero 
	rjmp delay1; salto a delay1
delay1:
	ldi r17,0xFF;cargo r17 denuevo
	dec r18; decremento r18 y vuelbo a delayo hasta que r18 da cero
	brne delay0; con esto hago loop adidado con delay0
	rjmp delay2;
delay2:
	ldi r17,0xFF;
	ldi r18,0xFF;
	dec r19
	brne delay0; con esto hago loop andidado con delay0 y delay1
	rjmp test	; cuando termino todo el delay me fijo que led estaba prendido
;aca sería ekl codigo para  un led solo parpadeante*/
test:	
	in r16, PORTB
	sbrc r16,2
	rjmp prendo
	rjmp apago
prendo:
	ldi r16,0b11111011; ;
	out PORTB,r16;
	rjmp start
apago:
	ldi r16,0b11111111; ;
	out PORTB,r16;
    rjmp start	 
	




