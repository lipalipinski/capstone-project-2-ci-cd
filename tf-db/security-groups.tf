resource "aws_security_group" "db-sg" {
  name        = "app_lb_sg"
  description = "SG for Petclinic RDS DB"
  vpc_id      = data.aws_vpcs.app-vpc.ids[0]

  ingress {
    description     = "Allow access to MYSQL for app SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [data.aws_security_groups.app-server-sg.ids[0]]
  }
}