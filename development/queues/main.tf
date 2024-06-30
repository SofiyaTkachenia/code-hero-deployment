module "problem_registry_sqs_queue" {
  source = "../../modules/sqs"

  base_name                    = var.base_name
  env_name                     = var.env_name
  message_delay_period_seconds = var.message_delay_period_seconds
  queue_name                   = var.queue_name
}