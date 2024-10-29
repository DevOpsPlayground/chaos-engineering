output "elb_url" {
  description = "URL of the ELB."
  value       = "http://${aws_elb.this.dns_name}"
}
