resource "aws_iam_role" "codedeploy" {

  count = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0

  name = format("%s-%s-codedeploy", var.cluster_name, var.service_name)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "codedeploy" {
  count      = var.deployment_controller == "CODE_DEPLOY" ? 1 : 0
  role       = aws_iam_role.codedeploy[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}