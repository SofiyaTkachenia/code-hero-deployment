module "s3bucket" {
  source = "../modules/s3bucket"

  base_name = var.base_name
  env_name = var.env_name
}

module "ProblemRegistrySQSQueue" {
  source = "../modules/sqs"

  base_name = var.base_name
  base_queue_name = var.base_problem_registry_queue_name
  delay_seconds = var.delay_seconds
  env_name = var.env_name
}

module "Java17VerifierSQSQueue" {
  source = "../modules/sqs"

  base_name = var.base_name
  base_queue_name = var.base_java_17_verifier_queue_name
  delay_seconds = var.delay_seconds
  env_name = var.env_name
}

module "Java17VerifierECSService" {
  source = "../modules/cloud_watch_iam_ecs"
  depends_on = [module.Java17VerifierSQSQueue, module.ProblemRegistrySQSQueue]

  cloud_watch_retention_days = var.cloud_watch_retention_days
  base_name = var.base_name
  env_name = var.env_name
  aws_lb_listener_arn = var.aws_lb_listener_arn
  aws_lb_target_group_arn = var.aws_lb_target_group_arn
  cluster_arn = var.cluster_arn
  cluster_id = var.cluster_id
  ecs_security_group = var.ecs_security_group
  ecs_subnets = var.ecs_subnets
  sidecar_container_container_port = var.sidecar_container_container_port
  sidecar_container_host_port = var.sidecar_container_host_port
  sidecar_container_image = var.sidecar_container_image
  sqs_queue_for_pulling_messages = module.Java17VerifierSQSQueue.queue_arn
  sqs_queue_for_pushing_messages = module.ProblemRegistrySQSQueue.queue_arn
  task_container_port = var.task_container_port
  task_host_port = var.task_host_port
  task_ecr_image_uri = var.task_ecr_image_uri
  memory_mb = var.memory_mb
  vcpus = var.vcpus
}

