output "ec2_details" {
  description = "Details of the EC2 instance."
  value = {
    instance_id     = aws_instance.simple_ec2.id
    instance_name   = lookup(aws_instance.simple_ec2.tags, "Name", "default")
    instance_ip_url = "http://${aws_instance.simple_ec2.public_ip}"
    instance_subnet = aws_instance.simple_ec2.subnet_id
    instance_az     = aws_instance.simple_ec2.availability_zone
  }
}
