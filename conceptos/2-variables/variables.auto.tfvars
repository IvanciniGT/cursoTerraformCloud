software            = "mariadb"           # El valor, debe ir en formato JSON
software_version    = "10.9.1"         
arranque_automatico_contenedor = true
variables_entorno = [
        "MARIADB_ROOT_PASSWORD=password",
        "MARIADB_DATABASE=midb",
        "MARIADB_USER=usuario",
        "MARIADB_PASSWORD=password"
    ]
    