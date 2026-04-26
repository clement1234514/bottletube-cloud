#!/bin/bash
cd /var/www/bottletube
pip3 install -r requirements.txt
systemctl restart apache2
