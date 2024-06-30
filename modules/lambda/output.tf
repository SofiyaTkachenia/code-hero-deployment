output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_cloud_watch_log_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}