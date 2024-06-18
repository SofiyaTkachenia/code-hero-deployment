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

variable "aws_lb_target_group_arn" {
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

variable "is_load_balanced" {
  type = bool
}

variable "desired_count" {
  type = number
}
