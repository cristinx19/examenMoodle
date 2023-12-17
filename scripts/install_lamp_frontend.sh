#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Instalar apache
apt install apache2 -y

# Instalación de PHP y sus extensiones
apt install php php-mysql libapache2-mod-php php-xml php-mbstring php-curl php-zip php-gd php-intl php-soap -y

# Configuración del parámetro max_input_vars en el archivo php-ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.1/apache2/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.1/cli/php.ini

# Copiamos en archivo de configuracion de Apache
cp ../conf/000-default.conf /etc/apache2/sites-available

# Activamos el módulo de reescritura de URLs de Apache
sudo a2enmod rewrite

# Reiniciamos el servicio de Apache
sudo systemctl restart apache2

# Copiamos el archivo de prueba de PHP
cp ../php/index.php /var/www/html

# Cambiamos el usuario y el propietario del directorio /var/www/html
chown -R www-data:www-data /var/www/html