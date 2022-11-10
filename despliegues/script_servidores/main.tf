terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
        tls = {
            source = "hashicorp/tls"
        }
    }
}

provider "aws" {
    region = var.regioncita
}
provider "tls" {
}

module "servidor_web" {
  source = "../servidor_aws"
  nombre_imagen ="*ubuntu-xenial-16.04-amd64-server-*"
  virtualizacion_imagen = var.virtualizacioncita_imagen
  propietario_imagen = "099720109477"
  nombre_servidor = "ServidorDeIvan"
  tipo_de_servidor = "t2.micro"
  nombre_claves_aws = "clave-ivan"
  nombre_security_group = "reglas_firewall_mi_servidor_ivan"
}
module "servidor_bbdd" {
  source = "../servidor_aws"
  nombre_imagen ="*ubuntu-xenial-16.04-amd64-server-*"
  virtualizacion_imagen = var.virtualizacioncita_imagen
  propietario_imagen = "099720109477"
  nombre_servidor = "ServidorDeIvanBBDD"
  tipo_de_servidor = "t2.micro"
  nombre_claves_aws = "clave-ivan-bbdd"
  nombre_security_group = "reglas_firewall_mi_servidor_ivan-bbdd"
}
# Si los modulos definieran un output, podriamos recuperarlos a nivel del script usandfo:
# module.servidor_bbdd.OUTPUTNAME