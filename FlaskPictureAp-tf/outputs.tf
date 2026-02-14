output "vpc_id" {
  value = aws_default_vpc.default.id
}

#############Output from the security_groups module###################
output "ssh_sg_id" {
  value = module.security_groups.ssh_sg_id
}

output "lbnginx_sg_id" {
  value = module.security_groups.lbnginx_sg_id
}

output "app_sg_id" {
  value = module.security_groups.app_sg_id
}

output "db_sg_id" {
  value = module.security_groups.db_sg_id
}

output "consul_sg_id" {
  value = module.security_groups.consul_sg_id
}

output "outbound_all_sg_id" {
  value = module.security_groups.outbound_all_sg_id
}

#############Output from the ec2 module########################
output "jenkins_ip" {
  value = module.app_servers.jenkins_public_ip
}

output "db_ip" {
  value = module.app_servers.db_public_ip
}

output "load_balancer_ip" {
  value = module.app_servers.lb_public_ip
}

output "app_server_ips" {
  value = module.app_servers.app_public_ips
}

output "consul_ip" {
  value = module.app_servers.consul_public_ip
}
