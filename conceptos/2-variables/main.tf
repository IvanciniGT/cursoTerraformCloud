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
    start = var.arranque_automatico_contenedor
    ports {
        internal = 3306
        external = 33306
    }
    volumes {
        container_path = "/var/lib/mysql"
        host_path      = "/home/ubuntu/datos/mariadb"
    }
    env = var.variables_entorno
}

resource "docker_image" "mi_imagen" {
    # Esto estaba guay, cuando tenía todo (nombre y versión) 
    # en unna única variable
    # name = var.software
    # name = "${var.software}"
    name = "${var.software}:${var.software_version}"
           # Interpolación de textos
}