output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
output "db_public_ip" {
  value = aws_instance.db.public_ip
}
output "lb_public_ip" {
  value = aws_instance.lb.public_ip
}
output "app_public_ips" {
  value = aws_instance.app[*].public_ip
}
output "consul_public_ip" {
  value = aws_instance.consul.public_ip
}