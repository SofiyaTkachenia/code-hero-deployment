variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "load_balancer_target_group_port" {
  type = number
}

variable "load_balancer_target_group_protocol" {
  type = string
}

variable "load_balancer_target_group_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "load_balancer_target_group_threshold" {
  type = number
}

variable "load_balancer_health_check_interval" {
  type = number
}

variable "load_balancer_target_group_unhealthy_threshold" {
  type = number
}

variable "load_balancer_listener_priority" {
  type = number
}

variable "load_balancer_listener_path_pattern" {
  type = string
}

variable "alb_arn" {
  type = string
}

variable "healthy_check_path" {
  type = string
}

variable "health_check_timeout" {
  type = string
}