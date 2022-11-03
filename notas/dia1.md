# Terraform

Lenguaje declarativo que permite automatizar la adquisición/liberación de servicios en un PROVEEDOR (cloud)
IaC : Infraestructura as Code

PROVEEDOR: 
- Cloud
- Cluster de Kubernetes
- Servidor de correo electrónico: Nueva dirección de correo electrónico / Baja
- MS Active Directory: LDAP de Miscrosoft: Proveedor de Identidades 
    - Nueva identidad
    - Baja de identidad

# Cloud | Cloud computing

Un cloud | Cloud computing es el conjunto de SERVICIOS (relacionados con el mundo TIC) 
que una empresa ofrece de forma automatizada a través de internet.

Esos servicios pueden ser de DIFERENETE NATURALEZA:
- Servicios de Infraestructura:     IaaS
  > Adquisición de hardware: Hardware físico o virtualizado / Contenedores / Cluster Kubernetes
  > Almacenamiento
  > Redes
- Servicios de Plataforma:          PaaS
    - BBDD
- Servicios de Software:            SaaS
    - Office 365 | Cloud9

Esos servicios llevan un modelo de PAGO POR USO (alquilo)

CLOUDS Más usados:
1 - AWS
2 - AZURE
3 - GCP


Para qué queremos una computadora/ordenador/servidor: Ejecutar software ---> Datos

# Contenedorización

## Contenedor

Un entorno aislado dentro de un SO que corra un kernel Linux en el que ejecutamos procesos.

Entorno aislado:
- Su propia configuración de red -> Su propia IP
- Sus propias variables de entorno
- Su propio sistema de archivos
- Limitación de acceso al hardware

Linux? Kernel de SO que supluestamente cumple con UNIX®
GNU: Montaron todo lo que hacía falta menos un KERNEL.

GNU + Linux = GNU/Linux:
    - Redhat
    - Suse
    - Debian > Ubuntu

Android = Kernel Linux + Librerias y Apps de Google

Qué es UNIX?   2 especificaciones acerca de cómo montar un SO: SUS + POSIX
Qué era UNIX?  Era un SO... cojonudo

Windows <<<<< Android
Windows Kernel ??? Microsoft ha tenido 2 kernels: 
- DOS : MSDOS, Windows 2, Windows 3, Windows 95m, Windows 98, Windows Millenium
- NT  : (new technology) windows NT, Windows XP, Windows Server, windows 7, 8, 10, 11


Tipos de software:
------------------

- Sistema operativo
- Aplicación
----------------------------- v Todo puede ser contenedorizado
- Driver
- Demonio               Software que se ejecuta en segundo plano
    - Servicio          Es un demonio que atiende peticiones de otros programas (Puerto de comunicaciones TCP/UDP)
- Script
- Comando

Los contenedores se crean desde lo que llamamos una IMAGEN DE CONTENEDOR.
Una imagen de contenedor es un triste fichero comprimido (tar) que contiene un software YA INSTALADO por alguien.

Las imágenes de contenedor se pueden descargar (se distribuyen) mediante un:
    REGISTRY de REPOSITORIOS de IMAGENES de CONTENEDOR: Docker hub

Instalar un Software : MS SQL Server

# Método tradicional:

1º Descargar "SQL Server"? NO
   Un instalador de SQL Server
2º Ejecutar el instalador.... configuraciones -> Instalación de SQL Server -> C:\ProgramFiles\SQLServer\...
                                                                                        |
                                                                                        V
                                                                                    Archivo comprimido -> email

    App1 + App2 + App3          Problemas: 
    ------------------              - Dependencias / Requisitos > Incompatibles
            SO                      - Configuraciones a nivel de SO (variables de entorno)
    ------------------              - App1 se vuelve loca (CPU 100%) > App1 OFFLINE
          HIERRO                                                       App2 y App3 OFFLINE
                                                                       SO: OFFLINE


     App1  | App2+App3
    ------------------          Problemas: 
     SO 1  |    SO 2                - Muchos SOs:
    ------------------                  - Dolor de cabeza gordo: Muchas configuraciones, instalaciones, actualziaciones.
     MV 1  |    MV 2                    - Desperdicio de recursos
    ------------------              - Menor rendimiento de las Apps
    Hipervisor: 
    VMWare, HyperV, KVM
    Citrix, VirtualBOX
    ------------------        
            SO                
    ------------------        
          HIERRO              


     App1  | App2+App3 
    ------------------         
     C  1  |    C  2           
    ------------------         
    Gestor de contenedores:
    Docker, CRIO, ContainerD, Podman
    ------------------        
        SO Linux
    ------------------        
    HIERRO (físico o virtual)              


Kubernetes (GOOGLE) << Openshift (REDHAT) Tamzu (VMWARE)

Gestores de gestores de contenedores, aptos para su uso en un entorno de producción

    Cluster Kubernetes
        Maquina 1
            CRIO / ContainerD
        Maquina 2
            CRIO / ContainerD
        ...
        Maquina N
            CRIO / ContainerD



Entornos de producción:

- Alta disponibilidad:
    Tratar de garantizar un determinado tiempo de servicio pactado contractualmente:
        Tiempo de servicio garantizado del 90%: 1 de cada 10 dias           OFFLINE     |   €
                                                36,5 días al año            OFFLINE     |   €€
        Tiempo de servicio garantizado del 99%: 3,6 días al año             OFFLINE     |   €€€€€
        Tiempo de servicio garantizado del 99,9%: 8 horas al año            OFFLINE     |   €€€€€€€€€€€
        Tiempo de servicio garantizado del 99,99%: 20-30 minutos al año     OFFLINE     V   €€€€€€€€€€€€€€€€€€€€€€€€
        
    Tratar de garantizar la NO PERDIDA de información
        En lugar de tener los datos guardados en 1 HDD, los tengo al menos triplicados (3x)
    
        REDUNDANCIA: CLUSTER
            Grupo de máquinas / procesos
                ACTIVO / PASIVO
                ACTIVO / ACTIVO

- Escalabilidad:
    Capacidad de ajustar(aumentar/disminuir) la infraestructura a las necesidades de cada momento

    MODELO 1 APP: App departamental: 
        Dia 1:          100 usuarios
        Dia 100:        102 usuarios        No necesito escalabilidad
        Dia 1000:        98 usuarios
    
    MODELO 2 APP: App para un nuevo servicio que ofrezco
        Dia 1:          100 usuarios
        Dia 100:        1000 usuarios       Escalabilidad Vertical: MAS MAQUINA !
        Dia 1000:       10000 usuarios
    
    MODELO 3 APP: INTERNET !
        Dia n:              100 usuarios
        Dia n+1:        1000000 usuarios       Escalabilidad Horizontal: MAS MAQUINAS !
        Dia n+2:           2000 usuarios
        Dia n+3:       20000000 usuarios

        Esto me lo dan los CLOUDs

El alquilar / contratar servicios contra un cloud:
- Lo puedo hacer manualmente. Problemas:
    - Alta probabilidad de error.... No funcione o MUCHA PASTA !!!!!
    - Lento y caro... Humano que va a su ritmo
    - No es fácilmente replicable... puedo volver a hacerlo desde 0
- Lo puedo automatizar: 
    - Hacer un programa que haga lo que un hombrecillo / mujercilla haría a manubrio.

Ese programa tendré multiples LENGUAJES DE PROGRAMACION para escribirlo... entre ellos: TERRAFORM

Lenguajes de programación: 
- De propósito general: JAVA, PYTHON, C#
- De propósito especifico: ANSIBLE, TERRAFORM

Lenguajes de programación / Lenguajes naturales (los que hablamos los humanos), tenemos paradigmas:
- Imperativo: Doy órdenes / Indico lo que hay que hacer. Son snecillos de entender... PERO NO NOS GUSTAN !!!
    - Es el lenguaje que habitualmente se usa en los scripts: .sh .bat .ps1
    
    > Ejemplo: Pon la silla debajo de la ventana!
- Declarativo: No doy órdenes... digo lo que quiero conseguir:
    > Ejemplo: Debe haber una silla debajo de la ventana!   

---
Si hay un mueble debajo de la ventana:          IF (Condicionales)
    Quitalo!!!
Si no hay sillas:
    Compra una silla !!!
Pon la silla debajo de la ventana!                  IMPERATIVO.  A PRIORI PARECE MÁS SENCILLA / NATURAL
                                                        Quién se come el "pensar lo que hay que hacer"? YO


Debe haber una silla debajo de la ventana!          DECLARATIVO
                                                        Quién se come el "pensar lo que hay que hacer"? EL OTRO / 
                                                                                                        El que va a hacerlo

Ya hay un mueble debajo de la ventana
No hay sillas!!!!

Lenguajes declarativos:
    TERRAFORM
    ANSIBLE
    KUBERNETES
    
    
## PALABRAS QUE USAMOS EN EL LENGUAJE TERRAFORM: Ese lenguaje se llama HCL
                                                                       Hashi Corp Language

PROVIDER:   Alguien a quien podemos contratar servicios
RESOURCE:   Un recurso/servicio que puedo contratar en un provider
DATA
VARIABLE
OUTPUT
PROVISIONER

Terraform es un lenguaje MODULAR.
Tenemos disponible muchos PROVIDERS.... Incluso podemos crear nuestros propios providers.


DEVOPS 
--------------------------------------------------------------------------------
JENKINS: Servidor de automatización (orquestador de trabajos) CI/CD
AZURE DEVOPS (TFS)


Defino una infraestructura que quiero crear en AMAZON: AWS                  ----> TERRAFORM
- 5 servidores
- Conectados en una red
- con unas reglas de red
- 50Gbs de almacenamiento... repartidos entre los servidores de X forma.

Ese programa de TERRAFORM, lo podría aplicar sobre AZURE ! Estaría bonito... NI DE COÑA !!!

Los programas (plantillas donde defino recursos) van TOTALMENTE LIGADAS A UN PROVIDER.