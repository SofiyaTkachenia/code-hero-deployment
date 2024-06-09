resource "aws_lb_target_group" "this" {
  name        = "${var.base_name}-${var.env_name}"
  port        = var.load_balancer_target_group_port
  protocol    = var.load_balancer_target_group_protocol
  target_type = var.load_balancer_target_group_type
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = var.load_balancer_target_group_threshold
    interval            = var.load_balancer_health_check_interval
    protocol            = var.load_balancer_target_group_protocol
    matcher             = "200"
    timeout             = var.health_check_timeout
    path                = var.healthy_check_path
    unhealthy_threshold = var.load_balancer_target_group_unhealthy_threshold
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = var.alb_arn
  port              = var.load_balancer_target_group_port
  protocol          = var.load_balancer_target_group_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority = var.load_balancer_listener_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.id
  }

  condition {
    path_pattern {
      values = [var.load_balancer_listener_path_pattern]
    }
  }
}