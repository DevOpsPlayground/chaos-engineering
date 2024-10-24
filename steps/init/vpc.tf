module "vpc" {
  source = "../modules/vpc"

  vpc_cidr     = local.vpc_cidr_range
  subnet_cidrs = local.subnet_cidr_ranges

  resource_suffix = local.resource_suffix
}