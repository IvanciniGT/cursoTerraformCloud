# Instalar Servidor WEB en mi computadora

Apache
Nginx: 80

# Interfaces de red encontramos en cualquier Computadora:

- Loopback : 127.0.0.1              <- localhost
- ETH:       172.31.15.137
- docker:    172.17.0.1

ipconfig
ifconfig

docker run --rm --name minginx nginx:latest
    docker image        pull        nginx:latest                                docker pull
    docker container    create      --name minginx nginx:latest                 
    docker container    start       minginx                                     docker start
    docker container    attach      minginx                                     docker attach
    
    
    
    
    
    docker container    stop        minginx
    docker container    list                                                    docker ps
    
    docker image list                                                           docker images
    docker image pull httpd:latest
    docker container    create      --name miapache httpd:latest
    
    
    
    
      -------------- Red amazon -----------------------
      |                                               |
      172.31.15.137                                 ###.###.###.###
      |    NAT: 8081-> 172.17.0.2:80                  |
    IvanPC                                          MenchuPC
      |                                                 curl 172.31.15.137:8081
      docker
      |
      - 172.17.0.2     Nginx : 80
      
      
mysql
      ---> 
           mariadb
                        Mi usuario
                        Mi contraseña
                        Mi nombre de BBDD
                        
                        
                        

-----
Ciclo de vida de un script terraform

El script estará ubicado en una carpeta... en esa carpeta ejecuto:

- terraform init            -> Descargar los proveedores requeridos
                            -> Lo ejecutamos: 1- Cuando comenzamos el proyecto... 2- Si hay un cambio en los proveedores
- terraform validate        -> Valida el / los ficheros de terraform que tengamos en la carpeta
- terraform plan            -> Muestra el plan de ejecución creado por terraform para conseguir 
                               el estado que le estoy poidiendo
- terraform apply           -> A por ello!
- terraform destroy


mariadb:latest      # Esto no nos gusta en producción
          |
          v
mariadb:10          # Esto montaría la ULTIMA versión 10   ***
mariadb:10.9        # Esto montaría la útlima versión 10.9 ********
mariadb:10.9.3      # Esto nos gusta en producción?     BUENO... Si!

10 -> Mayor         Implica cambios que no garantizan retrocompatibilidad
9  -> Minor         Aumentan funcionalidad
3  -> Micro         Arreglan bugs

docker container create \
    --name mimariab \
    -p 33306:3306 \
    -e MARIADB_ROOT_PASSWORD=password \
    -e MARIADB_DATABASE=midb \
    -e MARIADB_USER=usuario \
    -e MARIADB_PASSWORD=password \
    -v /home/ubuntu/datos/mariadb:/var/lib/mysql
    mariadb:latest
    
docker container create \
    --name minginx \
    -p 8080:80 \
    -p 8443:443 \
    nginx:latest
    
----

METODOLOGIAS AGILES: SCRUM
DEVOPS
CLOUDs
CONTENEDORES


Dev--->ops? Cultura de la AUTOMATIZACION
Automatición de qué? De todo lo que sea posible entre 

Integración continua    - Continuous Integration    - CI
Entrega continua        - Continuous Delivery       - CD
Despliegue continuo     - Continuous Deployment
                    
                    Automatizable?
Plan                        x
Code                        x
Empaqueto / Compilo         √       JAVA (MAVEN, GRADLE) PY (POETRY) .net (MSBUILD, DOTNET)
Test        
    Definición              x
    Ejecución               √       POSTMAN, SOAPUI, JMETER, SELENIUM, APPIUM, SONARQUBE
    Dónde ejecutaré las pruebas?
        Entorno de PRUEBAS, TEST, Q&A, PREPRODUCCION, Integración
            Tradicionalmente este entorno se crea al inicio del proyecto, junto con 
                El de desarrollo / el de producción
            RUINA !!!!
            
            Por qué no instalamos y probamos en la máquina del desarrollador? ESTA MALEADA !
            Por qué no instalamos y probamos en la máquina del tester?        ESTA MALEADA !
            Por qué no instalamos y probamos en el entorno de integración?    Podría estar maleado?
                FACILMENTE ! MOTIVO 1 para no precrear un entorno
                
            MOTIVO 2: Y cuando no estoy probando... que pasa con el entorno de integración? 
                     Ahí gastando billetes no?
            
            Qué me podría interesar? Crear en entorno cuando lo necesite... y desmantelarlo después.
            Que buenos son los clouds... como nos gustan!
                Y qué guay es terraform!
            
            
< ----- Continuous Integration
        Cuando consigo automatizar la instalación y ejecución de pruebas en el entorno de 
        INTEGRACION de la última versión del software
        
Release
< ----- Continuous Delivery
Deployment
< ----- Continuous Deployment
Monitor
Operate


Servidores de CI/CD: Jenkins, Azure Sevops, TravisCI, Bamboo, TeamCity
    TERRAFORM me ayuda a crear un entorno... una infraestructura: PROVEE LA INFRAESTRUCTURA
    Pero.. después esa infra hay que APROVISIONARLA (configurar usuarios, puertos, librerias, permisos,...
    Redes...Instalación) -> ANSIBLE, Puppet, Chef. 
    Instalación docker