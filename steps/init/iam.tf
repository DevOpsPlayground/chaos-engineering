resource "aws_iam_role" "fis_role" {
  name = "${var.panda_name}_fis_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "fis.amazonaws.com",
            "delivery.logs.amazonaws.com"
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_fis_policy_attachment" {
  name       = "ec2_instance_policy_attachment_${local.resource_suffix}"
  roles      = [aws_iam_role.fis_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSFaultInjectionSimulatorEC2Access"
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "${var.panda_name}_cloudwatch_logs_policy"
  description = "Policy to allow CloudWatch log group and log stream access"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:DescribeLogGroups",
          "logs:CreateLogDelivery",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents" 
        ],
        Resource = [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "cloudwatch_logs_policy_attachment" {
  name       = "${var.panda_name}_cloudwatch_logs_policy_attachment"
  roles      = [aws_iam_role.fis_role.name]
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}
