#!/bin/bash
sudo apt update
sudo apt install -y python3 python3-pip apache2 libapache2-mod-wsgi-py3
pip3 install bottle boto3 psycopg2-binary
