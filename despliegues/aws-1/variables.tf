variable "region" { 
    description = "Región donde crear la infra"
    type = string
    nullable = false
    validation {
        condition     = ( length(
                            regexall( 
                                "^[a-z]{2}-[a-z]{4,}-[1-3]$", 
                                var.region 
                            )
                        ) == 1)
        error_message = "El valor suministrado para la region no es válido."
    }
}

variable "nombre_imagen" { 
    description = "Nombre de la imagen a usar"
    type = string
    nullable = false
}

variable "virtualizacion_imagen" { 
    description = "Indica el tipo de virtualización soportado por la imagen"
    type = string
    nullable = true
    default = null
    validation {
        condition     = ( var.virtualizacion_imagen != null 
                            ? contains( ["hvm"], var.virtualizacion_imagen)
                            : true )
        error_message = "El valor suministrado para la virtualización de la imagen no es válido"
    }
}

variable "propietario_imagen" { 
    description = "Indica el tipo de virtualización soportado por la imagen"
    type = string
    nullable = false
    validation {
        condition     = ( length(
                            regexall( 
                                "^[0-9]+$", 
                                var.propietario_imagen 
                            )
                        ) == 1 )
        error_message = "El valor suministrado para la virtualización de la imagen no es válido"
    }
}

variable "nombre_servidor" { 
    description = "Nombre del servidor"
    type = string
    nullable = false
    validation {
        condition     = ( length(
                            regexall( 
                                "^[a-zA-Z0-9]+$" ,
                                var.nombre_servidor 
                            )
                        ) == 1 )
        error_message = "El valor suministrado para el nombre del servidor no es válido."
    }
}

variable "tipo_de_servidor" { 
    description = "Tipo del servidor"
    type = string
    nullable = false
    default="t2.micro"
    validation {
        condition     = ( length(
                            regexall( 
                                "^[a-z0-9]+[.][a-z]+$" ,
                                var.tipo_de_servidor 
                            )
                        ) == 1 )
        error_message = "El valor suministrado para el tipo de servidor no es válido."
    }
}

variable "nombre_claves_aws" { 
    description = "Nombre de las claves en AMAZON"
    type = string
    nullable = false
}
variable "nombre_security_group" { 
    description = "Nombre del security group en AMAZON"
    type = string
    nullable = false
}