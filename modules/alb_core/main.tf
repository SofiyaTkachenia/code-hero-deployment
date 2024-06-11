resource "aws_alb" "this" {
  name               = "${var.base_name}-${var.env_name}"
  internal           = var.is_load_balancer_internal
  load_balancer_type = var.load_balancer_type
  subnets            = var.load_balancer_subnets
  security_groups    = [var.load_balancer_security_group]
}
