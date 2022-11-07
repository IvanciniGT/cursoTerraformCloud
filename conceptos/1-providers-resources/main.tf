# Los ficheros de terraform están escritos usando sintaxis HCL: HashiCorp Language
# En HCL se pueden poner comentarios, con el cuadradito!

# Los ficheros de terraform se pueden llamar como nos de la real gana!
# Ahora bien, es importante que la extensión sea .tf
# Por convenio, todo el mundo llama al fichero (PRINCIPAL) main.tf

# ES CONVENIENTE SEGUIR EN CONVENIO

# En un fichero de terraform, definimos:
# PROVIDERS
# RESOURCES
# DATAS
# VARIABLES
# OUTPUTS

# Adicionalmente, tendremos que dar la configuración que necesitemos en terraform
# Y eso es lo primero que hacemos:

# En este ejemplo, vamos a usar terraform para gestionar un contenedor... Por ejemplo de MARIADB...
# Oye terraform:
#    ??? ejecuta "docker image pull mariadb:latest"     <--- Esto es RUINA (osea IMPERATIVO)
#    Necesito la última imagen de MariaDB               <--- Esto es GUAY  (osea DECLARATIVO)                
#    Necesito un contenedor desde la imagen de MariaDB  <--- Esto es GUAY  (osea DECLARATIVO)                
#       Ese contenedor quiero que tenga una determinada configuración: PUERTOS, VOLUMENES, VARIABLES DE ENTORNO...

# A quién le voy a pedir eso???? La imagen y el contenedor. PROVEEDOR??? docker
# Viene terraform de serie con el proveedor de DOCKER? NO.... Ni con ese ni con ningun otro!

terraform {
# Debo instalarlos ejecutando : $ terraform init
  required_providers {
    docker = {                                  # aws
      source = "kreuzwerker/docker"
    }
  }
}

# Configuraciones que requiera ese proveedor
provider "docker" {
  # Configuration options                       # aws: region
}

# El orden de los recursos en este fichero es INTRASCENDENTE
# Terraform calcula relaciones de dependencia entre recursos,
# En base a las referencias que existan

                                # Es un nombre de variable, 
                                # con la que referirme 
         # Tipo de recurso      # internamente a este recurso
resource "docker_container"     "mi_contenedor" {
    # Nombre del contenedor
    name  = "mimariadb"
    # Imagen
    image = docker_image.mi_imagen.image_id   # Esto genera una relación de dependencia
    start = true
    # Mapeo de puertos. Usamos esta sintaxis cuando el tipo es BLOCK
    ports {
        internal = 3306
        external = 33306
    }
    ports {
        internal = 80
        external = 8080
    }
    #ports {
    #    internal = 443
    #    external = 8443
    #}
    # Volumenes
    volumes {
        container_path = "/var/lib/mysql"
        host_path      = "/home/ubuntu/datos/mariadb"
    }
    # Variables de Entorno. Usamos esta sintaxis, tanto para Lists como para Sets
    env = [
        "MARIADB_ROOT_PASSWORD=password",
        "MARIADB_DATABASE=midb",
        "MARIADB_USER=usuario",
        "MARIADB_PASSWORD=password"
        ]
}

resource "docker_image" "mi_imagen" {
    name = "mariadb:10.9"
    # Repo(Nombre):  mariadb
    # Versión     :  latest
}