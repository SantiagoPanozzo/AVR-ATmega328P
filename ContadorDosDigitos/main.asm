;
; Menejo de display;
; Created: 29/9/2021 19:12:24
; Author: Microprocesadores
; En este programa vamos a poner el número 0 en dígito display de más a la derecha


; acá empieza el programa
start:
;configuro los puertos:
;	PB2 PB3 PB4 PB5	- son los LEDs del shield
;	PB0 es SD (serial data) para el display 7seg
;	PD7 es SCLK, el reloj de los shift registers del display 7seg
;	PD4 es LCH, transfiere los datos que ya ingresaron en serie, a la salida del registro paralelo 
;   PC son entradas para los botones
    ldi		r16,	0b00111101	
	out		DDRB,	r16			;4 LEDs del shield son salidas
	out		PORTB,	r16			;apago los LEDs
	ldi		r16,	0b00000000	
	out		DDRC,	r16			;3 botones del shield son entradas
	ldi		r16,	0b10010000
	out		DDRD,	r16			;configuro PD.4 y PD.7 como salidas
	cbi		PORTD,	7			;PD.7 a 0, es el reloj serial, inicializo a 0
	cbi		PORTD,	4			;PD.4 a 0, es el reloj del latch, inicializo a 0

apagar:		; apaga todo el display de 7 segmentos
	ldi r16,0b11111111
	ldi r17,0b11110000
	call sacanum
	
;-------------------------------------------------------------------------------------
; Observar la rutina sacanum, utiliza r16 para los LEDs del numero que quiero mostar, r17 para indicar dónde lo quiero mostrar
; En main: cargo en r16 los leds a encender para formar el '0', y en r17 indico es el primero de los 4 dígitos. 
; Luego se llama la rutina de sacar la iformación serial.
;
; En el ejemplo para ver el numero 0, r16 debe ser 0b00000011 (orden de segmentos es abcdefgh, h es el punto)
; y r17 debe ser 0b00010000 (dígito display de más a la derecha)

decenas:
	; 0
	ldi r27, 0b00000011
	call unidades

	; 1
	ldi r27, 0b10011111
	call unidades

	; 2
	ldi r27, 0b00100101
	call unidades

	; 3
	ldi r27, 0b00001101
	call unidades

	; 4
	ldi r27, 0b10011001
	call unidades
	
	; 5
	ldi r27, 0b01001001
	call unidades

	; 6
	ldi r27, 0b01000001
	call unidades

	; 7
	ldi r27, 0b00011111
	call unidades

	; 8
	ldi r27, 0b00000001
	call unidades

	; 9
	ldi r27, 0b00001001
	call unidades

	rjmp decenas


unidades:
	; 0
	ldi r28, 0b00000011
	call segundear

	; 1
	ldi r28, 0b10011111
	call segundear

	; 2
	ldi r28, 0b00100101
	call segundear

	; 3
	ldi r28, 0b00001101
	call segundear

	; 4
	ldi r28, 0b10011001
	call segundear

	; 5
	ldi r28, 0b01001001
	call segundear

	; 6
	ldi r28, 0b01000001
	call segundear

	; 7
	ldi r28, 0b00011111
	call segundear

	; 8
	ldi r28, 0b00000001
	call segundear

	; 9
	ldi r28, 0b00001001
	call segundear

	ret

segundear:
	ldi r25, 120
	segloop:
	mov r16,r28
	mov r19,r27
		call maindos
		call frame
		call maintre
		call frame
		dec r25
		brne segloop
	ret
	

maindos:
	ldi r17,0b00010000
	call sacanum
	ret

maintre:
	ldi r17,0b00100000
	call sacanum2
	ret

;-------------------------------------------------------------------------------------
; La rutina sacanum, envía lo que hay en r16 y r17 al display de 7 segmentos
; r16 - contiene los LEDs a prender/apagar 0 - prende, 1 - apaga
; r17 - contiene el dígito: r17 = 1000xxxx 0100xxxx 0010xxxx 0001xxxx del dígito menos al más significativo.

sacanum: 
	call	dato_serie
	mov		r16, r17
	call	dato_serie
	sbi		PORTD, 4		;PD.4 a 1, es LCH el reloj del latch
	cbi		PORTD, 4		;PD.4 a 0, 
	ret
	;Voy a sacar un byte por el 7seg

dato_serie:
	ldi		r18, 0x08 ; lo utilizo para contar 8 (8 bits)

loop_dato1:
	cbi		PORTD, 7		;SCLK = 0 reloj en 0
	lsr		r16				;roto a la derecha r16 y el bit 0 se pone en el C
	brcs	loop_dato2		;salta si C=1
	cbi		PORTB, 0		;SD = 0 escribo un 0 
	rjmp	loop_dato3

loop_dato2:
	sbi		PORTB, 0		;SD = 1 escribo un 1

loop_dato3:
	sbi		PORTD, 7		;SCLK = 1 reloj en 1
	dec		r18
	brne	loop_dato1; cuando r17 llega a 0 corta y vuelve
	ret
  

; --------------------------------------------------------------
; sacanum2

sacanum2: 
	call	dato_serie2
	mov		r19, r17
	call	dato_serie2
	sbi		PORTD, 4		;PD.4 a 1, es LCH el reloj del latch
	cbi		PORTD, 4		;PD.4 a 0, 
	ret
	;Voy a sacar un byte por el 7seg

dato_serie2:
	ldi		r18, 0x08 ; lo utilizo para contar 8 (8 bits)

loop_dato12:
	cbi		PORTD, 7		;SCLK = 0 reloj en 0
	lsr		r19			;roto a la derecha r19 y el bit 0 se pone en el C
	brcs	loop_dato22		;salta si C=1
	cbi		PORTB, 0		;SD = 0 escribo un 0 
	rjmp	loop_dato32

loop_dato22:
	sbi		PORTB, 0		;SD = 1 escribo un 1

loop_dato32:
	sbi		PORTD, 7		;SCLK = 1 reloj en 1
	dec		r18
	brne	loop_dato12; cuando r17 llega a 0 corta y vuelve
	ret


frame:
	; ============================= 
	;    delay loop generator 
	;     66666 cycles:
	; ----------------------------- 
	; delaying 66660 cycles:
			  ldi  R29, $65
	WGLOOP0:  ldi  R30, $DB
	WGLOOP1:  dec  R30
			  brne WGLOOP1
			  dec  R29
			  brne WGLOOP0
	; ----------------------------- 
	; delaying 6 cycles:
			  ldi  R29, $02
	WGLOOP2:  dec  R29
			  brne WGLOOP2
	; ============================= 
	ret


