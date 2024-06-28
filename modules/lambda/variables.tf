variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "lambda_name" {
  type = string
}

variable "lambda_task_role_policy" {
  type = string
}

variable "lambda_timeout_seconds" {
  type = number
}

variable "image_url" {
  type = string
}

variable "lambda_env_variables" {
  type = map(string)
  default = {}
}

variable "lambda_memory_mb" {
  type = number
}