resource "aws_lb_listener" "this" {
  load_balancer_arn = var.alb_arn
  port              = var.lb_target_group_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_arn
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority     = var.lb_rule_priority

  action {
    type             = "forward"
    target_group_arn = var.aws_lb_target_group_arn
  }

  condition {
    path_pattern {
      values = [var.lb_listener_path_pattern]
    }
  }
}