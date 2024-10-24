terraform {

  required_version = ">=1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.70.0"
    }
  }

  backend "local" {
    path = "../../statefiles/base_config.tfstate"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project = local.playground_name
      Panda   = var.panda_name
    }
  }
}
