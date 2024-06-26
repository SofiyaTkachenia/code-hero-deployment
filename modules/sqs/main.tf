#======IAM=========================================================
resource "aws_iam_role" "queue_role" {
  name               = "iam_for_queue"
  assume_role_policy = data.aws_iam_policy_document.queue_role_assume.json
}

resource "aws_iam_policy" "iam_policy_for_queue" {
  name   = "${var.base_name}-${var.queue_name}-${var.env_name}"
  policy = var.queue_role_policy
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.queue_role.name
  policy_arn = aws_iam_policy.iam_policy_for_queue.arn
}

#======SQS==========================================================

resource "aws_sqs_queue" "this" {
  name = "${var.base_name}-${var.queue_name}-${var.env_name}"
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  tags = {
    Name        = "${var.base_name}-${var.queue_name}"
    Environment = var.env_name
  }
}


