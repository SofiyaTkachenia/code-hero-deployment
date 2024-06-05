#======CloudWatch==================================================

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/ecs/${var.base_name}-${var.env_name}"
  retention_in_days = var.cloud_watch_retention_days
}

#======IAM=========================================================

##=====TaskExecutionRole===========================================
resource "aws_iam_role" "executionRole" {
  name = "${var.base_name}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role_assume.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.executionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


##=====TaskRole====================================================
resource "aws_iam_role" "taskRole" {
  name = "${var.base_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role_assume.json
}

resource "aws_iam_policy" "ecs_sqs_task_role_policy" {
  name        = "${var.base_name}-sqs-policy"
  policy =    data.aws_iam_policy_document.ecs_sqs_task_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.taskRole.name
  policy_arn = aws_iam_policy.ecs_sqs_task_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_xray_role_policy_attachment" {
  role       = aws_iam_role.taskRole.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayFullAccess"
}

#======ECS=========================================================
resource "aws_ecs_task_definition" "this" {
  network_mode = "awsvpc"
  family = "${var.base_name}-${var.env_name}-task-definition"
  cpu = var.vcpus
  memory = var.memory_mb
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "ARM64"
    operating_system_family = "LINUX"
  }

  task_role_arn      = aws_iam_role.taskRole.arn
  execution_role_arn = aws_iam_role.executionRole.arn

  container_definitions = jsonencode([
    {
      name = "${var.base_name}-${var.env_name}",
      image  = var.task_ecr_image_uri,
      cpu = 0
      essential = true,
      portMappings = [
        {
          containerPort = var.task_container_port,
          hostPort      = var.task_host_port,
          protocol      = "tcp",
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-datetime-format" = "%Y-%m-%d %H:%M:%S%L",
          "awslogs-group"           = aws_cloudwatch_log_group.this.name,
          "awslogs-region"          = var.aws_region
          "awslogs-stream-prefix"   = "ecs",
          "awslogs-create-group"    = "true",
        }
      },
    },
    {
      name = "${var.base_name}-sidecar-container",
      image = var.sidecar_container_image,
      essential = false,
      portMappings = [
        {
          containerPort = var.sidecar_container_container_port,
          hostPort      = var.sidecar_container_host_port
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-datetime-format" = "%Y-%m-%d %H:%M:%S%L",
          "awslogs-group"           = aws_cloudwatch_log_group.this.name,
          "awslogs-region"          = var.aws_region
          "awslogs-stream-prefix"   = "ecs",
          "awslogs-create-group"    = "true",
        }
      }
    }
  ])
}

resource "aws_ecs_service" "aws-ecs-service" {
  depends_on = [var.aws_lb_listener_arn]

  name                 = "${var.base_name}-${var.env_name}-ecs-service"
  cluster              = var.cluster_arn
  task_definition      = aws_ecs_task_definition.this.arn
  desired_count        = 1
  launch_type          = "FARGATE"

  network_configuration {
    subnets          = var.ecs_subnets
    security_groups  = var.ecs_security_group
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.aws_lb_target_group_arn
    container_name   = "${var.base_name}-${var.env_name}"
    container_port   = var.task_container_port
  }
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${var.cluster_id}/${aws_ecs_service.aws-ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy_alb_request_count_per_target" {
  name               = "${var.base_name}-${var.env_name}-cpu-auto-scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value      = 70
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}


