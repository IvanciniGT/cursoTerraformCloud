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
