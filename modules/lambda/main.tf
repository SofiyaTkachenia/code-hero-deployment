#======IAM=========================================================
resource "aws_iam_role" "lambda_role" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda_role_assume.json
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name   = "${var.base_name}-${var.lambda_name}-${var.env_name}"
  policy = var.lambda_task_role_policy
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

#======Lambda=======================================================
resource "aws_lambda_function" "profile_faker_function" {
  function_name = "${var.base_name}-${var.lambda_name}-${var.env_name}"
  timeout       = var.lambda_timeout
  image_uri     = var.image_url
  package_type  = "Image"

  role = aws_iam_role.lambda_role.arn

  environment {
    variables = var.lambda_env_variables
  }
}