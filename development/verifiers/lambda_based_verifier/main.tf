module "java17_sqs_queue" {
  source = "../../../modules/sqs"

  base_name         = var.base_name
  delay_seconds     = var.delay_seconds
  env_name          = var.env_name
  queue_name        = var.java17_sqs_queue
}

module "java17_compiler_lambda" {
  source = "../../../modules/lambda"

  base_name               = var.base_name
  env_name                = var.env_name
  image_url               = var.image_url
  lambda_name             = var.java17_compiler_lambda_name
  lambda_task_role_policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  lambda_timeout          = var.lambda_timeout
  lambda_memory           = var.lambda_memory
}

module "lambda_event_source_mapping" {
  source = "../../../modules/lambda_event_source_mapping"

  batch_size = var.batch_size
  lambda_arn = module.java17_compiler_lambda.lambda_arn
  queue_arn  = module.java17_sqs_queue.queue_arn
}

