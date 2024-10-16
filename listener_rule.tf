resource "aws_alb_listener_rule" "main" {

  count = (var.use_lb && var.deployment_controller == "ECS") ? 1 : 0

  listener_arn = var.service_listener

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main[count.index].arn
  }

  condition {
    host_header {
      values = var.service_hosts
    }
  }

}