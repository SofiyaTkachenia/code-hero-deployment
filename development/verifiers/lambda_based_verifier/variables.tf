variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "base_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "java17_sqs_queue" {
  type = string
}

variable "message_delay_period_seconds" {
  type = number
}

variable "image_url" {
  type = string
}

variable "java17_compiler_lambda_name" {
  type = string
}

variable "lambda_timeout_seconds" {
  type = number
}

variable "lambda_memory_mb" {
  type = number
}

variable "cloud_watch_retention_days" {
  type = number
}

variable "s3_put_object_bucket_arn" {
  type = string
}

variable "s3_get_object_bucket_arn" {
  type = string
}

variable "get_messages_queue_arn" {
  type = string
}

variable "send_messages_queue_arn" {
  type = string
}

variable "subnet_id" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}