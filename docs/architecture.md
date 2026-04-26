# Architektur

Die Anwendung besteht aus:
- EC2-Instanzen in einer Auto Scaling Group
- Application Load Balancer
- S3 Bucket für Bilder
- RDS Postgres Datenbank
- Secrets Manager für DB Credentials
- AMI für schnelles Bootstrapping
