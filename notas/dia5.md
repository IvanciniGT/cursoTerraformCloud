# Provisioners

Es un programa que ejecuto durante la creación o eliminación de un recurso.
Para configurar la máquina virtual.

Realmente, para este tipo de configuraciones, tenemos otros programas: 
- Ansible - Python 2.7 + ssh (usuario, clave ssh)
- Puppet
- Chef

Provisionadores en terraform:
- file              Permite copiar archivos al recurso recien adquirido
- local-exec        Permite ejecutar un programa en la máquina que ejecuta el script de terraform
- remote-exec       Permite ejecutar un programa en el recurso remoto que hemos adquirido


# Ansible , Chef, Puppet

Crearmos scripts de configuración e instalación de un sistema.
- Crear usuarios
- Instalar programasCambios en la configruación de un SO

# Pipeline gestionado por herramintas tipo Jenkins

Jenkins -------
 v ^          v
Terraform    Ansible 