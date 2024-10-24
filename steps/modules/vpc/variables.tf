variable "resource_suffix" {
  description = "Suffix for built resources."
  type        = string
}

variable "subnet_cidrs" {
  description = "list of cidrs for public subnets."
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR Range for VPC."
  type        = string
}

locals {
  az_count = length(var.subnet_cidrs)
}