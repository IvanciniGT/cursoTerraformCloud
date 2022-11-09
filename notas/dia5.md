# Provisioners

Es un programa que ejecuto durante la creación o eliminación de un recurso.
Para configurar la máquina virtual.

Realmente, para este tipo de configuraciones, tenemos otros programas: 
- Ansible - Python 2.7 + ssh (usuario, clave ssh)
- Puppet
- Chef

Provisionadores en terraform:
- file              Permite copiar archivos al recurso recien adquirido                                 scp
- local-exec        Permite ejecutar un programa en la máquina que ejecuta el script de terraform
- remote-exec       Permite ejecutar un programa en el recurso remoto que hemos adquirido               ssh


# Ansible , Chef, Puppet

Crearmos scripts de configuración e instalación de un sistema.
- Crear usuarios
- Instalar programasCambios en la configruación de un SO

# Pipeline gestionado por herramintas tipo Jenkins

Jenkins -------
 v ^          v
Terraform    Ansible 




inventario.ini
maquina1 IP1
maquina2 IP2
maquina3 IP3
maquina4 IP4
----

Cuando hacemos un programa, solemos agrupar el códido en funciones/procedimientos/métodos.
Por qué?
- Reutilizarlo

Si bién el grueso de el trabajo a realizar por la función / método es siempre el mismo...
Esas funciones suelen admitir parametrización: PARAMETROS, ARGUMENTOS DE ENTRADA (variables)
Normalmente, las funciones devuelven algunos datos.

Este concepto, lo traemos al mundo de terraform con el nombre de MODULOs

Un módulo de terraform es:
- un conjunto de RECURSOS que vamos a generar
- que admiten cierta parametrización 
- y que devuelven unos valores.

-----
Plan hasta fin de curso:
1º Crear un script que genere cosas en AWS (en un cloud real)
    - data
2º Convertir ese script en un módulo
3º Vamos a crear nuevos scripts que usen ese modulo que vamos a haber creado.


Script terraform ---> terraform < ---- providers -----> cli de AWS ----> AWS
 - providers                             AWS
    AWS
 - resources