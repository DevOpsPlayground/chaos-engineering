output "vpc_id" {
  description = "id of the vpc"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "The ids of the public subnets"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "The ids of the private subnets"
  value       = aws_subnet.private.*.id
}
