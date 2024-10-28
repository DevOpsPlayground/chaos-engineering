# create an iam role to act as ec2 instance profile
resource "aws_iam_role" "ec2_instance_role" {
  name = "${local.experiment}_${local.resource_suffix}_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_instance_policy_attachment" {
  name       = "${local.experiment}ec2_instance_policy_attachment_${local.resource_suffix}"
  roles      = [aws_iam_role.ec2_instance_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${local.experiment}_instance_profile_${local.resource_suffix}"
  role = aws_iam_role.ec2_instance_role.name
}
