
variable "panda_name" {
  description = "My Panda Name"
  type        = string
}

variable "region" {
  description = "AWS Region for deployment."
  type        = string
  default     = "eu-west-2"
}


locals {
  playground_name = "devops_playground_oct2024"
  panda_name_list = ["funky", "sad"]
  panda_number    = index(local.panda_name_list, var.panda_name)

  resource_suffix = "${var.panda_name}_${local.playground_name}"

  cidr_offset = 100

  vpc_cidr_range     = "10.${local.panda_number + local.cidr_offset}.0.0/16"
  subnet_cidr_ranges = [for i in range(length(data.aws_availability_zones.available_azs.names)) : "10.${local.panda_number + local.cidr_offset}.${i}.0/24"]
}