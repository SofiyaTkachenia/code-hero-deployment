
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

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


##=====TaskRole====================================================
resource "aws_iam_role" "task_role" {
  name               = "${var.base_name}-ecs-task-role-${var.env_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_role_assume.json
}

resource "aws_iam_policy" "ecs_sqs_task_role_policy" {
  name   = "${var.base_name}-ecs-task-role-policy-${var.env_name}"
  policy = var.ecs_task_role_policy
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.ecs_sqs_task_role_policy.arn
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
      name      = var.container_name,
      image     = var.task_ecr_image_uri,
      cpu       = 0
      essential = true,
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
      image     = var.sidecar_container_image,
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

  dynamic "load_balancer" {
    for_each = var.is_load_balanced ? [1] : []
    content {
      target_group_arn = var.aws_lb_target_group_arn
      container_name   = var.container_name
      container_port   = var.task_container_port
    }
  }
}


