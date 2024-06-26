module "problem_registry_sqs_queue" {
  source = "../../modules/sqs"

  base_name     = var.base_name
  delay_seconds = var.delay_seconds
  env_name      = var.env_name
  queue_name    = var.queue_name
}