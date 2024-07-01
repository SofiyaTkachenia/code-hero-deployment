#======SQS==========================================================
resource "aws_sqs_queue" "this" {
  name                       = "${var.base_name}-${var.queue_name}-${var.env_name}"
  delay_seconds              = var.message_delay_period_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.queue_visibility_timeout_seconds

  tags = {
    Name        = "${var.base_name}-${var.queue_name}"
    Environment = var.env_name
  }
}