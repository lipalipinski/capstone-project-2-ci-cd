resource "aws_security_group" "app_server_sg" {
  name = "app_server_sg"
  description = "SG for Petclinic app server"
  vpc_id = data.aws_vpcs.app-vpc.ids[0]

  ingress {
    description = "Allow 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # security_groups = [aws_security_group.app_lb_sg.id]
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "Allow 22 from jenkins-ctrl-sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins-ctrl-sg.id]
  }
}

resource "aws_security_group" "app_lb_sg" {
  name = "app_lb_sg"
  description = "SG for Petclinic Load Balancer"
  vpc_id = data.aws_vpcs.app-vpc.ids[0]

  ingress {
    description = "Allow 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}