
data "aws_vpcs" "app-vpc" {
  tags = {
    Name = "petclinic-jlipinski"
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

data "aws_security_groups" "app-server-sg" {
  filter {
    name   = "group-name"
    values = ["app_server_sg"]
  }
}

data "aws_db_subnet_group" "database" {
  name = "petclinic-jlipinski"
}