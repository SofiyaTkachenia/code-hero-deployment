resource "aws_sns_topic" "this" {
  name = "${var.base_name}-${var.sns_topic_name}-${var.env_name}"

  tags = {
    Name        = "${var.base_name}-${var.sns_topic_name}"
    Environment = var.env_name
  }
}