resource "aws_instance" "simple_ec2" {
  ami                  = data.aws_ami.amazon_linux_2.id
  instance_type        = "t3.nano"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  subnet_id                   = data.terraform_remote_state.base_config.outputs.public_subnet_ids[0]
  vpc_security_group_ids      = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]
  associate_public_ip_address = true

  user_data = local.cloud_config

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  tags = {
    Name       = "simple-${var.panda_name}"
    Panda      = var.panda_name
    Experiment = "step01"
    az         = data.aws_availability_zones.available_azs.names[0]
    Project    = "${local.resource_suffix}"
  }
}

locals {
  cloud_config = <<-END
    #cloud-config
    ${jsonencode({
  write_files = [
    {
      path        = "/run/myserver/template.html"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = filebase64("${path.module}/ec2_files/template.html")
    },
    {
      path        = "/run/myserver/panda.png"
      permissions = "0644"
      owner       = "root:root"
      encoding    = "b64"
      content     = filebase64("${path.module}/../../images/halloween_panda.png")
    }
  ],
  runcmd = [
    "yum update -y",
    "yum install -y httpd",
    "systemctl start httpd",
    "systemctl enable httpd",
    "export ec2_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)",
    "export ec2_name=$(curl -s http://169.254.169.254/latest/meta-data/tags/instance/Name)",
    "export ec2_az=$(curl -s http://169.254.169.254/latest/meta-data/tags/instance/az)",
    "envsubst < /run/myserver/template.html > /var/www/html/index.html",
    "mv /run/myserver/panda.png /var/www/html/panda.png"
  ],
})}
  END
}