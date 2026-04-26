resource "aws_autoscaling_policy" "cpu_scale_up" {
  name                   = "cpu-scale-up"
  autoscaling_group_name = aws_autoscaling_group.bottletube.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 60

  alarm_actions = [
    aws_autoscaling_policy.cpu_scale_up.arn
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.bottletube.name
  }
}
