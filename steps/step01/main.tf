terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.70.0"
    }
  }

  backend "local" {
    path = "../../statefiles/step01_config.tfstate"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project    = local.playground_name
      Panda      = var.panda_name
      Experiment = local.experiment
    }
  }
}
