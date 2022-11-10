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
    region = var.region
}
provider "tls" {
}

data "aws_ami" "imagen_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.nombre_imagen]
  }

  dynamic "filter" {
    for_each = var.virtualizacion_imagen != null ? [ var.virtualizacion_imagen ] : [ ]
    content {
        name   = "virtualization-type"
        values = [ var.virtualizacion_imagen ]
    }
  }

  owners = [var.propietario_imagen] 
}

resource "aws_instance" "miservidor" {
    ami           = data.aws_ami.imagen_ubuntu.id
    instance_type = var.tipo_de_servidor
    key_name      = aws_key_pair.mi_clave_publica.id
                    # Dar de alta la clave en el authorized_keys
    tags = {
        Name = var.nombre_servidor
    }
}

resource "aws_key_pair" "mi_clave_publica" {
  key_name   = "clave-ivan"
  public_key = tls_private_key.par_de_claves.public_key_openssh
}

resource "tls_private_key" "par_de_claves" {
  algorithm = "RSA"
  rsa_bits  = 4096
  
  provisioner "local-exec"{
      command = "echo '${self.private_key_pem}' > clave-privada.pem"
  }
  provisioner "local-exec"{
      command = "echo '${self.public_key_pem}' > clave-publica.pem"
  }
}
