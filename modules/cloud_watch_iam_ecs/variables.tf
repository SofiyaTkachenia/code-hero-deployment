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

variable "sqs_queue_for_pulling_messages" {
  type = string
}

variable "sqs_queue_for_pushing_messages" {
  type = string
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

variable "aws_lb_listener_arn" {
  type = string
}

variable "aws_lb_target_group_arn" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "ecs_subnets" {
  type    = list(string)
}

variable "ecs_security_group" {
  type    = list(string)
}