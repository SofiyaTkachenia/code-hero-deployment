variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "lb_target_group_port" {
  type = number
}

variable "lb_target_group_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "lb_target_group_threshold" {
  type = number
}

variable "lb_health_check_interval" {
  type = string
}

variable "lb_target_group_unhealthy_threshold" {
  type = number
}

variable "lb_rule_priority" {
  type = number
}

variable "lb_listener_path_pattern" {
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