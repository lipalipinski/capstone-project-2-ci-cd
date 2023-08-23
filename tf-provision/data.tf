data "aws_vpcs" "app-vpc" {
  tags = {
    Name = "jlipinski-petclinic"
  }
}
