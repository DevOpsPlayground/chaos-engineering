output "public_subnet_details" {
  description = "Details of the public subnets."
  value = {
    for subnet in aws_subnet.public : subnet.id => {
      cidr_block        = subnet.cidr_block
      availability_zone = subnet.availability_zone
    }
  }
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public.*.id
}

output "security_group_id" {
  description = "ID of the VPC security group."
  value       = aws_security_group.ec2_sg.id
}

output "subnetCidrs" {
  description = "list of cidrs for public subnets."
  value       = aws_subnet.public.*.cidr_block
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}