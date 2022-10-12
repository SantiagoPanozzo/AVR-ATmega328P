Funcion Retardo()
	r17<-50
	r18<-250
	r19<-213
	Repetir 
		r19 <- r19-1
	Hasta Que r19=0
	Repetir
		r18 <- r18-1
	Hasta Que r18=0
	Repetir
		r17 <- r17-1
	Hasta Que r17=0
	
Fin Funcion

Algoritmo ej2assembler

	r16<-b00111100
	DDRB<-r16
	r16<-FF
	PORTB<-r16
	Escribir "Apagado"
	
	Repetir
		r16<-b11110111
		PORTB<-R16
		Escribir "Encendido"
		Retardo()
		
		r16<-b11111111
		PORTB<-r16
		Escribir "Apagado"
		
		Retardo()
	Hasta Que 2<1

FinAlgoritmo


