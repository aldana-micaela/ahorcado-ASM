.data
	mapaBase: .asciz "___________________________________________________|\n                                                   |\n     *** EL JUEGO DEL AHORCADO - ORGA 1 ***        |\n___________________________________________________|\n                                                   |\n                                                   |\n          +------------+                           |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n          |                                        |\n +-------------------------------------------+     |\n |                                           |     |\n |                                           |     |\n |                                           |     |\n +-------------------------------------------+     |\n"

	/*Lista de caracteres que se usaron*/
	listaLetrasUsadas: .ascii "Letras usadas: "
	lista: .space 27

	/*GENERACIÓN DE NUMEROS RANDOM*/
	seed: .word 1
	const1: .word 1103515245
	const2: .word 12345
	numero: .word 0
	time: .space 8


	preguntaIniciarJuego: .asciz "\nPresione 1 para comenzar el juego o 0 para salir:\n"
	adivinaLaPalabra: .asciz "\n******************\nADIVINA LA PALABRA\n******************\n"

	/*LAS PALABRAS EN JUEGO*/
	palabra0: .asciz "transistor"
	palabra1: .asciz "binario"
	palabra2: .asciz "organizacion"
	palabra3: .asciz "arquitectura"
	palabra4: .asciz "vonnneumann"
	palabra5: .asciz "georgeboole"
	palabra6: .asciz "assemblerarm"
	palabra7: .asciz "osciloscopio"

	excepcion: .ascii "\nIngrese una letra en minuscula por favor = \n"

	respuestaUsuario: .space 1

	letraAcertada: .ascii "\nBIEEENN!! :)\n"

	mensajePerdiste: .ascii "\n********\nPERDISTE :((\n********\n"
	mensajeGanaste: .ascii "\n********\nGANASTE! :))\n********\n"

	noEsta: .ascii "\nMAAAL!!:( \n"

	letraUsada: .ascii "\nYA USASTE ESTA LETRA, INGRESA OTRA DISTINTA EN MINUSCULA\n"

	contadorNuevaOportunidad: .asciz "1"

	posibilidad: .asciz "\n\nESTAS A PUNTO DE QUEDARTE SIN VIDA, TIENES LA POSIBILIDAD DE AUMENTAR TU VIDA\n"
	posibilidadPreg: .asciz "RESPONDER LA PREGUNTA:\n"
	pregunta: .asciz "\n¿Cuanto es 15(decimal) en binario con 4 bits?\n!!!RESPONDER CON NUMEROS¡¡¡\n"
	felicidades: .asciz "FELICIDADES SE TE HA ASIGNADO UNA VIDA ADICIONAL"

	vidas: .ascii "\nVIDAS: "
	vida2: .ascii "8"

	longitudPalabra: .space 1
	respuestaPregunta: .space 4

	respuestaIncorrecta: .ascii "\nRESPUESTA INCORRECTA\n"
	respuestaCorrecta: .ascii "\nRESPUESTA CORRECTA\n"

	posicionSoga: .ascii "\nPERDISTE, PARA SALVAR AL HUMANO INGRESA LAS COORDENADAS DE LA FILA Y COLUMNA DE LA SOGA\n"
	ingresaPOSx: .ascii "INGRESA LA COORDENADA X DE LA SOGA\n"
	ingresaPOSy: .ascii "\nINGRESA LA COORDENADA Y DE LA SOGA\n"
	respuestaCoordenadaY: .space 1
	respuestaCoordenadaX: .space 2

	salto: .asciz " :D\n\n"
	laPalabraEra: .ascii "LA PALABRA ERA: "
	palabraElegida: .asciz ""

.text

/*SUBRUTINA PARA INGRESAR POR TECLADO UN SOLO CARACTER*/
	entradaUsuario:
			.fnstart
				push {lr}

				mov r7,#3
				mov r0,#0
				mov r2,#1
				ldr r1,=respuestaUsuario
				swi 0

				pop {lr}
				bx lr
			.fnend

/*SUBRUTINA QUE IMPRIME POR CONSOLA "RESPUESTA INCORRECTA"*/
	incorrecta:
		   .fnstart
			    push {lr}

                            mov r7,#4
                            mov r0,#1
                            mov r2,#22
                            ldr r1,=respuestaIncorrecta
                            swi 0

			    pop {lr}
			    bx lr
		   .fnend
/*SUBRUTINA QUE IMPRIME POR CONSOLA "RESPUESTA CORRECTA"*/
	correcta:
		.fnstart
			push {lr}

                        mov r7,#4
                        mov r0,#1
                        mov r2,#20
                        ldr r1,=respuestaCorrecta
                        swi 0

			pop {lr}
			bx lr
		.fnend


/*SUBRUTINA PARA INGRESAR LA RESPUESTA DE LA PREGUNTA APROXIMATIVA*/
	entradaPreguntaAproximativa:
					.fnstart
						 push {lr}

		                                 mov r7,#3
                		                 mov r0,#0
                                	 	 mov r2,#4
                                		 ldr r1,=respuestaPregunta
                               			 swi 0

						 pop {lr}
						 bx lr
					.fnend


/*SUBRUTINA QUE IMPRIME POR CONSOLA EL MAPA*/
	imprimirMapa:
		     .fnstart
				push {lr}

				mov r7,#4
				mov r0,#1
				mov r2,#1104         /*1061*/
				ldr r1,=mapaBase
				swi 0

				pop {lr}
				bx lr
		     .fnend

/*SUBRUTINA QUE VA MOSTRANDO POR CONSOLA LA CANTIDAD DE VIDA QUE TIENE EL JUGADOR*/
	contadorVidas:
			.fnstart
				push {lr}

				mov r7,#4
                                mov r0,#1
                                mov r2,#9
                                ldr r1,=vidas
                                swi 0

				pop {lr}
				bx lr
			.fnend

/*SUBRUTINA QUE IMPRIME POR CONSOLA QUE SE INGRESE UNA LETRA EN MINUSCULA Y TAMBIEN
	INDICA LA CANTIDAD DE VIDAS DEL JUGADOR*/
	ingresarPalabraMinuscula:
				.fnstart
					push {lr}

					mov r7,#4
					mov r0,#1
					mov r2,#45
					ldr r1,=excepcion
					swi 0

					pop {lr}
					bx lr
				.fnend

/*CUANDO SE PIERDE EN EL JUEGO, ESTA SUBRUTINA SE ENCARGA DE IMPRIMIR POR CONSOLA
	LOS MENSAJES DE QUE EL JUGADOR PERDIÓ Y QUE SE TERMINO EL JUEGO. TAMBIEN IMPRIME
	LA PALABRA.
*/
        imprimirMensajesPerdiste:
                                .fnstart
                                        push {lr}

                                        mov r7, #4
                                        mov r0, #1
                                        mov r2, #32
                                        ldr r1, =mensajePerdiste
                                        swi 0

                                        mov r7, #4
                                        mov r0, #1
                                        mov r2, #28
                                        ldr r1, =laPalabraEra
                                        swi 0

                                        mov r7, #4
                                        mov r0, #1
                                        mov r2, #5
                                        ldr r1, =salto
                                        swi 0

                                        pop {lr}
                                        bx lr
                                .fnend

/*LIMPIA EL MAPA UNA VEZ GANAND EL JUEGO*/
	limpiarMapaGanaste:

		.fnstart
                        push {lr}

       			ldr r10, =mapaBase
       			add r10, #100
        		add r10, #100
       			add r10, #194

       			mov r0, #0x20

    			strb r0,[r10]

     			add r10, #53
        		strb r0,[r10]

       			add r10, #53
        		strb r0,[r10]

       			add r10, #53
      			strb r0,[r10]

		        sub r10, #54
		        strb r0, [r10]

        		add r10, #2
        		strb r0, [r10]

        		add r10, #104
        		strb r0, [r10]

        		add r10, #2
        		strb r0, [r10]

			pop {lr}
			bx lr
                .fnend

/* toma la posiscion de la primera letra donde se esta formando la palabra. 
r5 guarda la direccion del dato que tiene el length de palabraElegida y r3 trae el contenido*/

        arroba:
                .fnstart
                        push {lr}

                        ldr r4, =mapaBase
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #100
                        add r4, #109

                        ldr r5, =longitudPalabra
                        ldrb r3, [r5]

                        mov r6, #0x40 	/*caracter guion bajo*/

                        pop {lr}
                        bx lr

                .fnend



.global main

        myrand:
		.fnstart
			 push {lr}
			 ldr r1, =seed
			 ldr r0, [ r1 ]
			 ldr r2, =const1
			 ldr r2, [ r2 ]
			 mul r3, r0, r2
			 ldr r0, =const2
			 ldr r0, [ r0 ]
			 add r0, r0, r3
			 str r0, [ r1 ]
		/* Estas dos lí neas
			devuelven "seed > >16 & 0x7fff ". Con un peque ño truco evitamos el uso del AND */
                	LSL r0, # 1
			LSR r0, # 17
			pop {lr}
			bx lr
        	.fnend

	mysrand:
		.fnstart
			push {lr}
			ldr r1, =seed
			str r0, [ r1 ]
			pop {lr}
			bx lr
        	.fnend

 	main:
	/* Llamamos a mysrand con parámetro 42 */
		mov r0, # 42    // se puede cambiar el valor
		bl mysrand     //se usa una sola vez al principio del programa

		bucle:
			bl myrand
       	 		mov r4,r0
			bl myrand
			mov r5,r0

			ldr r0,=time
			mov r7, #78
			swi 0
			ldr r0,=time
			ldr r9, [r0] //epoch https://www.epochconverter.com/
			add r0, #4
			ldr r10, [r0] //ms o ns?
			mov r0, #7
			and r10, r10, r0
	/*SE LIMPIAN TODOS LOS REGISTROS USADOS, MENOS EL r10 QUE TIENE EL NUMERO RANDOM*/
			eor r0,r0
			eor r1,r1
			eor r2,r2
			eor r3,r3
			eor r4,r4
			eor r5,r5
			eor r7,r7
			eor r9,r9

	/*IMPRIME POR CONSOLA PARA INICIAR EL JUEGO*/
			mov r7,#4
			mov r0,#1
			mov r2,#51
			ldr r1,=preguntaIniciarJuego
			swi 0


			bal ingresar



	/*LA SUBRUTINA <entradaUsuario> INGRESA POR TECLADO UN SOLO CARACTER.

	LAS SIGUIENTES LINEAS VERIFICAN LA RESPUESTA QUE INGRESÓ EL USUARIO
		1 = INICIO DEL JUEGO, SE CARGAN LAS PALABRAS.
		0 = SALIR DEL JUEGO.

		SI SE INGRESA ALGO DIFERENTE DE 0 O 1, EL USUARIO VUELVE A INGRESAR

		r0 = se carga el contenido de <respuestaUsuario>.
	*/
	ingresar:
			bl entradaUsuario

			ldrb r0,[r1]

			cmp r0,#0x30
			beq fin

			cmp r0,#0x31
			beq inicioJuego

			bal ingresar

/*LAS SIGUIENTES LINEAS VERIFICAN QUE NUMERO SE ELIGIÓ EN EL RAMDOM DE 0-7
	CADA NUMERO TIENE ASIGNADA UNA PALABRA*/
	inicioJuego:
	            mov r7,#4
                    mov r0,#1
                    mov r2,#58
                    ldr r1,=adivinaLaPalabra
                    swi 0

		    cmp r10, #0
		    beq palabraCero

		    cmp r10,#1
		    beq palabraUno

		    cmp r10,#2
		    beq palabraDos

		    cmp r10, #3
		    beq palabraTres

		    cmp r10, #4
		    beq palabraCuatro

		    cmp r10, #5
		    beq palabraCinco

		    cmp r10, #6
		    beq palabraSeis

		    cmp r10, #7
		    beq palabraSiete

/*EL REGISTRO r12 CONTIENE EL LENGHT DE LA PALABRA ELEGIDA*/
	ciclo:
		ldrb r3,[r2]

		cmp r3,#0x0
		beq imprimirGuiones

		strb r3,[r4]
		add r2,#1
		add r4,#1
		add r12,#1

		bal ciclo

/*PARA IMPRIMIR LOS GUIONES DE LA PALABRA, PRIMERO SE TIENE QUE SABER LA LONGITUD DE LA PALABRA QUE SE ESTA JUGANDO.
	UNA VEZ OBTENIDO EL LENGHT, SE HACE UN CICLO <cicloGuiones> PARA CARGAR EN MEMORIA LA CANTIDAD DE RENGLONES,
	EN DETERMINADA POSICION DEL MAPA.
*/
	imprimirGuiones:

			ldr r9, =mapaBase
			add r9, #100
			add r9, #100
                        add r9, #100
                        add r9, #100
                        add r9, #100
                        add r9, #100
                        add r9, #100
                        add r9, #100
			add r9, #109

			ldr r8, =longitudPalabra
			strb r12, [r8]

			mov r10, #0x5f
			mov r11, r12
			bal cicloGuiones


	cicloGuiones:

			cmp r11, #0
			beq mapaImprimir

			strb r10, [r9]
			add r9, #2
			sub r11, #1

			bal cicloGuiones

/*LAS ETIQUETAS:
		<palabraCero>,<palabraUno>,<palabraDos>
		<palabraTres>,<PalabraCuatro>,<palabraCinco>
		<palabraSeis>,<palabraSiete>
DEPENDIENDO DEL NUMERO ENTERO QUE ELIGIÓ EL RANDOM,SE COMPIARA
TODO EL CONTENIDO DE LA PALABRA ASIGNADA A UNA ETIQUETA NUEVA.

	r2 = direccion de la palabra asignada al número random.
	r4 = direccion de la etiqueta donde se va a copiar la palabra.
	r12 = longitud de la palabra asignada.
*/

	palabraCero:
		    ldr r2,=palabra0
		    ldr r4,=palabraElegida
		    mov r12,#0
		    bal ciclo


	palabraUno:
                    ldr r2,=palabra1
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

	palabraDos:
                    ldr r2,=palabra2
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

	palabraTres:
                    ldr r2,=palabra3
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

	palabraCuatro:
                    ldr r2,=palabra4
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

	palabraCinco:
                    ldr r2,=palabra5
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo


	palabraSeis:
                    ldr r2,=palabra6
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

	palabraSiete:
                    ldr r2,=palabra7
                    ldr r4,=palabraElegida
                    mov r12,#0
                    bal ciclo

/*DIRIGE A LAS SUBRUTINAS PARA INGRESAR UNA LETRA EN MINUSCULA E IMPRIME EL MAPA
	LUEGO COMPRUEBA SI LA LETRA INGRESADA PERNETECE A LA PALABRA ELEGIDA
*/
	mapaImprimir:
	       bl imprimirMapa
	       bal salidaIngresarLetra

/*ESTA ETIQUETA ES LA ENCARGADA DE CUMPLIR LA FUNCION PARA SABER SI EL JUGADOR GANÓ Y TAMBIEN PARA INGRESAR POR TECLADO
	UN SOLO CARACTER.
	<salidaIngresarLetra> & <ingresarPorTeclado>.
*/
	salidaIngresarLetra:
			    cmp r12,#0
			    beq ganaste

			    bl contadorVidas

     	       		    bl ingresarPalabraMinuscula
			    bal ingresarPorTeclado

	ingresarPorTeclado:
  	       		    bl entradaUsuario
	                    bal comprobarLetra

/*VERIFICA SI LA LETRA QUE INGRESÓ EL JUGADOR PERTENECE AL INTERVALO DE [Ox61 = a, 0x7a = z]
SI NO PERTENECE INGRESA NUEVAMENTE UNA LETRA.

	r5 = SE CARGA EL CONTENIDO DEL CARACTER QUE SE INGRESÓ POR TECLADO.

	r2 = SE GUARDA LA LISTA EN DONDE SE ALMACENAN LOS CARACTERES USADOS.

	OUTPUT = ETIQUETA QUE VERIFICA SI LA LETRA  YA SE INGRESÓ ANTERIORMENTE.
*/
	comprobarLetra:
			ldrb r5,[r1]

			cmp r5,#0x61
			blt ingresarPorTeclado

			cmp r5,#0x7a
			bgt ingresarPorTeclado

			ldr r8,=lista

			bal verSiYaSeUso

/*
	r3 = SE CARGA EL CONTENIDO DE LA LISTA DE LETRAS.
*/
	verSiYaSeUso:
			ldrb r3,[r8]

			cmp r3,#0x0
			beq juego

			cmp r3,r5
			beq estaLetraYaSeUso

			add r8,#1
			bal verSiYaSeUso

	/*IMPRIME POR CONSOLA QUE LA LETRA YA SE USÓ, SE PIDE QUE INGRESE OTRA LETRA*/
	estaLetraYaSeUso:
			 mov r7,#4
			 mov r0,#1
		         mov r2,#58
			 ldr r1,=letraUsada
			 swi 0

			 bal ingresarPorTeclado

/*EL JUGADOR PUEDE SEGUIR JUGANDO SI LA LETRA QUE SE INGRESÓ NO ESTÁ EN LA LISTA.

INCREMENTO DE 1 BYTE A LA LISTA PARA QUE NO SE PISEN LOS CARACTERES.

	SE LIMPIAN LOS REGISTROS PARA QUE SE PUEDAN VOLVER A USAR.

	SE GUARDA EL CARACTER NUNCA USADO EN LA LISTA DE LETRAS.
*/
	juego:
		eor r3,r3
		eor r1,r1
		eor r7,r7

		ldr r3,=palabraElegida
		ldr r4, =mapaBase
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #100
		add r4, #109

		strb r5,[r8]
		add r8,#1

		bal verSiLaLetraEsta


/*verifica que la letra este dentro de la palabraElegida*/

	verSiLaLetraEsta:
			 ldrb r6,[r3]

			 cmp r6,#0x0
			 beq NOesta

			 cmp r6,r5
			 beq SIesta

			 add r3,#1
			 add r4,#2

			 bal verSiLaLetraEsta

/*lleva la letra acertada a la posiscion del mapa que le corresponde y vuelve a ver si hay mas
	r12 TIENE EL LENGHT DE LA PALABRA EN JUEGO, CUANDO EL JUGADOR ACIERTA LETRAS, SE VA DESCONTANDO
	A LA LONGITUD DE LA CADENA, DE ESTA MANERA SE SABE CUANDO GANA LA PARTIDA
*/
	SIesta:
		strb r5,[r4]

		bl imprimirMapa

	        mov r7,#4
                mov r0,#1
                mov r2,#14
                ldr r1,=letraAcertada
                swi 0

		add r4,#2
		add r3,#1

		sub r12,#1
		bal verSiHayMas

/*CUMPLE LA FUNCION DE VERIFICAR SI HAY MAS DE UNA LETRA ACERTADA EN LA PALABRA
*/
	verSiHayMas:
		    ldrb r6,[r3]

		    cmp r6,#0x0
		    beq salidaIngresarLetra

		    cmp r6,r5
		    beq SIesta

		    add r3,#1
		    add r4,#2
		    bal verSiHayMas

	NOesta:
                bal imprimirPersona

	NOesta2:
		 bl imprimirMapa

		 mov r7,#4
                 mov r0,#1
                 mov r2,#12
                 ldr r1,=noEsta
                 swi 0

		 bal salidaIngresarLetra


/*
ETIQUETA ENCARGADA DE DIRIGIR A LAS RESPECTIVAS ETIQUETAS QUE DIBUJAN AL AHORCADO,
CADA VEZ QUE SE INGRESA UNA LETRA QUE NO PERTENCE A LA PALABRA EN JUEGO.

	TAMBIEN VA CARGANDO EN MEMORIA LA RESTA DE -1 A LA VIDA.
*/
		imprimirPersona:
                                ldr r10, =mapaBase

                                ldr r7,=vida2           /**/

                                add r10, #100
                                add r10, #100
                                add r10, #194

                                mov r0,#0x37            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20                  /*caracter espacio*/
                                beq dibujarSogaPechoPanza


                                add r10, #53

                                mov r0,#0x36            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarCabeza

                                add r10, #53

                                mov r0,#0x35            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarSogaPechoPanza

                                add r10, #53

                                mov r0,#0x34            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarSogaPechoPanza

                                sub r10, #54

                                mov r0,#0x33            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarBrazoIzquierdo

                                add r10, #2

                                mov r0,#0x32            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarBrazoDerecho

                                add r10, #104

                                mov r0,#0x31            /**/
                                strb r0,[r7]

                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarPiernaIzquierda

                                add r10, #2

                                mov r0,#0x30            /**/
                                strb r0,[r7]            /**/
                                ldrb r11, [r10]
                                cmp r11, #0x20
                                beq dibujarPiernaDerecha
/*LAS ETIQUETAS:
	<dibujarSogaPechoPanza>,<dibujarCabeza>,<dibujarBrazoIzquierdo>,
	<dibujarPiernaIzquierda>,<dibujarBrazoDerecho>,<dibujarPiernaDerecha>,

	SE ENCARGAN DE DIBUJAR AL AHORCADO EN EL MAPA.
	RETORNAN EN UNA ETIQUETA QUE INDICA QUE LAPALABRA FUE INCORRECTA Y VUELVE A PEDIRLE AL JUGADOR QUE
	INGRESE UNA NUEVA LETRA.
*/
        dibujarSogaPechoPanza:
                                        mov r0, #0x7c
                                        strb r0, [r10]

                                        bal NOesta2

        dibujarCabeza:
                                        mov r0, #0x4f
                                        strb r0, [r10]

                                        bal NOesta2

        dibujarBrazoIzquierdo:

                                        mov r0, #0x2f
                                        strb r0, [r10]

                                        bal NOesta2

        dibujarPiernaIzquierda:
                                        ldr r6, =contadorNuevaOportunidad
                                        ldrb r2, [r6]

                                        mov r0, #0x2f
                                        strb r0, [r10]

                                        cmp r2, #0x31
                                        beq preguntaAproximativa

                                        bal NOesta2


        dibujarBrazoDerecho:
                                        mov r0, #0x5c
                                        strb r0, [r10]

                                        bal NOesta2

        dibujarPiernaDerecha:
                                        mov r0, #0x5c
                                        strb r0, [r10]
                                        bal perdiste

/*SE INDICA QUE TIENE LA POSIBILIDAD DE AUMENTAR SU VIDA SI RESPONDE UNA PREGUNTA,
	PERO ESTA OPORTUNIDAD NO LA TENDRÁ MAS.
*/
	preguntaAproximativa:
				mov r0,#0x30
				strb r0,[r6]

				bl imprimirMapa
				bl contadorVidas

		                mov r7,#4
        		        mov r0,#1
	                        mov r2,#184
                 		ldr r1,=posibilidad
                 		swi 0

				bl entradaPreguntaAproximativa


/*COMO LA RESPUESTA CORRECTA DE LA PREGUNTA APROXIMATIVA ES DE 4 CARACTERES, 
	PARA SABER SI SE RESPONDIÓ BIEN, SE CONTROLA CARACTER POR CARACTER,
	ENTONCES LAS ETIQUETAS:
				<comprobarOportunidad>,<comprobarOportunidad1>
				<comprobarOportunidad2>,<comprobarOportunidad3>

	VERIFICAN SI LA RESPUESTA INGRESADA ES CORRECTA,
	SI FUE INCORRECTA, NO SE LE AUMENTA UNA VIDA.
*/
        comprobarOportunidad:

                                ldrb r11, [r1]

                                cmp r11, #0x30
                                blt entradaPreguntaAproximativa

                                cmp r11, #0x39
                                bgt entradaPreguntaAproximativa

                                cmp r11, #0x31
                                beq comprobarOportunidad1

                                bl incorrecta

                                bal salidaIngresarLetra

        comprobarOportunidad1:

                                        ldr r1, =respuestaPregunta
                                        add r1, #1
                                        ldrb r11, [r1]

                                        cmp r11, #0x31
                                        beq comprobarOportunidad2

                                        bl incorrecta

                                        bal salidaIngresarLetra


          comprobarOportunidad2:

                                        ldr r1, =respuestaPregunta

                                        add r1, #2
                                        ldrb r11, [r1]

                                        cmp r11, #0x31
                                        beq comprobarOportunidad3

					bl incorrecta

                                        bal salidaIngresarLetra


         comprobarOportunidad3:

                                        ldr r1, =respuestaPregunta

                                        add r1, #3
                                        ldrb r11, [r1]

                                        cmp r11, #0x31
                                        beq aumentarVida

					bl incorrecta

                                        bal salidaIngresarLetra

/*ETIQUETA ENCARGADA DE AUMENTARLE LA VIDA AL JUGADOR*/
	aumentarVida:
			mov r2,#0x32
			ldr r7,=vida2

			strb r2,[r7]

			mov r2,#0x20
			strb r2,[r10]

			bl imprimirMapa

			bl correcta

			bal salidaIngresarLetra

/*SI EL JUGADOR SE QUEDÓ SIN VIDAS, SE LE INDICA QUE DIGA LAS RESPECTIVAS COORDENADAS DE LA SOGA
PARA SALVAR AL AHORCADO
*/
	perdiste:
		 bl imprimirMapa

                 mov r7,#4
                 mov r0,#1
                 mov r2,#88
                 ldr r1,=posicionSoga
                 swi 0

	         mov r7,#4
                 mov r0,#1
                 mov r2,#37
                 ldr r1,=ingresaPOSy
                 swi 0

		bal entradaCoordenadaY

/*EL JUGADOR INGRESA LA COORDENADA DE LA SOGA EN EL EJE Y
*/
	entradaCoordenadaY:

	  		  bl entradaUsuario
			  bal comprobacionCoordenadaY

/* comprueba que la entrada sea un numero y si es la respuesta correcta a la coordenada Y salta a salidaCoordenadaX
y si no es el correcto pierde el juego*/

      comprobacionCoordenadaY:

                                        ldrb r11, [r1]

                                        cmp r11, #0x30
                                        blt entradaCoordenadaY

                                        cmp r11, #0x39
                                        bgt entradaCoordenadaY

                                        cmp r11, #0x36
                                        beq salidaCoordenadaX

					bl arroba
					bal cicloArroba1
/*es una salida que nos indica que debemos ingresar la coordenada X*/
        salidaCoordenadaX:

                               	   bl correcta

                                   mov r7, #4
                                   mov r0, #1
                                   mov r2, #35
                                   ldr r1, =ingresaPOSx
                                   swi 0

                                   bal entradaCoordenadaX

/*entrada de coordenada x para ingresar 2 caracteres*/
        entradaCoordenadaX:

                                   mov r7, #3
                                   mov r0, #0
                                   mov r2, #2
                                   ldr r1, =respuestaCoordenadaX
                                   swi 0

                                   bal comprobacionCoordenadaX

/* LAS ETIQUETAS:
			<comprobacionCoordenadaX>, <segundaComprobacion>

comprueban caracter por caracter de la coordenada X sea correcta*/


        comprobacionCoordenadaX:
                                        ldrb r11, [r1]

                                        cmp r11, #0x30
                                        blt entradaCoordenadaX

                                        cmp r11, #0x39
                                        bgt entradaCoordenadaX

                                        cmp r11, #0x32
                                        beq segundaComprobacionX

					bl arroba
					bal cicloArroba1

	segundaComprobacionX:

                                        add r1, #1
                                        ldrb r11, [r1]

                                        cmp r11, #0x34
                                        beq ganaste

					bl arroba

					bal cicloArroba1



/*CUANDO SE PIERDE EL JUEGO, SI QUEDARON LETRAS SIN ADIVINAR, ESTAS MISMAS
	SE REEMPLAZARAN POR CARACTERES ARROBA

	LAS ETIQUEAS:
			,<cicloArroba1>,<reemplazarCaracter1>, <cicloArroba2>,<reemplazarCaracter2>
	HACEN DICHA TAREA.
*/

	cicloArroba1:
			ldrb r1, [r4]

			cmp r3, #0x0
			beq finalizacion

			cmp r1, #0x5f
			beq reemplazarCaracter1

			add r4, #2
			sub r3, #1
			bal cicloArroba1

	reemplazarCaracter1:

			strb r6, [r4]
			add r4, #2
			sub r3, #1

			bal cicloArroba1

        cicloArroba2:
                        ldrb r1, [r4]

                        cmp r3, #0x0
                        beq ganasteFinal

                        cmp r1, #0x5f
                        beq reemplazarCaracter2

                        add r4, #2
                        sub r3, #1
                        bal cicloArroba2

        reemplazarCaracter2:

                        strb r6, [r4]
                        add r4, #2
                        sub r3, #1

                        bal cicloArroba2

/*   LA ETIQUETA:
                        ,<finalizacion>
        /*imprime los mensajes de que el jugador ya perdio el juego y termina el programa
*/


	finalizacion:

					bl imprimirMapa
                                        bl incorrecta
					bl imprimirMensajesPerdiste
					bal fin

/*   LA ETIQUETA:
                        ,<ganaste>
        /*si gano limpia los caracteres del ahorcado que se escribieron en el juego y hace el ciclo para verificar si hay guiones vacios
*/


	ganaste:
		bl limpiarMapaGanaste
		bl arroba
		bal cicloArroba2

/*   LA ETIQUETA:
                        ,<ganasteFinal>
        /*el jugador ya gano y se dibuja la persona en el piso y imprime el mapa y todos los mensajes de que el jugador ya gano
*/



	ganasteFinal:
		ldr r1,=mapaBase
		add r1,#100
		add r1,#100
		add r1,#100
		add r1,#100
		add r1,#100
		add r1,#159

		mov r0,#0x4f
		strb r0,[r1]

		add r1,#52
	        mov r0,#0x5c
                strb r0,[r1]

                add r1,#1
                mov r0,#0x7c
                strb r0,[r1]

	        add r1,#1
                mov r0,#0x2f
                strb r0,[r1]

		add r1,#52
                mov r0,#0x7c
                strb r0,[r1]

		add r1,#52
                mov r0,#0x2f
                strb r0,[r1]

                add r1,#2
                mov r0,#0x5c
                strb r0,[r1]

		bl imprimirMapa

		mov r7,#4
                mov r0,#1
                mov r2,#14
                ldr r1,=letraAcertada
                swi 0

		mov r7,#4
                mov r0,#1
                mov r2,#32
                ldr r1,=mensajeGanaste
                swi 0

	        mov r7, #4
                mov r0, #1
                mov r2, #28
                ldr r1, =laPalabraEra
                swi 0


		mov r7,#4
                mov r0,#1
                mov r2,#5
                ldr r1,=salto
                swi 0

		bal fin

	fin:
		mov r7,#1
		swi 0




