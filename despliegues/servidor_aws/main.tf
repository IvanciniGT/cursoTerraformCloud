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
    security_groups = [ aws_security_group.mi_security_group.name ]
    tags = {
        Name = var.nombre_servidor
    }
    
    connection {
        user = "ubuntu"
        type = "ssh"
        port = "22"
        host = self.public_ip
        private_key = tls_private_key.par_de_claves.private_key_pem
    }
    
    provisioner "remote-exec" { # Smoke test
        inline = [ "echo Dentro del servidor ! EUREKA !" ]    
        on_failure = fail
    }
}

resource "aws_key_pair" "mi_clave_publica" {
  key_name   = var.nombre_claves_aws
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

resource "aws_security_group" "mi_security_group" {
  name        = var.nombre_security_group
  description = "Permitir trafico ssh"
  vpc_id      = null

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = var.nombre_security_group
  }
}


#smoke test