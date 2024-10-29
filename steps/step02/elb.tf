resource "aws_elb" "this" {
  name            = replace("${local.experiment}-${var.panda_name}-elb", "_", "-")
  subnets         = data.terraform_remote_state.base_config.outputs.public_subnet_ids
  # availability_zones = data.aws_availability_zones.available_azs.names
  security_groups = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.experiment}_${local.resource_suffix}_elb"
  }
}

# resource "aws_lb" "this" {
#   name               = replace("${local.experiment}-${var.panda_name}-lb", "_", "-")
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [data.terraform_remote_state.base_config.outputs.vpc_security_group_id]
#   subnets            = data.terraform_remote_state.base_config.outputs.public_subnet_ids


#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     Name = "${local.experiment}_${local.resource_suffix}_alb"
#   }
# }