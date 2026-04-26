#!/bin/bash
set -e

apt update -y
apt install -y python3 python3-pip apache2 libapache2-mod-wsgi-py3

# App-Verzeichnis
mkdir -p /var/www/bottletube

# Environment Variablen aus Tags lesen
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION="eu-central-1"

S3_BUCKET=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=S3_BUCKET" --query "Tags[0].Value" --output text)
DB_HOST=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=DB_HOST" --query "Tags[0].Value" --output text)
DB_SECRET_NAME=$(aws ec2 describe-tags --region $REGION --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=DB_SECRET_NAME" --query "Tags[0].Value" --output text)

echo "export S3_BUCKET=$S3_BUCKET" >> /etc/environment
echo "export DB_HOST=$DB_HOST" >> /etc/environment
echo "export DB_SECRET_NAME=$DB_SECRET_NAME" >> /etc/environment
echo "export AWS_REGION=$REGION" >> /etc/environment

source /etc/environment

# Python Dependencies
pip3 install bottle boto3 psycopg2-binary

systemctl restart apache2
