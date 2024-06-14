resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${var.cluster_id}/${var.aws_ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_alb_request_count_per_target" {
  name               = "${var.base_name}-${var.env_name}"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = var.adjustment_type
    cooldown                = var.coooldown
    metric_aggregation_type = var.metric_aggregation_type

    step_adjustment {
      scaling_adjustment          = 0
      metric_interval_upper_bound = 0
    }

    step_adjustment {
      scaling_adjustment          = var.max_containers
      metric_interval_lower_bound = var.max_messages_in_the_queue
    }

    dynamic "step_adjustment" {
      for_each = var.dynamic_step_adjustments
      content {
        scaling_adjustment          = step_adjustment.value.scaling_adjustment
        metric_interval_lower_bound = step_adjustment.value.metric_interval_lower_bound
        metric_interval_upper_bound = step_adjustment.value.metric_interval_upper_bound
      }
    }
  }
}