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
ldi r20, 0x01		;Comparador
ldi r21, 0x00		;Comparador primera iteración
ldi r22, 0x01		;Comparador siguientes iteraciones

start:
	rjmp test	;2c


delayFirstIteration:
; delaying 7999962 cycles:
          ldi  R17, $6B
WGLOOP0:  ldi  R18, $75
WGLOOP1:  ldi  R19, $D4
WGLOOP2:  dec  R19
          brne WGLOOP2
          dec  R18
          brne WGLOOP1
          dec  R17
          brne WGLOOP0
; delaying 15 cycles:
          ldi  R17, $05
WGLOOP3:  dec  R17
          brne WGLOOP3
; delaying 1 cycle:
          nop
		  ldi r21, 0x01
		  ldi r22, 0x00
		  ret

 

delayThereafter:
; delaying 7999962 cycles:
          ldi  R17, $6B
NWGLOOP0:  ldi  R18, $75
NWGLOOP1:  ldi  R19, $D4
NWGLOOP2:  dec  R19
          brne NWGLOOP2
          dec  R18
          brne NWGLOOP1
          dec  R17
          brne NWGLOOP0

; delaying 15 cycles:
          ldi  R17, $05
NWGLOOP3:  dec  R17
          brne NWGLOOP3

; delaying 2 cycles:
          nop
          nop
		  ret 

test:	
	in r16, PORTB	; 1 ciclo
	sbrc r16,2		; 1 ciclo si es false, 2 si es true
	rjmp prendo		; 2 ciclos
	rjmp apago		; 2 ciclos
prendo:
	cpse r20, r22
	call delayThereafter
	nop
	cpse r20, r21		;2c si son iguales, 1c si no son
	call delayFirstIteration	;4c
	ldi r16,0b11111011;
	out PORTB,r16;
	rjmp start
apago:
	cpse r20, r22
	call delayThereafter
	cpse r20, r21		;2c si son iguales, 1c si no son
	call delayFirstIteration	;4c
	ldi r16,0b11111111;			;
	out PORTB,r16;
    rjmp start	