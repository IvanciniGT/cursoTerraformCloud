
# Los puedo obtener posteriormente con :
# $ terraform output [--jason | --raw ] direccion_ip
output "direccion_ip" { 
    value = docker_container.mi_contenedor.ip_address
}

# $ terraform output [--jason | --raw ] id
output "id" {
    value = docker_container.mi_contenedor.id
}