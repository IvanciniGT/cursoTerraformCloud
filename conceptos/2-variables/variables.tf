variable "software" { 
    description = "Imagen del contenedor a usar"
    type = string
    default = "mariadb"
}

variable "software_version" { 
    description = "Versión de la imagen del contenedor a usar"
    type = string
    default = "10.9"
}

variable "arranque_automatico_contenedor" { 
    description = "Indica si el contenedor debe arrancar en automático"
    type = bool
}
variable "cuota_cpu" { 
    description = "Tiempo de CPU que puede usar el contenedopr"
    type = number
    default = null # No es lo mismo que no asignar valor
    nullable = true # Este es el valor por defecto
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
}







