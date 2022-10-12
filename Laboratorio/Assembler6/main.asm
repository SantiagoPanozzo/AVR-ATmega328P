.include "./m328Pdef.inc"
.org 0x00 ;aca arranca el programa
; Replace with your application code
setup: ; configuro los puerto y pongo valores incinales
ldi r16,0b00111100; 
out DDRB,r16; configuro el puerto para para que los pines 5 al 2 sean salida
ldi r16,0b11111011; ;
out PORTB,r16; 

prendo:
	ldi r16,0b11111011; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11110011; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11100011; ;
	out PORTB,r16;
	call retardo2

	ldi r16,0b11100111; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11000111; ;
	out PORTB,r16;
	call retardo2

	ldi r16,0b11001111; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11011111; ;
	out PORTB,r16;
	call retardo1

	
	ldi r16,0b11001111; ;
	out PORTB,r16;
	call retardo1


	ldi r16,0b11000111; ;
	out PORTB,r16;
	call retardo2

	ldi r16,0b11100111; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11100011; ;
	out PORTB,r16;
	call retardo2

	ldi r16,0b11110011; ;
	out PORTB,r16;
	call retardo1

	ldi r16,0b11111011; ;
	out PORTB,r16;
	call retardo1
	rjmp prendo

retardo1:

          ldi  R29, 35
WGLOOP0:  ldi  R30, 50
WGLOOP1:  ldi  R31, 212
WGLOOP2:  dec  R31
          brne WGLOOP2
          dec  R30
          brne WGLOOP1
          dec  R29
          brne WGLOOP0

		  RET
retardo2:

          ldi  R29, 15
WGLOOP10:  ldi  R30, 50
WGLOOP11:  ldi  R31, 212
WGLOOP12:  dec  R31
          brne WGLOOP2
          dec  R30
          brne WGLOOP1
          dec  R29
          brne WGLOOP0

		  RET