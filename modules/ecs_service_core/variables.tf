variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "cloud_watch_retention_days" {
  type = number
}

variable "vcpus" {
  type = number
}

variable "memory_mb" {
  type = number
}

variable "image_uri" {
  type = string
}

variable "sidecar_image_uri" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "ecs_subnets" {
  type = list(string)
}

variable "ecs_security_group" {
  type = list(string)
}

variable "ecs_task_role_policy" {
  type = string
}

variable "cpu_architecture" {
  type = string
}

variable "container_name" {
  type    = string
  default = "essential_container_name"
}

variable "port_mappings" {
  description = "List of port mappings for the container"
  type        = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = []
}

variable "vcpu_sidecar" {
  type = number
}

variable "memory_mb_sidecar" {
  type = number
}

variable "desired_count" {
  type = number
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

variable "queue_name" {
  type = string
}

variable "aws_autoscaling_policy_arn" {
  type = string
}

variable "alarm_namespace" {
  type = string
}

variable "alarm_base_name" {
  type = string
}

variable "lb_health_check_interval" {
  type = string
}

variable "lb_listener_arn" {
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

variable "health_check_seconds_timeout" {
  type = string
}

variable "health_check_path" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "container_port" {
  type = number
}