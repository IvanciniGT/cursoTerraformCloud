terraform {
  required_providers {
    docker = {                        
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {
}

resource "docker_container" "mi_contenedor" {
    name  = "miapache"
    image = docker_image.mi_imagen.image_id   
    
    provisioner "local-exec"{
        # Aqu´definimos un comando que se ejecutará en la misma 
        # máquina que mi script de terraform
        #command = "echo $MAQUINA ${self.ip_address} >> inventario/inventario.ini"
        command = <<EOT
                        mkdir -p inventario
                        echo $MAQUINA ${self.ip_address} >> inventario/inventario.ini
                    EOT
        interpreter = [ "/bin/bash", "-c"] # python # perl
        environment = {
            MAQUINA = self.name
        }
        working_dir = "." # Aqui podeis poner una ruta relativa o absoluta
    }
    provisioner "local-exec"{
        command ="echo Chao pescao! && exit 1"
        when = destroy # Hace que el procisionador se ejecute SOLO cuando se 
                       # hace un destroy del recurso
        # Si el comando que ejecuta un provisionador peta ! Se corta 
        # la ejecución del script de terraform.
        on_failure = continue # fail(valor por defecto)
    }
}

resource "docker_image" "mi_imagen" {
    name = "httpd:latest"
}

output "direccion_ip" { 
    value = docker_container.mi_contenedor.ip_address
}