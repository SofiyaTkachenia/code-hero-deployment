#======CloudWatch==================================================
resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/ecs/${var.base_name}-${var.env_name}"
  retention_in_days = var.cloud_watch_retention_days
}

#======IAM=========================================================

##=====TaskExecutionRole===========================================
resource "aws_iam_role" "ecs_agent_role" {
  name               = "${var.base_name}-ecs-agent-role-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role_assume.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent_role_policy_attachment" {
  role       = aws_iam_role.ecs_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


##=====TaskRole====================================================
resource "aws_iam_role" "task_role" {
  name               = "${var.base_name}-ecs-task-role-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role_assume.json
}

resource "aws_iam_policy" "ecs_task_role_policy" {
  name   = "${var.base_name}-ecs-task-role-policy-${var.env_name}"
  policy = var.ecs_task_role_policy
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ecs_task_role_policy.arn
}

#======ECS=========================================================
resource "aws_ecs_task_definition" "this" {
  network_mode = "awsvpc"
  family       = "${var.base_name}-${var.env_name}"
  cpu          = var.vcpus
  memory       = var.memory_mb

  runtime_platform {
    cpu_architecture        = var.cpu_architecture
    operating_system_family = "LINUX"
  }

  task_role_arn      = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.ecs_agent_role.arn

  container_definitions = jsonencode([
    {
      name         = var.container_name,
      image        = var.image_uri,
      cpu          = 0
      essential    = true,
      portMappings = var.port_mappings
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-datetime-format" = "%Y-%m-%d %H:%M:%S%L",
          "awslogs-group"           = aws_cloudwatch_log_group.this.name,
          "awslogs-region"          = var.aws_region
          "awslogs-stream-prefix"   = "ecs"
        }
      },
    },
    {
      name      = "${var.base_name}-sidecar-container-${var.env_name}",
      image     = var.sidecar_image_uri,
      cpu       = var.vcpu_sidecar,
      memory    = var.memory_mb_sidecar,
      essential = false,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-datetime-format" = "%Y-%m-%d %H:%M:%S%L",
          "awslogs-group"           = aws_cloudwatch_log_group.this.name,
          "awslogs-region"          = var.aws_region
          "awslogs-stream-prefix"   = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "aws_ecs_service" {
  name            = "${var.base_name}-${var.env_name}"
  cluster         = var.cluster_arn
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.ecs_subnets
    security_groups  = var.ecs_security_group
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

#======ALBTargetGroup=========================================================
resource "aws_lb_target_group" "this" {
  name        = "${var.base_name}-${var.env_name}"
  port        = var.lb_target_group_port
  protocol    = "HTTP"
  target_type = var.lb_target_group_type
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = var.lb_target_group_threshold
    interval            = var.lb_health_check_interval
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = var.health_check_seconds_timeout
    path                = var.health_check_path
    unhealthy_threshold = var.lb_target_group_unhealthy_threshold
  }
}

#======ALBListenerRule========================================================
resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.lb_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = [var.lb_listener_path_pattern]
    }
  }
}

#======CloudwatchMetricAlarm====================================================
resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = "${var.alarm_base_name}-${var.env_name}"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.alarm_namespace
  period              = var.statistic_period
  statistic           = var.statistic_type
  threshold           = var.threshold
  actions_enabled     = true
  alarm_actions       = [var.aws_autoscaling_policy_arn]
  ok_actions          = [var.aws_autoscaling_policy_arn]

  dimensions = {
    QueueName = var.queue_name
  }
}