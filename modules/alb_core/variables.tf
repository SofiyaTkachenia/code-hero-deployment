variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "is_lb_internal" {
  type = bool
}

variable "lb_type" {
  type = string
}

variable "lb_subnets" {
  type = list(string)
}

variable "lb_security_group" {
  type = string
}