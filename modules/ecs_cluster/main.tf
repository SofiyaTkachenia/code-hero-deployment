resource "aws_ecs_cluster" "this" {
  name = "${var.base_name}-${var.env_name}"
}