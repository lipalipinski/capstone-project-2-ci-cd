resource "aws_iam_instance_profile" "app-server" {
  name = "app-server"
  role = aws_iam_role.app-server.name

  tags = {
    Name = "app-server"
  }
}

resource "aws_iam_role" "app-server" {
  name = "app-server"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  # set to meet GD policy
  permissions_boundary = var.gd-boundry-policy

  tags = {
    Name = "app-server"
  }
}

resource "aws_iam_role_policy_attachment" "app-runner-ecr" {
  role       = aws_iam_role.app-server.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role_policy_attachment" "app-server-ecr-token" {
  role       = aws_iam_role.app-server.name
  policy_arn = data.aws_iam_policy.get_ecr_token.arn
}

