output "fis_iam_role" {
  description = "IAM Role for FIS."
  value       = aws_iam_role.fis_role.name
}

output "fis_log_group" {
  description = "Log Group for FIS."
  value       = aws_cloudwatch_log_group.log_group.name
}


output "public_subnet_details" {
  description = "Details of the public subnets."
  value       = module.vpc.public_subnet_details
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "vpc_security_group_id" {
  description = "ID of the VPC Security Group."
  value       = module.vpc.security_group_id
}

output "subnet_cidr_ranges" {
  description = "CIDR Range for Subnets."
  value       = local.subnet_cidr_ranges
}

output "vpc_cidr_ranges" {
  description = "CIDR Range for VPC."
  value       = local.vpc_cidr_range
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}