resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_base_name}-${var.env_name}"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.alarm_namespace
  period              = var.statistic_period
  statistic           = var.statistic_type
  threshold           = var.threshold
  actions_enabled     = true
  alarm_actions       = [var.aws_autoscaling_policy_arn]
  ok_actions          = [var.aws_autoscaling_policy_arn]

  dimensions = {
    QueueName = var.queue_name
  }
}