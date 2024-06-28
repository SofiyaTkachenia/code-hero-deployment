module "java17_sqs_queue" {
  source = "../../../modules/sqs"

  base_name                    = var.base_name
  message_delay_period_seconds = var.message_delay_period_seconds
  env_name                     = var.env_name
  queue_name                   = var.java17_sqs_queue
}

module "java17_compiler_lambda" {
  source = "../../../modules/lambda"

  base_name               = var.base_name
  env_name                = var.env_name
  image_url               = var.image_url
  lambda_name             = var.java17_compiler_lambda_name
  lambda_task_role_policy = data.aws_iam_policy_document.lambda_policy.json
  lambda_timeout_seconds  = var.lambda_timeout_seconds
  lambda_memory_mb        = var.lambda_memory_mb
}

module "lambda_event_source_mapping" {
  source = "../../../modules/lambda_event_source_mapping"

  lambda_arn = module.java17_compiler_lambda.lambda_arn
  queue_arn  = module.java17_sqs_queue.queue_arn
}