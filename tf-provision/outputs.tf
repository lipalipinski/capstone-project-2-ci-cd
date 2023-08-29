output "AppLBAddress" {
  value = module.app-alb.lb_dns_name
}

output "AppServerIp" {
  value = module.app-server-1.private_ip
}