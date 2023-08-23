module "app-server-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.1"

  name = "app_server_1"

  instance_type = "t3.small"
  ami           = var.server-ami
  monitoring    = true
  subnet_id     = data.aws_subnets.private

  tags = {
    Name  = "app_server_1"
    Group = "app_server"
  }
}