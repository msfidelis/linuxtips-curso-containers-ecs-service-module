resource "aws_ecs_service" "main" {
  name    = var.service_name
  cluster = var.cluster_name

  task_definition = aws_ecs_task_definition.main.arn

  desired_count = var.service_task_count

  dynamic "service_registries" {
    for_each = var.service_discovery_namespace != null ? [var.service_name] : []
    content {
      registry_arn   = aws_service_discovery_service.main[0].arn
      container_name = service_registries.value
    }
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  deployment_controller {
    type = var.deployment_controller
  }

  deployment_circuit_breaker {
    enable   = var.deployment_controller == "ECS" ? true : false
    rollback = var.deployment_controller == "ECS" ? true : false
  }

  dynamic "capacity_provider_strategy" {
    for_each = var.service_launch_type

    content {
      capacity_provider = capacity_provider_strategy.value.capacity_provider
      weight            = capacity_provider_strategy.value.weight
    }
  }

  dynamic "service_connect_configuration" {
    for_each = var.use_service_connect ? [var.service_connect_name] : []

    content {
      enabled   = var.use_service_connect
      namespace = var.service_connect_name

      service {
        port_name      = var.service_name
        discovery_name = var.service_name

        client_alias {
          port     = var.service_port
          dns_name = format("%s.%s", var.service_name, var.service_connect_name)
        }
      }

    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = var.service_launch_type == "EC2" ? [1] : []
    content {
      type  = "spread"
      field = "attribute:ecs.availability-zone"
    }
  }

  network_configuration {
    security_groups = [
      aws_security_group.main.id
    ]

    subnets          = var.private_subnets
    assign_public_ip = false
  }

  dynamic "load_balancer" {
    for_each = var.use_lb ? [1] : []
    content {
      target_group_arn = (var.use_lb && var.deployment_controller == "CODE_DEPLOY") ? aws_alb_target_group.blue[0].arn : aws_alb_target_group.main[0].arn
      container_name   = var.service_name
      container_port   = var.service_port
    }
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      load_balancer
    ]
  }

  #   platform_version = "LATEST"

  depends_on = []

}