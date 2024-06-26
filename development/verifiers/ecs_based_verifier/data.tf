data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sqs:ReceiveMessage"]
    resources = [module.java17_verifier_sqs_queue.queue_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = [var.problem_registry_sqs_queue_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]
    resources = ["*"]
  }
}