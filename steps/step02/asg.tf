resource "aws_launch_template" "this" {
  name          = "${local.experiment}_${local.resource_suffix}_lt"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.nano"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  user_data = base64encode(local.cloud_config)

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  # vpc_security_group_ids = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.experiment}"
      Project  = "${local.resource_suffix}"
      Panda = var.panda_name
      Experiment = local.experiment
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name = "${local.experiment}_${local.resource_suffix}_asg"

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  vpc_zone_identifier = [data.terraform_remote_state.base_config.outputs.public_subnet_ids[0]]

  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  load_balancers = [aws_elb.this.id]

  health_check_type          = "ELB"
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
    },
  ],
  runcmd = [
    "yum update -y",
    "yum install -y httpd",
    "systemctl start httpd",
    "systemctl enable httpd",
    "export ec2_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)",
    "export ec2_name=$(curl -s http://169.254.169.254/latest/meta-data/tags/instance/Name)",
    "export ec2_az=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/)",
    "envsubst < /run/myserver/template.html > /var/www/html/index.html",
    "mv /run/myserver/panda.png /var/www/html/panda.png"
  ],
})}
  END
}

