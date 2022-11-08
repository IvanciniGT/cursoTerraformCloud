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
    


