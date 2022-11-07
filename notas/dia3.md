# Script terraform es qué?

Un conjunto de ficheros* con extensión .tf ( y otras que ya veremos), que usando 
lenguaje declarativo HCL definen un sonjutno de recursos que obtener de un conjunto de proveedores.

Esos script que definimos, podemos aplicarles distintos comandos (estados) en terraform:
Comandos de terraform
- terraform init:       Descarga proveedores desde el terraform registry (y otros que ya veremos) 
                        y genera una huella de los binarios de los proveedores, para su futura comprobación
- terraform validate    Validar la sintaxis del script
- terraform plan        Prepara el plan de ejecución para conseguir el estado deseado
- terraform apply       Aplicar el plan de ejecución para conseguir ese estado
- terraform destroy     Desmantela los recursos que se hubieran creado previamente

* Se deben llamar cómo los archivos? A terraform le da igual, en tanto que tengan extensión .tf (y otras)

Dentro de los ficheros HCL (.tf) encontramos marcas de tipo:

- terraform {...}                           Podemos especificar los proveedores que 
                                            necesitamos (required_providers), 
                                            sus versiones y la versión de terraform
- provider NOMBRE_DE_UN_PROVIDER {... }     Configuraciones necesarias por el proveedor.
- resource TIPO ID_INTERNO                  Cada recursos junto con sus propiedades específicas
- output NOMBRE {...}                       Permitían almacenar** datos de salida (generados) 
                                            por el proveedor al crear un recurso.
                                            Realmente nos permite establecer un nombre PROPIO para los mismos

** Los datos se generan de cualquier forma, y terraform los almacena siempre, todos ellos, 
los haya yo declarado como output o no (terraform.tfstate - En formato JSON).

Para recuperar un output usamos:
$ terraform output [--json | --raw ] NOMBRE_DEL_OUTPUT

# Respecto a la sintaxis HCL:

Los elementos pueden tener propiedades. Esas propiedades pueden ser de distintintos tipos
(hay que acudir a la documentación del provider/resource).

algunos tipos simples son: 
- texto
- valores lógicos
- números
- ...

Pero además hay valores de tipos compuestos: sets, lists, maps.

Todas estas propiedades se escriben en el fichero con la sintaxis:
    Propiedad   = Valor
    numero      = 17
    logico      = true
    texto       = "HOLA"
    lista       = [ 1,2,3 ]
    mapa        = {
                    clave1 = valor1
                    clave2 = valor2
                }
    

Pero hay un tipo de datos muy especial, que conlleva el uso de una sintaxis diferente: BLOCKs

Para los blocks la sintaxis es diferente:

NOMBRE_PROPIEDAD {
    propiedades... tal y como las hemos escrito arriba...
}

Pero además, los block pueden ser de tipo lista o set.... en cuyo caso,
debemos replicar esta entrada anterior en el fichero.


---

# Variables

Permiten personalizar (Parametrizar) un script de terraform.
Las variables tienen su propia marca en la sintaxis: variable

variable NOMBRE {
    description = "LA DESCRIPCION DE LA VARIABLE"
    default     = Valor por defecto que asignar a la variable (NOTA: Esto no lo hacemos)
    type        = (number | string | bool | list | map | any | object)
    sensitive   = true | false
    nullable    = true | false
    validation ...
}

Las variables, dónde (en qué fichero) debo declararlas? En un fichero que se llame como me dé la gana!
Podrían ir en el main.tf... o en el variables.tf o en el vars.tf.
Habitualmente generamos un fichero llamado variables.tf (por convenio)

Las variables las definimos, para usarlas posteriormente. 
Para usarlas, utilizaremos la sintaxis: var.NOMBRE_DE_VARIABLE

IMPORTANTE:

- Las variables se declaran en un fichero con extensión .tf
- Pero, los valores de las variables se establecen en 
  ficheros con extensión .tfvars
- Existe una extensión adicional que es: .auto.tfvars
  Los valores declarados en este fichero, se cargan de forma automática al hacer un
    - terraform apply
    - terraform destroy
  NOTA: Estos valores, reemplazan (sobreescriben) a los valores que se hayan definido 
  como valores por defecto al declarar la variable

NOTA: Podemos indicar que se use un determinado fichero añadiendo a cualquier comando: 
--var-file="variables1.tfvars"

NOTA 2: Los valores de variables definidos en este fichero, sobreescribe a los anteriores.
NOTA 3: Podemos dar tantos ficheros de variables como queramos.

NOTA 4: También se puede ( Y si Iván os ve hacerlo, os corta las uñas muy muy cortito 
        y os mete las manos en un vasito con zumo de limón, pa' que escueza montonón!"!!!")
        Suministrar valores de variables directamente a través de la linea de comandos, 
        usando el argumento:
        --var="VARIABLE=VALOR"
        
    Por qué dice Iván esta gilipollez?
        Dónde queda apuntado el valor de variable con el que despliego??? En ningún lado => RUINA !!!
        
        dónde van a estar guardados estos ficheros? (nuestro script de terraform) En un Sistema de control de versión.
    SUBNOTA 1: Hay algún escenario en el que este comportamiento sea DESEADO? 
                Precisamente cuando no quiero trazabilidad! Por ejemplo: Contraseña!
                
                
# SET vs LIST como tipos de variables

Una variable definida como LIST, garantiza que se mantendrá el ORDEN
    en el que se suministran los elementos
Una variable definida como SET,  NO garantiza que se mantendrá el ORDEN 
    en el que se suministran los elementos
