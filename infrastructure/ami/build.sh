#!/bin/bash
set -e

apt update
apt install -y python3 python3-pip apache2 libapache2-mod-wsgi-py3 git

mkdir -p /var/www/bottletube
cd /var/www/bottletube

# App wird später per Launch Template oder Git Pull aktualisiert
pip3 install bottle boto3 psycopg2-binary

systemctl enable apache2
