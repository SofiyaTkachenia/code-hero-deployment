variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "base_name" {
  type = string
}

variable "queue_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "delay_seconds" {
  type = string
}