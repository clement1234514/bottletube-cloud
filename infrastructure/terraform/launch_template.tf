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
}
