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

variable "variables_entorno" { 
    description = "Variables de entorno para configurar el contenedor"
    type = set(string)
}
