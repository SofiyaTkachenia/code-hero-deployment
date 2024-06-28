module "java17_verifier_sqs_queue" {
  source = "../../../modules/sqs"

  base_name     = var.base_name
  delay_seconds = var.delay_seconds
  env_name      = var.env_name
  queue_name    = var.queue_name
}

module "cluster" {
  source = "../../../modules/ecs_cluster"

  base_name = var.base_name
  env_name  = var.env_name
}

module "java17_ecs_service_autoscaling" {
  source = "../../../modules/ecs_service_autoscalling_step_scalling"

  aws_ecs_service_name         = module.java17_verifier_ecs_service.aws_ecs_service_name
  base_name                    = var.base_name
  cluster_id                   = module.cluster.cluster_id
  autoscaling_cooldown_seconds = var.autoscaling_cooldown_seconds
  env_name                     = var.env_name
  max_capacity                 = var.max_capacity
  metric_aggregation_type      = var.metric_aggregation_type
  min_capacity                 = var.min_capacity
  policy_type                  = var.policy_type
  dynamic_step_adjustments     = var.dynamic_step_adjustments
  max_replicas                 = var.max_replicas
  max_messages_in_the_queue    = var.max_messages_in_the_queue
}

module "java17_verifier_ecs_service" {
  source = "../../../modules/ecs_service"

  alarm_base_name                     = var.alarm_base_name
  alarm_namespace                     = var.alarm_namespace
  aws_autoscaling_policy_arn          = module.java17_ecs_service_autoscaling.autoscaling_policy_arn
  base_name                           = var.base_name
  cloud_watch_retention_days          = var.cloud_watch_retention_days
  cluster_arn                         = var.cluster_arn
  comparison_operator                 = var.comparison_operator
  container_port                      = var.container_port
  cpu_architecture                    = var.cpu_architecture
  desired_count                       = var.desired_count
  ecs_security_group                  = var.ecs_security_group
  ecs_subnets                         = var.ecs_subnets
  ecs_task_role_policy                = data.aws_iam_policy_document.ecs_task_role_policy.json
  env_name                            = var.env_name
  evaluation_periods                  = var.evaluation_periods
  health_check_path                   = var.health_check_path
  health_check_seconds_timeout        = var.health_check_seconds_timeout
  image_uri                           = var.image_uri
  lb_health_check_interval            = var.lb_health_check_interval
  lb_listener_path_pattern            = var.lb_listener_path_pattern
  lb_rule_priority                    = var.lb_rule_priority
  lb_target_group_port                = var.lb_target_group_port
  lb_target_group_threshold           = var.lb_target_group_threshold
  lb_target_group_type                = var.lb_target_group_type
  lb_target_group_unhealthy_threshold = var.lb_target_group_unhealthy_threshold
  memory_mb                           = var.memory_mb
  memory_mb_sidecar                   = var.memory_mb_sidecar
  metric_name                         = var.metric_name
  queue_name                          = module.java17_verifier_sqs_queue.queue_name
  sidecar_image_uri                   = var.sidecar_image_uri
  statistic_period                    = var.statistic_period
  statistic_type                      = var.statistic_type
  threshold                           = var.threshold
  vcpu_sidecar                        = var.vcpu_sidecar
  vcpus                               = var.vcpus
  vpc_id                              = var.vpc_id
}

module "alb_listener" {
  source = "../../../modules/alb_listener"

  alb_arn                  = ""
  aws_lb_target_group_arn  = ""
  lb_listener_path_pattern = ""
  lb_rule_priority         = 0
  lb_target_group_port     = 0
}