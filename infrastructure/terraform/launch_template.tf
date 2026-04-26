resource "aws_launch_template" "bottletube" {
  name_prefix   = "bottletube-"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  user_data = base64encode(file("${path.module}/../scripts/setup.sh"))

  network_interfaces {
    security_groups = [aws_security_group.ec2.id]
  }

  lifecycle {
    create_before_destroy = true
  }
metadata_options {
  http_tokens = "required"
}

tag_specifications {
  resource_type = "instance"

  tags = {
    S3_BUCKET       = aws_s3_bucket.bottletube.bucket
    DB_HOST         = aws_db_instance.bottletube.address
    DB_SECRET_NAME  = aws_secretsmanager_secret.db.name
    AWS_REGION      = var.region
  }
}
}
