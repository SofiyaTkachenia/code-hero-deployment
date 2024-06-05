data "aws_iam_policy_document" "ecs_tasks_role_assume" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ecs_sqs_task_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sqs:ReceiveMessage"]
    resources = [var.sqs_queue_for_pulling_messages]
  }

  statement {
    effect = "Allow"
    actions = ["sqs:SendMessage"]
    resources = [var.sqs_queue_for_pushing_messages]
  }
}


