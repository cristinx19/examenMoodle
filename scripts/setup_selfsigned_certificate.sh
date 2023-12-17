#!/bin/bash

# Para mostrar los comandos que se van ejecutando
set -ex

# Actualizamos la lista de repositorios
apt update
# apt upgrade -y

# Importamos el archivo .env
source .env

# Creamos el certificado autofirmado
openssl req \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=$OPENSSL_COUNTRY/ST=$OPENSSL_PROVINCE/L=$OPENSSL_LOCALITY/O=$OPENSSL_ORGANIZATION/OU=$OPENSSL_ORGUNIT/CN=$OPENSSL_DOMAIN/emailAddress=$CERTIFICATE_EMAIL"

# Copiamos el archivo de VirtualHost de SSL/TLS
cp ../conf/default-ssl.conf /etc/apache2/sites-available

# Habilitamos el VirtualHost que acabamos de crear
a2ensite default-ssl.conf

# Habilitamos el módulo de SSL
a2enmod ssl

# Copiamos el archivo de VirtualHost de HTTP
cp ../conf/000-default.conf /etc/apache2/sites-available

# Habilitamos el módulo rewrite
a2enmod rewrite

# Reiniciamos el servicio de Apache
systemctl restart apache2