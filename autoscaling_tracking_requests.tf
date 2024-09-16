resource "aws_appautoscaling_policy" "target_tracking_requests" {

  count = (var.scale_type == "requests_tracking" && var.use_lb) ? 1 : 0

  name = format("%s-%s-requests-tracking", var.cluster_name, var.service_name)

  resource_id        = aws_appautoscaling_target.main.resource_id
  service_namespace  = aws_appautoscaling_target.main.service_namespace
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    target_value       = var.scale_tracking_cpu
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${data.aws_alb.main[count.index].arn_suffix}/${aws_alb_target_group.main[count.index].arn_suffix}"
    }

  }

}










