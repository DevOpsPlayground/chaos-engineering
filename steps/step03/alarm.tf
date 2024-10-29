resource "aws_cloudwatch_metric_alarm" "lb_alarm" {
  alarm_name          = "${var.panda_name}-elb-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "4"
  metric_name         = "HTTPCode_ELB_5XX"
  namespace           = "AWS/ELB"
  period              = "10"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors the number of healthy hosts."
  datapoints_to_alarm = "2"
  treat_missing_data = "notBreaching"

  dimensions = {
    LoadBalancerName = "${aws_elb.this.name}"
  }
}