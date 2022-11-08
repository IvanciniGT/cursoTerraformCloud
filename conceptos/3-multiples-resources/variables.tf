variable "numero_contenedores" { 
    description = "Lo que sea"
    type = number
    default = 1
    nullable = false
}

variable "crear_contenedor_condicional" { 
    description = "Lo que sea"
    type = bool
    default = true
    nullable = false
}

# Quiero para cada contenedor poder dar su nombre y puerto externo
variable "contenedores_a_crear" { 
    description = "Lo que sea"
    type = map(number)
    nullable = false
    default = {
        # .key          .value
        "contenedorA" = 9090
        "contenedorB" = 9080
    }
}

# Quiero para cada contenedor poder dar:
# - su nombre 
# - puerto externo
# - y otros 80 datos... como por ejemplo:
#     - start = true | false
variable "contenedores_a_crear_mas_personalizados" { 
    description = "Lo que sea"
         # map(map(string))
    type = map(object({
        puerto_externo = number
        arranque_automatico = optional(bool, false)
    }))
    nullable = false
    default = {
        # .key          .value
        "contenedorP1" = {
                            puerto_externo = 9999
                            arranque_automatico = true
                        }
        "contenedorP2" = {
                            puerto_externo = 8888
                        }
    }
}
variable "lista_de_contenedores" { 
    description = "Lo que sea"
    type = list(object({
        nombre              = string
        puerto_externo      = number
        arranque_automatico = optional(bool, false)
    }))
    nullable = false
}