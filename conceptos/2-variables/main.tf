terraform {
  required_providers {
    docker = {                                  
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
}

resource "docker_container"     "mi_contenedor" {
    name  = "mimariadb"
    image = docker_image.mi_imagen.image_id  
    # Esto funcionaria por los pelos... gracias a la autoconversiónd e tipos de terraform
    # start = "${var.arranque_automatico_contenedor}"
    
    cpu_shares = var.cuota_cpu
                 # Si a una propiedad le asigno null, para terraform, 
                 # es como si no hubiera escrito esta linea.
    start = var.arranque_automatico_contenedor
    #ports {
        #internal = var.puertos[0]
        #external = var.puertos[1]
        #internal = var.puerto.interno
        #external = var.puerto.externo
    #}
    
    dynamic "ports"{
        for_each = var.puertos_expuestos # Aqui le pongo una lista o un set
        iterator = puerto_expuesto       # Esta variable me permite acceder 
                                         # a cada uno de los elementos de la lista
        content {
            internal = puerto_expuesto.value["interno"]
            external = puerto_expuesto.value["externo"]
        }
    }
    
    volumes {
        container_path = "/var/lib/mysql"
        host_path      = "/home/ubuntu/datos/mariadb"
    }
    
    #env = var.variables_entorno
    env = [ for variable_entorno in var.variables_entorno: "${variable_entorno.nombre}=${variable_entorno.valor}" ]
}

resource "docker_image" "mi_imagen" {
    # Esto estaba guay, cuando tenía todo (nombre y versión) 
    # en unna única variable
    # name = var.software
    # name = "${var.software}"
    name = "${var.software}:${var.software_version}"
           # Interpolación de textos
}