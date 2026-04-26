#!/bin/bash
apt update -y
apt install -y python3 python3-pip apache2 libapache2-mod-wsgi-py3

mkdir -p /var/www/bottletube
cd /var/www/bottletube

# App wird später per Git oder AMI bereitgestellt
pip3 install bottle boto3 psycopg2-binary

systemctl restart apache2
