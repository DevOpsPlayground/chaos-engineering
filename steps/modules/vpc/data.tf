# identify availability zones in region
data "aws_availability_zones" "available_azs" {
  state = "available"
}

