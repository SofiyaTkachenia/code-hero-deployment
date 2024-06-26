data "aws_iam_policy_document" "queue_role_assume" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sqs.amazonaws.com"]
    }
  }
}