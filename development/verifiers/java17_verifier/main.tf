module "s3_bucket" {
  source = "../../../modules/s3bucket"

  base_name = var.base_name
  env_name = var.env_name
}

module "problem_registry_sqs_queue" {
  source = "../../../modules/sqs"

  base_name = var.base_name
  base_queue_name = var.base_problem_registry_queue_name
  delay_seconds = var.delay_seconds
  env_name = var.env_name
}

module "java17_verifier_sqs_queue" {
  source = "../../../modules/sqs"

  base_name = var.base_name
  base_queue_name = var.base_java_17_verifier_queue_name
  delay_seconds = var.delay_seconds
  env_name = var.env_name
}

module "java17_verifier_ecs_service" {
  source = "../../../modules/ecs_service_core"

  cloud_watch_retention_days = var.cloud_watch_retention_days
  base_name = var.base_name
  env_name = var.env_name
  aws_lb_target_group_arn = var.aws_lb_target_group_arn
  cluster_arn = var.cluster_arn
  ecs_security_group = var.ecs_security_group
  ecs_task_role_policy = data.aws_iam_policy_document.ecs_task_role_policy.json
  ecs_subnets = var.ecs_subnets
  sidecar_container_container_port = var.sidecar_container_container_port
  sidecar_container_host_port = var.sidecar_container_host_port
  sidecar_container_image = var.sidecar_container_image
  task_container_port = var.task_container_port
  task_host_port = var.task_host_port
  task_ecr_image_uri = var.task_ecr_image_uri
  memory_mb = var.memory_mb
  vcpus = var.vcpus
  cpu_architecture = var.cpu_architecture
  including_port_mappings = var.including_port_mappings
  include_load_balancer = true
  memory_mb_sidecar = var.memory_mb_sidecar
  vcpu_sidecar = var.vcpu_sidecar
}

module "java17_ecs_service_autoscaling" {
  depends_on = [module.java17_verifier_ecs_service]
  source = "../../../modules/ecs_service_autoscalling"
  aws_ecs_service_name = module.java17_verifier_ecs_service.aws_ecs_service_name
  base_name = var.base_name
  cluster_id = var.cluster_id
  env_name = var.env_name
}

