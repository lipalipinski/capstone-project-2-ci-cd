output "VPC_id" {
  value = data.aws_vpcs.app-vpc
}

output "private_subnet" {
  value = data.aws_subnets.private
}