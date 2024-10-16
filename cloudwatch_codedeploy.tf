resource "aws_cloudwatch_metric_alarm" "rollback_alarm" {
  
    count = (var.deployment_controller == "CODE_DEPLOY" && var.codedeploy_rollback_alarm ) ? 1 : 0

    alarm_name = format("%s-error-rate", aws_codedeploy_app.main[count.index].name)

    comparison_operator = "GreaterThanOrEqualToThreshold"

    evaluation_periods = var.codedeploy_rollback_error_evaluation_period
    threshold = var.codedeploy_rollback_error_threshold

    metric_query {
      id = "error_rate"
      expression = "(errBlue + errGreen) / (rqBlue + rqGreen) * 100"
      label = "Error Rate"

      return_data = true
    }

    metric_query {
      id = "rqBlue"

      metric {
        metric_name = "RequestCount"
        namespace = "AWS/ApplicationELB"
        period = var.codedeploy_rollback_error_period
        stat = "Sum"
        unit = "Count"

        dimensions = {
          LoadBalancer = data.aws_alb.main[count.index].arn_suffix
          TargetGroup = aws_alb_target_group.blue[count.index].arn_suffix
        }
      }
    }

    metric_query {
      id = "rqGreen"

      metric {
        metric_name = "RequestCount"
        namespace = "AWS/ApplicationELB"
        period = var.codedeploy_rollback_error_period
        stat = "Sum"
        unit = "Count"

        dimensions = {
          LoadBalancer = data.aws_alb.main[count.index].arn_suffix
          TargetGroup = aws_alb_target_group.green[count.index].arn_suffix
        }
      }
    }


    metric_query {
      id = "errBlue"

      metric {
        metric_name = "HTTPCode_Target_5XX_Count"
        namespace = "AWS/ApplicationELB"
        period = var.codedeploy_rollback_error_period
        stat = "Sum"
        unit = "Count"

        dimensions = {
          LoadBalancer = data.aws_alb.main[count.index].arn_suffix
          TargetGroup = aws_alb_target_group.blue[count.index].arn_suffix
        }
      }
    }


    metric_query {
      id = "errGreen"

      metric {
        metric_name = "HTTPCode_Target_5XX_Count"
        namespace = "AWS/ApplicationELB"
        period = var.codedeploy_rollback_error_period
        stat = "Sum"
        unit = "Count"

        dimensions = {
          LoadBalancer = data.aws_alb.main[count.index].arn_suffix
          TargetGroup = aws_alb_target_group.green[count.index].arn_suffix
        }
      }
    }    


}