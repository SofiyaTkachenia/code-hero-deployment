resource "aws_alb" "this" {
  name               = "${var.base_name}-${var.env_name}"
  internal           = var.is_lb_internal
  load_balancer_type = var.lb_type
  subnets            = var.lb_subnets
  security_groups    = [var.lb_security_group]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = var.lb_target_group_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_group_arn
  }
}