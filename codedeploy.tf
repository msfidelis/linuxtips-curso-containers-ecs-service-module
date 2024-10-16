resource "aws_codedeploy_app" "main" {
  count            = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0
  name             = format("%s-%s", var.cluster_name, var.service_name)
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "main" {
  count = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0

  app_name              = aws_codedeploy_app.main[count.index].name
  deployment_group_name = aws_codedeploy_app.main[count.index].name

  deployment_config_name = var.codedeploy_strategy

  service_role_arn = aws_iam_role.codedeploy[count.index].arn

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }

  deployment_style {
    deployment_option = var.codedeploy_deployment_option
    deployment_type   = var.codedeploy_deployment_type
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = var.codedeploy_termination_wait_time_in_minutes
    }
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [
          var.service_listener
        ]
      }
      target_group {
        name = aws_alb_target_group.blue[count.index].name
      }
      target_group {
        name = aws_alb_target_group.green[count.index].name
      }
    }
  }
  auto_rollback_configuration {
    enabled = true
    events  =  ["DEPLOYMENT_FAILURE", "DEPLOYMENT_STOP_ON_ALARM"]
  }

  alarm_configuration {
    enabled = var.codedeploy_rollback_alarm

    alarms =  var.codedeploy_rollback_alarm ? [
        aws_cloudwatch_metric_alarm.rollback_alarm[count.index].id 
    ] : [ ]
  }
}