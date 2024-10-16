resource "aws_alb_listener_rule" "codedeploy" {

  count = (var.use_lb && var.deployment_controller == "CODE_DEPLOY") ? 1 : 0

  listener_arn = var.service_listener

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_alb_target_group.blue[count.index].arn
        weight = 100
      }

      target_group {
        arn    = aws_alb_target_group.green[count.index].arn
        weight = 0
      }

    }
  }

  condition {
    host_header {
      values = var.service_hosts
    }
  }

  lifecycle {
    ignore_changes = [
      action
    ]
  }

}