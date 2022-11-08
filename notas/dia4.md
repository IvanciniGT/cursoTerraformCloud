# Variables

## Con resspectoa cómo se definen y se les asigna valor

Las variables permiten parametrizar un script.
Ayer vimos 3 ficheros diferentes con respecto a las variables:

- .tf               Declarar variables. Esa declaración era de la forma:
                        
                        variable NOMBRE {
                            description = "Lo que sea"
                            type        = number | bool | string | set( ) | map( ) | list ( ) | object({...}) | any
                            default     = Un VALOR
                            nullable    = true | false  # Si la variable puede adquirir valor null
                            sentitive   = true | false  # Si la variable guarda información sensible
                                                        # (no aparecerá el valor en consola)
                            validation  = {
                                condition       = EXPRESIÓN LOGICA. Debe devolver "true" si el valor es correcto.
                                error_message   = "TEXTO" # Que se mostrará si el valor devuelto por la expresión
                                                          | anterior es false
                            }
                        }

- .auto.tfvars      Darles valores que se aplican automaticamente.
- .tfvars           Asignar valores que se deben aplciar manualmente:
                        --var-file="RUTA"

* NOTA: Hay una forma adicional de asignar valor a una variable: Directamente en linea de comandos:
                        --var="NOMBRE=valor"

## Con respecto a su utilización

Para referirnos a una variable dentro de los ficheros .tf:

- Si queremos asignar una propiedad con el valor de una variable:
    prop = var.NOMBRE
    
    * NOTA: Si la variable tiene valor "null", terraform no suministra la propiedad al provider.
    * NOTA2: Esto funciona para propiedades de tipo:
        prop[string]         = var.texto
        prop[bool]           = var.logico
        prop[number]         = var.numero
        prop[set|list|map]   = var.list|set|map
        prop[block|set(block)|list(block)] NO ADMITEN ESTA SINTAXIS

- Si queremos asignar propiedades de tipo block, qué sintaxis usábamos?
    dynamic "PROP" {
        for_each = var ( LISTA | SET )
        iterator = NOMBRE_ITERADOR
        content {
            ... 
            propX = NOMBRE_ITERADOR
        }
    }
    * NOTA: Si queremos referirnos a un elemento concreto de una lista que tenemos en una variable:
        var.lista[0]   # Esto nos refiere al primer elemento de esa lista
        [ for elemento in var.lista: elemento ]
    

---
Expresiones regulares

Una expresión regular es una secuencia/combinación de patrones.
Cada patrón contiene:
- Una secuencia de caracteres
        Hola                                La secuancia "Hola"
        [Hola]                              Una letra entre H, o, l, a, da igual , la que sea
        [0-9]                               Un caracter entre el 0 y el 9
            [0-48]                          Un caracter entre el 0 y el 4 (0, 1, 2, 3 o 4) y el 8
        [a-z]
        [A-Z]
        [a-zA-Z0-9ñÑáÁ]
        .                                   Cualquier caracter
- Seguido de un modificador de cantidad
        No poner nada detrás de la secuencia    Busca esa secuancia 1 vez
        ?                                       La secuencia puede parecer o no
        +                                       La secuencia debe aparecer al menos 1 vez... puede aparecer muchas
        *                                       La secuencia puede no aparecer o puede aparecer muchas veces
        {3}                                     La secuencia debe aparecer 3 veces
        {3,6}                                   de 3 a 6 veces

- Otros signos que puedo usar en expresiones regulares:
-------------------------------------------------------
    - |             o
    - ^             Comienza por
    - $             Acaba por 
Quiero un patrón para identificar un número del 0 al 99
    [1-9]?[0-9]

Entre el 0 y el 100
    ([1-9]?[0-9])|(100)


Email
letras @ masletras . extension