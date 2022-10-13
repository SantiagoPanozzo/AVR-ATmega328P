# Contador de dos dígitos
## División general del código
El código se divide en las siguientes partes/funciones principales:
* Decenas
* Unidades
* mains
* sacanums
* frame

Las limitaciones del display de 7 segmentos son tales que
* No se puede mostrar más de un número distinto a la vez, lo más cercano es mostrar el mismo número repetido.
* El display no trabaja con datos en paralelo, por lo que debemos enviar el número a mostrar en bits en forma de serie (uno por uno).
* Para controlar cada número vamos a requerir de usar distintos registros que almacenen el número que se va a mostrar, por lo que
todas las funciones que hagamos que dependan de estos registros van a tener que tener una copia por cada dígito a mostrar.

Es por estas limitaciones que las siguientes funciones existen.

### Sacanum
Las funciones que empiezan con "sacanum" son las que se encargan de convertir un byte en varios bits separados a mostrar en un dígito
del display.

Por ejemplo, el byte "00011001" se enviaría tal que 0, 0, 0, 1, 1, 0, 0, 1, uno a la vez. Esto se logra enviando el último dígito del
byte, luego corriendo todos los bits una posición, enviando el que ahora es el último, corriendo nuevamente todos los bits una posición,
enviando el que ahora es el último, y así sucesivamente hasta que todos los bits fueron enviados.

### Main
Las funciones que empiezan con "main" se van a encargar de cargar en el registro apropiado `r17` la posición en la que se va a mostrar
el número que queremos mostrar.

Por ejemplo, si queremos mostrar un número en el tercer dígito del display, tendríamos que cargar el byte `b00100000`. Los primeros
cuatro bits definen los dígitos que queremos que se enciendan, podemos ignorar los otro 4 bits, los dejamos en cero. `**1****`.

Luego de realizar esta configuración, la función main va a llamar a la función "sacanum" correspondiente para que muestre el número en
la posición que acabamos de establecer.

### Frame
Ya que vamos a necesitar mostrar uno a uno los números en cada posición, uno a la vez, vamos a necesitar un retardo ínfimo que
separe cada número, pero que sea tan corto que al ojo humano parezca una imágen constante y fluída.

Para esto creamos la función frame, que se trata de un delay de aproximadamente 1/120 de segundo. Esto es con la idea de que si
entre cada número hay ese delay, para los dos dígitos que tenemos que mostrar, habrá 1/60 de segundo, que es más que suficiente para
que a la vista parezca fluído, sería una tasa de refresco de 60 fotogramas por segundo.

En el hipotético caso que agregaramos más dígitos a mostrar, tendríamos que cambiar esto para que refleje el tiempo necesario
para esa cantidad de imágenes (números).

## Funciones lógicas
Para la parte verdaderamente lógica del programa tenemos la función de unidades y la función de decenas.

### Decenas
Esta función se encarga de establecer el registro correspondiente a lo que serían las "decenas" del display a cada número (del 0 al 9).
Cada vez que cambia el registro de la decena, también se dedica a llamar a la función de las unidades, y cuando termina de ejecutarse
la función de unidades, recién entonces cambia nuevamente el registro de las decenas y vuelve a llamar a unidades.

### Unidades
Esta otra función se encarga de hacer algo similar a las decenas. Va cambiando el registro correspondiente a las "unidades" del display
(con números del 0 al 9) y, cada vez que lo hace, llama a la función `segundear` que será la cual se encarge de realmente mostrar los 
números en el display. Una vez finalice la función de segundear, entonces recién se cambiará nuevamente el registro de unidades al
siguiente número. Cuando termina de iterarse todos los números del 0 al 9, entonces vuelve a decenas para volver a ser invocada cuando
cambie la decena.

### Segundear
Esta función inicialmente define un bucle de `120` repeticiones, una por cada fotograma que vamos a mostrar.

Recordemos que cada número se muestra por `1/60` segundos, y si tenemos 2 números, entre los dos se mostrarían `1/120` segundos;
si repetimos esto `120` veces sería que cada número se muestra 1 
segundo.

Para lograr este objetivo, la función se encarga de hacer una copia de los registros que fuimos alterando de las unidades y decenas, 
para luego llamar a la funcion `main` correspondiente que hará la configuración apropiada del display y llamará a su vez a la sacanum
que muestre el número establecido en la copia de unidades o decenas, según corresponda. Usamos una copia para no perder el número y poder
seguirlo mostrando sin que sea alteado al enviarse en serie (ya que la función sacanum termina "borrando" el registro), de esta forma 
hacemos una copia que no nos importa que sea borrada cada vez.

## Consideraciones
### Nombres de funciones
Es importante tener en cuenta que cada función tiene su nombre propio, es decir, cada sacanum tiene un número al final, cada main
tiene también un número al final. Las funciones internas TAMBIÉN tienen que tener un nombre característico.

Hay varias funciones que no son mencionadas en este documento ya que son meramente de funcionamiento interno, como `dato_serie`, 
`loop_dato` (del 1 al 3), etc.  

Estas funciones tienen sus propios nombres cuando son copiadas. Por ejemplo, en `sacanum` tenemos `dato_serie`, `loop_dato1`, `loop_dato2`,
`loop_dato3`. Pero `sacanum2` tiene `dato_serie2`, `loop_dato12`, `loop_dato22`, `loop_dato32`, para que no se confundan entre ellas.