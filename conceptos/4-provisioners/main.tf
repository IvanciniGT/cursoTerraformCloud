terraform {
  required_providers {
    docker = {                        
      source = "kreuzwerker/docker"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "null" {
}
provider "docker" {
}

resource "docker_container" "mi_contenedor" { # Esta variable es una list(contenedores)
    count = 10
    name  = "miapache_${count.index}"
    image = docker_image.mi_imagen.image_id   
    
    
    provisioner "local-exec"{
        command ="echo Chao pescao! && exit 1"
        when = destroy # Hace que el procisionador se ejecute SOLO cuando se 
                       # hace un destroy del recurso
        # Si el comando que ejecuta un provisionador peta ! Se corta 
        # la ejecución del script de terraform.
        on_failure = continue # fail(valor por defecto)
    }
}

resource "docker_image" "mi_imagen" {       # Esta variables es UNA imagen de contenedor
    name = "httpd:latest"
}
# Si hay un cambio, en cualquiera de las ips , que se regerene el fichero de inventario


#output "direccion_ip" { 
#    value = docker_container.mi_contenedor.ip_address
#}
# Si hay un cambio en alguna IP, quiero regererar el fichero de inventario

resource "null_resource" "cluster" {
    triggers = {
#        ips_que_si_cambian_se_regenere_el_fichero = join(",", [ for contenedor in docker_container.mi_contenedor: contenedor.ip_address ])
        ips_que_si_cambian_se_regenere_el_fichero = join(",", docker_container.mi_contenedor.*.ip_address )
    }
    
    provisioner "local-exec"{
        # Aqu´definimos un comando que se ejecutará en la misma 
        # máquina que mi script de terraform
        #command = "echo $MAQUINA ${self.ip_address} >> inventario/inventario.ini"
        command = <<EOT
                        mkdir -p inventario
                        rm -f inventario/inventario.ini
                        echo "${join("\n",docker_container.mi_contenedor.*.ip_address )}" > inventario/inventario.ini
                    EOT
#                        echo "${join("\n", [ for contenedor in docker_container.mi_contenedor: contenedor.ip_address ])}" > inventario/inventario.ini

        interpreter = [ "/bin/bash", "-c"] # python # perl
        #environment = {
        #    MAQUINA = "federico" #self.name
        #}
        working_dir = "." # Aqui podeis poner una ruta relativa o absoluta
    }
}
