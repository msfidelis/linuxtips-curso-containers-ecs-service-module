resource "aws_ecs_task_definition" "main" {
  family = format("%s-%s", var.cluster_name, var.service_name)

  network_mode = "awsvpc"

  requires_compatibilities = var.capabilities

  cpu    = var.service_cpu
  memory = var.service_memory

  execution_role_arn = aws_iam_role.service_execution_role.arn
  task_role_arn      = var.service_task_execution_role

  container_definitions = jsonencode([
    {
      name   = var.service_name
      image  = var.container_image
      cpu    = var.service_cpu
      memory = var.service_memory

      essential = true

      portMappings = [
        {
          containerPort = var.service_port
          hostPort      = var.service_port
          protocol      = "tcp"
        },
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.main.id
          awslogs-region        = var.region
          awslogs-stream-prefix = var.service_name
        }
      }

      environment = var.environment_variables
    }
  ])


}