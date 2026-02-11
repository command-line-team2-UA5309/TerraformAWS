output "ssh_sg_id" {
  value = aws_security_group.ssh.id
}

output "lbnginx_sg_id" {
  value = aws_security_group.lbnginx.id
}

output "app_sg_id" {
  value = aws_security_group.app.id
}

output "db_sg_id" {
  value = aws_security_group.db.id
}

output "consul_sg_id" {
  value = aws_security_group.consul.id
}

output "outbound_all_sg_id" {
  value = aws_security_group.outbound_all.id
}
