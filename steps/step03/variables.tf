
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

  domain_name = "devopsplayground.org"

  experiment = "step03"
}