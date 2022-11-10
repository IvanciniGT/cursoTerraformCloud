Claves SSH:
    Par de claves: 
        - Clave privada
        - Clave pública
        
1º Necesitamos un par de claves SSH
    Proveedor hashicorp/tls -> Generar un par de claves publica/privada
    privada -> Guardarla en un archivo        .pem
2º Debemos registrar la clave publica dentro de Amazon
    La clave publica, Amazon No la quiere en formato PEM, sino en formato OpenSSH
    Proveedor hashicorp/aws ->aws_key_pair
3º La configuramos en nuestro servidor
