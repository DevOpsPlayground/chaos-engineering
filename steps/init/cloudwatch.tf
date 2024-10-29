resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/fis/${var.panda_name}-fis-logs"
  retention_in_days = 1
}