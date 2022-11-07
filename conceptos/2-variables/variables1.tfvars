software_version    = "10.9.2" 
puertos_expuestos       =  [
                                {
                                        interno = 3306
                                        externo = 33306
                                },
                                {
                                        interno = 80
                                        externo = 8080
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
                           