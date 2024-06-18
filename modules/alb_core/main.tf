resource "aws_alb" "this" {
  name               = "${var.base_name}-${var.env_name}"
  internal           = var.is_lb_internal
  load_balancer_type = var.lb_type
  subnets            = var.lb_subnets
  security_groups    = [var.lb_security_group]
}