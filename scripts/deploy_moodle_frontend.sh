#!/bin/bash
 
# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
 apt update
# Actualizamos los paquetes del sistema
# apt upgrade -y

# Importamos variables de configuracion
source .env

# Eliminamos las descargas previas
rm -rf /tmp/v4.3.1.zip
rm -rf /tmp/moodle-4-3-1

# Descargamos la herramienta wp-cli 
wget https://github.com/moodle/moodle/archive/refs/tags/v4.3.1.zip -P /tmp

# Instalamos zip para descomprimir 
apt install unzip

# Descomprimimos el archivo
unzip /tmp/v4.3.1.zip -d /tmp

# Crear una carpeta para los datos de moodle por seguridad
mkdir /var/www/moodledata

# Dar permisos a la carpeta
chmod 777 /var/www/moodledata

# Mover los archivos de la carpeta moodle al directorio html
mv -f /tmp/moodle-4.3.1/* /var/www/html

# Instalación de Moodle
sudo -u www-data php /var/www/html/admin/cli/install.php \
    --lang=$MOODLE_LANG \
    --wwwroot=$MOODLE_WWWROOT \
    --dataroot=$MOODLE_DATAROOT \
    --dbtype=$MOODLE_DB_TYPE \
    --dbhost=$MOODLE_DB_HOST \
    --dbname=$MOODLE_DB_NAME \
    --dbuser=$MOODLE_DB_USER \
    --dbpass=$MOODLE_DB_PASSWORD \
    --fullname="$MOODLE_FULLNAME" \
    --shortname="$MOODLE_SHORTNAME" \
    --summary="$MOODLE_SUMARY" \
    --adminuser=$MOODLE_ADMIN_USER \
    --adminpass=$MOODLE_ADMIN_PASS \
    --adminemail=$MOODLE_ADMIN_EMAIL \
    --non-interactive \
    --agree-license
