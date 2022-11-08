terraform {
  required_providers {
    docker = {                                  # aws
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
}

resource "docker_container"     "mi_contenedor" {           
    # docker_container.mi_contenedor, qué tipo de objeto es? 
    #    list(docker_container)
    count = var.numero_contenedores     # Quiero tantas copias de este recurso
    # Que estamos montando aquí?        BUCLE FOR
    # O a un IF?                        TAMBIEN ! Si count = 0: No creo el recurso  
    #                                             Si count = 1: Si lo creo

    name  = "minginx_${count.index}"
    image = docker_image.mi_imagen.image_id
    
    ports {
        internal = 80
        external = 8080 + count.index
    }
}

resource "docker_container"     "mi_contenedor_condicional" {           
    count = var.crear_contenedor_condicional ? 1 : 0
    name  = "minginx_condicional"
    image = docker_image.mi_imagen.image_id
}


resource "docker_container"     "mi_contenedor_personalizado" {   
    # Qué tipo de objeto es: docker_container.mi_contenedor_personalizado?
    #   map(docker_container)... donde la clave para acceder a los datos de un 
    #.     contenedor es la clave de la variable que meto en el for_each
    for_each = var.contenedores_a_crear # Siempre metemos un mapa
        # Al usar for_each dentro de un resource
        # Tenemos a nuestra disposición la variable "each"
        # Para referirnos a los datos propios de cada elemento
    name  = each.key
    image = docker_image.mi_imagen.image_id
    ports {
        internal = 80
        external = each.value
    }
}

resource "docker_container"     "mi_contenedor_super_personalizado" {   
    for_each = var.contenedores_a_crear_mas_personalizados
    # Qué contiene "each"?              cada una de las entradas CLAVE/VALOR del mapa
    # Qué contiene each.key?            nombre del contenedor
    # Qué contiene each.value?          objetos
    name  = each.key
    image = docker_image.mi_imagen.image_id
    start = each.value.arranque_automatico

    ports {
        internal = 80
        external = each.value.puerto_externo
    }
}

resource "docker_container"     "mi_contenedor_lista" {   
    count = length(var.lista_de_contenedores) 
    
    name  = var.lista_de_contenedores[count.index].nombre
    image = docker_image.mi_imagen.image_id
    start = var.lista_de_contenedores[count.index].arranque_automatico

    ports {
        internal = 80
        external = var.lista_de_contenedores[count.index].puerto_externo
    }
}



resource "docker_image" "mi_imagen" {
    name = "nginx:latest"
}