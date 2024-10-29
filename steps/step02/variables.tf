
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

  domain_name = "devopsplayground.org"

  experiment = "step02"
}