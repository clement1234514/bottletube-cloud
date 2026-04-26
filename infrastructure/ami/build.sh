#!/bin/bash
set -e

apt update -y
apt install -y python3 python3-pip apache2 libapache2-mod-wsgi-py3 git

# App-Verzeichnis
mkdir -p /var/www/bottletube

# Apache Config kopieren
cp /tmp/bottletube.conf /etc/apache2/sites-available/bottletube.conf
a2ensite bottletube
a2dissite 000-default
systemctl reload apache2

# Python Dependencies
pip3 install bottle boto3 psycopg2-binary
