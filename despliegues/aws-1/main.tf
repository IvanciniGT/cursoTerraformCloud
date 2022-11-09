terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "eu-west-1"
}

data "aws_ami" "imagen_ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "miservidor" {
    ami           = data.aws_ami.imagen_ubuntu.id
    instance_type = "t2.micro"
    tags = {
        Name = "ServidorDeIvan"
    }
}

