
variable "lb_target_group_port" {
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

variable "aws_lb_target_group_arn" {
  type = string
}