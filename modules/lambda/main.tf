resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${var.base_name}-${var.lambda_name}-${var.env_name}}"
  retention_in_days = var.cloud_watch_retention_days
}

#======IAM=========================================================
resource "aws_iam_role" "lambda_role" {
  name               = "${var.base_name}-${var.lambda_name}-role-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.lambda_role_assume.json
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name   = "${var.base_name}-${var.lambda_name}-policy-${var.env_name}"
  policy = var.lambda_task_role_policy
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

#======Lambda=======================================================
resource "aws_lambda_function" "this" {
  function_name = "${var.base_name}-${var.lambda_name}-${var.env_name}"
  architectures = ["arm64"]
  timeout       = var.lambda_timeout_seconds
  image_uri     = var.image_url
  memory_size   = var.lambda_memory_mb
  package_type  = "Image"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = var.lambda_env_variables
  }

  vpc_config {
    subnet_ids         = var.subnet_id
    security_group_ids = var.security_group_ids
  }
}