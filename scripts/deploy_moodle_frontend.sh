#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Descargar herramienta unzip
apt install unzip

# Variables de entorno
source .env

# Borrar instalaciones previas
rm -rf /tmp/v4.3.1.zip
rm -rf /var/www/html/*
rm -rf /tmp/moodle-4.3.1
rm -rf /var/www/moodledata

# Descargar el zip de Moodle
wget https://github.com/moodle/moodle/archive/refs/tags/v4.3.1.zip -P /tmp

# Descomprimir el zip de Moodle en la carpeta tmp
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
        --dbpass=$MOODLE_DB_PASS \
        --fullname="$MOODLE_FULLNAME" \
        --shortname="$MOODLE_SHORTNAME" \
        --summary="$MOODLE_SUMMARY" \
        --adminuser=$MOODLE_ADMIN_USER \
        --adminpass=$MOODLE_ADMIN_PASS \
        --adminemail=$MOODLE_ADMIN_EMAIL \
        --non-interactive \
        --agree-license


# Copiar archivo htaccess
cp -f ../htaccess/.htaccess /var/www/html

# Cambiar el propietario de la carpeta /var/www/html/
chown -R www-data:www-data /var/www/html/