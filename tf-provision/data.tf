data "aws_vpcs" "app-vpc" {
  tags = {
    Name = "jlipinski-petclinic"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.app-vpc.id]
  }

  tags = {
    Tier = "private"
  }
}