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
    start = true
    ports {
        internal = 3306
        external = 33306
    }
    volumes {
        container_path = "/var/lib/mysql"
        host_path      = "/home/ubuntu/datos/mariadb"
    }
    env = [
        "MARIADB_ROOT_PASSWORD=password",
        "MARIADB_DATABASE=midb",
        "MARIADB_USER=usuario",
        "MARIADB_PASSWORD=password"
        ]
}

resource "docker_image" "mi_imagen" {
    # Esto estaba guay, cuando tenía todo (nombre y versión) 
    # en unna única variable
    # name = var.software
    # name = "${var.software}"
    name = "${var.software}:${var.software_version}"
           # Interpolación de textos
}