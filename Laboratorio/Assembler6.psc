algoritmo ASSEMBLER6
	r16<- b00111100
	DDRB<- r16
	r16<-b11111011
	PORTB<-r16
	z<-0

	Repetir //prendo()
		r16<-b11111011
		PORTB<-r16
		escribir "xxxo"
		retardo1
		
		r16<-b11110011
		PORTB<-r16
		escribir "xxoo"
		retardo1
		
		r16<-b11100011
		PORTB<-r16
		Escribir "xooo"
		retardo2
		
		r16<-b11100111
		PORTB<-r16
		Escribir "xoox"
		retardo1
		
		r16<-b11000111
		PORTB<-r16
		Escribir "ooox"
		retardo2
		
		r16<-b11001111
		Escribir "ooxx"
		PORTB<-r16
		retardo1
		
		r16<-b11011111
		PORTB<-r16
		Escribir "oxxx"
		retardo1
		
		r16<-b11001111
		PORTB<-r16
		Escribir "ooxx"
		retardo1
		
		r16<-b11000111
		PORTB<-r16
		escribir "ooox"
		retardo2
		
		r16<-b11100111
		PORTB<-r16
		escribir "xoox"
		retardo1
		
		r16<-b11100011
		PORTB<-r16
		escribir "xooo"
		retardo2
		
		r16<-b11110011
		PORTB<-r16
		escribir "xxoo"
		retardo1
		
		r16<-b11111011
		PORTB<-r16
		escribir "xxxo"
		retardo1
		z=z+1
	Hasta Que z=2
	
FinAlgoritmo

	SubProceso retardo1 ()
		r29<-35
		Repetir
			r30<-50
			Repetir
				r31<-212
				Repetir
					r31<-r31-1
				Hasta Que r31=0
				r30=r30-1
			Hasta Que r30=0
			r29=r29-1
		Hasta Que r29=0
	FinSubProceso


	SubProceso  retardo2 ()
		r29<-15
		Repetir
			r30<-50
			Repetir
				r31<-212
				Repetir
					r31<-r31-1
				Hasta Que r31=0
				r30=r30-1
			Hasta Que r30=0
			r29=r29-1
		Hasta Que r29=0
	FinSubProceso