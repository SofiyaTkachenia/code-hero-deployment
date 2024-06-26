resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn = var.queue_arn
  enabled          = true
  function_name    = var.lambda_arn
  batch_size       = var.batch_size
}