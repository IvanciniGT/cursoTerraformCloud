variable "software" { 
    description = "Imagen del contenedor a usar"
    type = string
    default = "mariadb"
    nullable = false
}

variable "software_version" { 
    description = "Versión de la imagen del contenedor a usar"
    type = string
    default = "10.9"
    nullable = false
}

variable "arranque_automatico_contenedor" { 
    description = "Indica si el contenedor debe arrancar en automático"
    type = bool
    #nullable = true
}

variable "cuota_cpu" { 
    description = "Tiempo de CPU que puede usar el contenedor"
    type = number
    default = null # No es lo mismo que no asignar valor
    nullable = true # Este es el valor por defecto
    validation {
        condition     = var.cuota_cpu == null ? true : var.cuota_cpu > 0 
                        # CONDICION ? VALOR SI VERDADERO : VALOR SI FALSO
                                                                  
        error_message = "El valor suministrado para cuota_cpu no es válido. Debe ser mayor que cero."
    }
}

variable "variables_entorno" { 
    description = "Variables de entorno para configurar el contenedor"
    #type = set(string)
    type = set(object({
            nombre = string
            valor  = string
    }))
}

#variable "puertos" { 
#    description = "La que sea"
#    type = list(number)
#}

#variable "puerto" {
#    description = "Lo que sea"
#    type = object({
#        interno = number
#        externo = number
#    })
#}
variable "puertos_expuestos" {
    description = "Lo que sea"
    type = set(object({
                        interno = number
                        externo = number
                    })
                )
    nullable = false
    default  = []
    validation {
        condition     = alltrue(
                            [ for puerto in var.puertos_expuestos: 
                                puerto.interno > 0 && puerto.interno < 40000 ]
                        )
        error_message = "El valor suministrado para el puerto interno debe estar entre el 1 y el 40000."
    }
    validation {
        condition     = alltrue(
                            [ for puerto in var.puertos_expuestos: 
                                puerto.externo > 0 && puerto.externo < 40000 ]
                        )
        error_message = "El valor suministrado para el puerto externo debe estar entre el 1 y el 40000."
    }
}







