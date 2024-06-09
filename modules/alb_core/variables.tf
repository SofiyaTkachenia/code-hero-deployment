variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "load_balancer_type" {
  type = string
}

variable "load_balancer_subnets" {
  type = list(string)
}

variable "load_balancer_security_group" {
  type = list(string)
}