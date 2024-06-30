module "java17_solutions" {
  source = "../../../modules/sqs"

  base_name                    = var.base_name
  message_delay_period_seconds = var.message_delay_period_seconds
  env_name                     = var.env_name
  queue_name                   = var.java17_sqs_queue
}

module "java17_compiler_lambda" {
  source = "../../../modules/lambda"

  base_name                  = var.base_name
  env_name                   = var.env_name
  image_url                  = var.image_url
  lambda_name                = var.java17_compiler_lambda_name
  lambda_task_role_policy    = data.aws_iam_policy_document.lambda_policy.json
  lambda_timeout_seconds     = var.lambda_timeout_seconds
  lambda_memory_mb           = var.lambda_memory_mb
  cloud_watch_retention_days = var.cloud_watch_retention_days
  security_group_ids         = var.security_group_ids
  subnet_id                  = var.subnet_id
}

resource "aws_lambda_event_source_mapping" "this" {
  event_source_arn = module.java17_solutions.queue_arn
  enabled          = true
  function_name    = module.java17_compiler_lambda.lambda_arn
  batch_size       = 1
}