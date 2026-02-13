####################### Public #######################

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_public_dns" {
  value = aws_instance.jenkins.public_dns
}

output "lb_public_ip" {
  value = aws_instance.lb.public_ip
}

output "lb_public_dns" {
  value = aws_instance.lb.public_dns
}

####################### Private #######################

output "db_private_ip" {
  value = aws_instance.db.private_ip
}

output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "consul_private_ip" {
  value = aws_instance.consul.private_ip
}