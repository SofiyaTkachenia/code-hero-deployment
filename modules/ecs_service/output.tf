output "aws_ecs_service_name" {
  value = aws_ecs_service.aws_ecs_service.name
}

output "lb_target_group_arn" {
  value = aws_lb_target_group.this.arn
}