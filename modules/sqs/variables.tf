variable "env_name" {
  type = string
}

variable "base_name" {
  type = string
}

variable "queue_name" {
  type = string
}

variable "message_delay_period_seconds" {
  type = number
}

variable "max_message_size" {
  type    = number
  default = 2048
}

variable "message_retention_seconds" {
  type    = number
  default = 86400
}

variable "receive_wait_time_seconds" {
  type    = number
  default = 10
}

variable "queue_visibility_timeout_seconds" {
  type = number
}