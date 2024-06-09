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

module "load_balancer" {
  source = "../../../modules/alb_core"
  base_name = var.base_name
  env_name = var.env_name
  is_load_balancer_internal = var.is_load_balancer_internal
  load_balancer_security_group = var.load_balancer_security_group
  load_balancer_subnets = var.load_balancer_subnets
  load_balancer_type = var.load_balancer_type
}

module "load_balancer_target_group" {
  source = "../../../modules/alb_target_group"
  alb_arn = module.load_balancer.alb_arn
  base_name = var.base_name
  env_name = var.env_name
  health_check_timeout = var.health_check_timeout
  healthy_check_path = var.healthy_check_path
  load_balancer_health_check_interval = var.load_balancer_health_check_interval
  load_balancer_listener_path_pattern = var.load_balancer_listener_path_pattern
  load_balancer_listener_priority = var.load_balancer_listener_priority
  load_balancer_target_group_port = var.load_balancer_target_group_port
  load_balancer_target_group_protocol = var.load_balancer_target_group_protocol
  load_balancer_target_group_threshold = var.load_balancer_target_group_threshold
  load_balancer_target_group_type = var.load_balancer_target_group_type
  load_balancer_target_group_unhealthy_threshold = var.load_balancer_target_group_unhealthy_threshold
  vpc_id = var.vpc_id
}

module "java17_verifier_ecs_service" {
  source = "../../../modules/ecs_service_core"

  cloud_watch_retention_days = var.cloud_watch_retention_days
  base_name = var.base_name
  env_name = var.env_name
  aws_lb_target_group_arn = module.load_balancer_target_group.target_group_arn
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

