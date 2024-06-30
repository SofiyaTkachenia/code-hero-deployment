data "aws_iam_policy_document" "lambda_policy" {

  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = [var.s3_put_object_bucket_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = [var.s3_get_object_bucket_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["sqs:DeleteMessage", "sqs:GetQueueAttributes", "sqs:ReceiveMessage"]
    resources = [var.get_messages_queue_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = [var.send_messages_queue_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = [module.java17_compiler_lambda.lambda_cloud_watch_log_group_arn]
  }
}