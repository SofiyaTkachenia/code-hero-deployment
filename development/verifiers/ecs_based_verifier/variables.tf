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

variable "queue_name" {
  type = string
}

variable "message_delay_period_seconds" {
  type = string
}

variable "cloud_watch_retention_days" {
  type = number
}

variable "image_uri" {
  type = string
}

variable "memory_mb" {
  type = number
}

variable "vcpus" {
  type = number
}

variable "sidecar_image_uri" {
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

variable "vcpu_sidecar" {
  type = number
}

variable "memory_mb_sidecar" {
  type = number
}

variable "health_check_seconds_timeout" {
  type = string
}

variable "health_check_path" {
  type = string
}

variable "lb_health_check_interval" {
  type = string
}

variable "lb_listener_path_pattern" {
  type = string
}

variable "lb_rule_priority" {
  type = number
}

variable "lb_target_group_port" {
  type = number
}

variable "lb_target_group_threshold" {
  type = number
}

variable "lb_target_group_unhealthy_threshold" {
  type = number
}

variable "lb_target_group_type" {
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

variable "is_load_balanced" {
  type = bool
}

variable "port_mappings" {
  description = "List of port mappings for the container"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = []
}

variable "container_port" {
  type = number
}

variable "problem_registry_sqs_queue_arn" {
  type = string
}

variable "queue_visibility_timeout_seconds" {
  type = number
}

variable "listener_arn" {
  type = string
}