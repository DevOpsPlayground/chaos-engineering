data "terraform_remote_state" "base_config" {
  backend = "local"

  config = {
    path = "../../statefiles/base_config.tfstate"
  }
}

# identify availability zones in region
data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
