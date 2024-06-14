variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "aws_ecs_service_name" {
  type = string
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

variable "adjustment_type" {
  type = string
}

variable "coooldown" {
  type = number
}

variable "metric_aggregation_type" {
  type = string
}

variable "dynamic_step_adjustments" {
  type = list(object({
    scaling_adjustment            = number
    metric_interval_lower_bound    = number
    metric_interval_upper_bound    = number
  }))
}

variable "max_containers" {
  type = number
}

variable "max_messages_in_the_queue" {
  type = number
}