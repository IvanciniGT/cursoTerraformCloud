numero_contenedores = 1

crear_contenedor_condicional = true

contenedores_a_crear = {
    "contenedorA" = 9090
    "contenedorB" = 9080
}

contenedores_a_crear_mas_personalizados= {
    "contenedorP1" = {
                        puerto_externo = 9999
                        arranque_automatico = true
                     }
                      
    "contenedorP2" = {
                        puerto_externo = 8888
                     }
}

lista_de_contenedores= [
    {
        nombre              = "contenedorL1"
        puerto_externo      = 9099
        arranque_automatico = true
    },
    {
        nombre              = "contenedorL2"
        puerto_externo      = 9099
        arranque_automatico = true
    },
    {
        nombre              = "contenedorL3"
        puerto_externo      = 8089
        arranque_automatico = true
    }
]
