data "aws_iam_policy_document" "ecs_task_role_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = [module.java17_compiler_lambda.lambda_arn]
  }
}