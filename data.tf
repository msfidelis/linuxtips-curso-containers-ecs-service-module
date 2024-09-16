data "aws_alb" "main" {
  count = var.use_lb ? 1 : 0
  arn   = var.alb_arn
}