variable "alarm_base_name" {
  type = string
}

variable "env_name" {
  type = string
}

variable "comparison_operator" {
  type = string
}

variable "evaluation_periods" {
  type = number
}

variable "metric_name" {
  type = string
}

variable "statistic_period" {
  type = number
}

variable "statistic_type" {
  type = string
}

variable "threshold" {
  type = number
}

variable "queue_name" {
  type = string
}

variable "aws_autoscaling_policy_arn" {
  type = string
}

variable "alarm_namespace" {
  type = string
}