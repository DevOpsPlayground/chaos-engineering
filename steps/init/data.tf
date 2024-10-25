# identify availability zones in region
data "aws_availability_zones" "available_azs" {
  state = "available"
}


data "aws_caller_identity" "current" {
}

data "aws_s3_bucket" "playground_assets" {
  bucket = "${local.account_id}-${var.region}-oct-assets"
}