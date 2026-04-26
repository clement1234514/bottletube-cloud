 Übersicht
Dieses Projekt implementiert die Anwendung BottleTube auf einer skalierbaren AWS‑Infrastruktur.
Die Lösung erfüllt alle Pflichtanforderungen sowie die beiden Bonuspunkte (HTTPS + Healthcheck).
Die Infrastruktur wird vollständig mit Terraform bereitgestellt.
Die Anwendung läuft auf EC2‑Instanzen hinter einem Application Load Balancer und nutzt:
- S3 für Bilder
- RDS Postgres für Metadaten
- Secrets Manager für Credentials
- Auto Scaling Group für Skalierung
- Apache + WSGI für Deployment

Architektur
Komponenten:
- EC2 Auto Scaling Group
- min = 1
- desired = 2
- max = 3
- Launch Template mit User‑Data
- Apache + WSGI Deployment
- Environment Variables über Tags
- Application Load Balancer (ALB)
- Listener: HTTP (80)
- Optional: HTTPS (443, ACM Zertifikat)
- Health Checks auf /
- S3 Bucket
- Speicherung aller Bilder
- Zugriff über boto3
- RDS Postgres
- Nicht öffentlich
- Zugriff nur von EC2 + meinem PC
- DB‑Tabelle images
- Secrets Manager
- Speicherung von DB‑Credentials
- Abruf in der App
- VPC
- 2 Public Subnets
- Internet Gateway
- Routing

Anwendung (BottleTube)
Funktionen:
- Upload neuer Bilder
- Speicherung in S3
- Speicherung der Metadaten in RDS
- Anzeige aller Bilder
- DB‑Initialisierung beim Start
Wichtige Dateien:
- app/bottletube/__init__.py – Hauptlogik
- app/bottletube/db.py – DB‑Verbindung
- app/bottletube/init_db.py – Tabellen‑Erstellung
- app/wsgi.py – WSGI Entry Point

Infrastruktur (Terraform)
Struktur:
infrastructure/
├── terraform/
│   ├── main.tf
│   ├── vpc.tf
│   ├── s3.tf
│   ├── rds.tf
│   ├── secrets.tf
│   ├── security_*.tf
│   ├── alb*.tf
│   ├── asg*.tf
│   └── variables.tf
└── scripts/
    ├── setup.sh
    └── bottletube.conf


Sicherheit
- EC2‑Security Group erlaubt nur Traffic vom ALB
- RDS‑Security Group erlaubt nur:
- EC2‑Instanzen
- meine eigene IP
- Keine öffentliche Datenbank
- Secrets Manager statt Klartext‑Passwörter
- HTTPS über ACM (Bonus)

 Auto Scaling & Stresstest
Scaling Policy:
- CPU > 60% → neue Instanz wird gestartet
- Cooldown: 60 Sekunden


