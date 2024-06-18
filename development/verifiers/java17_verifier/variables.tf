variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "base_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "base_problem_registry_queue_name" {
  type = string
}

variable "base_java_17_verifier_queue_name" {
  type = string
}

variable "delay_seconds" {
  type = string
}

variable "cloud_watch_retention_days" {
  type = number
}

variable "cluster_arn" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "task_ecr_image_uri" {
  type = string
}

variable "task_container_port" {
  type = number
}

variable "task_host_port" {
  type = number
}

variable "memory_mb" {
  type = number
}

variable "vcpus" {
  type = number
}

variable "sidecar_container_image" {
  type = string
}

variable "ecs_subnets" {
  type = list(string)
}

variable "ecs_security_group" {
  type = list(string)
}

variable "cpu_architecture" {
  type = string
}

variable "including_port_mappings" {
  type = bool
}

variable "vcpu_sidecar" {
  type = number
}

variable "memory_mb_sidecar" {
  type = number
}

variable "is_load_balancer_internal" {
  type = bool
}

variable "load_balancer_type" {
  type = string
}

variable "load_balancer_subnets" {
  type = list(string)
}

variable "load_balancer_security_group" {
  type = string
}

variable "health_check_timeout" {
  type = string
}

variable "healthy_check_path" {
  type = string
}

variable "load_balancer_health_check_interval" {
  type = string
}

variable "load_balancer_listener_path_pattern" {
  type = string
}

variable "load_balancer_listener_priority" {
  type = number
}

variable "load_balancer_target_group_port" {
  type = number
}

variable "load_balancer_target_group_protocol" {
  type = string
}

variable "load_balancer_target_group_threshold" {
  type = number
}

variable "load_balancer_target_group_unhealthy_threshold" {
  type = number
}

variable "load_balancer_target_group_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "alarm_base_name" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "evaluation_periods" {
  type = number
}

variable "metric_name" {
  type = string
}

variable "statistic_period" {
  type = number
}

variable "statistic_type" {
  type = string
}

variable "threshold" {
  type = number
}

variable "max_capacity" {
  type = number
}

variable "min_capacity" {
  type = number
}

variable "policy_type" {
  type = string
}

variable "autoscaling_cooldown_seconds" {
  type = number
}

variable "metric_aggregation_type" {
  type = string
}

variable "alarm_namespace" {
  type = string
}

variable "dynamic_step_adjustments" {
  type = list(object({
    scaling_adjustment          = number
    metric_interval_lower_bound = number
    metric_interval_upper_bound = number
  }))
}

variable "max_replicas" {
  type = number
}

variable "max_messages_in_the_queue" {
  type = number
}

variable "desired_count" {
  type = number
}
