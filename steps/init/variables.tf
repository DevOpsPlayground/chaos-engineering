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
  panda_name_list = [
    "funny",
    "sweet",
    "proud",
    "suited",
    "loved",
    "firm",
    "settling",
    "premium",
    "feasible",
    "welcome",
    "pumped",
    "trusty",
    "rational",
    "moving",
    "fast",
    "social",
    "logical",
    "on",
    "driving",
    "perfect",
    "equal",
    "becoming",
    "still",
    "touched",
    "fair",
    "quiet",
    "ample",
    "master",
    "fun",
    "big",
    "full",
    "credible",
    "inspired",
    "pet",
    "willing",
    "guiding",
    "useful",
    "close",
    "smashing",
    "stunning",
    "musical",
    "evolved",
    "teaching",
    "artistic",
    "learning",
    "singular",
    "funky",
    "optimal",
    "loving",
    "measured",
    "whole",
    "verified",
    "finer",
    "glorious",
    "outgoing",
    "living",
    "refined",
    "valued",
    "champion",
    "integral",
    "topical",
    "humble",
    "valid",
    "patient",
    "accurate",
    "allowed",
    "tight",
    "uncommon"
  ]
  panda_number    = index(local.panda_name_list, replace(var.panda_name, "/-(test|panda)\\s*$$/", ""))

  resource_suffix = "${var.panda_name}_${local.playground_name}"

  cidr_offset = 100

  vpc_cidr_range     = "10.${local.panda_number + local.cidr_offset}.0.0/16"
  subnet_cidr_ranges = [for i in range(length(data.aws_availability_zones.available_azs.names)) : "10.${local.panda_number + local.cidr_offset}.${i}.0/24"]

  # account_id = data.aws_caller_identity.current.account_id
}