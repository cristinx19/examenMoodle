#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -x

# Variables de configuración
source .env

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Instalacion de Adminer
mkdir -p /var/www/html/adminer
wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -P /var/www/html/
mv /var/www/html/adminer-4.8.1-mysql.php /var/www/html/index.php