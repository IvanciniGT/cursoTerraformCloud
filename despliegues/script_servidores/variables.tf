variable "regioncita" { 
    description = "Región donde crear la infra"
    type = string
    nullable = false
    validation {
        condition     = ( length(
                            regexall( 
                                "^[a-z]{2}-[a-z]{4,}-[1-3]$", 
                                var.regioncita 
                            )
                        ) == 1)
        error_message = "El valor suministrado para la region no es válido."
    }
}

variable "virtualizacioncita_imagen" { 
    description = "Indica el tipo de virtualización soportado por la imagen"
    type = string
    nullable = true
    default = null
    validation {
        condition     = ( var.virtualizacioncita_imagen != null 
                            ? contains( ["hvm"], var.virtualizacioncita_imagen)
                            : true )
        error_message = "El valor suministrado para la virtualización de la imagen no es válido"
    }
}
