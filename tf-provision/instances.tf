module "app-server-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.2.1"

  name                 = "app_server_1"
  key_name             = "app-server-kp"
  iam_instance_profile = data.aws_iam_instance_profile.app-server-profile.name

  instance_type          = "t3.small"
  ami                    = reverse(data.aws_ami_ids.jenkins-controller.ids)[0]
  monitoring             = true
  subnet_id              = data.aws_subnets.private.ids[0]
  vpc_security_group_ids = [data.aws_security_groups.app-server-sg.ids[0]]

  user_data_replace_on_change = true
  user_data                   = <<EOF
#!/bin/bash
${file("files/app-server-boot.sh")}
EOF

  tags = {
    Name  = "app_server_1"
    Group = "app_server"
  }
}
