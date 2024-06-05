variable "aws_region" {
  type = string
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

variable "base_java_17_verifier_queue_name" {
  type = string
}

variable "delay_seconds" {
  type = string
}

variable "cloud_watch_retention_days" {
  type = number
}

variable "aws_lb_listener_arn" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "cluster_id" {
  type = string
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

variable "memory_mb" {
  type = number
}

variable "vcpus" {
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

variable "ecs_subnets" {
  type    = list(string)
}

variable "ecs_security_group" {
  type    = list(string)
}

variable "aws_lb_target_group_arn" {
  type = string
}


