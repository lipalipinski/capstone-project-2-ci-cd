
data "aws_iam_instance_profile" "app-server-profile" {
  name = "app-server"
}

data "aws_security_groups" "app-lb-sg" {
  filter {
    name   = "group-name"
    values = ["app_lb_sg"]
  }
}

data "aws_security_groups" "app-server-sg" {
  filter {
    name   = "group-name"
    values = ["app_server_sg"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.app-vpc.ids[0]]
  }

  tags = {
    Tier = "private"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.app-vpc.ids[0]]
  }

  tags = {
    Tier = "public"
  }
}


data "aws_vpcs" "app-vpc" {
  tags = {
    Name = "petclinic-jlipinski"
  }
}