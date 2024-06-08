variable "aws_region" {
  type = string
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

variable "task_ecr_image_uri" {
  type = string
}

variable "task_container_port" {
  type = number
}

variable "task_host_port" {
  type = number
}

variable "sidecar_container_image" {
  type = string
}

variable "sidecar_container_container_port" {
  type = number
}

variable "sidecar_container_host_port" {
  type = number
}

variable "aws_lb_target_group_arn" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "ecs_subnets" {
  type    = list(string)
}

variable "ecs_security_group" {
  type    = list(string)
}

variable "ecs_task_role_policy" {
  type    = string
}

variable "cpu_architecture" {
  type = string
}

variable "container_name" {
  type = string
  default = "essentials"
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

variable "include_load_balancer" {
  type = bool
}
