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
    name  = "miservidor"
    image = docker_image.mi_imagen.image_id   

    connection {
        type     = "ssh" # winrm
        user     = "root"
        password = "root"
        host     = self.network_data[0].ip_address
        port     = "22"
    }

    provisioner "remote-exec"{
        inline  = [ "echo Dentro del contenedor", "echo HOLA >> /root/fichero.txt" ]
    }
    provisioner "remote-exec"{
        script  = "./script.sh" # Ruta del script en el host donde ejecutamos el script de terraform
#        scripts  = ["./script.sh", ""]
    }
    provisioner "file"{
        content = "Este es un contenido que estoy generando para el contenedor ${self.name}"
        destination = "/root/ficheroGenerado.txt"
    }
    provisioner "file"{
        source = "./fichero.txt"
        destination = "/root/ficheroGuardado.txt"
    }
}

resource "docker_image" "mi_imagen" {       
    name = "rastasheep/ubuntu-sshd:latest"
}