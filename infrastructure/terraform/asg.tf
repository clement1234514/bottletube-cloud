resource "aws_autoscaling_group" "bottletube" {
  name                      = "bottletube-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_type         = "ELB"
  health_check_grace_period = 30

  vpc_zone_identifier = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  launch_template {
    id      = aws_launch_template.bottletube.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.bottletube.arn
  ]

  tag {
    key                 = "Name"
    value               = "bottletube-instance"
    propagate_at_launch = true
  }
}
