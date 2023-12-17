#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -ex

# Importamos las variables
source .env

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Instalamos MySQL Server
apt install mysql-server -y

# Configuramos el parametro bind-addreess
sed -i "s/127.0.0.1/$MOODLE_DB_HOST/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de mysql
systemctl restart mysql