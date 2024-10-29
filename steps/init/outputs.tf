output "fis_iam_role" {
  description = "IAM Role for FIS."
  value       = aws_iam_role.fis_role.name
}

output "fis_log_group" {
  description = "Log Group for FIS."
  value       = aws_cloudwatch_log_group.log_group.name
}
