resource "aws_appautoscaling_policy" "cpu_high" {
  count = var.scale_type == "cpu" ? 1 : 0

  resource_id        = aws_appautoscaling_target.main.resource_id
  service_namespace  = aws_appautoscaling_target.main.service_namespace
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension

  name = format("%s-%s-cpu-scale-out", var.cluster_name, var.service_name)

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_out_cooldown
    metric_aggregation_type = var.scale_out_statistic

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = var.scale_out_adjustment
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name = format("%s-%s-cpu-scale-out", var.cluster_name, var.service_name)

  comparison_operator = var.scale_out_comparison_operator

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  statistic   = var.scale_out_statistic

  period             = var.scale_out_period
  evaluation_periods = var.scale_out_evaluation_periods
  threshold          = var.scale_out_cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [
    aws_appautoscaling_policy.cpu_high[count.index].arn
  ]
}

resource "aws_appautoscaling_policy" "cpu_low" {
  count = var.scale_type == "cpu" ? 1 : 0

  resource_id        = aws_appautoscaling_target.main.resource_id
  service_namespace  = aws_appautoscaling_target.main.service_namespace
  scalable_dimension = aws_appautoscaling_target.main.scalable_dimension

  name = format("%s-%s-cpu-scale-in", var.cluster_name, var.service_name)

  policy_type = "StepScaling"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.scale_in_cooldown
    metric_aggregation_type = var.scale_in_statistic

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = var.scale_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = var.scale_in_cpu_threshold
      scaling_adjustment          = var.scale_in_adjustment
    }

    step_adjustment {
      metric_interval_lower_bound = var.scale_in_cpu_threshold
      scaling_adjustment          = 0
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count = var.scale_type == "cpu" ? 1 : 0

  alarm_name = format("%s-%s-cpu-scale-in", var.cluster_name, var.service_name)

  comparison_operator = var.scale_in_comparison_operator

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"
  statistic   = var.scale_in_statistic

  period             = var.scale_in_period
  evaluation_periods = var.scale_in_evaluation_periods
  threshold          = var.scale_in_cpu_threshold

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [
    aws_appautoscaling_policy.cpu_low[count.index].arn
  ]
}