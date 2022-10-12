Algoritmo Assembler3
	r16<-b00111100
	DDRB<-r16
	r16<-FF
	PORTB<-r16
	Escribir "Apagado"
	Repetir
		r16<-b11111011
		PORTB<-r16
		Escribir "Encendido 1"
		
		r16<-b11110011
		PORTB<-r16
		Escribir "Encendido 2"
		
		r16<-b11100011
		PORTB<-r16
		Escribir "Encendido 3"
		
		r16<-b11000011
		PORTB<-r16
		Escribir "Encendido 4"
		
		r16<-b11111111
		PORTB<-r16
		Escribir "Apagados"
		Hasta Que 2<1
FinAlgoritmo

	