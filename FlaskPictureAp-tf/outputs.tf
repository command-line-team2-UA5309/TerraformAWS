output "vpc_id" {
  value = aws_default_vpc.default.id
}

output "ssh_sg_id" {
  value = module.security.ssh_sg_id
}

output "lbnginx_sg_id" {
  value = module.security.lbnginx_sg_id
}

output "app_sg_id" {
  value = module.security.app_sg_id
}

output "db_sg_id" {
  value = module.security.db_sg_id
}

output "consul_sg_id" {
  value = module.security.consul_sg_id
}

output "outbound_all_sg_id" {
  value = module.security.outbound_all_sg_id
}
