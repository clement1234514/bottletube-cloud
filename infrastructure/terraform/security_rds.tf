resource "aws_security_group" "rds" {
  name        = "bottletube-rds"
  description = "Allow EC2 + local PC to access Postgres"
  vpc_id      = aws_vpc.main.id

  # Zugriff von EC2-Instanzen
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }

  # Zugriff von deinem PC (ersetze durch deine echte IP)
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["YOUR.IP.ADDRESS/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
