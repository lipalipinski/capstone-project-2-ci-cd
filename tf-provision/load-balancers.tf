module "app-alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "petclinic-alb"

  load_balancer_type = "application"

  vpc_id          = data.aws_vpcs.app-vpc.ids[0]
  subnets         = data.aws_subnets.public.ids
  security_groups = [data.aws_security_group.app_lb_sg.id]

  target_groups = [
    {
      name             = "petclinic-tg"
      backend_protocol = "HTTP"
      backend_port     = 80
      health_check = {
        enabled             = true
        protocol            = "HTTP"
        interval            = 5
        timeout             = 3
        healthy_threshold   = 2
        unhealthy_threshold = 2
      }
      target_type = "instance"
      targets = [
        {
          port      = 80
          target_id = module.app-server-1.id
        },
      ]
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}