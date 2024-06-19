module "problem_registry_sqs_queue" {
  source = "../../modules/sqs"

  base_name       = var.base_name
  base_queue_name = var.base_problem_registry_queue_name
  delay_seconds   = var.delay_seconds
  env_name        = var.env_name
}