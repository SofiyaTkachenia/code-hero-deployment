data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = [module.java17_compiler_lambda.lambda_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["sqs:DeleteMessage", "sqs:GetQueueAttributes", "sqs:ReceiveMessage", "sqs:SendMessage"]
    resources = [module.java17_compiler_lambda.lambda_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = [module.java17_compiler_lambda.lambda_arn]
  }
}

data "aws_iam_policy_document" "queue_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:CreateEventSourceMapping", "lambda:ListEventSourceMappings", "lambda:ListFunctions"]
    resources = [module.java17_sqs_queue.queue_arn]
  }
}