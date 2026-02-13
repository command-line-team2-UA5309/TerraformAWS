#############Output from the vpc module###################
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  value = module.vpc.private_subnet_id
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr
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
  value = module.ec2.jenkins_public_ip
}

output "jenkins_dns" {
  value = module.ec2.jenkins_public_dns
}

output "lb_ip" {
  value = module.ec2.lb_public_ip
}

output "lb_dns" {
  value = module.ec2.lb_public_dns
}

output "app_ips" {
  value = module.ec2.app_private_ips
}

output "db_ip" {
  value = module.ec2.db_private_ip
}

output "consul_ip" {
  value = module.ec2.consul_private_ip
}