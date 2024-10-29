resource "aws_elb" "this" {
  name    = replace("${local.experiment}-${var.panda_name}-elb", "_", "-")
  subnets = data.terraform_remote_state.base_config.outputs.public_subnet_ids

  security_groups = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 5
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.experiment}_${local.resource_suffix}_elb"
  }
}
