#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Variables de entorno
source .env

# Crear la base de datos y el usuario para moodle y adminer
mysql -u root <<< "DROP DATABASE IF EXISTS $MOODLE_DB_NAME"
mysql -u root <<< "CREATE DATABASE $MOODLE_DB_NAME"
mysql -u root <<< "DROP USER IF EXISTS $MOODLE_DB_USER@'$IP_CLIENTE_MYSQL'"
mysql -u root <<< "CREATE USER $MOODLE_DB_USER@'$IP_CLIENTE_MYSQL' IDENTIFIED BY '$MOODLE_DB_PASSWORD'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $MOODLE_DB_NAME.* TO $MOODLE_DB_USER@'$IP_CLIENTE_MYSQL'"