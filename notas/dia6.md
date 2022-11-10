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


cvs > subversion
      mercurial     >   git         > Servidors que alojen repositorios remotos
      tfs                                   Github, Gitlab, Bitbucket
      
      
REPO GIT:
    RAMA: main/master   La de producción. En ella no se hace ni un commit.
            desarrollo
                tags:   release1
                        release2
            release1
            release2


terraform > github > Pipelines azuredevops > Azure


Servidor en Amazon
    Tipo
    Imagen : Ubuntu
    usuario: ubuntu
    claves configuradas
    
    ssh
        No podemos
    
    Ese servidor se ha conectado a un red: Por defecto
    
    AWS, tiene un firewall a nivel de red, que por defecto corta TODA COMUNICACION con el servidor
    OJO, no es un firewall a nivel de maquina, sino de la red de AMAZON. => security group