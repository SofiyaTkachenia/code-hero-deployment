#======SQS==================================================

resource "aws_sqs_queue" "this" {
  name                      = "${var.base_name}-${var.base_queue_name}-sqs-queue"
  delay_seconds             = var.delay_seconds
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Name        = var.base_queue_name
    Environment = var.env_name
  }
}


