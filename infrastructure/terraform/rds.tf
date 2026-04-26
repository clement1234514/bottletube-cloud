resource "aws_db_subnet_group" "bottletube" {
  name       = "bottletube-db-subnet-group"
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

resource "aws_db_instance" "bottletube" {
  identifier              = "bottletube-db"
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = "bottletube"
  password                = "SuperSicheresPasswort123!"
  db_subnet_group_name    = aws_db_subnet_group.bottletube.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}
