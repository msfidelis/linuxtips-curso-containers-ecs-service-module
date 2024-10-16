resource "null_resource" "deploy_ecs" {
  count = var.deployment_controller == "ECS" ? 1 : 0

  provisioner "local-exec" {
    command = "aws ecs update-service --cluster ${var.cluster_name} --service ${aws_ecs_service.main.name} --task-definition ${aws_ecs_task_definition.main.arn}"
    environment = {
      AWS_REGION = var.region
    }
  }

  triggers = {
    task_definition = aws_ecs_task_definition.main.revision
  }

  depends_on = [aws_ecs_service.main, aws_ecs_task_definition.main]

}

