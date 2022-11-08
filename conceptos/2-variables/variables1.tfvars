software_version    = "10.9.2" 
puertos_expuestos       =  [
                                {
                                        interno = 3306
                                        externo = 33306
                                        protocolo = "udp"   # tcp | udp    # contains
                                        ip = "0.0.0.0" # expresiones regulares!
                                },
                                {
                                        interno = 80
                                        externo = 8080
                                        protocolo = "tcp"   # tcp | udp    # contains
                                } 
                           ]
#variables_entorno       = [
#                        "MARIADB_ROOT_PASSWORD=password", 
#                        "MARIADB_DATABASE=midb",
#                        "MARIADB_USER=usuario",
#                        "MARIADB_PASSWORD=password"
#                        ] # Comportamiento implitito!

variables_entorno        = [
                                {
                                        nombre = "MARIADB_ROOT_PASSWORD"
                                        valor  = "password"
                                },
                                {
                                        nombre = "MARIADB_DATABASE"
                                        valor  = "midb"
                                },
                                {
                                        nombre = "MARIADB_USER"
                                        valor  = "usuario"
                                },
                                {
                                        nombre = "MARIADB_PASSWORD"
                                        valor  = "password"
                                },
                           ]
                           
cuota_cpu               = 1024
                           